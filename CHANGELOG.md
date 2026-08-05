# Changelog

All notable changes to Working Knowledge are documented here.

## [1.0] - 2026-08-05

### Added
- 20 new document locations in skill-specific workplaces: pottery studios, glass
  workshops, knapping and carving benches, blacksmith and tailoring workstations,
  cobbler and leatherworking benches, clock repair shops, furniture factories, and
  ranger, hunting and police lockers

### Changed
- Every location's spawn rate now follows one of three tiers instead of being tuned
  location by location: everyday furniture gives one document per 12 containers,
  trade-specific locations one per 6, and scarce workshops one per 3. Rates previously
  ranged from one per 1.8 to one per 69 with no consistent rule, which left some
  locations so sparse their documents were effectively unobtainable. Expect noticeably
  more documents overall, and scarce workshops to be worth going out of your way for
- Loot tables rewritten for performance. A generic filing cabinet previously evaluated
  235 loot entries every time one was generated; it now evaluates 23

### Fixed
- 12 documents could never spawn. The Glassmaking, Pottery and sport shooting documents
  lost their locations in 0.3 and were never given new ones. All 372 documents are now
  findable, and the Pottery and Glassmaking ones have proper workshop homes
- The version shown in the Mods menu was stuck at 0.7 since May. The bumps were being
  written to a mod.info the game does not read in B42

## [0.9] - 2026-07-30

### Fixed
- Item names now display correctly following the B42.20 update, which changed the expected translation file format

## [0.8] - 2026-05-08

### Added
- Translations: French, Brazilian Portuguese, Russian, Simplified Chinese, and Spanish — item
  names, tooltips, and sandbox option labels are now fully localised in all five languages

### Changed
- All 372 document tooltip descriptions rewritten for consistent style and line width

### Fixed
- 32 documents were not spawning in the world due to a syntax issue in the item definitions

## [0.7] - 2026-05-04

### Fixed
- Sandbox option labels now display correctly instead of showing raw translation keys;
  B42.15 switched from `Sandbox_EN.txt` to `Sandbox.json` format and we now ship both

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
