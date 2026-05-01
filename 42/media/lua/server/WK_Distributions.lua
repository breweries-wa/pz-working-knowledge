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
        { "WK_VietnamRiflemanNotes",    0.125   },  -- Aiming
        { "WK_NavalGunnersManual",      0.125   },  -- Reloading
        { "WK_GuardForceWeaponsManual", 0.125   },  -- Reloading
        { "WK_CombatShootingDrills",    0.125   },  -- Reloading
        { "WK_TacticalReloadRef",       0.125   },  -- Reloading
        { "WK_WWIIBayonetTraining",     0.125   },  -- Spear
        { "WK_ArmyAPFTManual",          0.125   },  -- Sprinting
        { "WK_ArmyCombatMedic",         0.125   },  -- First Aid
        { "WK_ArmyCombatLifter",        0.125   },  -- Strength
        { "WK_NavySEALReconPamph",      0.125   },  -- Tracking
        { "WK_SARTrackingTraining",     0.06 },  -- Tracking
        { "WK_ArmyMessHallSOP",         0.06 },  -- Cooking
    })
end


-- ArmyBunkerLockers: personal lockers — fitness manuals, field notes, personal copies.
if dist.ArmyBunkerLockers and dist.ArmyBunkerLockers.items then
    addMany(dist.ArmyBunkerLockers.items, {
        { "WK_ArmyAPFTManual",          0.125   },  -- Sprinting
        { "WK_ArmyCombatLifter",        0.125   },  -- Strength
        { "WK_VietnamRiflemanNotes",    0.06 },  -- Aiming
        { "WK_ArmyCombatMedic",         0.06 },  -- First Aid
        { "WK_NavySEALReconPamph",      0.06 },  -- Tracking
    })
end

-- ArmyBunkerStorage: supply storage — a few tactical and maintenance references.
if dist.ArmyBunkerStorage and dist.ArmyBunkerStorage.items then
    addMany(dist.ArmyBunkerStorage.items, {
        { "WK_NavalGunnersManual",      0.06 },  -- Reloading
        { "WK_ArmyCombatMedic",         0.06 },  -- First Aid
        { "WK_GuardForceWeaponsManual", 0.06 },  -- Reloading
    })
end

-- ── Police / Law Enforcement ─────────────────────────────────────────────────
if dist.PoliceFilingCabinet and dist.PoliceFilingCabinet.items then
    addMany(dist.PoliceFilingCabinet.items, {
        { "WK_KCPDFirearmsQual",        0.125   },
        { "WK_RangeSafetyOfficerRef",   0.125   },
        { "WK_DefensiveHandgunRef",     0.125   },
        { "WK_SheriffQualLog",          0.125   },
        { "WK_TacticalReloadRef",       0.125   },
        { "WK_MagazineDrillCard",       0.125   },
        { "WK_ArmorersWeaponsRef",      0.125   },
        { "WK_ImpactWeaponMaintSOP",    0.125   },
        { "WK_KCPDImpactWeaponsRef",    0.125   },
        { "WK_LEFitnessStandardsRef",   0.125   },
        { "WK_NRAPistolInstructorMan",  0.06 },
        { "WK_KYConcealedCarryGuide",   0.125   },
        { "WK_FBIQualScorebook",        0.125   },
        { "WK_PoliceAcademyHandgun",    0.125   },
        { "WK_RevolverSpeedloaderCard", 0.125   },
        { "WK_RangemasterDrillBook",    0.06 },
        { "WK_NightstickTrainingMan",   0.125   },
        { "WK_RiotBatonInstructorRef",  0.125   },
        { "WK_PoliceRecruitFitness",    0.125   },
        { "WK_BloodhoundHandlerCard",   0.125   },
    })
end

if dist.PoliceDesk and dist.PoliceDesk.items then
    addMany(dist.PoliceDesk.items, {
        { "WK_KCPDFirearmsQual",        0.125   },
        { "WK_DefensiveHandgunRef",     0.125   },
        { "WK_TacticalReloadRef",       0.125   },
        { "WK_MagazineDrillCard",       0.125   },
        { "WK_ImpactWeaponMaintSOP",    0.125   },
        { "WK_KCPDImpactWeaponsRef",    0.125   },
        { "WK_PoliceAcademyHandgun",    0.06 },
        { "WK_CombatShootingDrills",    0.06 },
        { "WK_PoliceRecruitFitness",    0.06 },
    })
