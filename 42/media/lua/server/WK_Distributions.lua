-- Add Working Knowledge documents to relevant loot tables.
-- This file runs after vanilla distribution tables are loaded.

local function addToItems(itemsTable, typeName, weight)
    table.insert(itemsTable, typeName)
    table.insert(itemsTable, weight)
end

local function addMany(itemsTable, entries)
    for _, entry in ipairs(entries) do
        addToItems(itemsTable, entry[1], entry[2])
    end
end

local dist = ProceduralDistributions.list

-- ── Military ─────────────────────────────────────────────────────────────────
-- ArmySurplusLiterature: the book/magazine rack in a surplus store.
--   Already carries vanilla skill books, so WK docs fit naturally.
if dist.ArmySurplusLiterature and dist.ArmySurplusLiterature.items then
    addMany(dist.ArmySurplusLiterature.items, {
        { "WK_VietnamRiflemanNotes",    0.25   },  -- Aiming
        { "WK_NavalGunnersManual",      0.25   },  -- Reloading
        { "WK_GuardForceWeaponsManual", 0.25   },  -- Reloading
        { "WK_CombatShootingDrills",    0.25   },  -- Reloading
        { "WK_TacticalReloadRef",       0.25   },  -- Reloading
        { "WK_WWIIBayonetTraining",     0.25   },  -- Spear
        { "WK_ArmyAPFTManual",          0.25   },  -- Sprinting
        { "WK_ArmyCombatMedic",         0.25   },  -- First Aid
        { "WK_ArmyCombatLifter",        0.25   },  -- Strength
        { "WK_NavySEALReconPamph",      0.25   },  -- Tracking
        { "WK_SARTrackingTraining",     0.12 },  -- Tracking
        { "WK_ArmyMessHallSOP",         0.12 },  -- Cooking
    })
end


-- ArmyBunkerLockers: personal lockers — fitness manuals, field notes, personal copies.
if dist.ArmyBunkerLockers and dist.ArmyBunkerLockers.items then
    addMany(dist.ArmyBunkerLockers.items, {
        { "WK_ArmyAPFTManual",          0.25   },  -- Sprinting
        { "WK_ArmyCombatLifter",        0.25   },  -- Strength
        { "WK_VietnamRiflemanNotes",    0.12 },  -- Aiming
        { "WK_ArmyCombatMedic",         0.12 },  -- First Aid
        { "WK_NavySEALReconPamph",      0.12 },  -- Tracking
    })
end

-- ArmyBunkerStorage: supply storage — a few tactical and maintenance references.
if dist.ArmyBunkerStorage and dist.ArmyBunkerStorage.items then
    addMany(dist.ArmyBunkerStorage.items, {
        { "WK_NavalGunnersManual",      0.12 },  -- Reloading
        { "WK_ArmyCombatMedic",         0.12 },  -- First Aid
        { "WK_GuardForceWeaponsManual", 0.12 },  -- Reloading
    })
end

-- ── Police / Law Enforcement ─────────────────────────────────────────────────
if dist.PoliceFilingCabinet and dist.PoliceFilingCabinet.items then
    addMany(dist.PoliceFilingCabinet.items, {
        { "WK_KCPDFirearmsQual",        0.25   },
        { "WK_RangeSafetyOfficerRef",   0.25   },
        { "WK_DefensiveHandgunRef",     0.25   },
        { "WK_SheriffQualLog",          0.25   },
        { "WK_TacticalReloadRef",       0.25   },
        { "WK_MagazineDrillCard",       0.25   },
        { "WK_ArmorersWeaponsRef",      0.25   },
        { "WK_ImpactWeaponMaintSOP",    0.25   },
        { "WK_KCPDImpactWeaponsRef",    0.25   },
        { "WK_LEFitnessStandardsRef",   0.25   },
        { "WK_NRAPistolInstructorMan",  0.12 },
        { "WK_KYConcealedCarryGuide",   0.25   },
        { "WK_FBIQualScorebook",        0.25   },
        { "WK_PoliceAcademyHandgun",    0.25   },
        { "WK_RevolverSpeedloaderCard", 0.25   },
        { "WK_RangemasterDrillBook",    0.12 },
        { "WK_NightstickTrainingMan",   0.25   },
        { "WK_RiotBatonInstructorRef",  0.25   },
        { "WK_PoliceRecruitFitness",    0.25   },
        { "WK_BloodhoundHandlerCard",   0.25   },
    })
