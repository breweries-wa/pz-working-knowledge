# Working Knowledge — Design Document

## Concept

Knox County's filing cabinets hold more than paperwork. Safety manuals, training guides, reference handbooks — the working knowledge of people who aren't around anymore. A survivor who finds and reads these documents gets a head start on skills they might otherwise have to learn the hard way.

## Core Mechanic

Each document grants a **one-time, flat XP boost** when read. The amount is 25% of the XP required to reach level 1 in the associated skill — enough to feel meaningful without being a shortcut to competence.

- No level gating. Anyone can read anything.
- One boost per document type per character, tracked via player moddata. The item itself is not consumed — it can be passed to another survivor.
- Stacks normally with skill books and all other XP sources.

## Skill Coverage

Documents exist for a wide range of skills. The guiding question is: *would a workplace plausibly produce written reference material for this?*

**Crafting and trade skills** are the easiest fit — carpentry, mechanics, tailoring, cooking, electrical, and so on. Workplaces generate documentation for these constantly: safety manuals, certification guides, service logs.

**Survival and outdoor skills** — farming, fishing, foraging, trapping — fit through the lens of hobbyist and agricultural publications, extension office materials, and field guides filed in relevant offices.

**Combat and physical skills** are included selectively. The bar is higher, but the cases exist: a kitchen knife safety card, a spear fishing handbook, a martial arts studio's training syllabus, a marathon training guide. Finding a physical fitness document in the right context should feel earned, not arbitrary.

There is no blanket exclusion. If a plausible document can be named and placed believably, it belongs.

## Spawning

Documents spawn exclusively in **filing cabinets**, in rooms where that document would plausibly be found. Spawn weights are tuned so that finding a relevant document feels like a lucky discovery, not a routine pickup.

Targeted room types include generic offices, medical offices, car dealerships, police stations, university department offices, and others. Each document type maps to one or more specific room contexts — nothing spawns in a generic catch-all.

Note: Project Zomboid B42 does not have a dedicated school administration office room type. School-related documents use the closest available context (e.g., general office rooms).

## Item Design

Documents use a consistent visual identity — they look like workplace paperwork, not books. They appear in inventory under the Literature category for sorting purposes.

Each document has:
- A title that reads like a real workplace document (not "Carpentry Skill Book Vol. 2")
- Flavor text describing what it is and where it came from
- A specific skill association
- A specific spawn location rationale