end

-- ── Gun Store ────────────────────────────────────────────────────────────────
if dist.GunStoreCounter and dist.GunStoreCounter.items then
    addMany(dist.GunStoreCounter.items, {
        { "WK_RangeSafetyOfficerRef",   0.125   },
        { "WK_MagazineDrillCard",       0.125   },
        { "WK_ArmorersWeaponsRef",      0.125   },
        { "WK_PracticalShootingRef",    0.125   },
        { "WK_NRAPistolInstructorMan",  0.125   },
        { "WK_BullseyeMatchProgramme",  0.125   },
        { "WK_KYConcealedCarryGuide",   0.06 },
        { "WK_USPSARulebook",           0.125   },
        { "WK_VietnamRiflemanNotes",    0.06 },
        { "WK_HighPowerNewsletter",     0.125   },
        { "WK_RevolverSpeedloaderCard", 0.06 },
        { "WK_CombatShootingDrills",    0.125   },
        { "WK_GunsmithStripping",       0.125   },
        { "WK_ShotgunReloadingCard",    0.125   },
        { "WK_RangemasterDrillBook",    0.125   },
    })
end

-- ── Fire Station ─────────────────────────────────────────────────────────────
if dist.FireStorageTools and dist.FireStorageTools.items then
    addMany(dist.FireStorageTools.items, {
        { "WK_ForcibleEntryRef",        0.125 },
        { "WK_FirefighterHandToolSOP",  0.125 },
        { "WK_CPRAEDRef",               0.125 },
        { "WK_EmergencyTriageRef",      0.125 },
        { "WK_FireAcademyFitnessRef",   0.125 },
        { "WK_WorkplaceFirstAidSOP",    0.125 },
        { "WK_EngineCompanyAxeRef",     0.125 },
        { "WK_EMTRescueKnifeCard",      0.125 },
        { "WK_FirefighterHaliganRef",   0.125 },
        { "WK_PulaskiSwingScale",       0.125 },
        { "WK_ParamedicProtocolMan",    0.125 },
        { "WK_ArmyCombatMedic",         0.125 },
        { "WK_SARTrackingTraining",     0.125 },
    })
end

-- ── Blacksmith / Metal Shop ───────────────────────────────────────────────────
if dist.WildWestBlacksmith and dist.WildWestBlacksmith.items then
    addMany(dist.WildWestBlacksmith.items, {
        { "WK_ASTMMaterialSpecRef",      0.125 },
        { "WK_ForgeHeatTreatGuide",      0.125 },
        { "WK_IndustrialMetalworkRef",   0.125 },
        { "WK_BlacksmithGuildStandards", 0.125 },
        { "WK_ABANANewsletter",          0.125 },
        { "WK_FarrierShoeingNotes",      0.125 },
        { "WK_FrontierForgeRef",         0.125 },
        { "WK_SwordsmithApprDiary",      0.125 },
        { "WK_ColonialIronworker",       0.125 },
    })
end

if dist.MetalShopTools and dist.MetalShopTools.items then
    addMany(dist.MetalShopTools.items, {
        { "WK_ASTMMaterialSpecRef",    0.125   },
        { "WK_ForgeHeatTreatGuide",    0.125   },
        { "WK_IndustrialMetalworkRef", 0.125   },
        { "WK_EdgeToolSharpeningRef",  0.125   },
        { "WK_WhetstoneSelectionRef",  0.125   },
        { "WK_BladesmithToolCare",     0.125   },
        { "WK_KnifemakerTestCutLog",   0.125   },
        { "WK_BlacksmithHammerCard",   0.125   },
        { "WK_SteelmillProcessRef",    0.125   },
        { "WK_KnifemakerForgeWeld",    0.125   },
        { "WK_MotorControlSchem",      0.06 },
    })
end

-- ── Welding Shop ─────────────────────────────────────────────────────────────
if dist.WeldingWorkshopTools and dist.WeldingWorkshopTools.items then
    addMany(dist.WeldingWorkshopTools.items, {
        { "WK_AWSD11WeldingRef",        0.125 },
        { "WK_WeldingProcSpecRef",      0.125 },
        { "WK_ElectrodeFillMetalRef",   0.125 },
        { "WK_WeldInspectionRef",       0.125 },
        { "WK_OSHAWeldingSafety",       0.125 },
        { "WK_AWSCertWelderManual",     0.125 },
        { "WK_PipefittersWelding",      0.125 },
        { "WK_AluminumMIGRef",          0.125 },
        { "WK_UAWWeldingShopSOP",       0.125 },
        { "WK_StickRodSelectionGuide",  0.125 },
        { "WK_AerospaceTIGNotes",       0.125 },
    })