end

if dist.PoliceDesk and dist.PoliceDesk.items then
    addMany(dist.PoliceDesk.items, {
        { "WK_KCPDFirearmsQual",        0.25   },
        { "WK_DefensiveHandgunRef",     0.25   },
        { "WK_TacticalReloadRef",       0.25   },
        { "WK_MagazineDrillCard",       0.25   },
        { "WK_ImpactWeaponMaintSOP",    0.25   },
        { "WK_KCPDImpactWeaponsRef",    0.25   },
        { "WK_PoliceAcademyHandgun",    0.12 },
        { "WK_CombatShootingDrills",    0.12 },
        { "WK_PoliceRecruitFitness",    0.12 },
    })
end

-- ── Gun Store ────────────────────────────────────────────────────────────────
if dist.GunStoreCounter and dist.GunStoreCounter.items then
    addMany(dist.GunStoreCounter.items, {
        { "WK_RangeSafetyOfficerRef",   0.25   },
        { "WK_MagazineDrillCard",       0.25   },
        { "WK_ArmorersWeaponsRef",      0.25   },
        { "WK_PracticalShootingRef",    0.25   },
        { "WK_NRAPistolInstructorMan",  0.25   },
        { "WK_BullseyeMatchProgramme",  0.25   },
        { "WK_KYConcealedCarryGuide",   0.12 },
        { "WK_USPSARulebook",           0.25   },
        { "WK_VietnamRiflemanNotes",    0.12 },
        { "WK_HighPowerNewsletter",     0.25   },
        { "WK_RevolverSpeedloaderCard", 0.12 },
        { "WK_CombatShootingDrills",    0.25   },
        { "WK_GunsmithStripping",       0.25   },
        { "WK_ShotgunReloadingCard",    0.25   },
        { "WK_RangemasterDrillBook",    0.25   },
    })
end

-- ── Fire Station ─────────────────────────────────────────────────────────────
if dist.FireStorageTools and dist.FireStorageTools.items then
    addMany(dist.FireStorageTools.items, {
        { "WK_ForcibleEntryRef",        0.25 },
        { "WK_FirefighterHandToolSOP",  0.25 },
        { "WK_CPRAEDRef",               0.25 },
        { "WK_EmergencyTriageRef",      0.25 },
        { "WK_FireAcademyFitnessRef",   0.25 },
        { "WK_WorkplaceFirstAidSOP",    0.25 },
        { "WK_EngineCompanyAxeRef",     0.25 },
        { "WK_EMTRescueKnifeCard",      0.25 },
        { "WK_FirefighterHaliganRef",   0.25 },
        { "WK_PulaskiSwingScale",       0.25 },
        { "WK_ParamedicProtocolMan",    0.25 },
        { "WK_ArmyCombatMedic",         0.25 },
        { "WK_SARTrackingTraining",     0.25 },
    })
end

-- ── Blacksmith / Metal Shop ───────────────────────────────────────────────────
if dist.WildWestBlacksmith and dist.WildWestBlacksmith.items then
    addMany(dist.WildWestBlacksmith.items, {
        { "WK_ASTMMaterialSpecRef",      0.25 },
        { "WK_ForgeHeatTreatGuide",      0.25 },
        { "WK_IndustrialMetalworkRef",   0.25 },
        { "WK_BlacksmithGuildStandards", 0.25 },
        { "WK_ABANANewsletter",          0.25 },
        { "WK_FarrierShoeingNotes",      0.25 },
        { "WK_FrontierForgeRef",         0.25 },
        { "WK_SwordsmithApprDiary",      0.25 },
        { "WK_ColonialIronworker",       0.25 },
    })
end

if dist.MetalShopTools and dist.MetalShopTools.items then
    addMany(dist.MetalShopTools.items, {
        { "WK_ASTMMaterialSpecRef",    0.25   },
        { "WK_ForgeHeatTreatGuide",    0.25   },
        { "WK_IndustrialMetalworkRef", 0.25   },
        { "WK_EdgeToolSharpeningRef",  0.25   },
        { "WK_WhetstoneSelectionRef",  0.25   },
        { "WK_BladesmithToolCare",     0.25   },
        { "WK_KnifemakerTestCutLog",   0.25   },
        { "WK_BlacksmithHammerCard",   0.25   },
        { "WK_SteelmillProcessRef",    0.25   },
        { "WK_KnifemakerForgeWeld",    0.25   },
        { "WK_MotorControlSchem",      0.12 },
    })
