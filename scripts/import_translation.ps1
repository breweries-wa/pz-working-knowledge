<#
.SYNOPSIS
    Imports a completed translation into Working Knowledge locale files.

.DESCRIPTION
    Reads three filled-in translate_*.txt source files and writes:
      - Translate/{Locale}/ItemName.json    ("Base.WK_Key": "name")
      - Translate/{Locale}/Tooltip.json     ("Tooltip_WK_Key": "flavor\n\nTrains: skill")
      - Translate/{Locale}/Sandbox.json     ("SandboxKey": "value")

    Auto-applies line breaks to tooltip flavor text (no \n needed in source).
    Validates all entries and reports issues before writing.

.PARAMETER Locale
    PZ locale code, e.g. DE, ES, PT, RU. Must match a folder name PZ recognizes.

.EXAMPLE
    .\import_translation.ps1 -Locale DE

.NOTES
    Source files live in scripts/translate_*.txt.
    Fill in translations as:   KEY | translated text (| skill for tooltips)
    Working directory: C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\WorkingKnowledge\
#>

param(
    [Parameter(Mandatory)]
    [string]$Locale
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$root      = 'C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\WorkingKnowledge'
$scriptDir = Join-Path $root 'scripts'
$outDir    = Join-Path $root "42\media\lua\shared\Translate\$Locale"
$utf8NoBom = [System.Text.UTF8Encoding]::new($false)

$namesFile   = Join-Path $scriptDir 'translate_names.txt'
$tooltipFile = Join-Path $scriptDir 'translate_tooltips.txt'
$sandboxFile = Join-Path $scriptDir 'translate_sandbox.txt'

# ── Helpers ───────────────────────────────────────────────────────────────────

function Parse-PipeFile([string]$path, [int]$fields) {
    # Returns ordered hashtable: key -> string[]  (the remaining fields after key)
    $result = [ordered]@{}
    $n = 0
    foreach ($raw in [System.IO.File]::ReadAllLines($path)) {
        $n++
        $line = $raw.Trim()
        if ($line -eq '') { continue }
        $parts = $line -split ' \| ', $fields
        if ($parts.Count -lt $fields) {
            Write-Warning "[$path line $n] Expected $fields fields, got $($parts.Count): $line"
            continue
        }
        $key = $parts[0].Trim()
        $result[$key] = @($parts[1..($parts.Count - 1)] | ForEach-Object { $_.Trim() })
    }
    return $result
}

function Apply-LineBreak([string]$text) {
    # Returns flavor text with a literal '\n' (two chars) inserted at the best
    # word boundary, or unchanged if it fits on one line.
    #
    # Rules:
    #   - Single line if total length <= 55
    #   - Line 1 <= 55 chars, line 2 <= 55 chars
    #   - len(line1) >= len(line2)
    #   - Line 2 must have >= 3 words or >= 20 chars (no widow)

    $text = $text.Trim()
    if ($text.Length -le 55) { return $text }

    # Break position b = index of the space we split at.
    # line1 = text[0..b-1] with length b
    # line2 = text[b+1..]  with length (text.Length - b - 1)
    # line1 >= line2  =>  b >= (text.Length - 1) / 2
    $minB = [int][Math]::Ceiling(($text.Length - 1) / 2.0)
    $maxB = 55   # line1 can be at most 55 chars

    # Search latest valid position first (gives longest line1)
    $fallback = -1
    for ($i = $maxB; $i -ge 1; $i--) {
        if ($i -ge $text.Length) { continue }
        if ($text[$i] -ne ' ')   { continue }

        $line1 = $text.Substring(0, $i)
        $line2 = $text.Substring($i + 1)

        if ($line2.Length -gt 55) { continue }   # line2 too long

        if ($i -ge $minB) {
            # Satisfies line1 >= line2 in length
            $words2 = @($line2.Trim() -split '\s+' | Where-Object { $_ -ne '' }).Count
            if ($words2 -ge 3 -or $line2.Length -ge 20) {
                return "$line1\n$line2"
            }
            # Widow — record as fallback, keep searching
            if ($fallback -lt 0) { $fallback = $i }
        }
    }

    # Use fallback (widow, but line1 >= line2) if found
    if ($fallback -ge 0) {
        $line1 = $text.Substring(0, $fallback)
        $line2 = $text.Substring($fallback + 1)
        Write-Warning "  Widow on line2 (could not avoid): '$line2'"
        return "$line1\n$line2"
    }

    # Text too long to balance — just break at last space <= 55
    for ($i = $maxB; $i -ge 1; $i--) {
        if ($i -ge $text.Length) { continue }
        if ($text[$i] -eq ' ') {
            $line1 = $text.Substring(0, $i)
            $line2 = $text.Substring($i + 1)
            Write-Warning "  line1 < line2 (text too long to balance): '$text'"
            return "$line1\n$line2"
        }
    }

    Write-Warning "  No break point found (no spaces?): '$text'"
    return $text
}

function Escape-Json([string]$s) {
    # Minimal JSON string escaping.
    # Preserve literal \n (backslash+n) — do NOT double-escape it.
    # Escape: " -> \"   and any lone \ that isn't part of \n -> \\
    $s = $s -replace '\\(?!n)', '\\'   # escape \ not followed by n
    $s = $s -replace '"', '\"'
    return $s
}

function Write-JsonFile([string]$path, [System.Collections.Specialized.OrderedDictionary]$entries) {
    $lines = [System.Collections.Generic.List[string]]::new()
    $lines.Add('{')
    $keys = @($entries.Keys)
    for ($i = 0; $i -lt $keys.Count; $i++) {
        $k = $keys[$i]
        $v = Escape-Json $entries[$k]
        $comma = if ($i -lt $keys.Count - 1) { ',' } else { '' }
        $lines.Add("    `"$k`": `"$v`"$comma")
    }
    $lines.Add('}')
    [System.IO.File]::WriteAllLines($path, $lines, $utf8NoBom)
}

# ── Load master key list from EN source (for validation) ─────────────────────

$enNameFile = Join-Path $root '42\media\lua\shared\Translate\EN\ItemName_EN.txt'
$masterKeys = [System.Collections.Generic.HashSet[string]]::new()
foreach ($line in [System.IO.File]::ReadAllLines($enNameFile)) {
    if ($line -match 'Item_(WK_\w+)\s*=') {
        $masterKeys.Add($Matches[1]) | Out-Null
    }
}
Write-Host "Master key list: $($masterKeys.Count) WK_ keys from ItemName_EN.txt"

# ── Parse source files ────────────────────────────────────────────────────────

Write-Host ""
Write-Host "Parsing source files..."
$names   = Parse-PipeFile $namesFile   2
$tips    = Parse-PipeFile $tooltipFile 3
$sandbox = Parse-PipeFile $sandboxFile 2

Write-Host "  Names   : $($names.Count) entries"
Write-Host "  Tooltips: $($tips.Count) entries"
Write-Host "  Sandbox : $($sandbox.Count) entries"

# ── Validate ──────────────────────────────────────────────────────────────────

Write-Host ""
Write-Host "Validating..."
$errors   = 0
$warnings = 0

# Check counts
if ($names.Count -ne $masterKeys.Count) {
    Write-Warning "Names count $($names.Count) != expected $($masterKeys.Count)"
    $warnings++
}
if ($tips.Count -ne $masterKeys.Count) {
    Write-Warning "Tooltips count $($tips.Count) != expected $($masterKeys.Count)"
    $warnings++
}

# Check all master keys present
foreach ($k in $masterKeys) {
    if (-not $names.Contains($k)) {
        Write-Warning "Missing name entry: $k"
        $warnings++
    }
    if (-not $tips.Contains($k)) {
        Write-Warning "Missing tooltip entry: $k"
        $warnings++
    }
}

# Check no em-dashes; check empty values
$emDash = [string][char]0x2014
foreach ($k in $names.Keys) {
    $v = $names[$k][0]
    if ($v -eq '') { Write-Warning "Empty name: $k"; $warnings++ }
    if ($v.Contains($emDash)) { Write-Warning "Em-dash in name [$k]: $v"; $warnings++ }
}
foreach ($k in $tips.Keys) {
    $flavor = $tips[$k][0]
    $skill  = $tips[$k][1]
    if ($flavor -eq '') { Write-Warning "Empty flavor: $k"; $warnings++ }
    if ($skill  -eq '') { Write-Warning "Empty skill: $k";  $warnings++ }
    if ($flavor.Contains($emDash)) { Write-Warning "Em-dash in tooltip [$k]: $flavor"; $warnings++ }
}

Write-Host "  Validation: $errors error(s), $warnings warning(s)"

# ── Build output entries ───────────────────────────────────────────────────────

Write-Host ""
Write-Host "Applying line breaks and building output..."

$nameJson    = [ordered]@{}
$tooltipJson = [ordered]@{}
$sandboxJson = [ordered]@{}

$breakWarnings = 0
foreach ($k in $names.Keys) {
    $nameJson["Base.$k"] = $names[$k][0]
}

foreach ($k in $tips.Keys) {
    $flavor = $tips[$k][0]
    $skill  = $tips[$k][1]

    # Strip any accidental \n already in source (translator shouldn't add these)
    $flavor = ($flavor -replace '\\n', ' ') -replace '\s{2,}', ' '

    $broken = Apply-LineBreak $flavor
    if ($broken -ne $flavor -and $broken -notmatch '\\n') {
        # Apply-LineBreak returned unchanged but text > 55 — count as warning
        $breakWarnings++
    }

    # Post-break length check
    $lineParts = $broken -split '\\n', 2
    foreach ($lp in $lineParts) {
        if ($lp.Length -gt 55) {
            Write-Warning "Line > 55 chars after break [$k]: '$lp' ($($lp.Length) chars)"
            $breakWarnings++
        }
    }

    $tooltipJson["Tooltip_$k"] = $broken + '\n\n' + $skill
}

# Sandbox: keys are already full names
foreach ($k in $sandbox.Keys) {
    $sandboxJson[$k] = $sandbox[$k][0]
}

Write-Host "  Line-break warnings: $breakWarnings"

# ── Write output ──────────────────────────────────────────────────────────────

if (-not (Test-Path $outDir)) {
    New-Item -ItemType Directory -Path $outDir | Out-Null
    Write-Host ""
    Write-Host "Created directory: $outDir"
}

$nameOut    = Join-Path $outDir 'ItemName.json'
$tooltipOut = Join-Path $outDir 'Tooltip.json'
$sandboxOut = Join-Path $outDir 'Sandbox.json'

Write-JsonFile $nameOut    $nameJson
Write-JsonFile $tooltipOut $tooltipJson
Write-JsonFile $sandboxOut $sandboxJson

# Verify no BOM on each file
foreach ($f in @($nameOut, $tooltipOut, $sandboxOut)) {
    $firstByte = ([System.IO.File]::ReadAllBytes($f))[0]
    $bom = if ($firstByte -eq 123) { 'OK' } else { "WRONG ($firstByte) - BOM?" }
    Write-Host "  First byte [$([System.IO.Path]::GetFileName($f))]: $bom"
}

Write-Host ""
Write-Host "=== Done ==="
Write-Host "  ItemName.json : $($nameJson.Count) entries -> $nameOut"
Write-Host "  Tooltip.json  : $($tooltipJson.Count) entries -> $tooltipOut"
Write-Host "  Sandbox.json  : $($sandboxJson.Count) entries -> $sandboxOut"
if ($errors -gt 0) {
    Write-Host "  *** $errors ERRORS — review warnings above before committing ***" -ForegroundColor Red
}
