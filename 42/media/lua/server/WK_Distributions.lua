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
if dist.ArmySurplusLiterature and dist.ArmySurplusLiterature.items then  -- target ~10
    addMany(dist.ArmySurplusLiterature.items, {
        { "WK_VietnamRiflemanNotes",    w(0.5071)   },  -- Aiming
        { "WK_NavalGunnersManual",      w(0.5071)   },  -- Reloading
        { "WK_GuardForceWeaponsManual", w(0.5071)   },  -- Reloading
        { "WK_CombatShootingDrills",    w(0.5071)   },  -- Reloading
        { "WK_TacticalReloadRef",       w(0.5071)   },  -- Reloading
        { "WK_WWIIBayonetTraining",     w(0.5071)   },  -- Spear
        { "WK_ArmyAPFTManual",          w(0.5071)   },  -- Sprinting
        { "WK_ArmyCombatMedic",         w(0.5071)   },  -- First Aid
        { "WK_ArmyCombatLifter",        w(0.5071)   },  -- Strength
        { "WK_NavySEALReconPamph",      w(0.5071)   },  -- Tracking
        { "WK_SARTrackingTraining",     w(0.5071) },  -- Tracking
        { "WK_ArmyMessHallSOP",         w(0.5071) },  -- Cooking
    })
end


-- ArmyBunkerLockers: personal lockers — fitness manuals, field notes, personal copies.
if dist.ArmyBunkerLockers and dist.ArmyBunkerLockers.items then  -- target ~20
    addMany(dist.ArmyBunkerLockers.items, {
        { "WK_ArmyAPFTManual",          w(0.0725)   },  -- Sprinting
        { "WK_ArmyCombatLifter",        w(0.0725)   },  -- Strength
        { "WK_VietnamRiflemanNotes",    w(0.0725) },  -- Aiming
        { "WK_ArmyCombatMedic",         w(0.0725) },  -- First Aid
        { "WK_NavySEALReconPamph",      w(0.0725) },  -- Tracking
    })
end

-- ArmyBunkerStorage: supply storage — a few tactical and maintenance references.
if dist.ArmyBunkerStorage and dist.ArmyBunkerStorage.items then  -- target ~10
    addMany(dist.ArmyBunkerStorage.items, {
        { "WK_NavalGunnersManual",      w(0.4673) },  -- Reloading
        { "WK_ArmyCombatMedic",         w(0.4673) },  -- First Aid
        { "WK_GuardForceWeaponsManual", w(0.4673) },  -- Reloading
    })
end

-- ── Police / Law Enforcement ─────────────────────────────────────────────────
if dist.PoliceFilingCabinet and dist.PoliceFilingCabinet.items then  -- target ~10
    addMany(dist.PoliceFilingCabinet.items, {
        { "WK_KCPDFirearmsQual",        w(0.7019)   },
        { "WK_RangeSafetyOfficerRef",   w(0.7019)   },
        { "WK_DefensiveHandgunRef",     w(0.7019)   },
        { "WK_SheriffQualLog",          w(0.7019)   },
        { "WK_TacticalReloadRef",       w(0.7019)   },
        { "WK_MagazineDrillCard",       w(0.7019)   },
        { "WK_ArmorersWeaponsRef",      w(0.7019)   },
        { "WK_ImpactWeaponMaintSOP",    w(0.7019)   },
        { "WK_KCPDImpactWeaponsRef",    w(0.7019)   },
        { "WK_LEFitnessStandardsRef",   w(0.7019)   },
        { "WK_NRAPistolInstructorMan",  w(0.7019) },
        { "WK_KYConcealedCarryGuide",   w(0.7019)   },
        { "WK_FBIQualScorebook",        w(0.7019)   },
        { "WK_PoliceAcademyHandgun",    w(0.7019)   },
        { "WK_RevolverSpeedloaderCard", w(0.7019)   },
        { "WK_RangemasterDrillBook",    w(0.7019) },
        { "WK_NightstickTrainingMan",   w(0.7019)   },
        { "WK_RiotBatonInstructorRef",  w(0.7019)   },
        { "WK_PoliceRecruitFitness",    w(0.7019)   },
        { "WK_BloodhoundHandlerCard",   w(0.7019)   },
    })
end

if dist.PoliceDesk and dist.PoliceDesk.items then  -- target ~20
    addMany(dist.PoliceDesk.items, {
        { "WK_KCPDFirearmsQual",        w(0.4844)   },
        { "WK_DefensiveHandgunRef",     w(0.4844)   },
        { "WK_TacticalReloadRef",       w(0.4844)   },
        { "WK_MagazineDrillCard",       w(0.4844)   },
        { "WK_ImpactWeaponMaintSOP",    w(0.4844)   },
        { "WK_KCPDImpactWeaponsRef",    w(0.4844)   },
        { "WK_PoliceAcademyHandgun",    w(0.4844) },
        { "WK_CombatShootingDrills",    w(0.4844) },
        { "WK_PoliceRecruitFitness",    w(0.4844) },
    })
end

-- ── Gun Store ────────────────────────────────────────────────────────────────
-- GunStoreCounter is marked DEPRECATED in B42 vanilla (empty items table).
-- Skipping until TIS ships an active replacement pool for gun store containers.

