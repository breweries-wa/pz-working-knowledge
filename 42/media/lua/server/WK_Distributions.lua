-- Add Working Knowledge documents to relevant loot tables.
-- This file runs after vanilla distribution tables are loaded.

-- ── Spawn rate multiplier ─────────────────────────────────────────────────────
-- Reads the SpawnRate sandbox option (1–5) and converts to a weight multiplier.
-- 1=Very Rare (×0.25), 2=Rare (×0.5), 3=Normal (×1), 4=Common (×2), 5=Abundant (×4)
local _spawnMult = 1.0
local _opts = getSandboxOptions and getSandboxOptions()
if _opts then
    local _o = _opts:getOptionByName("WorkingKnowledge.SpawnRate")
    if _o then
        local _level = _o:getValue()  -- returns 1–5
        local _levels = { 0.25, 0.5, 1.0, 2.0, 4.0 }
        _spawnMult = _levels[_level] or 1.0
    end
end

local function w(weight)
    return weight * _spawnMult
end

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
        { "WK_VietnamRiflemanNotes",    w(0.25)   },  -- Aiming
        { "WK_NavalGunnersManual",      w(0.25)   },  -- Reloading
        { "WK_GuardForceWeaponsManual", w(0.25)   },  -- Reloading
        { "WK_CombatShootingDrills",    w(0.25)   },  -- Reloading
        { "WK_TacticalReloadRef",       w(0.25)   },  -- Reloading
        { "WK_WWIIBayonetTraining",     w(0.25)   },  -- Spear
        { "WK_ArmyAPFTManual",          w(0.25)   },  -- Sprinting
        { "WK_ArmyCombatMedic",         w(0.25)   },  -- First Aid
        { "WK_ArmyCombatLifter",        w(0.25)   },  -- Strength
        { "WK_NavySEALReconPamph",      w(0.25)   },  -- Tracking
        { "WK_SARTrackingTraining",     w(0.12) },  -- Tracking
        { "WK_ArmyMessHallSOP",         w(0.12) },  -- Cooking
    })
end


-- ArmyBunkerLockers: personal lockers — fitness manuals, field notes, personal copies.
if dist.ArmyBunkerLockers and dist.ArmyBunkerLockers.items then
    addMany(dist.ArmyBunkerLockers.items, {
        { "WK_ArmyAPFTManual",          w(0.25)   },  -- Sprinting
        { "WK_ArmyCombatLifter",        w(0.25)   },  -- Strength
        { "WK_VietnamRiflemanNotes",    w(0.12) },  -- Aiming
        { "WK_ArmyCombatMedic",         w(0.12) },  -- First Aid
        { "WK_NavySEALReconPamph",      w(0.12) },  -- Tracking
    })
end

-- ArmyBunkerStorage: supply storage — a few tactical and maintenance references.
if dist.ArmyBunkerStorage and dist.ArmyBunkerStorage.items then
    addMany(dist.ArmyBunkerStorage.items, {
        { "WK_NavalGunnersManual",      w(0.12) },  -- Reloading
        { "WK_ArmyCombatMedic",         w(0.12) },  -- First Aid
        { "WK_GuardForceWeaponsManual", w(0.12) },  -- Reloading
    })
end

-- ── Police / Law Enforcement ─────────────────────────────────────────────────
if dist.PoliceFilingCabinet and dist.PoliceFilingCabinet.items then
    addMany(dist.PoliceFilingCabinet.items, {
        { "WK_KCPDFirearmsQual",        w(0.25)   },
        { "WK_RangeSafetyOfficerRef",   w(0.25)   },
        { "WK_DefensiveHandgunRef",     w(0.25)   },
        { "WK_SheriffQualLog",          w(0.25)   },
        { "WK_TacticalReloadRef",       w(0.25)   },
        { "WK_MagazineDrillCard",       w(0.25)   },
        { "WK_ArmorersWeaponsRef",      w(0.25)   },
        { "WK_ImpactWeaponMaintSOP",    w(0.25)   },
        { "WK_KCPDImpactWeaponsRef",    w(0.25)   },
        { "WK_LEFitnessStandardsRef",   w(0.25)   },
        { "WK_NRAPistolInstructorMan",  w(0.12) },
        { "WK_KYConcealedCarryGuide",   w(0.25)   },
        { "WK_FBIQualScorebook",        w(0.25)   },
        { "WK_PoliceAcademyHandgun",    w(0.25)   },
        { "WK_RevolverSpeedloaderCard", w(0.25)   },
        { "WK_RangemasterDrillBook",    w(0.12) },
        { "WK_NightstickTrainingMan",   w(0.25)   },
        { "WK_RiotBatonInstructorRef",  w(0.25)   },
        { "WK_PoliceRecruitFitness",    w(0.25)   },
        { "WK_BloodhoundHandlerCard",   w(0.25)   },
    })
end