end

-- ── Welding Shop ─────────────────────────────────────────────────────────────
if dist.WeldingWorkshopTools and dist.WeldingWorkshopTools.items then
    addMany(dist.WeldingWorkshopTools.items, {
        { "WK_AWSD11WeldingRef",        0.25 },
        { "WK_WeldingProcSpecRef",      0.25 },
        { "WK_ElectrodeFillMetalRef",   0.25 },
        { "WK_WeldInspectionRef",       0.25 },
        { "WK_OSHAWeldingSafety",       0.25 },
        { "WK_AWSCertWelderManual",     0.25 },
        { "WK_PipefittersWelding",      0.25 },
        { "WK_AluminumMIGRef",          0.25 },
        { "WK_UAWWeldingShopSOP",       0.25 },
        { "WK_StickRodSelectionGuide",  0.25 },
        { "WK_AerospaceTIGNotes",       0.25 },
    })
end

-- ── Auto Shop / Mechanic ──────────────────────────────────────────────────────
if dist.MechanicShelfBooks and dist.MechanicShelfBooks.items then
    addMany(dist.MechanicShelfBooks.items, {
        { "WK_OBDIICodeRef",        0.25 },
        { "WK_TorqueSpecsRef",      0.25 },
        { "WK_BrakeServiceRef",     0.25 },
        { "WK_AutoElecDiagRef",     0.25 },
        { "WK_FleetMaintenanceLog", 0.25 },
        { "WK_AutoBodyHammerNotes", 0.25 },
        { "WK_ASEStudyGuide",       0.25 },
        { "WK_KYVehicleInspection", 0.25 },
        { "WK_BriggsStrattonRepair",1 },
        { "WK_DieselTroubleshoot",  0.25 },
        { "WK_FordPickupShopMan",   0.25 },
        { "WK_ChevyTechServiceBull",1 },
        { "WK_AutoBodyWeldingRef",  0.25 },
    })
end

if dist.MechanicShelfBrakes and dist.MechanicShelfBrakes.items then
    addToItems(dist.MechanicShelfBrakes.items, "WK_BrakeServiceRef", 1)
end

if dist.MechanicShelfElectric and dist.MechanicShelfElectric.items then
    addToItems(dist.MechanicShelfElectric.items, "WK_AutoElecDiagRef", 1)
end

if dist.CarDealerFilingCabinet and dist.CarDealerFilingCabinet.items then
    addMany(dist.CarDealerFilingCabinet.items, {
        { "WK_OBDIICodeRef",         0.25   },
        { "WK_TorqueSpecsRef",       0.25   },
        { "WK_FleetMaintenanceLog",  0.25   },
        { "WK_ASEStudyGuide",        0.12 },
        { "WK_ChevyTechServiceBull", 0.12 },
        { "WK_TruckingFleetPMSched", 0.25   },
    })
end

-- ── Electrician ───────────────────────────────────────────────────────────────
if dist.ElectricianTools and dist.ElectricianTools.items then
    addMany(dist.ElectricianTools.items, {
        { "WK_NECArticleRef",            0.25 },
        { "WK_WireGaugeAmpacityRef",     0.25 },
        { "WK_OSHAElectricalSafety",     0.25 },
        { "WK_ConduitFillRef",           0.25 },
        { "WK_PanelInspectionChecklist", 0.25 },
        { "WK_IBEWApprentBook",          0.25 },
        { "WK_ResWiringText",            0.25 },
        { "WK_MotorControlSchem",        0.25 },
        { "WK_TransformerNamePlate",     0.25 },
        { "WK_GroundingBondingRef",      0.25 },
        { "WK_KYStateLicensingMan",      0.25 },
        { "WK_UndergroundCableRef",      0.25 },
    })
end

-- ── Glassmaking ───────────────────────────────────────────────────────────────
if dist.UniversityFilingCabinet_Glassmaking and dist.UniversityFilingCabinet_Glassmaking.items then
    addMany(dist.UniversityFilingCabinet_Glassmaking.items, {
        { "WK_GlassAnnealingRef",    0.25 },
        { "WK_KilnFormingRef",       0.25 },
        { "WK_FloatGlassManufRef",   0.25 },
        { "WK_PenlandStudioGlass",   0.25 },
        { "WK_CorningEngineering",   0.25 },
        { "WK_BorosilicateLampwork", 0.25 },
    })