end

-- ── Auto Shop / Mechanic ──────────────────────────────────────────────────────
if dist.MechanicShelfBooks and dist.MechanicShelfBooks.items then
    addMany(dist.MechanicShelfBooks.items, {
        { "WK_OBDIICodeRef",        0.125 },
        { "WK_TorqueSpecsRef",      0.125 },
        { "WK_BrakeServiceRef",     0.125 },
        { "WK_AutoElecDiagRef",     0.125 },
        { "WK_FleetMaintenanceLog", 0.125 },
        { "WK_AutoBodyHammerNotes", 0.125 },
        { "WK_ASEStudyGuide",       0.125 },
        { "WK_KYVehicleInspection", 0.125 },
        { "WK_BriggsStrattonRepair",0.5 },
        { "WK_DieselTroubleshoot",  0.125 },
        { "WK_FordPickupShopMan",   0.125 },
        { "WK_ChevyTechServiceBull",0.5 },
        { "WK_AutoBodyWeldingRef",  0.125 },
    })
end

if dist.MechanicShelfBrakes and dist.MechanicShelfBrakes.items then
    addToItems(dist.MechanicShelfBrakes.items, "WK_BrakeServiceRef", 0.5)
end

if dist.MechanicShelfElectric and dist.MechanicShelfElectric.items then
    addToItems(dist.MechanicShelfElectric.items, "WK_AutoElecDiagRef", 0.5)
end

if dist.CarDealerFilingCabinet and dist.CarDealerFilingCabinet.items then
    addMany(dist.CarDealerFilingCabinet.items, {
        { "WK_OBDIICodeRef",         0.125   },
        { "WK_TorqueSpecsRef",       0.125   },
        { "WK_FleetMaintenanceLog",  0.125   },
        { "WK_ASEStudyGuide",        0.06 },
        { "WK_ChevyTechServiceBull", 0.06 },
        { "WK_TruckingFleetPMSched", 0.125   },
    })
end

-- ── Electrician ───────────────────────────────────────────────────────────────
if dist.ElectricianTools and dist.ElectricianTools.items then
    addMany(dist.ElectricianTools.items, {
        { "WK_NECArticleRef",            0.125 },
        { "WK_WireGaugeAmpacityRef",     0.125 },
        { "WK_OSHAElectricalSafety",     0.125 },
        { "WK_ConduitFillRef",           0.125 },
        { "WK_PanelInspectionChecklist", 0.125 },
        { "WK_IBEWApprentBook",          0.125 },
        { "WK_ResWiringText",            0.125 },
        { "WK_MotorControlSchem",        0.125 },
        { "WK_TransformerNamePlate",     0.125 },
        { "WK_GroundingBondingRef",      0.125 },
        { "WK_KYStateLicensingMan",      0.125 },
        { "WK_UndergroundCableRef",      0.125 },
    })
end

-- ── Glassmaking ───────────────────────────────────────────────────────────────
if dist.UniversityFilingCabinet_Glassmaking and dist.UniversityFilingCabinet_Glassmaking.items then
    addMany(dist.UniversityFilingCabinet_Glassmaking.items, {
        { "WK_GlassAnnealingRef",    0.125 },
        { "WK_KilnFormingRef",       0.125 },
        { "WK_FloatGlassManufRef",   0.125 },
        { "WK_PenlandStudioGlass",   0.125 },
        { "WK_CorningEngineering",   0.125 },
        { "WK_BorosilicateLampwork", 0.125 },
    })
end

