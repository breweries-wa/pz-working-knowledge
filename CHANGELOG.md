# Changelog

All notable changes to Working Knowledge are documented here.

## [0.2] - 2026-05-01

### Added
- Expanded document catalogue from 117 to 372 documents — 12 per supported skill, covering
  carpentry, cooking, first aid, aiming, reloading, fitness, foraging, fishing, trapping,
  tracking, smithing, welding, tailoring, pottery, and more
- Military loot locations: Army Surplus Literature, Army Bunker Lockers, Army Bunker Storage
- All 372 documents now registered in the translation system (`ItemName_EN.txt`), fixing
  missing display names in LootZed and the in-game inventory UI
- 29 documents that were defined but unplaced now distributed across appropriate containers

### Changed
- Thematic container weights reduced (÷4) relative to initial release — spawn rates in
  dedicated locations (police cabinets, fire station, gun store, etc.) are now meaningfully
  rare rather than common
- Removed Working Knowledge documents from ArmyStorageGuns (weapons armory crates are not
  a natural place for literature)

### Fixed
- Progress bar on document reads now finishes in sync with the server-side reading action;
  previously the bar would fill while the character continued reading indefinitely

## [0.1] - 2026-04-27

- Initial release: 117 documents across core skills
- One-time flat XP grant per document, per character — re-reading does nothing
- Documents placed in filing cabinets, desks, and thematic containers matching their subject
- Sandbox option to configure XP amount