if dist.PoliceDesk and dist.PoliceDesk.items then
    addMany(dist.PoliceDesk.items, {
        { "WK_KCPDFirearmsQual",        w(0.25)   },
        { "WK_DefensiveHandgunRef",     w(0.25)   },
        { "WK_TacticalReloadRef",       w(0.25)   },
        { "WK_MagazineDrillCard",       w(0.25)   },
        { "WK_ImpactWeaponMaintSOP",    w(0.25)   },
        { "WK_KCPDImpactWeaponsRef",    w(0.25)   },
        { "WK_PoliceAcademyHandgun",    w(0.12) },
        { "WK_CombatShootingDrills",    w(0.12) },
        { "WK_PoliceRecruitFitness",    w(0.12) },
    })
end

-- ── Gun Store ────────────────────────────────────────────────────────────────
if dist.GunStoreCounter and dist.GunStoreCounter.items then
    addMany(dist.GunStoreCounter.items, {
        { "WK_RangeSafetyOfficerRef",   w(0.25)   },
        { "WK_MagazineDrillCard",       w(0.25)   },
        { "WK_ArmorersWeaponsRef",      w(0.25)   },
        { "WK_PracticalShootingRef",    w(0.25)   },
        { "WK_NRAPistolInstructorMan",  w(0.25)   },
        { "WK_BullseyeMatchProgramme",  w(0.25)   },
        { "WK_KYConcealedCarryGuide",   w(0.12) },
        { "WK_USPSARulebook",           w(0.25)   },
        { "WK_VietnamRiflemanNotes",    w(0.12) },
        { "WK_HighPowerNewsletter",     w(0.25)   },
        { "WK_RevolverSpeedloaderCard", w(0.12) },
        { "WK_CombatShootingDrills",    w(0.25)   },
        { "WK_GunsmithStripping",       w(0.25)   },
        { "WK_ShotgunReloadingCard",    w(0.25)   },
        { "WK_RangemasterDrillBook",    w(0.25)   },
    })
end

-- ── Fire Station ─────────────────────────────────────────────────────────────
if dist.FireStorageTools and dist.FireStorageTools.items then
    addMany(dist.FireStorageTools.items, {
        { "WK_ForcibleEntryRef",        w(0.25) },
        { "WK_FirefighterHandToolSOP",  w(0.25) },
        { "WK_CPRAEDRef",               w(0.25) },
        { "WK_EmergencyTriageRef",      w(0.25) },
        { "WK_FireAcademyFitnessRef",   w(0.25) },
        { "WK_WorkplaceFirstAidSOP",    w(0.25) },
        { "WK_EngineCompanyAxeRef",     w(0.25) },
        { "WK_EMTRescueKnifeCard",      w(0.25) },
        { "WK_FirefighterHaliganRef",   w(0.25) },
        { "WK_PulaskiSwingScale",       w(0.25) },
        { "WK_ParamedicProtocolMan",    w(0.25) },
        { "WK_ArmyCombatMedic",         w(0.25) },
        { "WK_SARTrackingTraining",     w(0.25) },
    })
end

-- ── Blacksmith / Metal Shop ───────────────────────────────────────────────────
if dist.WildWestBlacksmith and dist.WildWestBlacksmith.items then
    addMany(dist.WildWestBlacksmith.items, {
        { "WK_ASTMMaterialSpecRef",      w(0.25) },
        { "WK_ForgeHeatTreatGuide",      w(0.25) },
        { "WK_IndustrialMetalworkRef",   w(0.25) },
        { "WK_BlacksmithGuildStandards", w(0.25) },
        { "WK_ABANANewsletter",          w(0.25) },
        { "WK_FarrierShoeingNotes",      w(0.25) },
        { "WK_FrontierForgeRef",         w(0.25) },
        { "WK_SwordsmithApprDiary",      w(0.25) },
        { "WK_ColonialIronworker",       w(0.25) },
    })
end

if dist.MetalShopTools and dist.MetalShopTools.items then
    addMany(dist.MetalShopTools.items, {
        { "WK_ASTMMaterialSpecRef",    w(0.25)   },
        { "WK_ForgeHeatTreatGuide",    w(0.25)   },
        { "WK_IndustrialMetalworkRef", w(0.25)   },
        { "WK_EdgeToolSharpeningRef",  w(0.25)   },
        { "WK_WhetstoneSelectionRef",  w(0.25)   },
        { "WK_BladesmithToolCare",     w(0.25)   },
        { "WK_KnifemakerTestCutLog",   w(0.25)   },
        { "WK_BlacksmithHammerCard",   w(0.25)   },
        { "WK_SteelmillProcessRef",    w(0.25)   },
        { "WK_KnifemakerForgeWeld",    w(0.25)   },
        { "WK_MotorControlSchem",      w(0.12) },
        { "WK_NSFBladeSafetyRef",      w(0.25)   },  -- SmallBlade
    })
end