-- ── Fire Station ─────────────────────────────────────────────────────────────
if dist.FireStorageTools and dist.FireStorageTools.items then  -- target ~10
    addMany(dist.FireStorageTools.items, {
        { "WK_ForcibleEntryRef",        w(0.3462) },
        { "WK_FirefighterHandToolSOP",  w(0.3462) },
        { "WK_CPRAEDRef",               w(0.3462) },
        { "WK_EmergencyTriageRef",      w(0.3462) },
        { "WK_FireAcademyFitnessRef",   w(0.3462) },
        { "WK_WorkplaceFirstAidSOP",    w(0.3462) },
        { "WK_EngineCompanyAxeRef",     w(0.3462) },
        { "WK_EMTRescueKnifeCard",      w(0.3462) },
        { "WK_FirefighterHaliganRef",   w(0.3462) },
        { "WK_PulaskiSwingScale",       w(0.3462) },
        { "WK_ParamedicProtocolMan",    w(0.3462) },
        { "WK_ArmyCombatMedic",         w(0.3462) },
        { "WK_SARTrackingTraining",     w(0.3462) },
    })
end

-- ── Blacksmith / Metal Shop ───────────────────────────────────────────────────
if dist.WildWestBlacksmith and dist.WildWestBlacksmith.items then  -- target ~10
    addMany(dist.WildWestBlacksmith.items, {
        { "WK_ASTMMaterialSpecRef",      w(0.2936) },
        { "WK_ForgeHeatTreatGuide",      w(0.2936) },
        { "WK_IndustrialMetalworkRef",   w(0.2936) },
        { "WK_BlacksmithGuildStandards", w(0.2936) },
        { "WK_ABANANewsletter",          w(0.2936) },
        { "WK_FarrierShoeingNotes",      w(0.2936) },
        { "WK_FrontierForgeRef",         w(0.2936) },
        { "WK_SwordsmithApprDiary",      w(0.2936) },
        { "WK_ColonialIronworker",       w(0.2936) },
    })
end

if dist.MetalShopTools and dist.MetalShopTools.items then  -- target ~10
    addMany(dist.MetalShopTools.items, {
        { "WK_ASTMMaterialSpecRef",    w(0.8959)   },
        { "WK_ForgeHeatTreatGuide",    w(0.8959)   },
        { "WK_IndustrialMetalworkRef", w(0.8959)   },
        { "WK_EdgeToolSharpeningRef",  w(0.8959)   },
        { "WK_WhetstoneSelectionRef",  w(0.8959)   },
        { "WK_BladesmithToolCare",     w(0.8959)   },
        { "WK_KnifemakerTestCutLog",   w(0.8959)   },
        { "WK_BlacksmithHammerCard",   w(0.8959)   },
        { "WK_SteelmillProcessRef",    w(0.8959)   },
        { "WK_KnifemakerForgeWeld",    w(0.8959)   },
        { "WK_MotorControlSchem",      w(0.8959) },
        { "WK_NSFBladeSafetyRef",      w(0.8959)   },  -- SmallBlade
    })
end

-- ── Welding Shop ─────────────────────────────────────────────────────────────
if dist.WeldingWorkshopTools and dist.WeldingWorkshopTools.items then  -- target ~10
    addMany(dist.WeldingWorkshopTools.items, {
        { "WK_AWSD11WeldingRef",        w(0.5636) },
        { "WK_WeldingProcSpecRef",      w(0.5636) },
        { "WK_ElectrodeFillMetalRef",   w(0.5636) },
        { "WK_WeldInspectionRef",       w(0.5636) },
        { "WK_OSHAWeldingSafety",       w(0.5636) },
        { "WK_AWSCertWelderManual",     w(0.5636) },
        { "WK_PipefittersWelding",      w(0.5636) },
        { "WK_AluminumMIGRef",          w(0.5636) },
        { "WK_UAWWeldingShopSOP",       w(0.5636) },
        { "WK_StickRodSelectionGuide",  w(0.5636) },
        { "WK_AerospaceTIGNotes",       w(0.5636) },
    })
end

-- ── Auto Shop / Mechanic ──────────────────────────────────────────────────────
if dist.MechanicShelfBooks and dist.MechanicShelfBooks.items then  -- target ~10
    addMany(dist.MechanicShelfBooks.items, {
        { "WK_OBDIICodeRef",        w(0.427) },
        { "WK_TorqueSpecsRef",      w(0.427) },
        { "WK_BrakeServiceRef",     w(0.427) },
        { "WK_AutoElecDiagRef",     w(0.427) },
        { "WK_FleetMaintenanceLog", w(0.427) },
        { "WK_AutoBodyHammerNotes", w(0.427) },
        { "WK_ASEStudyGuide",       w(0.427) },
        { "WK_KYVehicleInspection", w(0.427) },
        { "WK_BriggsStrattonRepair",w(0.427) },
        { "WK_DieselTroubleshoot",  w(0.427) },
        { "WK_FordPickupShopMan",   w(0.427) },
        { "WK_ChevyTechServiceBull",w(0.427) },
        { "WK_AutoBodyWeldingRef",  w(0.427) },
    })
end

if dist.MechanicShelfBrakes and dist.MechanicShelfBrakes.items then  -- target ~10
    addToItems(dist.MechanicShelfBrakes.items, "WK_BrakeServiceRef", w(3.0694))
end

if dist.MechanicShelfElectric and dist.MechanicShelfElectric.items then  -- target ~20
    addToItems(dist.MechanicShelfElectric.items, "WK_AutoElecDiagRef", w(2.2134))
end

if dist.CarDealerFilingCabinet and dist.CarDealerFilingCabinet.items then  -- target ~20
    addMany(dist.CarDealerFilingCabinet.items, {
        { "WK_OBDIICodeRef",         w(0.8879)   },
        { "WK_TorqueSpecsRef",       w(0.8879)   },
        { "WK_FleetMaintenanceLog",  w(0.8879)   },
        { "WK_ASEStudyGuide",        w(0.8879) },
        { "WK_ChevyTechServiceBull", w(0.8879) },
        { "WK_TruckingFleetPMSched", w(0.8879)   },
    })