end

-- ── Farming / Agriculture ─────────────────────────────────────────────────────
if dist.ToolCabinetFarming and dist.ToolCabinetFarming.items then
    addMany(dist.ToolCabinetFarming.items, {
        { "WK_KnoxExtensionGuide",      0.25   },
        { "WK_SoilTestInterpretRef",    0.25   },
        { "WK_PesticideApplicationRef", 0.25   },
        { "WK_IrrigationSchedulingRef", 0.25   },
        { "WK_LivestockHealthRef",      0.25   },
        { "WK_VaccinationDosageRef",    0.25   },
        { "WK_KDALivestockRef",         0.25   },
        { "WK_BushHogOperatorRef",      0.25   },
        { "WK_CornDetasselingCard",     0.25   },
        { "WK_KaiserBladeFieldRef",     0.12 },
        { "WK_FarrierShoeingNotes",     0.12 },
        { "WK_KYExtensionCookbook",     0.12 },
        { "WK_BriggsStrattonRepair",    0.12 },
        { "WK_FFAVocAgText",            0.25   },
        { "WK_KYExtensionAgBull",       0.25   },
        { "WK_FertSpreaderCalCard",     0.25   },
        { "WK_USDACropRotation",        0.25   },
        { "WK_NoTillFarmingMan",        0.25   },
        { "WK_KYTobaccoGrowGuide",      0.25   },
        { "WK_KYCattlemensNews",        0.25   },
        { "WK_FFALivestockJudging",     0.25   },
        { "WK_TysonPoultryGrower",      0.25   },
        { "WK_SheepGoatBreeder",        0.25   },
        { "WK_SwineProductionMan",      0.25   },
        { "WK_DairyHerdMgmt",           0.25   },
        { "WK_DeerProcessorGuide",      0.12 },
        { "WK_WildGameProcessor",       0.12 },
        { "WK_FarmStrengthManual",      0.25   },
        { "WK_KYWildflowerGuide",       0.25   },
        { "WK_USDAAnimalDamage",        0.25   },
    })
end

-- ── Butcher ───────────────────────────────────────────────────────────────────
if dist.ButcherLiterature and dist.ButcherLiterature.items then
    addMany(dist.ButcherLiterature.items, {
        { "WK_USDAMeatGradingRef",    0.25 },
        { "WK_PrimalSubPrimalRef",    0.25 },
        { "WK_HACCPMeatProcessing",   0.25 },
        { "WK_MeatFabricationRef",    0.25 },
        { "WK_ButchersBoningGuide",   0.25 },
        { "WK_UFCWCutleryTechRef",    0.25 },
        { "WK_UnionStockyardsCut",    0.25 },
        { "WK_DeerProcessorGuide",    0.25 },
        { "WK_SausageProductionNotes",1 },
        { "WK_SmallSlaughterhouseSOP",1 },
        { "WK_KosherButcheringRef",   0.25 },
        { "WK_CharcuterieProduction", 0.25 },
        { "WK_HolidayTurkeyCard",     0.25 },
        { "WK_CharcutierApprDiary",   0.25 },
        { "WK_WildGameProcessor",     0.25 },
    })
end

-- ── Tool Store (back room) ────────────────────────────────────────────────────
if dist.ToolStoreMisc and dist.ToolStoreMisc.items then
    addMany(dist.ToolStoreMisc.items, {
        { "WK_FramingHammerCard",      0.25   },
        { "WK_CrowbarApplicationsRef", 0.25   },
        { "WK_FramingSquareCard",      0.25   },
        { "WK_EdgeToolSharpeningRef",  0.25   },
        { "WK_WhetstoneSelectionRef",  0.25   },
        { "WK_WoodenHandleShaftRef",   0.25   },
        { "WK_KnifeHandleFittingRef",  0.25   },
        { "WK_MortarMixRef",           0.25   },
        { "WK_HandToolConditionRef",   0.25   },
        { "WK_OSHAHandToolSafety",     0.25   },
        { "WK_TimberCruiserHandbook",  0.25   },
        { "WK_AppalachianFellingNotes",1   },
        { "WK_MountainRescueIceAxe",   0.25   },
        { "WK_BackcountryHatchetCard", 0.25   },
        { "WK_TechnicalRescueAxeRef",  0.12 },
        { "WK_KaiserBladeFieldRef",    0.25   },
        { "WK_JewelersFileCard",       0.25   },
        { "WK_ShopApprenticeToolLog",  0.25   },
        { "WK_BowSawSetGuide",         0.25   },
        { "WK_ProductionFramerCard",   0.25   },
        { "WK_MasonsHammerRef",        0.25   },
        { "WK_RoofersFlashingCard",    0.25   },
        { "WK_LandClearingMaul",       0.25   },
        { "WK_BIATraditionalBrick",    0.25   },
        { "WK_StonecutterApprenNote",  0.25   },
        { "WK_ConcreteFinishersRef",   0.25   },
        { "WK_FieldstoneWalls",        0.25   },
        { "WK_PavingStoneInstall",     0.25   },
        { "WK_CabinetmakerJoinery",    0.25   },
        { "WK_RoofFramingCalcCard",    0.25   },
        { "WK_LogHomeBuildersRef",     0.25   },
        { "WK_FurnitureMakerNotes",    0.25   },
    })
