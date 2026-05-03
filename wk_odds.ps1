<#
.SYNOPSIS
    Working Knowledge spawn-rate checker.

.DESCRIPTION
    Parses vanilla ProceduralDistributions.lua and WK_Distributions.lua to
    report per-container odds and expected search counts for WK documents.

    Weights assume sandbox SpawnRate = Normal (multiplier 1.0).
    At other settings the WK weights scale linearly; use -ShowSensitivity
    to print the full five-level table for every pool.

.PARAMETER ShowSensitivity
    Print the SpawnRate sensitivity table for every pool (verbose).

.EXAMPLE
    .\wk_odds.ps1
    .\wk_odds.ps1 -ShowSensitivity
#>
param([switch] $ShowSensitivity)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# ── Paths ─────────────────────────────────────────────────────────────────────

$VanillaProc = "C:\Program Files (x86)\Steam\steamapps\common\ProjectZomboid\media\lua\server\Items\ProceduralDistributions.lua"
$WkDist      = "C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\WorkingKnowledge\42\media\lua\server\WK_Distributions.lua"

# ── Pools to analyse ──────────────────────────────────────────────────────────
# Key = ProceduralDistributions pool name, Value = human-readable label.
# Add entries here when WK starts using a new container pool.

$Pools = [ordered]@{
    # ── Specific / thematic ───────────────────────────────────────────────────
    ArmySurplusLiterature              = "Army Surplus (Literature Rack)"
    ArmyBunkerLockers                  = "Army Bunker (Lockers)"
    ArmyBunkerStorage                  = "Army Bunker (Storage)"
    PoliceFilingCabinet                = "Police (Filing Cabinet)"
    PoliceDesk                         = "Police (Desk)"
    # GunStoreCounter: DEPRECATED in vanilla — pool is empty, skipped until TIS ships a replacement
    FireStorageTools                   = "Fire Station (Tools)"
    WildWestBlacksmith                 = "Wild West Blacksmith"
    MetalShopTools                     = "Metal Shop (Tools)"
    WeldingWorkshopTools               = "Welding Workshop (Tools)"
    MechanicShelfBooks                 = "Mechanic Shop (Book Shelf)"
    MechanicShelfBrakes                = "Mechanic Shop (Brake Shelf)"
    MechanicShelfElectric              = "Mechanic Shop (Elec. Shelf)"
    CarDealerFilingCabinet             = "Car Dealer (Filing Cabinet)"
    ElectricianTools                   = "Electrician (Tools)"
    # UniversityFilingCabinet_Glassmaking: IN PROGRESS in vanilla — pool is empty, skipped until TIS populates it
    ToolCabinetFarming                 = "Farm (Tool Cabinet)"
    ButcherLiterature                  = "Butcher (Literature)"
    ToolStoreMisc                      = "Tool Store (Misc)"
    FishingStoreGear                   = "Fishing Store (Gear)"
    PlumbingSupplies                   = "Plumbing (Supplies)"
    BlacksmithLiterature               = "Blacksmith (Literature Rack)"
    TailoringLiterature                = "Tailoring / Fabric Store (Literature)"
    RangerBooks                        = "Ranger Station (Books)"
    MedicalOfficeBooks                 = "Medical Office (Books)"
    GardenStoreMisc                    = "Garden / Nursery Store (Misc)"
    # ── Generic fallbacks ─────────────────────────────────────────────────────
    DeskGeneric                        = "Generic Desk"
    FilingCabinetGeneric               = "Generic Filing Cabinet"
}

# ── Vanilla pool parser ───────────────────────────────────────────────────────

