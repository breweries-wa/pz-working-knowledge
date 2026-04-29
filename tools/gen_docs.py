#!/usr/bin/env python3
"""
tools/gen_docs.py — Regenerate DOCUMENTS.md from Working Knowledge mod source files.

Run from anywhere inside the WorkingKnowledge/ tree:
    python tools/gen_docs.py
    # or, from the mod root:
    python WorkingKnowledge/tools/gen_docs.py

Source files read (all paths resolved relative to this script's parent dir):
    42/media/scripts/WK_items.txt               → DisplayName per item, definition order
    42/media/lua/shared/Translate/EN/Tooltip.json → authoritative short descriptions
    42/media/lua/client/WK_ContextMenu.lua       → perk string per item
    42/media/lua/server/WK_Distributions.lua     → container keys per item

What is preserved from the existing DOCUMENTS.md:
    • File header (everything before the first ## heading)
    • ## Category headings and their order
    • ### Section headings (including decorative markup like *(Sprinting)*)
    • Italic prose intro paragraphs under each ### Section

What is fully rebuilt:
    • Bullet lists — descriptions come from Tooltip.json, keys from Distributions.lua
    • Item order within each section follows WK_items.txt definition order

Run this script after any of the following changes:
    • Tooltip descriptions edited in Tooltip.json
    • New items added to WK_items.txt / WK_ContextMenu.lua / WK_Distributions.lua
    • Container key assignments changed in WK_Distributions.lua
    • New ### sections added to DOCUMENTS.md (intro prose preserved on next run)
"""

import re
import json
import os
import sys
from collections import defaultdict, OrderedDict

# ── File locations ─────────────────────────────────────────────────────────────
HERE         = os.path.dirname(os.path.abspath(__file__))
ROOT         = os.path.dirname(HERE)   # WorkingKnowledge/

ITEMS_TXT    = os.path.join(ROOT, "42", "media", "scripts", "WK_items.txt")
TOOLTIP_JSON = os.path.join(ROOT, "42", "media", "lua", "shared", "Translate", "EN", "Tooltip.json")
CONTEXT_LUA  = os.path.join(ROOT, "42", "media", "lua", "client", "WK_ContextMenu.lua")
DIST_LUA     = os.path.join(ROOT, "42", "media", "lua", "server", "WK_Distributions.lua")
DOCS_MD      = os.path.join(ROOT, "DOCUMENTS.md")

# ── ### Section heading → perk string used in WK_ContextMenu.lua ──────────────
# Key is the normalised heading text (stripped of decorative markup).
SECTION_TO_PERK = {
    "Aiming":        "Aiming",
    "Reloading":     "Reloading",
    "Axe":           "Axe",
    "Long Blade":    "LongBlade",
    "Maintenance":   "Maintenance",
    "Short Blade":   "SmallBlade",
    "Short Blunt":   "SmallBlunt",
    "Long Blunt":    "Blunt",
    "Spear":         "Spear",
    "Blacksmithing": "Blacksmith",
    "Carpentry":     "Woodwork",
    "Carving":       "Carving",
    "Cooking":       "Cooking",
    "Electrical":    "Electricity",
    "Glassmaking":   "Glassmaking",
    "Knapping":      "FlintKnapping",
    "Masonry":       "Masonry",
    "Mechanics":     "Mechanics",
    "Pottery":       "Pottery",
    "Tailoring":     "Tailoring",
    "Welding":       "MetalWelding",
    "Agriculture":   "Farming",
    "Animal Care":   "Husbandry",
    "Butchering":    "Butchering",
    "Running":       "Sprinting",   # heading is "Running *(Sprinting)*"
    "Strength":      "Strength",
    "First Aid":     "Doctor",
    "Fishing":       "Fishing",
    "Foraging":      "PlantScavenging",
    "Tracking":      "Tracking",
    "Trapping":      "Trapping",
}


# ── Parsers ───────────────────────────────────────────────────────────────────