-- ── Welding Shop ─────────────────────────────────────────────────────────────
if dist.WeldingWorkshopTools and dist.WeldingWorkshopTools.items then
    addMany(dist.WeldingWorkshopTools.items, {
        { "WK_AWSD11WeldingRef",        w(0.25) },
        { "WK_WeldingProcSpecRef",      w(0.25) },
        { "WK_ElectrodeFillMetalRef",   w(0.25) },
        { "WK_WeldInspectionRef",       w(0.25) },
        { "WK_OSHAWeldingSafety",       w(0.25) },
        { "WK_AWSCertWelderManual",     w(0.25) },
        { "WK_PipefittersWelding",      w(0.25) },
        { "WK_AluminumMIGRef",          w(0.25) },
        { "WK_UAWWeldingShopSOP",       w(0.25) },
        { "WK_StickRodSelectionGuide",  w(0.25) },
        { "WK_AerospaceTIGNotes",       w(0.25) },
    })
end

-- ── Auto Shop / Mechanic ──────────────────────────────────────────────────────
if dist.MechanicShelfBooks and dist.MechanicShelfBooks.items then
    addMany(dist.MechanicShelfBooks.items, {
        { "WK_OBDIICodeRef",        w(0.25) },
        { "WK_TorqueSpecsRef",      w(0.25) },
        { "WK_BrakeServiceRef",     w(0.25) },
        { "WK_AutoElecDiagRef",     w(0.25) },
        { "WK_FleetMaintenanceLog", w(0.25) },
        { "WK_AutoBodyHammerNotes", w(0.25) },
        { "WK_ASEStudyGuide",       w(0.25) },
        { "WK_KYVehicleInspection", w(0.25) },
        { "WK_BriggsStrattonRepair",w(1) },
        { "WK_DieselTroubleshoot",  w(0.25) },
        { "WK_FordPickupShopMan",   w(0.25) },
        { "WK_ChevyTechServiceBull",w(1) },
        { "WK_AutoBodyWeldingRef",  w(0.25) },
    })
end

if dist.MechanicShelfBrakes and dist.MechanicShelfBrakes.items then
    addToItems(dist.MechanicShelfBrakes.items, "WK_BrakeServiceRef", w(1))
end

if dist.MechanicShelfElectric and dist.MechanicShelfElectric.items then
    addToItems(dist.MechanicShelfElectric.items, "WK_AutoElecDiagRef", w(1))
end

if dist.CarDealerFilingCabinet and dist.CarDealerFilingCabinet.items then
    addMany(dist.CarDealerFilingCabinet.items, {
        { "WK_OBDIICodeRef",         w(0.25)   },
        { "WK_TorqueSpecsRef",       w(0.25)   },
        { "WK_FleetMaintenanceLog",  w(0.25)   },
        { "WK_ASEStudyGuide",        w(0.12) },
        { "WK_ChevyTechServiceBull", w(0.12) },
        { "WK_TruckingFleetPMSched", w(0.25)   },
    })
end

-- ── Electrician ───────────────────────────────────────────────────────────────
if dist.ElectricianTools and dist.ElectricianTools.items then
    addMany(dist.ElectricianTools.items, {
        { "WK_NECArticleRef",            w(0.25) },
        { "WK_WireGaugeAmpacityRef",     w(0.25) },
        { "WK_OSHAElectricalSafety",     w(0.25) },
        { "WK_ConduitFillRef",           w(0.25) },
        { "WK_PanelInspectionChecklist", w(0.25) },
        { "WK_IBEWApprentBook",          w(0.25) },
        { "WK_ResWiringText",            w(0.25) },
        { "WK_MotorControlSchem",        w(0.25) },
        { "WK_TransformerNamePlate",     w(0.25) },
        { "WK_GroundingBondingRef",      w(0.25) },
        { "WK_KYStateLicensingMan",      w(0.25) },
        { "WK_UndergroundCableRef",      w(0.25) },
    })
end

-- ── Glassmaking ───────────────────────────────────────────────────────────────
if dist.UniversityFilingCabinet_Glassmaking and dist.UniversityFilingCabinet_Glassmaking.items then
    addMany(dist.UniversityFilingCabinet_Glassmaking.items, {
        { "WK_GlassAnnealingRef",    w(0.25) },
        { "WK_KilnFormingRef",       w(0.25) },
        { "WK_FloatGlassManufRef",   w(0.25) },
        { "WK_PenlandStudioGlass",   w(0.25) },
        { "WK_CorningEngineering",   w(0.25) },
        { "WK_BorosilicateLampwork",   w(0.25) },
        { "WK_KilnFiringScheduleRef",  w(0.25) },  -- Pottery
        { "WK_GlazeChemistryRef",      w(0.25) },  -- Pottery
        { "WK_ClayBodyFormulationRef", w(0.25) },  -- Pottery
    })
end