function Get-VanillaPool {
    param([string] $Text, [string] $PoolName)

    $startPattern = "(?m)^[ \t]+$([regex]::Escape($PoolName))\s*=\s*\{"
    $startMatch   = [regex]::Match($Text, $startPattern)
    if (-not $startMatch.Success) { return $null }

    # Locate end of top-level block
    $pos = $startMatch.Index + $startMatch.Length; $depth = 1
    while ($pos -lt $Text.Length -and $depth -gt 0) {
        if ($Text[$pos] -eq '{') { $depth++ } elseif ($Text[$pos] -eq '}') { $depth-- }
        $pos++
    }
    $blockText = $Text.Substring($startMatch.Index, $pos - $startMatch.Index)

    # Rolls
    $rollsM = [regex]::Match($blockText, '\brolls\s*=\s*(\d+)')
    $rolls  = if ($rollsM.Success) { [int]$rollsM.Groups[1].Value } else { 1 }

    # Main items block (stop before junk)
    $itemsM = [regex]::Match($blockText, '\bitems\s*=\s*\{')
    if (-not $itemsM.Success) { return @{ Rolls = $rolls; VanillaWeight = 0.0 } }

    $ipos = $itemsM.Index + $itemsM.Length; $idepth = 1
    while ($ipos -lt $blockText.Length -and $idepth -gt 0) {
        if ($blockText[$ipos] -eq '{') { $idepth++ } elseif ($blockText[$ipos] -eq '}') { $idepth-- }
        $ipos++
    }
    $itemsText = $blockText.Substring($itemsM.Index + $itemsM.Length, $ipos - $itemsM.Index - $itemsM.Length - 1)

    # Truncate at junk block if present
    $junkM = [regex]::Match($itemsText, '\bjunk\s*=')
    if ($junkM.Success) { $itemsText = $itemsText.Substring(0, $junkM.Index) }

    $weightSum = 0.0
    foreach ($m in [regex]::Matches($itemsText, '"[^"]+",\s*([\d.]+)')) {
        $weightSum += [double]$m.Groups[1].Value
    }

    return @{ Rolls = $rolls; VanillaWeight = $weightSum }
}

# ── WK additions parser ───────────────────────────────────────────────────────
# Handles both:
#   addMany(dist.Pool.items, { { "WK_...", w(N) }, ... })
#   addToItems(dist.Pool.items, "WK_...", w(N))

function Get-WkAdditions {
    param([string] $Text, [string] $PoolName)

    $count     = 0
    $weightSum = 0.0
    $escaped   = [regex]::Escape($PoolName)

    # ── addMany blocks (there may be more than one per pool)
    $blockRe = [regex]("addMany\s*\(\s*dist\.$escaped\.items\s*,\s*\{")
    foreach ($bm in $blockRe.Matches($Text)) {
        $pos = $bm.Index + $bm.Length; $depth = 1
        while ($pos -lt $Text.Length -and $depth -gt 0) {
            if ($Text[$pos] -eq '{') { $depth++ } elseif ($Text[$pos] -eq '}') { $depth-- }
            $pos++
        }
        $block = $Text.Substring($bm.Index + $bm.Length, $pos - $bm.Index - $bm.Length - 1)

        foreach ($m in [regex]::Matches($block, '\{\s*"WK_[^"]+"\s*,\s*w\(([\d.]+)\)\s*\}')) {
            $count++; $weightSum += [double]$m.Groups[1].Value
        }
    }

    # ── addToItems single-item calls
    $singleRe = [regex]("addToItems\s*\(\s*dist\.$escaped\.items\s*,\s*""WK_[^""]*""\s*,\s*w\(([\d.]+)\)\s*\)")
    foreach ($m in $singleRe.Matches($Text)) {
        $count++; $weightSum += [double]$m.Groups[1].Value
    }

    return @{ Count = $count; WkWeight = $weightSum }
}

# ── Sensitivity table helper ──────────────────────────────────────────────────