end

-- ── Electrician ───────────────────────────────────────────────────────────────
if dist.ElectricianTools and dist.ElectricianTools.items then  -- target ~10
    addMany(dist.ElectricianTools.items, {
        { "WK_NECArticleRef",            w(0.7048) },
        { "WK_WireGaugeAmpacityRef",     w(0.7048) },
        { "WK_OSHAElectricalSafety",     w(0.7048) },
        { "WK_ConduitFillRef",           w(0.7048) },
        { "WK_PanelInspectionChecklist", w(0.7048) },
        { "WK_IBEWApprentBook",          w(0.7048) },
        { "WK_ResWiringText",            w(0.7048) },
        { "WK_MotorControlSchem",        w(0.7048) },
        { "WK_TransformerNamePlate",     w(0.7048) },
        { "WK_GroundingBondingRef",      w(0.7048) },
        { "WK_KYStateLicensingMan",      w(0.7048) },
        { "WK_UndergroundCableRef",      w(0.7048) },
    })
end

-- ── Glassmaking ───────────────────────────────────────────────────────────────
-- UniversityFilingCabinet_Glassmaking is marked IN PROGRESS in B42 vanilla (empty items table).
-- Skipping until TIS populates this pool — adding to it now would give 100% hit rate.

-- ── Farming / Agriculture ─────────────────────────────────────────────────────
if dist.ToolCabinetFarming and dist.ToolCabinetFarming.items then  -- target ~10
    addMany(dist.ToolCabinetFarming.items, {
        { "WK_KnoxExtensionGuide",      w(0.2529)   },
        { "WK_SoilTestInterpretRef",    w(0.2529)   },
        { "WK_PesticideApplicationRef", w(0.2529)   },
        { "WK_IrrigationSchedulingRef", w(0.2529)   },
        { "WK_LivestockHealthRef",      w(0.2529)   },
        { "WK_VaccinationDosageRef",    w(0.2529)   },
        { "WK_KDALivestockRef",         w(0.2529)   },
        { "WK_BushHogOperatorRef",      w(0.2529)   },
        { "WK_CornDetasselingCard",     w(0.2529)   },
        { "WK_KaiserBladeFieldRef",     w(0.2529) },
        { "WK_FarrierShoeingNotes",     w(0.2529) },
        { "WK_KYExtensionCookbook",     w(0.2529) },
        { "WK_BriggsStrattonRepair",    w(0.2529) },
        { "WK_FFAVocAgText",            w(0.2529)   },
        { "WK_KYExtensionAgBull",       w(0.2529)   },
        { "WK_FertSpreaderCalCard",     w(0.2529)   },
        { "WK_USDACropRotation",        w(0.2529)   },
        { "WK_NoTillFarmingMan",        w(0.2529)   },
        { "WK_KYTobaccoGrowGuide",      w(0.2529)   },
        { "WK_KYCattlemensNews",        w(0.2529)   },
        { "WK_FFALivestockJudging",     w(0.2529)   },
        { "WK_TysonPoultryGrower",      w(0.2529)   },
        { "WK_SheepGoatBreeder",        w(0.2529)   },
        { "WK_SwineProductionMan",      w(0.2529)   },
        { "WK_DairyHerdMgmt",           w(0.2529)   },
        { "WK_DeerProcessorGuide",      w(0.2529) },
        { "WK_WildGameProcessor",       w(0.2529) },
        { "WK_FarmStrengthManual",      w(0.2529)   },
        { "WK_KYWildflowerGuide",       w(0.2529)   },
        { "WK_USDAAnimalDamage",        w(0.2529)   },
    })
end

-- ── Butcher ───────────────────────────────────────────────────────────────────
if dist.ButcherLiterature and dist.ButcherLiterature.items then  -- target ~10
    addMany(dist.ButcherLiterature.items, {
        { "WK_USDAMeatGradingRef",    w(0.084) },
        { "WK_PrimalSubPrimalRef",    w(0.084) },
        { "WK_HACCPMeatProcessing",   w(0.084) },
        { "WK_MeatFabricationRef",    w(0.084) },
        { "WK_ButchersBoningGuide",   w(0.084) },
        { "WK_UFCWCutleryTechRef",    w(0.084) },
        { "WK_UnionStockyardsCut",    w(0.084) },
        { "WK_DeerProcessorGuide",    w(0.084) },
        { "WK_SausageProductionNotes",w(0.084) },
        { "WK_SmallSlaughterhouseSOP",w(0.084) },
        { "WK_KosherButcheringRef",   w(0.084) },
        { "WK_CharcuterieProduction", w(0.084) },
        { "WK_HolidayTurkeyCard",     w(0.084) },
        { "WK_CharcutierApprDiary",   w(0.084) },
        { "WK_WildGameProcessor",     w(0.084) },
        { "WK_FishFabricationRef",    w(0.084) },  -- SmallBlade
        { "WK_SauceStockLog",         w(0.084) },  -- Cooking
    })
end

