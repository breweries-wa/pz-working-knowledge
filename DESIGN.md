# Working Knowledge — Design Document

## Concept

Knox County holds the working knowledge of people who aren't around anymore. Safety manuals, training guides, reference handbooks — practical documentation from the jobs and hobbies of the old world. A survivor who finds and reads one of these documents gets a head start on skills they might otherwise have to learn the hard way.

## Core Mechanic

Each document grants a **one-time, flat XP boost** when read. The base grant is 50 XP, scaled by the game's passive skill rate — an untrained character receives around 12 XP, a practiced one noticeably more. The boost is meaningful without being a shortcut to competence.

Read state is tracked per character, per document type. Reading any copy of a document marks that document as read for that character — finding another copy of the same manual won't grant XP again. A different survivor who finds the same copy can still benefit from it.

## Skill Coverage

Documents exist for a wide range of skills. The guiding question is: *would a workplace or hobby plausibly produce written reference material for this?*

**Crafting and trade skills** are the easiest fit — carpentry, mechanics, tailoring, cooking, electrical, and so on. Workplaces generate documentation for these constantly: safety manuals, certification guides, service logs.

**Survival and outdoor skills** — farming, fishing, foraging, trapping — fit through the lens of hobbyist and agricultural publications, extension office materials, and field guides.

**Combat and physical skills** are included selectively. The bar is higher, but the cases exist: a kitchen knife safety card, a spear fishing handbook, a martial arts studio's training syllabus, a marathon training guide. Finding a physical fitness document in the right context should feel earned, not arbitrary.

## Spawning

Documents spawn in containers where they would plausibly be found. Spawn weights are tuned so that finding a relevant document feels like a lucky discovery, not a routine pickup.

Container types include filing cabinets, store counters, and others appropriate to the location. Each document maps to one or more specific room contexts — nothing spawns in a generic catch-all.

## Item Design

Documents use a consistent visual identity — they look like workplace paperwork, not books. They appear in inventory under the Literature category for sorting purposes.

Each document has:
- A title that reads like a real workplace document (not "Carpentry Skill Book Vol. 2")
- Flavor text describing what it is and where it came from
- A specific skill association
- A specific spawn location rationale