-- ── Farming / Agriculture ─────────────────────────────────────────────────────
if dist.ToolCabinetFarming and dist.ToolCabinetFarming.items then
    addMany(dist.ToolCabinetFarming.items, {
        { "WK_KnoxExtensionGuide",      w(0.25)   },
        { "WK_SoilTestInterpretRef",    w(0.25)   },
        { "WK_PesticideApplicationRef", w(0.25)   },
        { "WK_IrrigationSchedulingRef", w(0.25)   },
        { "WK_LivestockHealthRef",      w(0.25)   },
        { "WK_VaccinationDosageRef",    w(0.25)   },
        { "WK_KDALivestockRef",         w(0.25)   },
        { "WK_BushHogOperatorRef",      w(0.25)   },
        { "WK_CornDetasselingCard",     w(0.25)   },
        { "WK_KaiserBladeFieldRef",     w(0.12) },
        { "WK_FarrierShoeingNotes",     w(0.12) },
        { "WK_KYExtensionCookbook",     w(0.12) },
        { "WK_BriggsStrattonRepair",    w(0.12) },
        { "WK_FFAVocAgText",            w(0.25)   },
        { "WK_KYExtensionAgBull",       w(0.25)   },
        { "WK_FertSpreaderCalCard",     w(0.25)   },
        { "WK_USDACropRotation",        w(0.25)   },
        { "WK_NoTillFarmingMan",        w(0.25)   },
        { "WK_KYTobaccoGrowGuide",      w(0.25)   },
        { "WK_KYCattlemensNews",        w(0.25)   },
        { "WK_FFALivestockJudging",     w(0.25)   },
        { "WK_TysonPoultryGrower",      w(0.25)   },
        { "WK_SheepGoatBreeder",        w(0.25)   },
        { "WK_SwineProductionMan",      w(0.25)   },
        { "WK_DairyHerdMgmt",           w(0.25)   },
        { "WK_DeerProcessorGuide",      w(0.12) },
        { "WK_WildGameProcessor",       w(0.12) },
        { "WK_FarmStrengthManual",      w(0.25)   },
        { "WK_KYWildflowerGuide",       w(0.25)   },
        { "WK_USDAAnimalDamage",        w(0.25)   },
    })
end

-- ── Butcher ───────────────────────────────────────────────────────────────────
if dist.ButcherLiterature and dist.ButcherLiterature.items then
    addMany(dist.ButcherLiterature.items, {
        { "WK_USDAMeatGradingRef",    w(0.25) },
        { "WK_PrimalSubPrimalRef",    w(0.25) },
        { "WK_HACCPMeatProcessing",   w(0.25) },
        { "WK_MeatFabricationRef",    w(0.25) },
        { "WK_ButchersBoningGuide",   w(0.25) },
        { "WK_UFCWCutleryTechRef",    w(0.25) },
        { "WK_UnionStockyardsCut",    w(0.25) },
        { "WK_DeerProcessorGuide",    w(0.25) },
        { "WK_SausageProductionNotes",w(1) },
        { "WK_SmallSlaughterhouseSOP",w(1) },
        { "WK_KosherButcheringRef",   w(0.25) },
        { "WK_CharcuterieProduction", w(0.25) },
        { "WK_HolidayTurkeyCard",     w(0.25) },
        { "WK_CharcutierApprDiary",   w(0.25) },
        { "WK_WildGameProcessor",     w(0.25) },
        { "WK_FishFabricationRef",    w(0.25) },  -- SmallBlade
        { "WK_SauceStockLog",         w(0.25) },  -- Cooking
    })
end

-- ── Tool Store (back room) ────────────────────────────────────────────────────
if dist.ToolStoreMisc and dist.ToolStoreMisc.items then
    addMany(dist.ToolStoreMisc.items, {
        { "WK_FramingHammerCard",      w(0.25)   },
        { "WK_CrowbarApplicationsRef", w(0.25)   },
        { "WK_FramingSquareCard",      w(0.25)   },
        { "WK_EdgeToolSharpeningRef",  w(0.25)   },
        { "WK_WhetstoneSelectionRef",  w(0.25)   },
        { "WK_WoodenHandleShaftRef",   w(0.25)   },
        { "WK_KnifeHandleFittingRef",  w(0.25)   },
        { "WK_MortarMixRef",           w(0.25)   },
        { "WK_HandToolConditionRef",   w(0.25)   },
        { "WK_OSHAHandToolSafety",     w(0.25)   },
        { "WK_TimberCruiserHandbook",  w(0.25)   },
        { "WK_AppalachianFellingNotes",w(1)   },
        { "WK_MountainRescueIceAxe",   w(0.25)   },
        { "WK_BackcountryHatchetCard", w(0.25)   },
        { "WK_TechnicalRescueAxeRef",  w(0.12) },
        { "WK_KaiserBladeFieldRef",    w(0.25)   },
        { "WK_JewelersFileCard",       w(0.25)   },
        { "WK_ShopApprenticeToolLog",  w(0.25)   },
        { "WK_BowSawSetGuide",         w(0.25)   },
        { "WK_ProductionFramerCard",   w(0.25)   },
        { "WK_MasonsHammerRef",        w(0.25)   },
        { "WK_RoofersFlashingCard",    w(0.25)   },
        { "WK_LandClearingMaul",       w(0.25)   },
        { "WK_BIATraditionalBrick",    w(0.25)   },
        { "WK_StonecutterApprenNote",  w(0.25)   },
        { "WK_ConcreteFinishersRef",   w(0.25)   },
        { "WK_FieldstoneWalls",        w(0.25)   },
        { "WK_PavingStoneInstall",     w(0.25)   },
        { "WK_CabinetmakerJoinery",    w(0.25)   },
        { "WK_RoofFramingCalcCard",    w(0.25)   },
        { "WK_LogHomeBuildersRef",     w(0.25)   },
        { "WK_FurnitureMakerNotes",    w(0.25)   },
        { "WK_ArboristFieldGuide",     w(0.25)   },  -- Axe
        { "WK_BrushClearingRef",       w(0.25)   },  -- LongBlade
        { "WK_MacheteUseGuide",        w(0.25)   },  -- LongBlade
        { "WK_ForestryContractorSOP",  w(0.25)   },  -- LongBlade
        { "WK_DemolitionHandToolRef",  w(0.25)   },  -- Blunt
        { "WK_FieldExpedientToolRef",  w(0.25)   },  -- Carving
        { "WK_TrapperBoneToolRef",     w(0.25)   },  -- Carving
        { "WK_ArchaeologicalToolNotes",w(0.25)   },  -- Carving
    })
