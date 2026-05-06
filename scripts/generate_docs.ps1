<#
.SYNOPSIS
    Regenerates DOCUMENTS.md from source files for the Working Knowledge mod.

.DESCRIPTION
    - Parses ItemName_EN.txt to build Title -> WK_Key lookup
    - Parses Tooltip.json for flavor text (part before \n\nTrains:)
    - Parses WK_Distributions.lua for loot pool names per item
    - Reads DOCUMENTS.md structure skeleton (headers, dividers, italic paragraphs)
    - Outputs reformatted DOCUMENTS.md with bold title, flavor text, and pool backtick tags

.NOTES
    Working directory: C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\WorkingKnowledge\
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$root = 'C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\WorkingKnowledge'

$itemNameFile  = Join-Path $root '42\media\lua\shared\Translate\EN\ItemName_EN.txt'
$tooltipFile   = Join-Path $root '42\media\lua\shared\Translate\EN\Tooltip.json'
$distFile      = Join-Path $root '42\media\lua\server\WK_Distributions.lua'
$docsFile      = Join-Path $root 'DOCUMENTS.md'

# ── 1. Build Title -> WK_Key map from ItemName_EN.txt ──────────────────────────
# Lines look like:  Item_WK_SomeKey = "Title String",
$titleToKey = @{}
$keyToTitle = @{}

foreach ($line in [System.IO.File]::ReadAllLines($itemNameFile)) {
    if ($line -match 'Item_WK_(\w+)\s*=\s*"(.+?)"') {
        $key   = $Matches[1]   # e.g. KCPDFirearmsQual
        $title = $Matches[2]   # e.g. KCPD Patrol Firearms Qualification Standards
        $titleToKey[$title] = $key
        $keyToTitle[$key]   = $title
    }
}

Write-Host "Loaded $($titleToKey.Count) item title->key mappings."

# ── 2. Parse Tooltip.json for flavor text ─────────────────────────────────────
# Keys look like: "Tooltip_WK_SomeKey": "Flavor text.\n\nTrains: Skill"
# We want only the part before \n\nTrains:
$keyToFlavor = @{}

$tooltipJson = [System.IO.File]::ReadAllText($tooltipFile)

# Match each key-value pair
$tooltipRegex = [regex]'"Tooltip_WK_(\w+)"\s*:\s*"((?:[^"\\]|\\.)*)"\s*[,}]'
foreach ($m in $tooltipRegex.Matches($tooltipJson)) {
    $key        = $m.Groups[1].Value
    $rawFlavor  = $m.Groups[2].Value

    # Split on \n\nTrains: and keep only the part before it
    # The raw JSON uses literal \n (two characters: backslash + n)
    $parts = $rawFlavor -split '\\n\\nTrains:', 2
    $flavor = $parts[0]

    # Replace remaining literal \n with actual newline for output
    $flavor = $flavor -replace '\\n', "`n"

    $keyToFlavor[$key] = $flavor.Trim()
}

Write-Host "Loaded $($keyToFlavor.Count) flavor text entries."

# ── 3. Parse WK_Distributions.lua for pool names per WK_Key ───────────────────
# We scan for lines containing "WK_KeyName" inside addMany/addToItems blocks.
# The pool name is read from the most-recently-seen
#   addMany(dist.PoolName.items, ...) or addToItems(dist.PoolName.items, ...)
# context before each item mention.

$keyToPools = @{}   # key -> [ordered list of unique pool names]

$distLines = [System.IO.File]::ReadAllLines($distFile)
$currentPool = $null

foreach ($line in $distLines) {
    # Detect pool context: addMany(dist.PoolName.items, or addToItems(dist.PoolName.items,
    if ($line -match '(?:addMany|addToItems)\s*\(\s*dist\.(\w+)\.items') {
        $currentPool = $Matches[1]
    }

    # Detect item reference: "WK_KeyName"
    if ($line -match '"WK_(\w+)"') {
        $itemKey = $Matches[1]
        if ($currentPool) {
            if (-not $keyToPools.ContainsKey($itemKey)) {
                $keyToPools[$itemKey] = [System.Collections.Generic.List[string]]::new()
            }
            if ($keyToPools[$itemKey] -notcontains $currentPool) {
                $keyToPools[$itemKey].Add($currentPool)
            }
        }
    }
}

Write-Host "Loaded pool data for $($keyToPools.Count) items."

# ── 3b. Build a normalized-title lookup for fuzzy matching ────────────────────
# Some skeleton titles may have minor wording differences vs ItemName_EN.txt.
# Build a map of lowercased/stripped title -> canonical title for fallback.
$normalizedToTitle = @{}
foreach ($t in $titleToKey.Keys) {
    $norm = ($t -replace "[^a-z0-9]", '').ToLower()
    $normalizedToTitle[$norm] = $t
}

function Get-WKKey($skeletonTitle) {
    # Exact match first
    if ($titleToKey.ContainsKey($skeletonTitle)) {
        return $titleToKey[$skeletonTitle]
    }
    # Normalized fallback
    $norm = ($skeletonTitle -replace "[^a-z0-9]", '').ToLower()
    if ($normalizedToTitle.ContainsKey($norm)) {
        $canonicalTitle = $normalizedToTitle[$norm]
        return $titleToKey[$canonicalTitle]
    }
    return $null
}