-- ── Farming / Agriculture ─────────────────────────────────────────────────────
if dist.ToolCabinetFarming and dist.ToolCabinetFarming.items then
    addMany(dist.ToolCabinetFarming.items, {
        { "WK_KnoxExtensionGuide",      0.125   },
        { "WK_SoilTestInterpretRef",    0.125   },
        { "WK_PesticideApplicationRef", 0.125   },
        { "WK_IrrigationSchedulingRef", 0.125   },
        { "WK_LivestockHealthRef",      0.125   },
        { "WK_VaccinationDosageRef",    0.125   },
        { "WK_KDALivestockRef",         0.125   },
        { "WK_BushHogOperatorRef",      0.125   },
        { "WK_CornDetasselingCard",     0.125   },
        { "WK_KaiserBladeFieldRef",     0.06 },
        { "WK_FarrierShoeingNotes",     0.06 },
        { "WK_KYExtensionCookbook",     0.06 },
        { "WK_BriggsStrattonRepair",    0.06 },
        { "WK_FFAVocAgText",            0.125   },
        { "WK_KYExtensionAgBull",       0.125   },
        { "WK_FertSpreaderCalCard",     0.125   },
        { "WK_USDACropRotation",        0.125   },
        { "WK_NoTillFarmingMan",        0.125   },
        { "WK_KYTobaccoGrowGuide",      0.125   },
        { "WK_KYCattlemensNews",        0.125   },
        { "WK_FFALivestockJudging",     0.125   },
        { "WK_TysonPoultryGrower",      0.125   },
        { "WK_SheepGoatBreeder",        0.125   },
        { "WK_SwineProductionMan",      0.125   },
        { "WK_DairyHerdMgmt",           0.125   },
        { "WK_DeerProcessorGuide",      0.06 },
        { "WK_WildGameProcessor",       0.06 },
        { "WK_FarmStrengthManual",      0.125   },
        { "WK_KYWildflowerGuide",       0.125   },
        { "WK_USDAAnimalDamage",        0.125   },
    })
end

-- ── Butcher ───────────────────────────────────────────────────────────────────
if dist.ButcherLiterature and dist.ButcherLiterature.items then
    addMany(dist.ButcherLiterature.items, {
        { "WK_USDAMeatGradingRef",    0.125 },
        { "WK_PrimalSubPrimalRef",    0.125 },
        { "WK_HACCPMeatProcessing",   0.125 },
        { "WK_MeatFabricationRef",    0.125 },
        { "WK_ButchersBoningGuide",   0.125 },
        { "WK_UFCWCutleryTechRef",    0.125 },
        { "WK_UnionStockyardsCut",    0.125 },
        { "WK_DeerProcessorGuide",    0.125 },
        { "WK_SausageProductionNotes",0.5 },
        { "WK_SmallSlaughterhouseSOP",0.5 },
        { "WK_KosherButcheringRef",   0.125 },
        { "WK_CharcuterieProduction", 0.125 },
        { "WK_HolidayTurkeyCard",     0.125 },
        { "WK_CharcutierApprDiary",   0.125 },
        { "WK_WildGameProcessor",     0.125 },
    })
end

-- ── Tool Store (back room) ────────────────────────────────────────────────────
if dist.ToolStoreMisc and dist.ToolStoreMisc.items then
    addMany(dist.ToolStoreMisc.items, {
        { "WK_FramingHammerCard",      0.125   },
        { "WK_CrowbarApplicationsRef", 0.125   },
        { "WK_FramingSquareCard",      0.125   },
        { "WK_EdgeToolSharpeningRef",  0.125   },
        { "WK_WhetstoneSelectionRef",  0.125   },
        { "WK_WoodenHandleShaftRef",   0.125   },
        { "WK_KnifeHandleFittingRef",  0.125   },
        { "WK_MortarMixRef",           0.125   },
        { "WK_HandToolConditionRef",   0.125   },
        { "WK_OSHAHandToolSafety",     0.125   },
        { "WK_TimberCruiserHandbook",  0.125   },
        { "WK_AppalachianFellingNotes",0.5   },
        { "WK_MountainRescueIceAxe",   0.125   },
        { "WK_BackcountryHatchetCard", 0.125   },
        { "WK_TechnicalRescueAxeRef",  0.06 },
        { "WK_KaiserBladeFieldRef",    0.125   },
        { "WK_JewelersFileCard",       0.125   },
        { "WK_ShopApprenticeToolLog",  0.125   },
        { "WK_BowSawSetGuide",         0.125   },
        { "WK_ProductionFramerCard",   0.125   },
        { "WK_MasonsHammerRef",        0.125   },
        { "WK_RoofersFlashingCard",    0.125   },
        { "WK_LandClearingMaul",       0.125   },
        { "WK_BIATraditionalBrick",    0.125   },
        { "WK_StonecutterApprenNote",  0.125   },
        { "WK_ConcreteFinishersRef",   0.125   },
        { "WK_FieldstoneWalls",        0.125   },
        { "WK_PavingStoneInstall",     0.125   },
        { "WK_CabinetmakerJoinery",    0.125   },
        { "WK_RoofFramingCalcCard",    0.125   },
        { "WK_LogHomeBuildersRef",     0.125   },
        { "WK_FurnitureMakerNotes",    0.125   },
    })
