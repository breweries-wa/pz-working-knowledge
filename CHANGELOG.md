# Changelog

All notable changes to Working Knowledge are documented here.

## [0.6] - 2026-05-04

### Fixed
- Sandbox options (Document Spawn Rate, XP Grant) now appear correctly in the
  Custom Sandbox screen with proper labels and tooltips; the translation file
  was not being found because the sandbox translation scanner only reads from
  the Steam Workshop content path, not the local mods folder

## [0.5] - 2026-05-03

### Fixed
- XP now granted correctly in singleplayer; the server-side XP guard was checking the same
  modData key the client had already written, and in singleplayer both sides share the same
  underlying modData object — so the guard always fired and XP was never awarded. Server now
  uses a separate internal key (`WK_xp_*`) that the client never touches

## [0.4] - 2026-05-03

### Fixed
- Reading a document now correctly grants XP and marks it as read on the first read in
  multiplayer (hosted and dedicated servers); a bug in the read-state ordering caused the
  mod to write its state after the vanilla inventory refresh had already run, which on some
  server configurations prevented XP from being granted until a second read

## [0.3] - 2026-05-03

### Added
- **Document Spawn Rate** sandbox option (Very Rare / Rare / Normal / Common / Abundant) — scales
  all WK loot weights by 0.25× to 4×; default is Normal (1×); does not affect already-generated
  containers, only new ones
- 11 new container types now carry WK documents:
  - Thematic: blacksmith literature rack, tailoring/fabric store, ranger station bookshelf,
    medical office desk, garden/nursery store misc shelf
  - Office desks: generic business office, home office, classy home office, medical waiting-room
    reception desk
  - Classroom desks: elementary (Boy Scout / youth-program handouts) and secondary (HS athletics,
    home ec, woodshop)

### Changed
- All container spawn weights recalibrated to consistent math-based targets — ~10 expected
  containers at Normal sandbox (10% hit chance per container) for most locations; ~20 expected
  (5% hit chance) for containers already carrying high-value loot: Army Bunker Lockers, Police
  Desk, Mechanic Electrical Shelf, Car Dealer Filing Cabinet
- WK documents removed from `GunStoreCounter` (deprecated/empty in B42) and
  `UniversityFilingCabinet_Glassmaking` (stub/empty in B42); generic desk and filing cabinet
  pools provide fallback coverage for those locations
- Medical office documents moved from bookshelf pool to the desk — they now appear in the desk
  you actually interact with in the room

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