end

-- ── Fishing Store ─────────────────────────────────────────────────────────────
if dist.FishingStoreGear and dist.FishingStoreGear.items then
    addMany(dist.FishingStoreGear.items, {
        { "WK_FishIdentificationRef", w(0.25) },  -- Fishing
        { "WK_RiggingTackleRef",      w(0.25) },  -- Fishing
    })
end

-- ── Plumbing ──────────────────────────────────────────────────────────────────
if dist.PlumbingSupplies and dist.PlumbingSupplies.items then
    addMany(dist.PlumbingSupplies.items, {
        { "WK_PlumbingQuickClearRef", w(0.25) },  -- SmallBlunt
    })
end

-- ── Generic Desk ─────────────────────────────────────────────────────────────
-- Weight 0.07 per item: ~44 items → cumulative ~3.1 WK weight.
-- At base pool ~80 with 3 rolls: ~10% chance of a doc per desk.
if dist.DeskGeneric and dist.DeskGeneric.items then
    addMany(dist.DeskGeneric.items, {
        { "WK_GolfSwingRef",           w(0.07) },
        { "WK_BaseballSwingRef",       w(0.07) },
        { "WK_LEFitnessStandardsRef",  w(0.07) },
        { "WK_BullseyeMatchProgramme", w(0.07) },
        { "WK_BoyScoutRiflery",        w(0.07) },
        { "WK_HighPowerNewsletter",    w(0.07) },
        { "WK_BoyScoutAxemanship",     w(0.07) },
        { "WK_SCAHeavyFightCard",      w(0.07) },
        { "WK_LarpFightChoreography",  w(0.07) },
        { "WK_ScoutTroopToolCare",     w(0.07) },
        { "WK_ScoutCampcraftKnife",    w(0.07) },
        { "WK_CricketBowlersGuide",    w(0.07) },
        { "WK_LacrosseCoachManual",    w(0.07) },
        { "WK_HockeyStickHandling",    w(0.07) },
        { "WK_SCAPolearmRef",          w(0.07) },
        { "WK_TrackPoleVaultCard",     w(0.07) },
        { "WK_KarateBoStaffMan",       w(0.07) },
        { "WK_ScoutsPolearmDemo",      w(0.07) },
        { "WK_ScoutMetalwork",         w(0.07) },
        { "WK_SpoonCarvingNotes",      w(0.07) },
        { "WK_ChipCarvingPattern",     w(0.07) },
        { "WK_WaldenWoodcrafter",      w(0.07) },
        { "WK_JuniorHighWoodshop",     w(0.07) },
        { "WK_AppalachianFolkArt",     w(0.07) },
        { "WK_KilnFusedJewelry",       w(0.07) },
        { "WK_BeadSocietyLampwork",    w(0.07) },
        { "WK_RendezvousMtnMan",       w(0.07) },
        { "WK_BSAPrimitiveSurvival",   w(0.07) },
        { "WK_ChildrenPotteryLesson",  w(0.07) },
        { "WK_BeginnerWheelNotes",     w(0.07) },
        { "WK_HomeEcSewingText",       w(0.07) },
        { "WK_AgEdJudgingCard",        w(0.07) },
        { "WK_HSTrackCoachManual",     w(0.07) },
        { "WK_KYHSAARulebook",         w(0.07) },
        { "WK_SprintIntervalCard",     w(0.07) },
        { "WK_CrossCountryRef",        w(0.07) },
        { "WK_HSFootballCondition",    w(0.07) },
        { "WK_BMXRacingTraining",      w(0.07) },
        { "WK_RugbyStrengthMan",       w(0.07) },
        { "WK_HSWrestlingStrength",    w(0.07) },
        { "WK_PediatricFirstAid",      w(0.07) },
        { "WK_ScoutCarpentryMerit",    w(0.07) },
        { "WK_StageCombatSpearRef",    w(0.07) },  -- Spear (theatre/drama)
        { "WK_JavelinCoachingRef",     w(0.07) },  -- Spear (athletics)
    })
end