end

-- ── Generic Desk ─────────────────────────────────────────────────────────────
-- Weight 0.07 per item: ~44 items → cumulative ~3.1 WK weight.
-- At base pool ~80 with 3 rolls: ~10% chance of a doc per desk.
if dist.DeskGeneric and dist.DeskGeneric.items then
    addMany(dist.DeskGeneric.items, {
        { "WK_GolfSwingRef",           0.035 },
        { "WK_BaseballSwingRef",       0.035 },
        { "WK_LEFitnessStandardsRef",  0.035 },
        { "WK_BullseyeMatchProgramme", 0.035 },
        { "WK_BoyScoutRiflery",        0.035 },
        { "WK_HighPowerNewsletter",    0.035 },
        { "WK_BoyScoutAxemanship",     0.035 },
        { "WK_SCAHeavyFightCard",      0.035 },
        { "WK_LarpFightChoreography",  0.035 },
        { "WK_ScoutTroopToolCare",     0.035 },
        { "WK_ScoutCampcraftKnife",    0.035 },
        { "WK_CricketBowlersGuide",    0.035 },
        { "WK_LacrosseCoachManual",    0.035 },
        { "WK_HockeyStickHandling",    0.035 },
        { "WK_SCAPolearmRef",          0.035 },
        { "WK_TrackPoleVaultCard",     0.035 },
        { "WK_KarateBoStaffMan",       0.035 },
        { "WK_ScoutsPolearmDemo",      0.035 },
        { "WK_ScoutMetalwork",         0.035 },
        { "WK_SpoonCarvingNotes",      0.035 },
        { "WK_ChipCarvingPattern",     0.035 },
        { "WK_WaldenWoodcrafter",      0.035 },
        { "WK_JuniorHighWoodshop",     0.035 },
        { "WK_AppalachianFolkArt",     0.035 },
        { "WK_KilnFusedJewelry",       0.035 },
        { "WK_BeadSocietyLampwork",    0.035 },
        { "WK_RendezvousMtnMan",       0.035 },
        { "WK_BSAPrimitiveSurvival",   0.035 },
        { "WK_ChildrenPotteryLesson",  0.035 },
        { "WK_BeginnerWheelNotes",     0.035 },
        { "WK_HomeEcSewingText",       0.035 },
        { "WK_AgEdJudgingCard",        0.035 },
        { "WK_HSTrackCoachManual",     0.035 },
        { "WK_KYHSAARulebook",         0.035 },
        { "WK_SprintIntervalCard",     0.035 },
        { "WK_CrossCountryRef",        0.035 },
        { "WK_HSFootballCondition",    0.035 },
        { "WK_BMXRacingTraining",      0.035 },
        { "WK_RugbyStrengthMan",       0.035 },
        { "WK_HSWrestlingStrength",    0.035 },
        { "WK_PediatricFirstAid",      0.035 },
        { "WK_ScoutCarpentryMerit",    0.035 },
    })
end