-- ── Tool Store (back room) ────────────────────────────────────────────────────
if dist.ToolStoreMisc and dist.ToolStoreMisc.items then  -- target ~10
    addMany(dist.ToolStoreMisc.items, {
        { "WK_FramingHammerCard",      w(0.197)   },
        { "WK_CrowbarApplicationsRef", w(0.197)   },
        { "WK_FramingSquareCard",      w(0.197)   },
        { "WK_EdgeToolSharpeningRef",  w(0.197)   },
        { "WK_WhetstoneSelectionRef",  w(0.197)   },
        { "WK_WoodenHandleShaftRef",   w(0.197)   },
        { "WK_KnifeHandleFittingRef",  w(0.197)   },
        { "WK_MortarMixRef",           w(0.197)   },
        { "WK_HandToolConditionRef",   w(0.197)   },
        { "WK_OSHAHandToolSafety",     w(0.197)   },
        { "WK_TimberCruiserHandbook",  w(0.197)   },
        { "WK_AppalachianFellingNotes",w(0.197)   },
        { "WK_MountainRescueIceAxe",   w(0.197)   },
        { "WK_BackcountryHatchetCard", w(0.197)   },
        { "WK_TechnicalRescueAxeRef",  w(0.197) },
        { "WK_KaiserBladeFieldRef",    w(0.197)   },
        { "WK_JewelersFileCard",       w(0.197)   },
        { "WK_ShopApprenticeToolLog",  w(0.197)   },
        { "WK_BowSawSetGuide",         w(0.197)   },
        { "WK_ProductionFramerCard",   w(0.197)   },
        { "WK_MasonsHammerRef",        w(0.197)   },
        { "WK_RoofersFlashingCard",    w(0.197)   },
        { "WK_LandClearingMaul",       w(0.197)   },
        { "WK_BIATraditionalBrick",    w(0.197)   },
        { "WK_StonecutterApprenNote",  w(0.197)   },
        { "WK_ConcreteFinishersRef",   w(0.197)   },
        { "WK_FieldstoneWalls",        w(0.197)   },
        { "WK_PavingStoneInstall",     w(0.197)   },
        { "WK_CabinetmakerJoinery",    w(0.197)   },
        { "WK_RoofFramingCalcCard",    w(0.197)   },
        { "WK_LogHomeBuildersRef",     w(0.197)   },
        { "WK_FurnitureMakerNotes",    w(0.197)   },
        { "WK_ArboristFieldGuide",     w(0.197)   },  -- Axe
        { "WK_BrushClearingRef",       w(0.197)   },  -- LongBlade
        { "WK_MacheteUseGuide",        w(0.197)   },  -- LongBlade
        { "WK_ForestryContractorSOP",  w(0.197)   },  -- LongBlade
        { "WK_DemolitionHandToolRef",  w(0.197)   },  -- Blunt
        { "WK_FieldExpedientToolRef",  w(0.197)   },  -- Carving
        { "WK_TrapperBoneToolRef",     w(0.197)   },  -- Carving
        { "WK_ArchaeologicalToolNotes",w(0.197)   },  -- Carving
    })
end

-- ── Fishing Store ─────────────────────────────────────────────────────────────
if dist.FishingStoreGear and dist.FishingStoreGear.items then  -- target ~10
    addMany(dist.FishingStoreGear.items, {
        { "WK_FishIdentificationRef", w(1.7443) },  -- Fishing
        { "WK_RiggingTackleRef",      w(1.7443) },  -- Fishing
    })
end

-- ── Plumbing ──────────────────────────────────────────────────────────────────
if dist.PlumbingSupplies and dist.PlumbingSupplies.items then  -- target ~10
    addMany(dist.PlumbingSupplies.items, {
        { "WK_PlumbingQuickClearRef", w(4.6975) },  -- SmallBlunt
    })
end

-- ── Blacksmith Literature Rack ───────────────────────────────────────────────
if dist.BlacksmithLiterature and dist.BlacksmithLiterature.items then  -- target ~10
    addMany(dist.BlacksmithLiterature.items, {
        { "WK_ABANANewsletter",          w(0.1806) },
        { "WK_ForgeHeatTreatGuide",      w(0.1806) },
        { "WK_BlacksmithGuildStandards", w(0.1806) },
        { "WK_IndustrialMetalworkRef",   w(0.1806) },
        { "WK_ASTMMaterialSpecRef",      w(0.1806) },
        { "WK_SteelmillProcessRef",      w(0.1806) },
        { "WK_ColonialIronworker",       w(0.1806) },
        { "WK_FrontierForgeRef",         w(0.1806) },
        { "WK_SwordsmithApprDiary",      w(0.1806) },
        { "WK_FarrierShoeingNotes",      w(0.1806) },
    })
end

-- ── Tailoring / Fabric Store ──────────────────────────────────────────────────
if dist.TailoringLiterature and dist.TailoringLiterature.items then  -- target ~10
    addMany(dist.TailoringLiterature.items, {
        { "WK_PatternGradingRef",        w(0.2802) },
        { "WK_IndustrialSewingRef",      w(0.2802) },
        { "WK_FiberFabricRef",           w(0.2802) },
        { "WK_GarmentQualityRef",        w(0.2802) },
        { "WK_SearsPatternCatalog",      w(0.2802) },
        { "WK_CarhartUnionShop",         w(0.2802) },
        { "WK_AlterationsTailorCard",    w(0.2802) },
        { "WK_HomeEcSewingText",         w(0.2802) },
        { "WK_TheatricalCostumeShop",    w(0.2802) },
        { "WK_HancockFabricsManual",     w(0.2802) },
        { "WK_UpholstererGuide",         w(0.2802) },
        { "WK_BridalSeamstressNotes",    w(0.2802) },
    })
end