function Write-SensitivityTable {
    param([double]$VanillaW, [double]$WkW, [int]$Rolls)

    $levels = @(
        @{ Name="Very Rare"; Mult=0.25 },
        @{ Name="Rare";      Mult=0.5  },
        @{ Name="Normal";    Mult=1.0  },
        @{ Name="Common";    Mult=2.0  },
        @{ Name="Abundant";  Mult=4.0  }
    )
    Write-Host ("    {0,-12}  {1,4}  {2,7}  {3,9}" -f "Setting","Mult","P(hit)","Expected")
    Write-Host ("    {0,-12}  {1,4}  {2,7}  {3,9}" -f "------------","----","-------","---------")
    foreach ($lvl in $levels) {
        $wkS  = $WkW * $lvl.Mult
        $totS = $VanillaW + $wkS
        $pR   = if ($totS) { $wkS / $totS } else { 0.0 }
        $pH   = 1.0 - [Math]::Pow(1.0 - $pR, $Rolls)
        $exp  = if ($pH) { 1.0 / $pH } else { [double]::PositiveInfinity }
        $mark = if ($lvl.Name -eq "Normal") { "  <" } else { "" }
        Write-Host ("    {0,-12}  {1,4:F2}  {2,6:F2}%  {3,9:F1}{4}" -f $lvl.Name, $lvl.Mult, (100.0*$pH), $exp, $mark)
    }
}

# ── Main ──────────────────────────────────────────────────────────────────────

foreach ($path in @($VanillaProc, $WkDist)) {
    if (-not (Test-Path $path)) { Write-Error "File not found: $path"; exit 1 }
}

$vanillaText = [System.IO.File]::ReadAllText($VanillaProc)
$wkText      = [System.IO.File]::ReadAllText($WkDist)

$sep = "=" * 70

Write-Host ""
Write-Host $sep
Write-Host "  Working Knowledge — spawn odds  (sandbox: Normal / 1.0x)"
Write-Host $sep
Write-Host ("  {0,-42} {1,5}  {2,7}  {3,9}" -f "Container","Rolls","P(hit)","Expected")
Write-Host ("  {0,-42} {1,5}  {2,7}  {3,9}" -f ("-"*42),("─"*5),("─"*7),("─"*9))

$warnings = [System.Collections.Generic.List[string]]::new()

foreach ($poolName in $Pools.Keys) {
    $label   = $Pools[$poolName]
    $vanilla = Get-VanillaPool -Text $vanillaText -PoolName $poolName
    $wkAdds  = Get-WkAdditions -Text $wkText      -PoolName $poolName

    if ($null -eq $vanilla) {
        Write-Host ("  {0,-42} {1}" -f $label, "POOL NOT IN VANILLA — update POOLS or vanilla changed")
        $warnings.Add("  ! $label [$poolName]: not found in ProceduralDistributions.lua")
        continue
    }

    if ($wkAdds.Count -eq 0) {
        Write-Host ("  {0,-42} {1}" -f $label, "no WK entries found in WK_Distributions.lua")
        $warnings.Add("  ! $label [$poolName]: no WK entries found")
        continue
    }

    $rolls    = $vanilla.Rolls
    $vanillaW = $vanilla.VanillaWeight
    $wkW      = $wkAdds.WkWeight
    $totalW   = $vanillaW + $wkW
    $pRoll    = if ($totalW) { $wkW / $totalW } else { 0.0 }
    $pHit     = 1.0 - [Math]::Pow(1.0 - $pRoll, $rolls)
    $expected = if ($pHit) { 1.0 / $pHit } else { [double]::PositiveInfinity }

    Write-Host ("  {0,-42} {1,5}  {2,6:F2}%  {3,9:F1}" -f $label, $rolls, (100.0*$pHit), $expected)

    if ($ShowSensitivity) {
        Write-Host ""
        Write-Host ("    [{0}]  vanilla weight {1:F2}  WK items {2}  WK weight {3:F4}" -f $poolName, $vanillaW, $wkAdds.Count, $wkW)
        Write-SensitivityTable -VanillaW $vanillaW -WkW $wkW -Rolls $rolls
        Write-Host ""
    }
}

Write-Host $sep

if ($warnings.Count -gt 0) {
    Write-Host ""
    Write-Host "  Warnings:"
    foreach ($w in $warnings) { Write-Host $w }
}

Write-Host ""
