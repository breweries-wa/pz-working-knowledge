# Working Knowledge

A Project Zomboid Build 42 mod. Knox County is full of the working knowledge of people who aren't around to use it anymore — safety manuals, training guides, certification handbooks. Find one, read it, and carry a little of that forward.

![Working Knowledge](preview.png)

## How It Works

Documents scattered across Knox County can each be read once per character. Reading one grants a flat XP boost toward the associated skill. The boost is modest, meant to supplement your experience rather than replace it. Once read, the document can be passed to another survivor.

## Finding Documents

Different documents appear in contextually appropriate locations — a fleet maintenance log turns up at a car dealership, not a hospital. Spawn rates are intentionally low; finding one should feel like a find.

## Design

See [DESIGN.md](DESIGN.md) for full product requirements — mechanic details, skill coverage philosophy, and spawning rules.

The specific documents, their associated skills, spawn locations, and flavor text are catalogued in [DOCUMENTS.md](DOCUMENTS.md).

## Configuration

Both options are found under **Working Knowledge** in the Sandbox settings when creating a new game, or via **Sandbox** in an existing save's escape menu.

### Document Spawn Rate

Controls how often WK documents appear in loot containers.

There are three tiers of container, each twice as generous as the last:

- **Generic** — everyday desks and filing cabinets found throughout Knox County. These carry the full document catalogue, so any document could turn up anywhere.
- **Specific** — tied to a trade or building type that is reasonably common: the police filing cabinet, the fire station tool locker, the mechanic's shelf, the ranger station bookshelf. These carry only documents relevant to that location.
- **Rare** — tied to a trade or building type that is scarce map-wide: the pottery studio, the glass workshop, the knapping bench, the cobbler's station, the army bunker. Highest hit rate, because you may only ever find a handful of these.

The tiers exist because a flat per-container rate is not the same as how often you actually encounter something. A generic filing cabinet appears thousands of times across the map; a pottery studio appears a handful of times. Without a higher hit rate, the documents in those rare workshops would effectively never be found.

| Setting | Multiplier | Generic | Specific | Rare |
|---|---|---|---|---|
| Very Rare | 0.25× | 1 per 48 | 1 per 24 | 1 per 12 |
| Rare | 0.5× | 1 per 24 | 1 per 12 | 1 per 6 |
| **Normal** | **1×** | **1 per 12** | **1 per 6** | **1 per 3** |
| Common | 2× | 1 per 6 | 1 per 3 | 1 per 1.5 |
| Abundant | 4× | 1 per 3 | 1 per 1.5 | nearly every one |

Changing this setting mid-save only affects containers generated after the change — already-looted areas are not retroactively updated.

### XP Grant

The flat XP awarded when a document is read for the first time. Scaled by the game's passive skill multiplier. Default is **50**. Set to 0 to disable XP entirely while keeping documents as collectibles.

## Installation

1. Subscribe on the Steam Workshop *(link coming at release)*
2. Enable **Working Knowledge** in the Mods menu
3. Start or load a save

**Existing saves:** Documents will appear in any area you haven't visited yet. Containers that were already opened before the mod was added won't be affected — PZ spawns loot when a chunk is first loaded, not retroactively.

## Credits

Built with [Claude Code](https://claude.ai/code).