end

-- ── Generic Desk ─────────────────────────────────────────────────────────────
-- Weight 0.07 per item: ~44 items → cumulative ~3.1 WK weight.
-- At base pool ~80 with 3 rolls: ~10% chance of a doc per desk.
if dist.DeskGeneric and dist.DeskGeneric.items then
    addMany(dist.DeskGeneric.items, {
        { "WK_GolfSwingRef",           0.07 },
        { "WK_BaseballSwingRef",       0.07 },
        { "WK_LEFitnessStandardsRef",  0.07 },
        { "WK_BullseyeMatchProgramme", 0.07 },
        { "WK_BoyScoutRiflery",        0.07 },
        { "WK_HighPowerNewsletter",    0.07 },
        { "WK_BoyScoutAxemanship",     0.07 },
        { "WK_SCAHeavyFightCard",      0.07 },
        { "WK_LarpFightChoreography",  0.07 },
        { "WK_ScoutTroopToolCare",     0.07 },
        { "WK_ScoutCampcraftKnife",    0.07 },
        { "WK_CricketBowlersGuide",    0.07 },
        { "WK_LacrosseCoachManual",    0.07 },
        { "WK_HockeyStickHandling",    0.07 },
        { "WK_SCAPolearmRef",          0.07 },
        { "WK_TrackPoleVaultCard",     0.07 },
        { "WK_KarateBoStaffMan",       0.07 },
        { "WK_ScoutsPolearmDemo",      0.07 },
        { "WK_ScoutMetalwork",         0.07 },
        { "WK_SpoonCarvingNotes",      0.07 },
        { "WK_ChipCarvingPattern",     0.07 },
        { "WK_WaldenWoodcrafter",      0.07 },
        { "WK_JuniorHighWoodshop",     0.07 },
        { "WK_AppalachianFolkArt",     0.07 },
        { "WK_KilnFusedJewelry",       0.07 },
        { "WK_BeadSocietyLampwork",    0.07 },
        { "WK_RendezvousMtnMan",       0.07 },
        { "WK_BSAPrimitiveSurvival",   0.07 },
        { "WK_ChildrenPotteryLesson",  0.07 },
        { "WK_BeginnerWheelNotes",     0.07 },
        { "WK_HomeEcSewingText",       0.07 },
        { "WK_AgEdJudgingCard",        0.07 },
        { "WK_HSTrackCoachManual",     0.07 },
        { "WK_KYHSAARulebook",         0.07 },
        { "WK_SprintIntervalCard",     0.07 },
        { "WK_CrossCountryRef",        0.07 },
        { "WK_HSFootballCondition",    0.07 },
        { "WK_BMXRacingTraining",      0.07 },
        { "WK_RugbyStrengthMan",       0.07 },
        { "WK_HSWrestlingStrength",    0.07 },
        { "WK_PediatricFirstAid",      0.07 },
        { "WK_ScoutCarpentryMerit",    0.07 },
    })
end