-- ── Filing Cabinet (Generic) ──────────────────────────────────────────────────
-- Weight 0.01 per item: ~157 items → cumulative ~1.6 WK weight.
-- At base pool ~100 with 5 rolls: ~7-8% chance of a doc per cabinet.
-- Six cabinets + six desks yields roughly one WK document on average.
if dist.FilingCabinetGeneric and dist.FilingCabinetGeneric.items then
    addMany(dist.FilingCabinetGeneric.items, {
        -- Carpentry / construction
        { "WK_LumberYardManual",          0.005 },
        { "WK_SpanTablesRef",             0.005 },
        { "WK_NDSWoodConstruction",       0.005 },
        { "WK_FinishCarpentryNotes",      0.005 },
        { "WK_FramingSquareCard",         0.005 },
        -- Aiming / law enforcement
        { "WK_SheriffQualLog",            0.005 },
        { "WK_FBIQualScorebook",          0.005 },
        { "WK_BoyScoutRiflery",           0.005 },
        { "WK_VietnamRiflemanNotes",      0.005 },
        { "WK_NavalGunnersManual",        0.005 },
        { "WK_GuardForceWeaponsManual",   0.005 },
        -- Maintenance / tool care
        { "WK_KnifeMaintenanceLog",       0.005 },
        { "WK_HandToolConditionRef",      0.005 },
        { "WK_ShopApprenticeToolLog",     0.005 },
        { "WK_BarberRazorStropping",      0.005 },
        { "WK_AntiqueDealerCare",         0.005 },
        { "WK_UFCWCutleryTechRef",        0.005 },
        -- OSHA / workplace safety
        { "WK_OSHALoggingRef",            0.005 },
        { "WK_OSHAHandToolSafety",        0.005 },
        { "WK_OSHAElectricalSafety",      0.005 },
        { "WK_OSHAWeldingSafety",         0.005 },
        { "WK_OSHAFirstAidRef",           0.005 },
        -- Construction / masonry
        { "WK_MortarMixRef",              0.005 },
        { "WK_ASTMC90MasonryRef",         0.005 },
        { "WK_BrickBlockInspectionRef",   0.005 },
        { "WK_ConcreteMixRef",            0.005 },
        { "WK_BIATraditionalBrick",       0.005 },
        { "WK_ChimneySweepInspect",       0.005 },
        { "WK_HistoricPointingMan",       0.005 },
        { "WK_KCMasonsLocalNews",         0.005 },
        -- Electrical
        { "WK_NECArticleRef",             0.005 },
        { "WK_WireGaugeAmpacityRef",      0.005 },
        { "WK_ConduitFillRef",            0.005 },
        { "WK_PanelInspectionChecklist",  0.005 },
        { "WK_IBEWApprentBook",           0.005 },
        { "WK_GroundingBondingRef",       0.005 },
        { "WK_KYStateLicensingMan",       0.005 },
        -- Mechanics / fleet
        { "WK_FleetMaintenanceLog",       0.005 },
        { "WK_KYVehicleInspection",       0.005 },
        { "WK_TruckingFleetPMSched",      0.005 },
        -- Cooking / food safety
        { "WK_HACCPFoodSafetyPlan",       0.005 },
        { "WK_TempTimeControlChart",      0.005 },
        { "WK_ServSafeRef",               0.005 },
        { "WK_LineCookStationRef",        0.005 },
        { "WK_SullivanCulinaryText",      0.005 },
        { "WK_KYExtensionCookbook",       0.005 },
        { "WK_ArmyMessHallSOP",           0.005 },
        { "WK_SchoolCafeteriaRef",        0.005 },
        { "WK_PitBossBBQManual",          0.005 },
        { "WK_HeritageCookbook1957",      0.005 },
        { "WK_TruckStopGriddleNotes",     0.005 },
        -- First Aid / medical
        { "WK_WorkplaceFirstAidSOP",      0.005 },
        { "WK_CPRAEDRef",                 0.005 },
        { "WK_EmergencyTriageRef",        0.005 },
        { "WK_ParamedicProtocolMan",      0.005 },
        { "WK_ERTriageTextbook",          0.005 },
        { "WK_NursingFundamentals",       0.005 },
        { "WK_PharmacistDispensing",      0.005 },
        { "WK_ArmyCombatMedic",           0.005 },
        { "WK_NursingHomeCareMan",        0.005 },
        { "WK_WoundCareSuturing",         0.005 },
        { "WK_PediatricFirstAid",         0.005 },
        -- Tailoring / textile industry
        { "WK_PatternGradingRef",         0.005 },
        { "WK_IndustrialSewingRef",       0.005 },
        { "WK_FiberFabricRef",            0.005 },
        { "WK_GarmentQualityRef",         0.005 },
        { "WK_SearsPatternCatalog",       0.005 },
        { "WK_CarhartUnionShop",          0.005 },
        { "WK_AlterationsTailorCard",     0.005 },
        { "WK_HomeEcSewingText",          0.005 },
        { "WK_TheatricalCostumeShop",     0.005 },
        { "WK_HancockFabricsManual",      0.005 },
        { "WK_UpholstererGuide",          0.005 },
        { "WK_BridalSeamstressNotes",     0.005 },
        -- Agriculture / extension office
        { "WK_KnoxExtensionGuide",        0.005 },
        { "WK_SoilTestInterpretRef",      0.005 },
        { "WK_PesticideApplicationRef",   0.005 },
        { "WK_IrrigationSchedulingRef",   0.005 },
        { "WK_FFAVocAgText",              0.005 },
        { "WK_KYExtensionAgBull",         0.005 },
        { "WK_UKAgEconNotes",             0.005 },
        { "WK_KYTobaccoGrowGuide",        0.005 },
        { "WK_RodaleOrganicPamph",        0.005 },
        -- Animal Care (vet clinic, farm office)
        { "WK_LivestockHealthRef",        0.005 },
        { "WK_VaccinationDosageRef",      0.005 },
        { "WK_ReproductiveMgmtBinder",    0.005 },
        { "WK_KDALivestockRef",           0.005 },
        { "WK_KYCattlemensNews",          0.005 },
        { "WK_TysonPoultryGrower",        0.005 },
        { "WK_TrackVetDailyLog",          0.005 },
        -- Butchering / food processing
        { "WK_USDAMeatGradingRef",        0.005 },
        { "WK_HACCPMeatProcessing",       0.005 },
        { "WK_UnionStockyardsCut",        0.005 },
        { "WK_SmallSlaughterhouseSOP",    0.005 },
        { "WK_CharcuterieProduction",     0.005 },
        -- Running / fitness
        { "WK_LEFitnessStandardsRef",     0.005 },
        { "WK_FireAcademyFitnessRef",     0.005 },
        { "WK_NCAAStrengthCondition",     0.005 },
        { "WK_BostonMarathonTrain",       0.005 },
        { "WK_ArmyAPFTManual",            0.005 },
        -- Strength / ergonomics
        { "WK_NIOSHLiftingRef",           0.005 },
        { "WK_ManualMaterialsHandRef",    0.005 },
        { "WK_USPFPowerlifting",          0.005 },
        { "WK_OlympicLiftingNotes",       0.005 },
        { "WK_StrongmanTrainingMan",      0.005 },
        { "WK_MuscleBuilderMag",          0.005 },
        { "WK_ArmyCombatLifter",          0.005 },
        { "WK_FreightDockLiftCard",       0.005 },
        { "WK_CollegeStrengthLog",        0.005 },
        -- Fishing
        { "WK_KYFishingRegs",             0.005 },
        { "WK_CommercialFishingSafetyRef",0.005 },
        { "WK_KYBassFishingClub",         0.005 },
        { "WK_CrappieAnglersGuide",       0.005 },
        { "WK_KYTroutStocking",           0.005 },
        { "WK_FlyTyingPattern",           0.005 },
        { "WK_KYRiverCatfishing",         0.005 },
        { "WK_WalleyeFishingRef",         0.005 },
        { "WK_NoodlingHandfishing",       0.005 },
        { "WK_KYMusselRegs",              0.005 },
        -- Foraging / botany
        { "WK_EdiblePlantsRef",           0.005 },
        { "WK_ToxicPlantRef",             0.005 },
        { "WK_KYWildflowerGuide",         0.005 },
        { "WK_StalkingWildAsparagus",     0.005 },
        { "WK_HerbalPharmacyEnc",         0.005 },
        { "WK_WildMushroomHunt",          0.005 },
        { "WK_BackyardForaging",          0.005 },
        { "WK_EthnobotanyText",           0.005 },
        { "WK_TraditionalAppPlants",      0.005 },
        { "WK_HunterGatherersRef",        0.005 },
        { "WK_WildEdiblesCookbook",       0.005 },
        -- Tracking / wildlife management
        { "WK_KDFWRGameMgmtRef",          0.005 },
        { "WK_ApacheScoutTracking",       0.005 },
        { "WK_KYCoonHunting",             0.005 },
        { "WK_SARTrackingTraining",       0.005 },
        { "WK_TurkeyHuntingRef",          0.005 },
        { "WK_WildlifeBiologyText",       0.005 },
        { "WK_BowHunterCamoMan",          0.005 },
        { "WK_NavySEALReconPamph",        0.005 },
        { "WK_SignReadingNotes",          0.005 },
        -- Axe / forestry
        { "WK_TimberCruiserHandbook",     0.005 },
        { "WK_BoyScoutAxemanship",        0.005 },
        { "WK_BackcountryHatchetCard",    0.005 },
        { "WK_TechnicalRescueAxeRef",     0.005 },
        { "WK_KDFWRDeadwoodPamph",        0.005 },
        { "WK_KYHighwayBrushControl",     0.005 },
        -- Long Blade / brush clearing
        { "WK_CornDetasselingCard",       0.005 },
        { "WK_AppalachianHerbalCutting",  0.005 },
        { "WK_StateParksTrailCrew",       0.005 },
        { "WK_CaneCuttingManual",         0.005 },
        -- Short Blade
        { "WK_SushiChefKnifeBook",        0.005 },
        { "WK_TaxidermistCapingRef",      0.005 },
        { "WK_SurgeonScalpelRef",         0.005 },
        { "WK_NorthwoodsFilletCard",      0.005 },
        -- Short Blunt / heavy tools
        { "WK_RailroadSpikeMaul",         0.005 },
        { "WK_CaverHammerPickRef",        0.005 },
        { "WK_TrackMaintenanceSledge",    0.005 },
        -- Spear / pole weapons
        { "WK_KDFWRBowfishingRef",        0.005 },
        { "WK_CherokeeFishSpear",         0.005 },
        { "WK_WWIIBayonetTraining",       0.005 },
        { "WK_PrimitiveSpearfishing",     0.005 },
        -- Blacksmithing / metalwork
        { "WK_ABANANewsletter",           0.005 },
        { "WK_SteelmillProcessRef",       0.005 },
        { "WK_ASTMMaterialSpecRef",       0.005 },
        { "WK_IndustrialMetalworkRef",    0.005 },
        -- Welding
        { "WK_WeldingProcSpecRef",        0.005 },
        { "WK_WeldInspectionRef",         0.005 },
        { "WK_AWSCertWelderManual",       0.005 },
        { "WK_UAWWeldingShopSOP",         0.005 },
        -- Carving / woodcraft
        { "WK_CountryCarversBook",        0.005 },
        { "WK_AppalachianFolkArt",        0.005 },
        { "WK_BowyerTilleringNotes",      0.005 },
        -- Glassmaking
        { "WK_CorningEngineering",        0.005 },
        { "WK_StainedGlassChurch",        0.005 },
        { "WK_AntiqueBottleCollect",      0.005 },
        { "WK_TiffanyMethodRef",          0.005 },
        { "WK_NeonSignBenders",           0.005 },
        -- Knapping
        { "WK_CherokeeArrowhead",         0.005 },
        { "WK_FieldArchKnapping",         0.005 },
        { "WK_PrimBowhunterFlint",        0.005 },
        { "WK_AmateurArchPamph",          0.005 },
        { "WK_ObsidianSourceRef",         0.005 },
        { "WK_KCMuseumLithicCat",         0.005 },
        { "WK_ToolStoneQualityCard",      0.005 },
        -- Pottery / ceramics
        { "WK_UnivCeramicsText",          0.005 },
        { "WK_PenlandWheelRef",           0.005 },
        { "WK_RakuFiringNotes",           0.005 },
        { "WK_SaltGlazeStoneware",        0.005 },
        { "WK_AppFolkPotteryPamph",       0.005 },
        { "WK_StudioKilnRepair",          0.005 },
        { "WK_CommercialPotteryProc",     0.005 },
        -- Trapping
        { "WK_KDFWRTrapperRegs",          0.005 },
        { "WK_NTAFurHandlersGuide",       0.005 },
        { "WK_KYBeaverTrapPamph",         0.005 },
        { "WK_FoxHolerLureRecipes",       0.005 },
        { "WK_ConibearSetTechnique",      0.005 },
        { "WK_FootholdStakingRef",        0.005 },
        { "WK_USDAAnimalDamage",          0.005 },
        { "WK_KDFWRNuisanceWild",         0.005 },
        { "WK_MuskratPeltStretch",        0.005 },
        { "WK_FurAuctionGrading",         0.005 },
        -- Carpentry / timber framing
        { "WK_LogHomeBuildersRef",        0.005 },
        { "WK_AppTimberFramePamph",       0.005 },
        { "WK_VocSchoolBuildTrades",      0.005 },
    })
end