def parse_items():
    """Return OrderedDict{bare_type: display_name} in WK_items.txt definition order."""
    result = OrderedDict()
    with open(ITEMS_TXT, encoding="utf-8") as f:
        text = f.read()
    for m in re.finditer(r'\bitem\s+(WK_\w+)\s*\{([^}]+)\}', text, re.DOTALL):
        bare = m.group(1)
        body = m.group(2)
        dn = re.search(r'DisplayName\s*=\s*(.+?)\s*,', body)
        if dn:
            result[bare] = dn.group(1).strip()
    return result


def parse_tooltips():
    """Return {bare_type: short_desc} — description only, without the 'Trains:' suffix."""
    with open(TOOLTIP_JSON, encoding="utf-8") as f:
        data = json.load(f)
    result = {}
    for key, val in data.items():
        if not key.startswith("Tooltip_WK_"):
            continue
        bare = key[len("Tooltip_"):]           # strip "Tooltip_" prefix
        desc = val.split("\n\nTrains:")[0].strip()
        result[bare] = desc
    return result


def parse_perks():
    """Return {bare_type: perk_str} from the WK_DOCS table in WK_ContextMenu.lua."""
    with open(CONTEXT_LUA, encoding="utf-8") as f:
        text = f.read()
    result = {}
    for m in re.finditer(r'\b(WK_\w+)\s*=\s*"(\w+)"', text):
        result[m.group(1)] = m.group(2)
    return result


def parse_distributions():
    """
    Return {bare_type: [ContainerKey, ...]} — keys in first-appearance order.

    Handles both patterns in WK_Distributions.lua:
        addMany(dist.ContainerKey.items, { {"WK_xxx", weight}, ... })
        addToItems(dist.ContainerKey.items, "WK_xxx", weight)
    """
    with open(DIST_LUA, encoding="utf-8") as f:
        text = f.read()
    result = defaultdict(list)

    # addMany blocks: if dist.ContainerKey and dist.ContainerKey.items then ... end
    for block_m in re.finditer(
        r'if\s+dist\.(\w+)\s+and\s+dist\.\w+\.items\s+then(.*?)end',
        text, re.DOTALL
    ):
        container = block_m.group(1)
        body = block_m.group(2)
        for item_m in re.finditer(r'"(WK_\w+)"', body):
            bare = item_m.group(1)
            if container not in result[bare]:
                result[bare].append(container)

    # Standalone addToItems calls
    for m in re.finditer(
        r'addToItems\s*\(\s*dist\.(\w+)\.items\s*,\s*"(WK_\w+)"', text
    ):
        container, bare = m.group(1), m.group(2)
        if container not in result[bare]:
            result[bare].append(container)

    return dict(result)


def parse_docs():
    """
    Parse existing DOCUMENTS.md structure.

    Returns:
        header_lines: list[str]  — lines before the first ## heading (trailing blanks stripped)
        sections: list[dict]     — one entry per ### heading, in file order:
            h2         str  — "## Combat — Firearms"
            h3_raw     str  — "### Running *(Sprinting)*"  (exact, for output)
            h3_key     str  — "Running"  (normalised, for SECTION_TO_PERK lookup)
            intro_lines list[str]  — lines between heading and first bullet
    """
    with open(DOCS_MD, encoding="utf-8") as f:
        lines = [l.rstrip('\n') for l in f.readlines()]

    header_lines = []
    sections = []
    current_h2 = None
    current_sec = None
    seen_first_h2 = False
    in_intro = False

    for line in lines:
        if line == '---':
            continue   # structural separator — reproduced in output

        if line.startswith('## '):
            seen_first_h2 = True
            current_h2 = line
            current_sec = None
            in_intro = False
            continue

        if line.startswith('### '):
            h3_raw = line
            # Normalise: strip "### " then drop " *(anything)*" decorations
            h3_plain = line[4:]
            h3_key = re.sub(r'\s*\(.*?\)\s*', '', h3_plain)   # remove (...)
            h3_key = re.sub(r'\*', '', h3_key).strip()         # remove stray *
            current_sec = {
                'h2':          current_h2,
                'h3_raw':      h3_raw,
                'h3_key':      h3_key,
                'intro_lines': [],
            }
            sections.append(current_sec)
            in_intro = True
            continue

        if not seen_first_h2:
            header_lines.append(line)
            continue

        if current_sec is not None:
            if line.startswith('- '):
                in_intro = False   # first bullet — stop collecting intro
                continue           # skip existing bullets entirely
            if in_intro:
                current_sec['intro_lines'].append(line)

    # Strip trailing blank lines from header
    while header_lines and not header_lines[-1].strip():
        header_lines.pop()

    return header_lines, sections