-- ── Filing Cabinet (Generic) ──────────────────────────────────────────────────
-- Weight 0.01 per item: ~157 items → cumulative ~1.6 WK weight.
-- At base pool ~100 with 5 rolls: ~7-8% chance of a doc per cabinet.
-- Six cabinets + six desks yields roughly one WK document on average.
if dist.FilingCabinetGeneric and dist.FilingCabinetGeneric.items then
    addMany(dist.FilingCabinetGeneric.items, {
        -- Carpentry / construction
        { "WK_LumberYardManual",          w(0.01) },
        { "WK_SpanTablesRef",             w(0.01) },
        { "WK_NDSWoodConstruction",       w(0.01) },
        { "WK_FinishCarpentryNotes",      w(0.01) },
        { "WK_FramingSquareCard",         w(0.01) },
        -- Aiming / law enforcement
        { "WK_SheriffQualLog",            w(0.01) },
        { "WK_FBIQualScorebook",          w(0.01) },
        { "WK_BoyScoutRiflery",           w(0.01) },
        { "WK_VietnamRiflemanNotes",      w(0.01) },
        { "WK_NavalGunnersManual",        w(0.01) },
        { "WK_GuardForceWeaponsManual",   w(0.01) },
        -- Maintenance / tool care
        { "WK_KnifeMaintenanceLog",       w(0.01) },
        { "WK_HandToolConditionRef",      w(0.01) },
        { "WK_ShopApprenticeToolLog",     w(0.01) },
        { "WK_BarberRazorStropping",      w(0.01) },
        { "WK_AntiqueDealerCare",         w(0.01) },
        { "WK_UFCWCutleryTechRef",        w(0.01) },
        -- OSHA / workplace safety
        { "WK_OSHALoggingRef",            w(0.01) },
        { "WK_OSHAHandToolSafety",        w(0.01) },
        { "WK_OSHAElectricalSafety",      w(0.01) },
        { "WK_OSHAWeldingSafety",         w(0.01) },
        { "WK_OSHAFirstAidRef",           w(0.01) },
        -- Construction / masonry
        { "WK_MortarMixRef",              w(0.01) },
        { "WK_ASTMC90MasonryRef",         w(0.01) },
        { "WK_BrickBlockInspectionRef",   w(0.01) },
        { "WK_ConcreteMixRef",            w(0.01) },
        { "WK_BIATraditionalBrick",       w(0.01) },
        { "WK_ChimneySweepInspect",       w(0.01) },
        { "WK_HistoricPointingMan",       w(0.01) },
        { "WK_KCMasonsLocalNews",         w(0.01) },
        -- Electrical
        { "WK_NECArticleRef",             w(0.01) },
        { "WK_WireGaugeAmpacityRef",      w(0.01) },
        { "WK_ConduitFillRef",            w(0.01) },
        { "WK_PanelInspectionChecklist",  w(0.01) },
        { "WK_IBEWApprentBook",           w(0.01) },
        { "WK_GroundingBondingRef",       w(0.01) },
        { "WK_KYStateLicensingMan",       w(0.01) },
        -- Mechanics / fleet
        { "WK_FleetMaintenanceLog",       w(0.01) },
        { "WK_KYVehicleInspection",       w(0.01) },
        { "WK_TruckingFleetPMSched",      w(0.01) },
        -- Cooking / food safety
        { "WK_HACCPFoodSafetyPlan",       w(0.01) },
        { "WK_TempTimeControlChart",      w(0.01) },
        { "WK_ServSafeRef",               w(0.01) },
        { "WK_LineCookStationRef",        w(0.01) },
        { "WK_SullivanCulinaryText",      w(0.01) },
        { "WK_KYExtensionCookbook",       w(0.01) },
        { "WK_ArmyMessHallSOP",           w(0.01) },
        { "WK_SchoolCafeteriaRef",        w(0.01) },
        { "WK_PitBossBBQManual",          w(0.01) },
        { "WK_HeritageCookbook1957",      w(0.01) },
        { "WK_TruckStopGriddleNotes",     w(0.01) },
        -- First Aid / medical
        { "WK_WorkplaceFirstAidSOP",      w(0.01) },
        { "WK_CPRAEDRef",                 w(0.01) },
        { "WK_EmergencyTriageRef",        w(0.01) },
        { "WK_ParamedicProtocolMan",      w(0.01) },
        { "WK_ERTriageTextbook",          w(0.01) },
        { "WK_NursingFundamentals",       w(0.01) },
        { "WK_PharmacistDispensing",      w(0.01) },
        { "WK_ArmyCombatMedic",           w(0.01) },
        { "WK_NursingHomeCareMan",        w(0.01) },
        { "WK_WoundCareSuturing",         w(0.01) },
        { "WK_PediatricFirstAid",         w(0.01) },
        -- Tailoring / textile industry
        { "WK_PatternGradingRef",         w(0.01) },
        { "WK_IndustrialSewingRef",       w(0.01) },
        { "WK_FiberFabricRef",            w(0.01) },
        { "WK_GarmentQualityRef",         w(0.01) },
        { "WK_SearsPatternCatalog",       w(0.01) },
        { "WK_CarhartUnionShop",          w(0.01) },
        { "WK_AlterationsTailorCard",     w(0.01) },
        { "WK_HomeEcSewingText",          w(0.01) },
        { "WK_TheatricalCostumeShop",     w(0.01) },
        { "WK_HancockFabricsManual",      w(0.01) },
        { "WK_UpholstererGuide",          w(0.01) },
        { "WK_BridalSeamstressNotes",     w(0.01) },
        -- Agriculture / extension office
        { "WK_KnoxExtensionGuide",        w(0.01) },
        { "WK_SoilTestInterpretRef",      w(0.01) },
        { "WK_PesticideApplicationRef",   w(0.01) },
        { "WK_IrrigationSchedulingRef",   w(0.01) },
        { "WK_FFAVocAgText",              w(0.01) },
        { "WK_KYExtensionAgBull",         w(0.01) },
        { "WK_UKAgEconNotes",             w(0.01) },
        { "WK_KYTobaccoGrowGuide",        w(0.01) },
        { "WK_RodaleOrganicPamph",        w(0.01) },
        -- Animal Care (vet clinic, farm office)
        { "WK_LivestockHealthRef",        w(0.01) },
        { "WK_VaccinationDosageRef",      w(0.01) },
        { "WK_ReproductiveMgmtBinder",    w(0.01) },
        { "WK_KDALivestockRef",           w(0.01) },
        { "WK_KYCattlemensNews",          w(0.01) },
        { "WK_TysonPoultryGrower",        w(0.01) },
        { "WK_TrackVetDailyLog",          w(0.01) },
        -- Butchering / food processing
        { "WK_USDAMeatGradingRef",        w(0.01) },
        { "WK_HACCPMeatProcessing",       w(0.01) },
        { "WK_UnionStockyardsCut",        w(0.01) },
        { "WK_SmallSlaughterhouseSOP",    w(0.01) },
        { "WK_CharcuterieProduction",     w(0.01) },
        -- Running / fitness
        { "WK_LEFitnessStandardsRef",     w(0.01) },
        { "WK_FireAcademyFitnessRef",     w(0.01) },
        { "WK_NCAAStrengthCondition",     w(0.01) },
        { "WK_BostonMarathonTrain",       w(0.01) },
        { "WK_ArmyAPFTManual",            w(0.01) },
        -- Strength / ergonomics
        { "WK_NIOSHLiftingRef",           w(0.01) },
        { "WK_ManualMaterialsHandRef",    w(0.01) },
        { "WK_USPFPowerlifting",          w(0.01) },
        { "WK_OlympicLiftingNotes",       w(0.01) },
        { "WK_StrongmanTrainingMan",      w(0.01) },
        { "WK_MuscleBuilderMag",          w(0.01) },
        { "WK_ArmyCombatLifter",          w(0.01) },
        { "WK_FreightDockLiftCard",       w(0.01) },
        { "WK_CollegeStrengthLog",        w(0.01) },
        -- Fishing
        { "WK_KYFishingRegs",             w(0.01) },
        { "WK_CommercialFishingSafetyRef",w(0.01) },
        { "WK_KYBassFishingClub",         w(0.01) },
        { "WK_CrappieAnglersGuide",       w(0.01) },
        { "WK_KYTroutStocking",           w(0.01) },
        { "WK_FlyTyingPattern",           w(0.01) },
        { "WK_KYRiverCatfishing",         w(0.01) },
        { "WK_WalleyeFishingRef",         w(0.01) },
        { "WK_NoodlingHandfishing",       w(0.01) },
        { "WK_KYMusselRegs",              w(0.01) },
        -- Foraging / botany
        { "WK_EdiblePlantsRef",           w(0.01) },
        { "WK_ToxicPlantRef",             w(0.01) },
        { "WK_KYWildflowerGuide",         w(0.01) },
        { "WK_StalkingWildAsparagus",     w(0.01) },
        { "WK_HerbalPharmacyEnc",         w(0.01) },
        { "WK_WildMushroomHunt",          w(0.01) },
        { "WK_BackyardForaging",          w(0.01) },
        { "WK_EthnobotanyText",           w(0.01) },
        { "WK_TraditionalAppPlants",      w(0.01) },
        { "WK_HunterGatherersRef",        w(0.01) },
        { "WK_WildEdiblesCookbook",       w(0.01) },
        -- Tracking / wildlife management
        { "WK_KDFWRGameMgmtRef",          w(0.01) },
        { "WK_ApacheScoutTracking",       w(0.01) },
        { "WK_KYCoonHunting",             w(0.01) },
        { "WK_SARTrackingTraining",       w(0.01) },
        { "WK_TurkeyHuntingRef",          w(0.01) },
        { "WK_WildlifeBiologyText",       w(0.01) },
        { "WK_BowHunterCamoMan",          w(0.01) },
        { "WK_NavySEALReconPamph",        w(0.01) },
        { "WK_SignReadingNotes",          w(0.01) },
        -- Axe / forestry
        { "WK_TimberCruiserHandbook",     w(0.01) },
        { "WK_BoyScoutAxemanship",        w(0.01) },
        { "WK_BackcountryHatchetCard",    w(0.01) },
        { "WK_TechnicalRescueAxeRef",     w(0.01) },
        { "WK_KDFWRDeadwoodPamph",        w(0.01) },
        { "WK_KYHighwayBrushControl",     w(0.01) },
        -- Long Blade / brush clearing
        { "WK_CornDetasselingCard",       w(0.01) },
        { "WK_AppalachianHerbalCutting",  w(0.01) },
        { "WK_StateParksTrailCrew",       w(0.01) },
        { "WK_CaneCuttingManual",         w(0.01) },
        -- Short Blade
        { "WK_SushiChefKnifeBook",        w(0.01) },
        { "WK_TaxidermistCapingRef",      w(0.01) },
        { "WK_SurgeonScalpelRef",         w(0.01) },
        { "WK_NorthwoodsFilletCard",      w(0.01) },
        -- Short Blunt / heavy tools
        { "WK_RailroadSpikeMaul",         w(0.01) },
        { "WK_CaverHammerPickRef",        w(0.01) },
        { "WK_TrackMaintenanceSledge",    w(0.01) },
        -- Spear / pole weapons
        { "WK_KDFWRBowfishingRef",        w(0.01) },
        { "WK_CherokeeFishSpear",         w(0.01) },
        { "WK_WWIIBayonetTraining",       w(0.01) },
        { "WK_PrimitiveSpearfishing",     w(0.01) },
        -- Blacksmithing / metalwork
        { "WK_ABANANewsletter",           w(0.01) },
        { "WK_SteelmillProcessRef",       w(0.01) },
        { "WK_ASTMMaterialSpecRef",       w(0.01) },
        { "WK_IndustrialMetalworkRef",    w(0.01) },
        -- Welding
        { "WK_WeldingProcSpecRef",        w(0.01) },
        { "WK_WeldInspectionRef",         w(0.01) },
        { "WK_AWSCertWelderManual",       w(0.01) },
        { "WK_UAWWeldingShopSOP",         w(0.01) },
        -- Carving / woodcraft
        { "WK_CountryCarversBook",        w(0.01) },
        { "WK_AppalachianFolkArt",        w(0.01) },
        { "WK_BowyerTilleringNotes",      w(0.01) },
        -- Glassmaking
        { "WK_CorningEngineering",        w(0.01) },
        { "WK_StainedGlassChurch",        w(0.01) },
        { "WK_AntiqueBottleCollect",      w(0.01) },
        { "WK_TiffanyMethodRef",          w(0.01) },
        { "WK_NeonSignBenders",           w(0.01) },
        -- Knapping
        { "WK_CherokeeArrowhead",         w(0.01) },
        { "WK_FieldArchKnapping",         w(0.01) },
        { "WK_PrimBowhunterFlint",        w(0.01) },
        { "WK_AmateurArchPamph",          w(0.01) },
        { "WK_ObsidianSourceRef",         w(0.01) },
        { "WK_KCMuseumLithicCat",         w(0.01) },
        { "WK_ToolStoneQualityCard",      w(0.01) },
        { "WK_LithicTechnologyRef",       w(0.01) },
        { "WK_PrimitiveSkillsKnappingRef",w(0.01) },
        { "WK_LithicAnalysisStandards",   w(0.01) },
        -- Pottery / ceramics
        { "WK_UnivCeramicsText",          w(0.01) },
        { "WK_PenlandWheelRef",           w(0.01) },
        { "WK_RakuFiringNotes",           w(0.01) },
        { "WK_SaltGlazeStoneware",        w(0.01) },
        { "WK_AppFolkPotteryPamph",       w(0.01) },
        { "WK_StudioKilnRepair",          w(0.01) },
        { "WK_CommercialPotteryProc",     w(0.01) },
        -- Trapping
        { "WK_KDFWRTrapperRegs",          w(0.01) },
        { "WK_NTAFurHandlersGuide",       w(0.01) },
        { "WK_KYBeaverTrapPamph",         w(0.01) },
        { "WK_FoxHolerLureRecipes",       w(0.01) },
        { "WK_ConibearSetTechnique",      w(0.01) },
        { "WK_FootholdStakingRef",        w(0.01) },
        { "WK_USDAAnimalDamage",          w(0.01) },
        { "WK_KDFWRNuisanceWild",         w(0.01) },
        { "WK_MuskratPeltStretch",        w(0.01) },
        { "WK_FurAuctionGrading",         w(0.01) },
        { "WK_WildlifeTrappingGuide",     w(0.01) },
        { "WK_FurbearerRef",              w(0.01) },
        -- Tracking
        { "WK_WildlifeTrackSignRef",      w(0.01) },
        { "WK_DeerMovementRef",           w(0.01) },
        -- Spear / primitive weapons
        { "WK_KDFWRPrimitiveWeapons",     w(0.01) },
        { "WK_AtlatlSpearRef",            w(0.01) },
        -- Foraging / herbalism
        { "WK_WildcraftHerbalistRef",     w(0.01) },
        -- Carpentry / timber framing
        { "WK_LogHomeBuildersRef",        w(0.01) },
        { "WK_AppTimberFramePamph",       w(0.01) },
        { "WK_VocSchoolBuildTrades",      w(0.01) },
    })
end