-- ── Filing Cabinet (Generic) ──────────────────────────────────────────────────
-- Weight 0.01 per item: ~157 items → cumulative ~1.6 WK weight.
-- At base pool ~100 with 5 rolls: ~7-8% chance of a doc per cabinet.
-- Six cabinets + six desks yields roughly one WK document on average.
if dist.FilingCabinetGeneric and dist.FilingCabinetGeneric.items then
    addMany(dist.FilingCabinetGeneric.items, {
        -- Carpentry / construction
        { "WK_LumberYardManual",          0.01 },
        { "WK_SpanTablesRef",             0.01 },
        { "WK_NDSWoodConstruction",       0.01 },
        { "WK_FinishCarpentryNotes",      0.01 },
        { "WK_FramingSquareCard",         0.01 },
        -- Aiming / law enforcement
        { "WK_SheriffQualLog",            0.01 },
        { "WK_FBIQualScorebook",          0.01 },
        { "WK_BoyScoutRiflery",           0.01 },
        { "WK_VietnamRiflemanNotes",      0.01 },
        { "WK_NavalGunnersManual",        0.01 },
        { "WK_GuardForceWeaponsManual",   0.01 },
        -- Maintenance / tool care
        { "WK_KnifeMaintenanceLog",       0.01 },
        { "WK_HandToolConditionRef",      0.01 },
        { "WK_ShopApprenticeToolLog",     0.01 },
        { "WK_BarberRazorStropping",      0.01 },
        { "WK_AntiqueDealerCare",         0.01 },
        { "WK_UFCWCutleryTechRef",        0.01 },
        -- OSHA / workplace safety
        { "WK_OSHALoggingRef",            0.01 },
        { "WK_OSHAHandToolSafety",        0.01 },
        { "WK_OSHAElectricalSafety",      0.01 },
        { "WK_OSHAWeldingSafety",         0.01 },
        { "WK_OSHAFirstAidRef",           0.01 },
        -- Construction / masonry
        { "WK_MortarMixRef",              0.01 },
        { "WK_ASTMC90MasonryRef",         0.01 },
        { "WK_BrickBlockInspectionRef",   0.01 },
        { "WK_ConcreteMixRef",            0.01 },
        { "WK_BIATraditionalBrick",       0.01 },
        { "WK_ChimneySweepInspect",       0.01 },
        { "WK_HistoricPointingMan",       0.01 },
        { "WK_KCMasonsLocalNews",         0.01 },
        -- Electrical
        { "WK_NECArticleRef",             0.01 },
        { "WK_WireGaugeAmpacityRef",      0.01 },
        { "WK_ConduitFillRef",            0.01 },
        { "WK_PanelInspectionChecklist",  0.01 },
        { "WK_IBEWApprentBook",           0.01 },
        { "WK_GroundingBondingRef",       0.01 },
        { "WK_KYStateLicensingMan",       0.01 },
        -- Mechanics / fleet
        { "WK_FleetMaintenanceLog",       0.01 },
        { "WK_KYVehicleInspection",       0.01 },
        { "WK_TruckingFleetPMSched",      0.01 },
        -- Cooking / food safety
        { "WK_HACCPFoodSafetyPlan",       0.01 },
        { "WK_TempTimeControlChart",      0.01 },
        { "WK_ServSafeRef",               0.01 },
        { "WK_LineCookStationRef",        0.01 },
        { "WK_SullivanCulinaryText",      0.01 },
        { "WK_KYExtensionCookbook",       0.01 },
        { "WK_ArmyMessHallSOP",           0.01 },
        { "WK_SchoolCafeteriaRef",        0.01 },
        { "WK_PitBossBBQManual",          0.01 },
        { "WK_HeritageCookbook1957",      0.01 },
        { "WK_TruckStopGriddleNotes",     0.01 },
        -- First Aid / medical
        { "WK_WorkplaceFirstAidSOP",      0.01 },
        { "WK_CPRAEDRef",                 0.01 },
        { "WK_EmergencyTriageRef",        0.01 },
        { "WK_ParamedicProtocolMan",      0.01 },
        { "WK_ERTriageTextbook",          0.01 },
        { "WK_NursingFundamentals",       0.01 },
        { "WK_PharmacistDispensing",      0.01 },
        { "WK_ArmyCombatMedic",           0.01 },
        { "WK_NursingHomeCareMan",        0.01 },
        { "WK_WoundCareSuturing",         0.01 },
        { "WK_PediatricFirstAid",         0.01 },
        -- Tailoring / textile industry
        { "WK_PatternGradingRef",         0.01 },
        { "WK_IndustrialSewingRef",       0.01 },
        { "WK_FiberFabricRef",            0.01 },
        { "WK_GarmentQualityRef",         0.01 },
        { "WK_SearsPatternCatalog",       0.01 },
        { "WK_CarhartUnionShop",          0.01 },
        { "WK_AlterationsTailorCard",     0.01 },
        { "WK_HomeEcSewingText",          0.01 },
        { "WK_TheatricalCostumeShop",     0.01 },
        { "WK_HancockFabricsManual",      0.01 },
        { "WK_UpholstererGuide",          0.01 },
        { "WK_BridalSeamstressNotes",     0.01 },
        -- Agriculture / extension office
        { "WK_KnoxExtensionGuide",        0.01 },
        { "WK_SoilTestInterpretRef",      0.01 },
        { "WK_PesticideApplicationRef",   0.01 },
        { "WK_IrrigationSchedulingRef",   0.01 },
        { "WK_FFAVocAgText",              0.01 },
        { "WK_KYExtensionAgBull",         0.01 },
        { "WK_UKAgEconNotes",             0.01 },
        { "WK_KYTobaccoGrowGuide",        0.01 },
        { "WK_RodaleOrganicPamph",        0.01 },
        -- Animal Care (vet clinic, farm office)
        { "WK_LivestockHealthRef",        0.01 },
        { "WK_VaccinationDosageRef",      0.01 },
        { "WK_ReproductiveMgmtBinder",    0.01 },
        { "WK_KDALivestockRef",           0.01 },
        { "WK_KYCattlemensNews",          0.01 },
        { "WK_TysonPoultryGrower",        0.01 },
        { "WK_TrackVetDailyLog",          0.01 },
        -- Butchering / food processing
        { "WK_USDAMeatGradingRef",        0.01 },
        { "WK_HACCPMeatProcessing",       0.01 },
        { "WK_UnionStockyardsCut",        0.01 },
        { "WK_SmallSlaughterhouseSOP",    0.01 },
        { "WK_CharcuterieProduction",     0.01 },
        -- Running / fitness
        { "WK_LEFitnessStandardsRef",     0.01 },
        { "WK_FireAcademyFitnessRef",     0.01 },
        { "WK_NCAAStrengthCondition",     0.01 },
        { "WK_BostonMarathonTrain",       0.01 },
        { "WK_ArmyAPFTManual",            0.01 },
        -- Strength / ergonomics
        { "WK_NIOSHLiftingRef",           0.01 },
        { "WK_ManualMaterialsHandRef",    0.01 },
        { "WK_USPFPowerlifting",          0.01 },
        { "WK_OlympicLiftingNotes",       0.01 },
        { "WK_StrongmanTrainingMan",      0.01 },
        { "WK_MuscleBuilderMag",          0.01 },
        { "WK_ArmyCombatLifter",          0.01 },
        { "WK_FreightDockLiftCard",       0.01 },
        { "WK_CollegeStrengthLog",        0.01 },
        -- Fishing
        { "WK_KYFishingRegs",             0.01 },
        { "WK_CommercialFishingSafetyRef",0.01 },
        { "WK_KYBassFishingClub",         0.01 },
        { "WK_CrappieAnglersGuide",       0.01 },
        { "WK_KYTroutStocking",           0.01 },
        { "WK_FlyTyingPattern",           0.01 },
        { "WK_KYRiverCatfishing",         0.01 },
        { "WK_WalleyeFishingRef",         0.01 },
        { "WK_NoodlingHandfishing",       0.01 },
        { "WK_KYMusselRegs",              0.01 },
        -- Foraging / botany
        { "WK_EdiblePlantsRef",           0.01 },
        { "WK_ToxicPlantRef",             0.01 },
        { "WK_KYWildflowerGuide",         0.01 },
        { "WK_StalkingWildAsparagus",     0.01 },
        { "WK_HerbalPharmacyEnc",         0.01 },
        { "WK_WildMushroomHunt",          0.01 },
        { "WK_BackyardForaging",          0.01 },
        { "WK_EthnobotanyText",           0.01 },
        { "WK_TraditionalAppPlants",      0.01 },
        { "WK_HunterGatherersRef",        0.01 },
        { "WK_WildEdiblesCookbook",       0.01 },
        -- Tracking / wildlife management
        { "WK_KDFWRGameMgmtRef",          0.01 },
        { "WK_ApacheScoutTracking",       0.01 },
        { "WK_KYCoonHunting",             0.01 },
        { "WK_SARTrackingTraining",       0.01 },
        { "WK_TurkeyHuntingRef",          0.01 },
        { "WK_WildlifeBiologyText",       0.01 },
        { "WK_BowHunterCamoMan",          0.01 },
        { "WK_NavySEALReconPamph",        0.01 },
        { "WK_SignReadingNotes",          0.01 },
        -- Axe / forestry
        { "WK_TimberCruiserHandbook",     0.01 },
        { "WK_BoyScoutAxemanship",        0.01 },
        { "WK_BackcountryHatchetCard",    0.01 },
        { "WK_TechnicalRescueAxeRef",     0.01 },
        { "WK_KDFWRDeadwoodPamph",        0.01 },
        { "WK_KYHighwayBrushControl",     0.01 },
        -- Long Blade / brush clearing
        { "WK_CornDetasselingCard",       0.01 },
        { "WK_AppalachianHerbalCutting",  0.01 },
        { "WK_StateParksTrailCrew",       0.01 },
        { "WK_CaneCuttingManual",         0.01 },
        -- Short Blade
        { "WK_SushiChefKnifeBook",        0.01 },
        { "WK_TaxidermistCapingRef",      0.01 },
        { "WK_SurgeonScalpelRef",         0.01 },
        { "WK_NorthwoodsFilletCard",      0.01 },
        -- Short Blunt / heavy tools
        { "WK_RailroadSpikeMaul",         0.01 },
        { "WK_CaverHammerPickRef",        0.01 },
        { "WK_TrackMaintenanceSledge",    0.01 },
        -- Spear / pole weapons
        { "WK_KDFWRBowfishingRef",        0.01 },
        { "WK_CherokeeFishSpear",         0.01 },
        { "WK_WWIIBayonetTraining",       0.01 },
        { "WK_PrimitiveSpearfishing",     0.01 },
        -- Blacksmithing / metalwork
        { "WK_ABANANewsletter",           0.01 },
        { "WK_SteelmillProcessRef",       0.01 },
        { "WK_ASTMMaterialSpecRef",       0.01 },
        { "WK_IndustrialMetalworkRef",    0.01 },
        -- Welding
        { "WK_WeldingProcSpecRef",        0.01 },
        { "WK_WeldInspectionRef",         0.01 },
        { "WK_AWSCertWelderManual",       0.01 },
        { "WK_UAWWeldingShopSOP",         0.01 },
        -- Carving / woodcraft
        { "WK_CountryCarversBook",        0.01 },
        { "WK_AppalachianFolkArt",        0.01 },
        { "WK_BowyerTilleringNotes",      0.01 },
        -- Glassmaking
        { "WK_CorningEngineering",        0.01 },
        { "WK_StainedGlassChurch",        0.01 },
        { "WK_AntiqueBottleCollect",      0.01 },
        { "WK_TiffanyMethodRef",          0.01 },
        { "WK_NeonSignBenders",           0.01 },
        -- Knapping
        { "WK_CherokeeArrowhead",         0.01 },
        { "WK_FieldArchKnapping",         0.01 },
        { "WK_PrimBowhunterFlint",        0.01 },
        { "WK_AmateurArchPamph",          0.01 },
        { "WK_ObsidianSourceRef",         0.01 },
        { "WK_KCMuseumLithicCat",         0.01 },
        { "WK_ToolStoneQualityCard",      0.01 },
        -- Pottery / ceramics
        { "WK_UnivCeramicsText",          0.01 },
        { "WK_PenlandWheelRef",           0.01 },
        { "WK_RakuFiringNotes",           0.01 },
        { "WK_SaltGlazeStoneware",        0.01 },
        { "WK_AppFolkPotteryPamph",       0.01 },
        { "WK_StudioKilnRepair",          0.01 },
        { "WK_CommercialPotteryProc",     0.01 },
        -- Trapping
        { "WK_KDFWRTrapperRegs",          0.01 },
        { "WK_NTAFurHandlersGuide",       0.01 },
        { "WK_KYBeaverTrapPamph",         0.01 },
        { "WK_FoxHolerLureRecipes",       0.01 },
        { "WK_ConibearSetTechnique",      0.01 },
        { "WK_FootholdStakingRef",        0.01 },
        { "WK_USDAAnimalDamage",          0.01 },
        { "WK_KDFWRNuisanceWild",         0.01 },
        { "WK_MuskratPeltStretch",        0.01 },
        { "WK_FurAuctionGrading",         0.01 },
        -- Carpentry / timber framing
        { "WK_LogHomeBuildersRef",        0.01 },
        { "WK_AppTimberFramePamph",       0.01 },
        { "WK_VocSchoolBuildTrades",      0.01 },
    })
end