-- ── Ranger Station ────────────────────────────────────────────────────────────
if dist.RangerBooks and dist.RangerBooks.items then  -- target ~10
    addMany(dist.RangerBooks.items, {
        { "WK_KDFWRGameMgmtRef",         w(0.3381) },
        { "WK_ApacheScoutTracking",      w(0.3381) },
        { "WK_WildlifeTrackSignRef",     w(0.3381) },
        { "WK_DeerMovementRef",          w(0.3381) },
        { "WK_SARTrackingTraining",      w(0.3381) },
        { "WK_TurkeyHuntingRef",         w(0.3381) },
        { "WK_WildlifeBiologyText",      w(0.3381) },
        { "WK_KDFWRTrapperRegs",         w(0.3381) },
        { "WK_NTAFurHandlersGuide",      w(0.3381) },
        { "WK_WildlifeTrappingGuide",    w(0.3381) },
        { "WK_FurbearerRef",             w(0.3381) },
        { "WK_EdiblePlantsRef",          w(0.3381) },
        { "WK_KYWildflowerGuide",        w(0.3381) },
        { "WK_WildMushroomHunt",         w(0.3381) },
        { "WK_HunterGatherersRef",       w(0.3381) },
    })
end

-- ── Medical Office ────────────────────────────────────────────────────────────
if dist.MedicalOfficeBooks and dist.MedicalOfficeBooks.items then  -- target ~10
    addMany(dist.MedicalOfficeBooks.items, {
        { "WK_WorkplaceFirstAidSOP",     w(0.2620) },
        { "WK_CPRAEDRef",                w(0.2620) },
        { "WK_EmergencyTriageRef",       w(0.2620) },
        { "WK_ParamedicProtocolMan",     w(0.2620) },
        { "WK_ERTriageTextbook",         w(0.2620) },
        { "WK_NursingFundamentals",      w(0.2620) },
        { "WK_PharmacistDispensing",     w(0.2620) },
        { "WK_WoundCareSuturing",        w(0.2620) },
        { "WK_ArmyCombatMedic",          w(0.2620) },
        { "WK_NursingHomeCareMan",       w(0.2620) },
        { "WK_PediatricFirstAid",        w(0.2620) },
    })
end

-- ── Garden / Nursery Store ────────────────────────────────────────────────────
if dist.GardenStoreMisc and dist.GardenStoreMisc.items then  -- target ~10
    addMany(dist.GardenStoreMisc.items, {
        { "WK_KnoxExtensionGuide",       w(0.5142) },
        { "WK_SoilTestInterpretRef",     w(0.5142) },
        { "WK_PesticideApplicationRef",  w(0.5142) },
        { "WK_IrrigationSchedulingRef",  w(0.5142) },
        { "WK_KYExtensionAgBull",        w(0.5142) },
        { "WK_FFAVocAgText",             w(0.5142) },
        { "WK_RodaleOrganicPamph",       w(0.5142) },
        { "WK_KYTobaccoGrowGuide",       w(0.5142) },
        { "WK_EdiblePlantsRef",          w(0.5142) },
        { "WK_KYWildflowerGuide",        w(0.5142) },
        { "WK_BackyardForaging",         w(0.5142) },
        { "WK_StalkingWildAsparagus",    w(0.5142) },
        { "WK_UKAgEconNotes",            w(0.5142) },
        { "WK_HerbalPharmacyEnc",        w(0.5142) },
        { "WK_EthnobotanyText",          w(0.5142) },
    })
end

-- ── Generic Desk ─────────────────────────────────────────────────────────────
-- target ~10
if dist.DeskGeneric and dist.DeskGeneric.items then  -- target ~10
    addMany(dist.DeskGeneric.items, {
        { "WK_GolfSwingRef",           w(0.0189) },
        { "WK_BaseballSwingRef",       w(0.0189) },
        { "WK_LEFitnessStandardsRef",  w(0.0189) },
        { "WK_BullseyeMatchProgramme", w(0.0189) },
        { "WK_BoyScoutRiflery",        w(0.0189) },
        { "WK_HighPowerNewsletter",    w(0.0189) },
        { "WK_BoyScoutAxemanship",     w(0.0189) },
        { "WK_SCAHeavyFightCard",      w(0.0189) },
        { "WK_LarpFightChoreography",  w(0.0189) },
        { "WK_ScoutTroopToolCare",     w(0.0189) },
        { "WK_ScoutCampcraftKnife",    w(0.0189) },
        { "WK_CricketBowlersGuide",    w(0.0189) },
        { "WK_LacrosseCoachManual",    w(0.0189) },
        { "WK_HockeyStickHandling",    w(0.0189) },
        { "WK_SCAPolearmRef",          w(0.0189) },
        { "WK_TrackPoleVaultCard",     w(0.0189) },
        { "WK_KarateBoStaffMan",       w(0.0189) },
        { "WK_ScoutsPolearmDemo",      w(0.0189) },
        { "WK_ScoutMetalwork",         w(0.0189) },
        { "WK_SpoonCarvingNotes",      w(0.0189) },
        { "WK_ChipCarvingPattern",     w(0.0189) },
        { "WK_WaldenWoodcrafter",      w(0.0189) },
        { "WK_JuniorHighWoodshop",     w(0.0189) },
        { "WK_AppalachianFolkArt",     w(0.0189) },
        { "WK_KilnFusedJewelry",       w(0.0189) },
        { "WK_BeadSocietyLampwork",    w(0.0189) },
        { "WK_RendezvousMtnMan",       w(0.0189) },
        { "WK_BSAPrimitiveSurvival",   w(0.0189) },
        { "WK_ChildrenPotteryLesson",  w(0.0189) },
        { "WK_BeginnerWheelNotes",     w(0.0189) },
        { "WK_HomeEcSewingText",       w(0.0189) },
        { "WK_AgEdJudgingCard",        w(0.0189) },
        { "WK_HSTrackCoachManual",     w(0.0189) },
        { "WK_KYHSAARulebook",         w(0.0189) },
        { "WK_SprintIntervalCard",     w(0.0189) },
        { "WK_CrossCountryRef",        w(0.0189) },
        { "WK_HSFootballCondition",    w(0.0189) },
        { "WK_BMXRacingTraining",      w(0.0189) },
        { "WK_RugbyStrengthMan",       w(0.0189) },
        { "WK_HSWrestlingStrength",    w(0.0189) },
        { "WK_PediatricFirstAid",      w(0.0189) },
        { "WK_ScoutCarpentryMerit",    w(0.0189) },
        { "WK_StageCombatSpearRef",    w(0.0189) },  -- Spear (theatre/drama)
        { "WK_JavelinCoachingRef",     w(0.0189) },  -- Spear (athletics)
    })