# ── Output helpers ────────────────────────────────────────────────────────────

def trim_blank_edges(lines):
    """Return lines with leading and trailing blank entries removed."""
    start, end = 0, len(lines)
    while start < end and not lines[start].strip():
        start += 1
    while end > start and not lines[end - 1].strip():
        end -= 1
    return lines[start:end]


def make_bullet(display, desc, keys):
    if keys:
        keys_str = ', '.join(f'`{k}`' for k in keys)
        return f'- **{display}** — {desc} Keys: {keys_str}'
    return f'- **{display}** — {desc}'


# ── Main ──────────────────────────────────────────────────────────────────────

def main():
    # Load all data sources
    items    = parse_items()        # bare → display_name  (ordered)
    tooltips = parse_tooltips()     # bare → short_desc
    perks    = parse_perks()        # bare → perk_str
    dists    = parse_distributions()  # bare → [ContainerKey, ...]

    header_lines, sections = parse_docs()

    # Build perk → [bare_type, ...] preserving WK_items.txt order
    perk_to_items = defaultdict(list)
    for bare in items:            # iterate in definition order
        perk = perks.get(bare)
        if perk:
            perk_to_items[perk].append(bare)

    # ── Generate output ───────────────────────────────────────────────────────
    out = []

    # File header
    out.extend(header_lines)
    out.append('')
    out.append('---')
    out.append('')

    prev_h2 = None

    for sec in sections:
        h2      = sec['h2']
        h3_raw  = sec['h3_raw']
        h3_key  = sec['h3_key']

        # ── Category separator ────────────────────────────────────────────────
        if h2 != prev_h2:
            if prev_h2 is not None:
                # End of previous category: trim any trailing blank we added,
                # then emit the --- separator.
                while out and out[-1] == '':
                    out.pop()
                out.append('')
                out.append('---')
                out.append('')
            out.append(h2)
            prev_h2 = h2

        # ── Section heading ───────────────────────────────────────────────────
        out.append('')
        out.append(h3_raw)
        out.append('')

        # ── Intro prose (preserved verbatim) ─────────────────────────────────
        intro = trim_blank_edges(sec['intro_lines'])
        out.extend(intro)
        out.append('')

        # ── Bullets ───────────────────────────────────────────────────────────
        perk = SECTION_TO_PERK.get(h3_key)
        if perk is None:
            print(f"  WARNING: no SECTION_TO_PERK entry for '{h3_key}' "
                  f"(heading: {h3_raw})", file=sys.stderr)
            out.append(f'<!-- gen_docs.py: no perk mapping for section "{h3_key}" -->')
            continue

        bare_list = perk_to_items.get(perk, [])
        if not bare_list:
            print(f"  WARNING: no items found for perk '{perk}' "
                  f"(section: {h3_key})", file=sys.stderr)
        for bare in bare_list:
            display = items[bare]
            desc    = tooltips.get(bare, '(missing tooltip)')
            keys    = dists.get(bare, [])
            out.append(make_bullet(display, desc, keys))

    # Final newline
    out.append('')

    result = '\n'.join(out)
    with open(DOCS_MD, 'w', encoding='utf-8', newline='\n') as f:
        f.write(result)

    # ── Summary ───────────────────────────────────────────────────────────────
    total = sum(len(v) for v in perk_to_items.values())
    print(f"Wrote {DOCS_MD}")
    print(f"Total items: {total}")
    print()
    print(f"{'Section':<22} {'Perk':<20} Items")
    print('-' * 55)
    for sec in sections:
        perk  = SECTION_TO_PERK.get(sec['h3_key'], '???')
        count = len(perk_to_items.get(perk, []))
        print(f"  {sec['h3_key']:<20} {perk:<20} {count}")


if __name__ == '__main__':
    main()