function Get-CanonicalTitle($skeletonTitle) {
    if ($titleToKey.ContainsKey($skeletonTitle)) {
        return $skeletonTitle
    }
    $norm = ($skeletonTitle -replace "[^a-z0-9]", '').ToLower()
    if ($normalizedToTitle.ContainsKey($norm)) {
        return $normalizedToTitle[$norm]
    }
    return $skeletonTitle
}

# ── 4. Process DOCUMENTS.md skeleton and generate output ──────────────────────
$inputLines  = [System.IO.File]::ReadAllLines($docsFile)
$outputLines = [System.Collections.Generic.List[string]]::new()

# Track statistics
$boldCount      = 0
$noKeyCount     = 0
$noKeyTitles    = @()

# We read the first 9 lines as the header verbatim (up to and including the first ---)
$headerDone = $false
$headerLineCount = 0

# State: track whether we are inside an item block (to add blank line after pool tags)
# The item entries in the skeleton are lines starting with "- **"

for ($i = 0; $i -lt $inputLines.Count; $i++) {
    $line = $inputLines[$i]

    # Output header verbatim (first 9 lines)
    if (-not $headerDone) {
        $outputLines.Add($line)
        $headerLineCount++
        if ($headerLineCount -ge 9) {
            $headerDone = $true
        }
        continue
    }

    # Structural lines: section headers, dividers, blank lines, italic paragraphs.
    # These are always passed through as-is.
    # Suppress consecutive blank lines to keep the file tidy.
    $isStructural = ($line -match '^##' -or $line -match '^---' -or $line -eq '' -or $line -match '^\*[^*].*\*$')
    if ($isStructural) {
        # Suppress double blank lines
        if ($line -eq '' -and $outputLines.Count -gt 0 -and $outputLines[$outputLines.Count - 1] -eq '') {
            continue
        }
        $outputLines.Add($line)
        continue
    }

    # Detect item lines in either format:
    #   Original skeleton: "- **Title** — description. Keys: ..."
    #   Already-formatted: "**Title**" or "**Title** <!-- NO KEY -->"
    $isItemLine = $false
    $title = $null
    if ($line -match '^- \*\*(.+?)\*\*') {
        $isItemLine = $true
        $title = $Matches[1]
    } elseif ($line -match '^\*\*(.+?)\*\*') {
        $isItemLine = $true
        $title = $Matches[1]
        # Strip trailing comment if present (e.g. <!-- NO KEY -->)
        $title = ($title -replace '\s*<!--.*?-->', '').Trim()
    }

    if ($isItemLine -and $null -ne $title) {
        # Consume and discard any following non-structural lines that belong to
        # the OLD entry (flavor lines, pool tag lines from a previous run).
        # We do NOT advance $i here — the loop body itself will skip them
        # naturally because they won't match any item or structural pattern.
        # (They fall through to the "else: discard" at the bottom.)

        # Look up WK_Key from title (with normalized fallback)
        $wkKey = Get-WKKey $title
        $canonicalTitle = Get-CanonicalTitle $title
        if ($null -ne $wkKey) {
            $title = $canonicalTitle  # use authoritative title from ItemName_EN.txt

            # Get flavor text
            $flavor = ''
            if ($keyToFlavor.ContainsKey($wkKey)) {
                $flavor = $keyToFlavor[$wkKey]
            }

            # Get pools
            $poolTags = ''
            if ($keyToPools.ContainsKey($wkKey)) {
                $pools = $keyToPools[$wkKey]
                $poolTags = ($pools | ForEach-Object { "``$_``" }) -join ' '
            }

            # Output formatted block.
            # Trailing two spaces on each line (except the last) force markdown <br>.
            $outputLines.Add("**$title**  ")
            $boldCount++

            # Flavor text: split on newline if present
            if ($flavor -ne '') {
                $flavorParts = $flavor -split "`n", 2
                if ($flavorParts.Count -gt 1 -and $flavorParts[1].Trim() -ne '') {
                    $outputLines.Add($flavorParts[0].Trim() + "  ")
                    $outputLines.Add($flavorParts[1].Trim() + "  ")
                } else {
                    $outputLines.Add($flavorParts[0].Trim() + "  ")
                }
            }

            # Pool tags line — no trailing spaces needed, blank line follows
            $outputLines.Add($poolTags)

            # Blank line after entry — suppress if pool tags was already blank
            if ($outputLines.Count -eq 0 -or $outputLines[$outputLines.Count - 1] -ne '') {
                $outputLines.Add('')
            }

        } else {
            # No WK_Key found even after normalization
            $noKeyCount++
            $noKeyTitles += $title
            $outputLines.Add("**$title** <!-- NO KEY -->")
            $outputLines.Add('')
            $boldCount++
        }

        continue
    }

    # Any other line (flavor text or pool tags from a previously-formatted run):
    # silently discard — the script regenerates all item content from source files.
}

# ── 5. Write output ────────────────────────────────────────────────────────────
[System.IO.File]::WriteAllLines($docsFile, $outputLines, [System.Text.UTF8Encoding]::new($false))

Write-Host ""
Write-Host "=== Done ==="
Write-Host "Bold entries written : $boldCount"
Write-Host "Entries with NO KEY  : $noKeyCount"
if ($noKeyTitles.Count -gt 0) {
    Write-Host "Unmatched titles:"
    foreach ($t in $noKeyTitles) {
        Write-Host "  - $t"
    }
}
Write-Host "Output written to: $docsFile"