end

-- ── Filing Cabinet (Generic) ──────────────────────────────────────────────────
-- target ~10
if dist.FilingCabinetGeneric and dist.FilingCabinetGeneric.items then  -- target ~10
    addMany(dist.FilingCabinetGeneric.items, {
        -- Carpentry / construction
        { "WK_LumberYardManual",          w(0.0426) },
        { "WK_SpanTablesRef",             w(0.0426) },
        { "WK_NDSWoodConstruction",       w(0.0426) },
        { "WK_FinishCarpentryNotes",      w(0.0426) },
        { "WK_FramingSquareCard",         w(0.0426) },
        -- Aiming / law enforcement
        { "WK_SheriffQualLog",            w(0.0426) },
        { "WK_FBIQualScorebook",          w(0.0426) },
        { "WK_BoyScoutRiflery",           w(0.0426) },
        { "WK_VietnamRiflemanNotes",      w(0.0426) },
        { "WK_NavalGunnersManual",        w(0.0426) },
        { "WK_GuardForceWeaponsManual",   w(0.0426) },
        -- Maintenance / tool care
        { "WK_KnifeMaintenanceLog",       w(0.0426) },
        { "WK_HandToolConditionRef",      w(0.0426) },
        { "WK_ShopApprenticeToolLog",     w(0.0426) },
        { "WK_BarberRazorStropping",      w(0.0426) },
        { "WK_AntiqueDealerCare",         w(0.0426) },
        { "WK_UFCWCutleryTechRef",        w(0.0426) },
        -- OSHA / workplace safety
        { "WK_OSHALoggingRef",            w(0.0426) },
        { "WK_OSHAHandToolSafety",        w(0.0426) },
        { "WK_OSHAElectricalSafety",      w(0.0426) },
        { "WK_OSHAWeldingSafety",         w(0.0426) },
        { "WK_OSHAFirstAidRef",           w(0.0426) },
        -- Construction / masonry
        { "WK_MortarMixRef",              w(0.0426) },
        { "WK_ASTMC90MasonryRef",         w(0.0426) },
        { "WK_BrickBlockInspectionRef",   w(0.0426) },
        { "WK_ConcreteMixRef",            w(0.0426) },
        { "WK_BIATraditionalBrick",       w(0.0426) },
        { "WK_ChimneySweepInspect",       w(0.0426) },
        { "WK_HistoricPointingMan",       w(0.0426) },
        { "WK_KCMasonsLocalNews",         w(0.0426) },
        -- Electrical
        { "WK_NECArticleRef",             w(0.0426) },
        { "WK_WireGaugeAmpacityRef",      w(0.0426) },
        { "WK_ConduitFillRef",            w(0.0426) },
        { "WK_PanelInspectionChecklist",  w(0.0426) },
        { "WK_IBEWApprentBook",           w(0.0426) },
        { "WK_GroundingBondingRef",       w(0.0426) },
        { "WK_KYStateLicensingMan",       w(0.0426) },
        -- Mechanics / fleet
        { "WK_FleetMaintenanceLog",       w(0.0426) },
        { "WK_KYVehicleInspection",       w(0.0426) },
        { "WK_TruckingFleetPMSched",      w(0.0426) },
        -- Cooking / food safety
        { "WK_HACCPFoodSafetyPlan",       w(0.0426) },
        { "WK_TempTimeControlChart",      w(0.0426) },
        { "WK_ServSafeRef",               w(0.0426) },
        { "WK_LineCookStationRef",        w(0.0426) },
        { "WK_SullivanCulinaryText",      w(0.0426) },
        { "WK_KYExtensionCookbook",       w(0.0426) },
        { "WK_ArmyMessHallSOP",           w(0.0426) },
        { "WK_SchoolCafeteriaRef",        w(0.0426) },
        { "WK_PitBossBBQManual",          w(0.0426) },
        { "WK_HeritageCookbook1957",      w(0.0426) },
        { "WK_TruckStopGriddleNotes",     w(0.0426) },
        -- First Aid / medical
        { "WK_WorkplaceFirstAidSOP",      w(0.0426) },
        { "WK_CPRAEDRef",                 w(0.0426) },
        { "WK_EmergencyTriageRef",        w(0.0426) },
        { "WK_ParamedicProtocolMan",      w(0.0426) },
        { "WK_ERTriageTextbook",          w(0.0426) },
        { "WK_NursingFundamentals",       w(0.0426) },
        { "WK_PharmacistDispensing",      w(0.0426) },
        { "WK_ArmyCombatMedic",           w(0.0426) },
        { "WK_NursingHomeCareMan",        w(0.0426) },
        { "WK_WoundCareSuturing",         w(0.0426) },
        { "WK_PediatricFirstAid",         w(0.0426) },
        -- Tailoring / textile industry
        { "WK_PatternGradingRef",         w(0.0426) },
        { "WK_IndustrialSewingRef",       w(0.0426) },
        { "WK_FiberFabricRef",            w(0.0426) },
        { "WK_GarmentQualityRef",         w(0.0426) },
        { "WK_SearsPatternCatalog",       w(0.0426) },
        { "WK_CarhartUnionShop",          w(0.0426) },
        { "WK_AlterationsTailorCard",     w(0.0426) },
        { "WK_HomeEcSewingText",          w(0.0426) },
        { "WK_TheatricalCostumeShop",     w(0.0426) },
        { "WK_HancockFabricsManual",      w(0.0426) },
        { "WK_UpholstererGuide",          w(0.0426) },
        { "WK_BridalSeamstressNotes",     w(0.0426) },
        -- Agriculture / extension office
        { "WK_KnoxExtensionGuide",        w(0.0426) },
        { "WK_SoilTestInterpretRef",      w(0.0426) },
        { "WK_PesticideApplicationRef",   w(0.0426) },
        { "WK_IrrigationSchedulingRef",   w(0.0426) },
        { "WK_FFAVocAgText",              w(0.0426) },
        { "WK_KYExtensionAgBull",         w(0.0426) },
        { "WK_UKAgEconNotes",             w(0.0426) },
        { "WK_KYTobaccoGrowGuide",        w(0.0426) },
        { "WK_RodaleOrganicPamph",        w(0.0426) },
        -- Animal Care (vet clinic, farm office)
        { "WK_LivestockHealthRef",        w(0.0426) },
        { "WK_VaccinationDosageRef",      w(0.0426) },
        { "WK_ReproductiveMgmtBinder",    w(0.0426) },
        { "WK_KDALivestockRef",           w(0.0426) },
        { "WK_KYCattlemensNews",          w(0.0426) },
        { "WK_TysonPoultryGrower",        w(0.0426) },
        { "WK_TrackVetDailyLog",          w(0.0426) },
        -- Butchering / food processing
        { "WK_USDAMeatGradingRef",        w(0.0426) },
        { "WK_HACCPMeatProcessing",       w(0.0426) },
        { "WK_UnionStockyardsCut",        w(0.0426) },
        { "WK_SmallSlaughterhouseSOP",    w(0.0426) },
        { "WK_CharcuterieProduction",     w(0.0426) },
        -- Running / fitness
        { "WK_LEFitnessStandardsRef",     w(0.0426) },
        { "WK_FireAcademyFitnessRef",     w(0.0426) },
        { "WK_NCAAStrengthCondition",     w(0.0426) },
        { "WK_BostonMarathonTrain",       w(0.0426) },
        { "WK_ArmyAPFTManual",            w(0.0426) },
        -- Strength / ergonomics
        { "WK_NIOSHLiftingRef",           w(0.0426) },
        { "WK_ManualMaterialsHandRef",    w(0.0426) },
        { "WK_USPFPowerlifting",          w(0.0426) },
        { "WK_OlympicLiftingNotes",       w(0.0426) },
        { "WK_StrongmanTrainingMan",      w(0.0426) },
        { "WK_MuscleBuilderMag",          w(0.0426) },
        { "WK_ArmyCombatLifter",          w(0.0426) },
        { "WK_FreightDockLiftCard",       w(0.0426) },
        { "WK_CollegeStrengthLog",        w(0.0426) },
        -- Fishing
        { "WK_KYFishingRegs",             w(0.0426) },
        { "WK_CommercialFishingSafetyRef",w(0.0426) },
        { "WK_KYBassFishingClub",         w(0.0426) },
        { "WK_CrappieAnglersGuide",       w(0.0426) },
        { "WK_KYTroutStocking",           w(0.0426) },
        { "WK_FlyTyingPattern",           w(0.0426) },
        { "WK_KYRiverCatfishing",         w(0.0426) },
        { "WK_WalleyeFishingRef",         w(0.0426) },
        { "WK_NoodlingHandfishing",       w(0.0426) },
        { "WK_KYMusselRegs",              w(0.0426) },
        -- Foraging / botany
        { "WK_EdiblePlantsRef",           w(0.0426) },
        { "WK_ToxicPlantRef",             w(0.0426) },
        { "WK_KYWildflowerGuide",         w(0.0426) },
        { "WK_StalkingWildAsparagus",     w(0.0426) },
        { "WK_HerbalPharmacyEnc",         w(0.0426) },
        { "WK_WildMushroomHunt",          w(0.0426) },
        { "WK_BackyardForaging",          w(0.0426) },
        { "WK_EthnobotanyText",           w(0.0426) },
        { "WK_TraditionalAppPlants",      w(0.0426) },
        { "WK_HunterGatherersRef",        w(0.0426) },
        { "WK_WildEdiblesCookbook",       w(0.0426) },
        -- Tracking / wildlife management
        { "WK_KDFWRGameMgmtRef",          w(0.0426) },
        { "WK_ApacheScoutTracking",       w(0.0426) },
        { "WK_KYCoonHunting",             w(0.0426) },
        { "WK_SARTrackingTraining",       w(0.0426) },
        { "WK_TurkeyHuntingRef",          w(0.0426) },
        { "WK_WildlifeBiologyText",       w(0.0426) },
        { "WK_BowHunterCamoMan",          w(0.0426) },
        { "WK_NavySEALReconPamph",        w(0.0426) },
        { "WK_SignReadingNotes",          w(0.0426) },
        -- Axe / forestry
        { "WK_TimberCruiserHandbook",     w(0.0426) },
        { "WK_BoyScoutAxemanship",        w(0.0426) },
        { "WK_BackcountryHatchetCard",    w(0.0426) },
        { "WK_TechnicalRescueAxeRef",     w(0.0426) },
        { "WK_KDFWRDeadwoodPamph",        w(0.0426) },
        { "WK_KYHighwayBrushControl",     w(0.0426) },
        -- Long Blade / brush clearing
        { "WK_CornDetasselingCard",       w(0.0426) },
        { "WK_AppalachianHerbalCutting",  w(0.0426) },
        { "WK_StateParksTrailCrew",       w(0.0426) },
        { "WK_CaneCuttingManual",         w(0.0426) },
        -- Short Blade
        { "WK_SushiChefKnifeBook",        w(0.0426) },
        { "WK_TaxidermistCapingRef",      w(0.0426) },
        { "WK_SurgeonScalpelRef",         w(0.0426) },
        { "WK_NorthwoodsFilletCard",      w(0.0426) },
        -- Short Blunt / heavy tools
        { "WK_RailroadSpikeMaul",         w(0.0426) },
        { "WK_CaverHammerPickRef",        w(0.0426) },
        { "WK_TrackMaintenanceSledge",    w(0.0426) },
        -- Spear / pole weapons
        { "WK_KDFWRBowfishingRef",        w(0.0426) },
        { "WK_CherokeeFishSpear",         w(0.0426) },
        { "WK_WWIIBayonetTraining",       w(0.0426) },
        { "WK_PrimitiveSpearfishing",     w(0.0426) },
        -- Blacksmithing / metalwork
        { "WK_ABANANewsletter",           w(0.0426) },
        { "WK_SteelmillProcessRef",       w(0.0426) },
        { "WK_ASTMMaterialSpecRef",       w(0.0426) },
        { "WK_IndustrialMetalworkRef",    w(0.0426) },
        -- Welding
        { "WK_WeldingProcSpecRef",        w(0.0426) },
        { "WK_WeldInspectionRef",         w(0.0426) },
        { "WK_AWSCertWelderManual",       w(0.0426) },
        { "WK_UAWWeldingShopSOP",         w(0.0426) },
        -- Carving / woodcraft
        { "WK_CountryCarversBook",        w(0.0426) },
        { "WK_AppalachianFolkArt",        w(0.0426) },
        { "WK_BowyerTilleringNotes",      w(0.0426) },
        -- Glassmaking
        { "WK_CorningEngineering",        w(0.0426) },
        { "WK_StainedGlassChurch",        w(0.0426) },
        { "WK_AntiqueBottleCollect",      w(0.0426) },
        { "WK_TiffanyMethodRef",          w(0.0426) },
        { "WK_NeonSignBenders",           w(0.0426) },
        -- Knapping
        { "WK_CherokeeArrowhead",         w(0.0426) },
        { "WK_FieldArchKnapping",         w(0.0426) },
        { "WK_PrimBowhunterFlint",        w(0.0426) },
        { "WK_AmateurArchPamph",          w(0.0426) },
        { "WK_ObsidianSourceRef",         w(0.0426) },
        { "WK_KCMuseumLithicCat",         w(0.0426) },
        { "WK_ToolStoneQualityCard",      w(0.0426) },
        { "WK_LithicTechnologyRef",       w(0.0426) },
        { "WK_PrimitiveSkillsKnappingRef",w(0.0426) },
        { "WK_LithicAnalysisStandards",   w(0.0426) },
        -- Pottery / ceramics
        { "WK_UnivCeramicsText",          w(0.0426) },
        { "WK_PenlandWheelRef",           w(0.0426) },
        { "WK_RakuFiringNotes",           w(0.0426) },
        { "WK_SaltGlazeStoneware",        w(0.0426) },
        { "WK_AppFolkPotteryPamph",       w(0.0426) },
        { "WK_StudioKilnRepair",          w(0.0426) },
        { "WK_CommercialPotteryProc",     w(0.0426) },
        -- Trapping
        { "WK_KDFWRTrapperRegs",          w(0.0426) },
        { "WK_NTAFurHandlersGuide",       w(0.0426) },
        { "WK_KYBeaverTrapPamph",         w(0.0426) },
        { "WK_FoxHolerLureRecipes",       w(0.0426) },
        { "WK_ConibearSetTechnique",      w(0.0426) },
        { "WK_FootholdStakingRef",        w(0.0426) },
        { "WK_USDAAnimalDamage",          w(0.0426) },
        { "WK_KDFWRNuisanceWild",         w(0.0426) },
        { "WK_MuskratPeltStretch",        w(0.0426) },
        { "WK_FurAuctionGrading",         w(0.0426) },
        { "WK_WildlifeTrappingGuide",     w(0.0426) },
        { "WK_FurbearerRef",              w(0.0426) },
        -- Tracking
        { "WK_WildlifeTrackSignRef",      w(0.0426) },
        { "WK_DeerMovementRef",           w(0.0426) },
        -- Spear / primitive weapons
        { "WK_KDFWRPrimitiveWeapons",     w(0.0426) },
        { "WK_AtlatlSpearRef",            w(0.0426) },
        -- Foraging / herbalism
        { "WK_WildcraftHerbalistRef",     w(0.0426) },
        -- Carpentry / timber framing
        { "WK_LogHomeBuildersRef",        w(0.0426) },
        { "WK_AppTimberFramePamph",       w(0.0426) },
        { "WK_VocSchoolBuildTrades",      w(0.0426) },
    })
end
