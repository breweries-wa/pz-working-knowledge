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

-- ── Police / Law Enforcement ─────────────────────────────────────────────────
if dist.PoliceFilingCabinet and dist.PoliceFilingCabinet.items then
    addMany(dist.PoliceFilingCabinet.items, {
        { "WK_KCPDFirearmsQual",       1 },
        { "WK_RangeSafetyOfficerRef",  1 },
        { "WK_DefensiveHandgunRef",    1 },
        { "WK_SheriffQualLog",         1 },
        { "WK_TacticalReloadRef",      1 },
        { "WK_MagazineDrillCard",      1 },
        { "WK_ArmorersWeaponsRef",     1 },
        { "WK_ImpactWeaponMaintSOP",   1 },
        { "WK_KCPDImpactWeaponsRef",   1 },
        { "WK_LEFitnessStandardsRef",  1 },
    })
end

if dist.PoliceDesk and dist.PoliceDesk.items then
    addMany(dist.PoliceDesk.items, {
        { "WK_KCPDFirearmsQual",       1 },
        { "WK_DefensiveHandgunRef",    1 },
        { "WK_TacticalReloadRef",      1 },
        { "WK_MagazineDrillCard",      1 },
        { "WK_ImpactWeaponMaintSOP",   1 },
        { "WK_KCPDImpactWeaponsRef",   1 },
    })
end

-- ── Gun Store ────────────────────────────────────────────────────────────────
if dist.GunStoreCounter and dist.GunStoreCounter.items then
    addMany(dist.GunStoreCounter.items, {
        { "WK_RangeSafetyOfficerRef",  1 },
        { "WK_MagazineDrillCard",      1 },
        { "WK_ArmorersWeaponsRef",     1 },
        { "WK_PracticalShootingRef",   1 },
    })
end

-- ── Fire Station ─────────────────────────────────────────────────────────────
if dist.FireStorageTools and dist.FireStorageTools.items then
    addMany(dist.FireStorageTools.items, {
        { "WK_ForcibleEntryRef",       1 },
        { "WK_FirefighterHandToolSOP", 1 },
        { "WK_CPRAEDRef",              1 },
        { "WK_EmergencyTriageRef",     1 },
        { "WK_FireAcademyFitnessRef",  1 },
        { "WK_WorkplaceFirstAidSOP",   1 },
    })
end

-- ── Blacksmith / Metal Shop ───────────────────────────────────────────────────
if dist.WildWestBlacksmith and dist.WildWestBlacksmith.items then
    addMany(dist.WildWestBlacksmith.items, {
        { "WK_ASTMMaterialSpecRef",      1 },
        { "WK_ForgeHeatTreatGuide",      1 },
        { "WK_IndustrialMetalworkRef",   1 },
        { "WK_BlacksmithGuildStandards", 1 },
    })
end

if dist.MetalShopTools and dist.MetalShopTools.items then
    addMany(dist.MetalShopTools.items, {
        { "WK_ASTMMaterialSpecRef",    1 },
        { "WK_ForgeHeatTreatGuide",    1 },
        { "WK_IndustrialMetalworkRef", 1 },
        { "WK_EdgeToolSharpeningRef",  1 },
        { "WK_WhetstoneSelectionRef",  1 },
    })
end

-- ── Welding Shop ─────────────────────────────────────────────────────────────
if dist.WeldingWorkshopTools and dist.WeldingWorkshopTools.items then
    addMany(dist.WeldingWorkshopTools.items, {
        { "WK_AWSD11WeldingRef",       1 },
        { "WK_WeldingProcSpecRef",     1 },
        { "WK_ElectrodeFillMetalRef",  1 },
        { "WK_WeldInspectionRef",      1 },
        { "WK_OSHAWeldingSafety",      1 },
    })
end

-- ── Auto Shop / Mechanic ──────────────────────────────────────────────────────
if dist.MechanicShelfBooks and dist.MechanicShelfBooks.items then
    addMany(dist.MechanicShelfBooks.items, {
        { "WK_OBDIICodeRef",        1 },
        { "WK_TorqueSpecsRef",      1 },
        { "WK_BrakeServiceRef",     1 },
        { "WK_AutoElecDiagRef",     1 },
        { "WK_FleetMaintenanceLog", 1 },
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
        { "WK_OBDIICodeRef",        1 },
        { "WK_TorqueSpecsRef",      1 },
        { "WK_FleetMaintenanceLog", 1 },
    })
end

-- ── Electrician ───────────────────────────────────────────────────────────────
if dist.ElectricianTools and dist.ElectricianTools.items then
    addMany(dist.ElectricianTools.items, {
        { "WK_NECArticleRef",            1 },
        { "WK_WireGaugeAmpacityRef",     1 },
        { "WK_OSHAElectricalSafety",     1 },
        { "WK_ConduitFillRef",           1 },
        { "WK_PanelInspectionChecklist", 1 },
    })
end

-- ── Glassmaking ───────────────────────────────────────────────────────────────
if dist.UniversityFilingCabinet_Glassmaking and dist.UniversityFilingCabinet_Glassmaking.items then
    addMany(dist.UniversityFilingCabinet_Glassmaking.items, {
        { "WK_GlassAnnealingRef",   1 },
        { "WK_KilnFormingRef",      1 },
        { "WK_FloatGlassManufRef",  1 },
    })
end

-- ── Farming / Agriculture ─────────────────────────────────────────────────────
if dist.ToolCabinetFarming and dist.ToolCabinetFarming.items then
    addMany(dist.ToolCabinetFarming.items, {
        { "WK_KnoxExtensionGuide",      1 },
        { "WK_SoilTestInterpretRef",    1 },
        { "WK_PesticideApplicationRef", 1 },
        { "WK_IrrigationSchedulingRef", 1 },
        { "WK_LivestockHealthRef",      1 },
        { "WK_VaccinationDosageRef",    1 },
        { "WK_KDALivestockRef",         1 },
    })
end

-- ── Butcher ───────────────────────────────────────────────────────────────────
if dist.ButcherLiterature and dist.ButcherLiterature.items then
    addMany(dist.ButcherLiterature.items, {
        { "WK_USDAMeatGradingRef",  1 },
        { "WK_PrimalSubPrimalRef",  1 },
        { "WK_HACCPMeatProcessing", 1 },
        { "WK_MeatFabricationRef",  1 },
    })
end

-- ── Tool Store (back room) ────────────────────────────────────────────────────
if dist.ToolStoreMisc and dist.ToolStoreMisc.items then
    addMany(dist.ToolStoreMisc.items, {
        { "WK_FramingHammerCard",      1 },
        { "WK_CrowbarApplicationsRef", 1 },
        { "WK_FramingSquareCard",      1 },
        { "WK_EdgeToolSharpeningRef",  1 },
        { "WK_WhetstoneSelectionRef",  1 },
        { "WK_WoodenHandleShaftRef",   1 },
        { "WK_KnifeHandleFittingRef",  1 },
        { "WK_MortarMixRef",           1 },
        { "WK_HandToolConditionRef",   1 },
        { "WK_OSHAHandToolSafety",     1 },
    })
end

-- ── Generic desk: golf club / rec center back-office docs ────────────────────
if dist.DeskGeneric and dist.DeskGeneric.items then
    addMany(dist.DeskGeneric.items, {
        { "WK_GolfSwingRef",          0.07 },
        { "WK_BaseballSwingRef",      0.07 },
        { "WK_LEFitnessStandardsRef", 0.07 },
    })
end

-- ── FilingCabinetGeneric ─────────────────────────────────────────────────────
-- Covers offices, office storage, medical offices, break rooms.
-- Weight 0.01 per item: ~157 items total → cumulative ~1.6 WK weight.
-- At base pool ~100 with 5 rolls: ~7-8% chance of a doc per cabinet.
-- Six cabinets + six desks yields roughly one WK document on average.
if dist.FilingCabinetGeneric and dist.FilingCabinetGeneric.items then
    addMany(dist.FilingCabinetGeneric.items, {
        -- Carpentry / construction (contractor offices, lumber yards)
        { "WK_LumberYardManual",         0.01 },
        { "WK_SpanTablesRef",            0.01 },
        { "WK_NDSWoodConstruction",      0.01 },
        { "WK_FinishCarpentryNotes",     0.01 },
        { "WK_FramingSquareCard",        0.01 },
        -- Aiming / law enforcement
        { "WK_SheriffQualLog",           0.01 },
        -- Maintenance / tool care
        { "WK_KnifeMaintenanceLog",      0.01 },
        { "WK_HandToolConditionRef",     0.01 },
        -- OSHA / workplace safety (very broadly applicable)
        { "WK_OSHALoggingRef",           0.01 },
        { "WK_OSHAHandToolSafety",       0.01 },
        { "WK_OSHAElectricalSafety",     0.01 },
        { "WK_OSHAWeldingSafety",        0.01 },
        { "WK_OSHAFirstAidRef",          0.01 },
        -- Construction / masonry
        { "WK_MortarMixRef",             0.01 },
        { "WK_ASTMC90MasonryRef",        0.01 },
        { "WK_BrickBlockInspectionRef",  0.01 },
        { "WK_ConcreteMixRef",           0.01 },
        -- Electrical
        { "WK_NECArticleRef",            0.01 },
        { "WK_WireGaugeAmpacityRef",     0.01 },
        { "WK_ConduitFillRef",           0.01 },
        { "WK_PanelInspectionChecklist", 0.01 },
        -- Mechanics / fleet
        { "WK_FleetMaintenanceLog",      0.01 },
        -- Cooking / food safety
        { "WK_HACCPFoodSafetyPlan",      0.01 },
        { "WK_TempTimeControlChart",     0.01 },
        { "WK_ServSafeRef",              0.01 },
        { "WK_LineCookStationRef",       0.01 },
        -- First Aid / medical
        { "WK_WorkplaceFirstAidSOP",     0.01 },
        { "WK_CPRAEDRef",                0.01 },
        { "WK_EmergencyTriageRef",       0.01 },
        -- Tailoring / textile industry
        { "WK_PatternGradingRef",        0.01 },
        { "WK_IndustrialSewingRef",      0.01 },
        { "WK_FiberFabricRef",           0.01 },
        { "WK_GarmentQualityRef",        0.01 },
        -- Agriculture / extension office
        { "WK_KnoxExtensionGuide",       0.01 },
        { "WK_SoilTestInterpretRef",     0.01 },
        { "WK_PesticideApplicationRef",  0.01 },
        { "WK_IrrigationSchedulingRef",  0.01 },
        -- Animal Care (vet clinic, farm office)
        { "WK_LivestockHealthRef",       0.01 },
        { "WK_VaccinationDosageRef",     0.01 },
        { "WK_ReproductiveMgmtBinder",   0.01 },
        { "WK_KDALivestockRef",          0.01 },
        -- Butchering / food processing
        { "WK_USDAMeatGradingRef",       0.01 },
        { "WK_HACCPMeatProcessing",      0.01 },
        -- Running / fitness
        { "WK_LEFitnessStandardsRef",    0.01 },
        { "WK_FireAcademyFitnessRef",    0.01 },
        -- Strength / ergonomics
        { "WK_NIOSHLiftingRef",          0.01 },
        { "WK_ManualMaterialsHandRef",   0.01 },
        -- Fishing (tackle shop back office, marina)
        { "WK_KYFishingRegs",            0.01 },
        { "WK_CommercialFishingSafetyRef", 0.01 },
        -- Foraging / botany (university, extension office)
        { "WK_EdiblePlantsRef",          0.01 },
        { "WK_ToxicPlantRef",            0.01 },
        -- Tracking / wildlife management (KDFW offices)
        { "WK_KDFWRGameMgmtRef",         0.01 },
        -- Trapping (KDFW, fur trade offices)
        { "WK_KDFWRTrapperRegs",         0.01 },
        -- Blacksmithing / materials (industrial offices)
        { "WK_ASTMMaterialSpecRef",      0.01 },
        { "WK_IndustrialMetalworkRef",   0.01 },
        -- Welding (fab shop, construction office)
        { "WK_WeldingProcSpecRef",       0.01 },
        { "WK_WeldInspectionRef",        0.01 },
    })
end

-- EXPANDED CONTENT v2
if dist.ButcherLiterature and dist.ButcherLiterature.items then
    addMany(dist.ButcherLiterature.items, {
        { "WK_ButchersBoningGuide", 1 },
        { "WK_UFCWCutleryTechRef", 1 },
        { "WK_UnionStockyardsCut", 1 },
        { "WK_DeerProcessorGuide", 1 },
        { "WK_SausageProductionNotes", 1 },
        { "WK_SmallSlaughterhouseSOP", 1 },
        { "WK_KosherButcheringRef", 1 },
        { "WK_CharcuterieProduction", 1 },
        { "WK_HolidayTurkeyCard", 1 },
        { "WK_CharcutierApprDiary", 1 },
        { "WK_WildGameProcessor", 1 },
    })
end

if dist.CarDealerFilingCabinet and dist.CarDealerFilingCabinet.items then
    addMany(dist.CarDealerFilingCabinet.items, {
        { "WK_ASEStudyGuide", 0.5 },
        { "WK_ChevyTechServiceBull", 0.5 },
        { "WK_TruckingFleetPMSched", 1 },
    })
end

if dist.DeskGeneric and dist.DeskGeneric.items then
    addMany(dist.DeskGeneric.items, {
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

if dist.ElectricianTools and dist.ElectricianTools.items then
    addMany(dist.ElectricianTools.items, {
        { "WK_IBEWApprentBook", 1 },
        { "WK_ResWiringText", 1 },
        { "WK_MotorControlSchem", 1 },
        { "WK_TransformerNamePlate", 1 },
        { "WK_GroundingBondingRef", 1 },
        { "WK_UndergroundCableRef", 1 },
    })
end

if dist.FilingCabinetGeneric and dist.FilingCabinetGeneric.items then
    addMany(dist.FilingCabinetGeneric.items, {
        { "WK_FBIQualScorebook",        0.01 },
        { "WK_BoyScoutRiflery",         0.01 },
        { "WK_VietnamRiflemanNotes",    0.01 },
        { "WK_NavalGunnersManual",      0.01 },
        { "WK_GuardForceWeaponsManual", 0.01 },
        { "WK_TimberCruiserHandbook",   0.01 },
        { "WK_BoyScoutAxemanship",      0.01 },
        { "WK_BackcountryHatchetCard",  0.01 },
        { "WK_TechnicalRescueAxeRef",   0.01 },
        { "WK_KDFWRDeadwoodPamph",      0.01 },
        { "WK_KYHighwayBrushControl",   0.01 },
        { "WK_CornDetasselingCard",      0.01 },
        { "WK_AppalachianHerbalCutting", 0.01 },
        { "WK_StateParksTrailCrew",     0.01 },
        { "WK_CaneCuttingManual",       0.01 },
        { "WK_ShopApprenticeToolLog",   0.01 },
        { "WK_BarberRazorStropping",    0.01 },
        { "WK_AntiqueDealerCare",       0.01 },
        { "WK_SushiChefKnifeBook",      0.01 },
        { "WK_TaxidermistCapingRef",    0.01 },
        { "WK_SurgeonScalpelRef",       0.01 },
        { "WK_UFCWCutleryTechRef",      0.01 },
        { "WK_NorthwoodsFilletCard",    0.01 },
        { "WK_RailroadSpikeMaul",       0.01 },
        { "WK_CaverHammerPickRef",      0.01 },
        { "WK_TrackMaintenanceSledge",  0.01 },
        { "WK_KDFWRBowfishingRef",      0.01 },
        { "WK_CherokeeFishSpear",       0.01 },
        { "WK_WWIIBayonetTraining",     0.01 },
        { "WK_PrimitiveSpearfishing",   0.01 },
        { "WK_ABANANewsletter",         0.01 },
        { "WK_SteelmillProcessRef",     0.01 },
        { "WK_CountryCarversBook",      0.01 },
        { "WK_AppalachianFolkArt",      0.01 },
        { "WK_BowyerTilleringNotes",    0.01 },
        { "WK_SullivanCulinaryText",    0.01 },
        { "WK_KYExtensionCookbook",     0.01 },
        { "WK_ArmyMessHallSOP",         0.01 },
        { "WK_SchoolCafeteriaRef",      0.01 },
        { "WK_PitBossBBQManual",        0.01 },
        { "WK_HeritageCookbook1957",    0.01 },
        { "WK_TruckStopGriddleNotes",   0.01 },
        { "WK_IBEWApprentBook",         0.01 },
        { "WK_GroundingBondingRef",     0.01 },
        { "WK_KYStateLicensingMan",     0.01 },
        { "WK_CorningEngineering",      0.01 },
        { "WK_StainedGlassChurch",      0.01 },
        { "WK_AntiqueBottleCollect",    0.01 },
        { "WK_TiffanyMethodRef",        0.01 },
        { "WK_NeonSignBenders",         0.01 },
        { "WK_CherokeeArrowhead",       0.01 },
        { "WK_FieldArchKnapping",       0.01 },
        { "WK_PrimBowhunterFlint",      0.01 },
        { "WK_AmateurArchPamph",        0.01 },
        { "WK_ObsidianSourceRef",       0.01 },
        { "WK_KCMuseumLithicCat",       0.01 },
        { "WK_ToolStoneQualityCard",    0.01 },
        { "WK_BIATraditionalBrick",     0.01 },
        { "WK_ChimneySweepInspect",     0.01 },
        { "WK_HistoricPointingMan",     0.01 },
        { "WK_KCMasonsLocalNews",       0.01 },
        { "WK_KYVehicleInspection",     0.01 },
        { "WK_TruckingFleetPMSched",    0.01 },
        { "WK_UnivCeramicsText",        0.01 },
        { "WK_PenlandWheelRef",         0.01 },
        { "WK_RakuFiringNotes",         0.01 },
        { "WK_SaltGlazeStoneware",      0.01 },
        { "WK_AppFolkPotteryPamph",     0.01 },
        { "WK_StudioKilnRepair",        0.01 },
        { "WK_CommercialPotteryProc",   0.01 },
        { "WK_SearsPatternCatalog",     0.01 },
        { "WK_CarhartUnionShop",        0.01 },
        { "WK_AlterationsTailorCard",   0.01 },
        { "WK_HomeEcSewingText",        0.01 },
        { "WK_TheatricalCostumeShop",   0.01 },
        { "WK_HancockFabricsManual",    0.01 },
        { "WK_UpholstererGuide",        0.01 },
        { "WK_BridalSeamstressNotes",   0.01 },
        { "WK_AWSCertWelderManual",     0.01 },
        { "WK_UAWWeldingShopSOP",       0.01 },
        { "WK_FFAVocAgText",            0.01 },
        { "WK_KYExtensionAgBull",       0.01 },
        { "WK_UKAgEconNotes",           0.01 },
        { "WK_KYTobaccoGrowGuide",      0.01 },
        { "WK_RodaleOrganicPamph",      0.01 },
        { "WK_KYCattlemensNews",        0.01 },
        { "WK_TysonPoultryGrower",      0.01 },
        { "WK_TrackVetDailyLog",        0.01 },
        { "WK_UnionStockyardsCut",      0.01 },
        { "WK_SmallSlaughterhouseSOP",  0.01 },
        { "WK_CharcuterieProduction",   0.01 },
        { "WK_NCAAStrengthCondition",   0.01 },
        { "WK_BostonMarathonTrain",     0.01 },
        { "WK_ArmyAPFTManual",          0.01 },
        { "WK_USPFPowerlifting",         0.01 },
        { "WK_OlympicLiftingNotes",     0.01 },
        { "WK_StrongmanTrainingMan",    0.01 },
        { "WK_MuscleBuilderMag",        0.01 },
        { "WK_ArmyCombatLifter",        0.01 },
        { "WK_FreightDockLiftCard",     0.01 },
        { "WK_CollegeStrengthLog",      0.01 },
        { "WK_ParamedicProtocolMan",    0.01 },
        { "WK_ERTriageTextbook",        0.01 },
        { "WK_NursingFundamentals",     0.01 },
        { "WK_PharmacistDispensing",    0.01 },
        { "WK_ArmyCombatMedic",         0.01 },
        { "WK_NursingHomeCareMan",      0.01 },
        { "WK_WoundCareSuturing",       0.01 },
        { "WK_PediatricFirstAid",       0.01 },
        { "WK_KYBassFishingClub",       0.01 },
        { "WK_CrappieAnglersGuide",     0.01 },
        { "WK_KYTroutStocking",         0.01 },
        { "WK_FlyTyingPattern",         0.01 },
        { "WK_KYRiverCatfishing",       0.01 },
        { "WK_WalleyeFishingRef",       0.01 },
        { "WK_NoodlingHandfishing",     0.01 },
        { "WK_KYMusselRegs",            0.01 },
        { "WK_KYWildflowerGuide",       0.01 },
        { "WK_StalkingWildAsparagus",   0.01 },
        { "WK_HerbalPharmacyEnc",       0.01 },
        { "WK_WildMushroomHunt",        0.01 },
        { "WK_BackyardForaging",        0.01 },
        { "WK_EthnobotanyText",         0.01 },
        { "WK_TraditionalAppPlants",    0.01 },
        { "WK_HunterGatherersRef",      0.01 },
        { "WK_WildEdiblesCookbook",     0.01 },
        { "WK_ApacheScoutTracking",     0.01 },
        { "WK_KYCoonHunting",           0.01 },
        { "WK_SARTrackingTraining",     0.01 },
        { "WK_TurkeyHuntingRef",        0.01 },
        { "WK_WildlifeBiologyText",     0.01 },
        { "WK_BowHunterCamoMan",        0.01 },
        { "WK_NavySEALReconPamph",      0.01 },
        { "WK_SignReadingNotes",         0.01 },
        { "WK_NTAFurHandlersGuide",     0.01 },
        { "WK_KYBeaverTrapPamph",       0.01 },
        { "WK_FoxHolerLureRecipes",     0.01 },
        { "WK_ConibearSetTechnique",    0.01 },
        { "WK_FootholdStakingRef",      0.01 },
        { "WK_USDAAnimalDamage",        0.01 },
        { "WK_KDFWRNuisanceWild",       0.01 },
        { "WK_MuskratPeltStretch",      0.01 },
        { "WK_FurAuctionGrading",       0.01 },
        { "WK_LogHomeBuildersRef",      0.01 },
        { "WK_AppTimberFramePamph",     0.01 },
        { "WK_VocSchoolBuildTrades",    0.01 },
    })
end

if dist.FireStorageTools and dist.FireStorageTools.items then
    addMany(dist.FireStorageTools.items, {
        { "WK_EngineCompanyAxeRef", 1 },
        { "WK_EMTRescueKnifeCard", 1 },
        { "WK_FirefighterHaliganRef", 1 },
        { "WK_PulaskiSwingScale", 1 },
        { "WK_ParamedicProtocolMan", 1 },
        { "WK_ArmyCombatMedic", 1 },
        { "WK_SARTrackingTraining", 1 },
    })
end

if dist.GunStoreCounter and dist.GunStoreCounter.items then
    addMany(dist.GunStoreCounter.items, {
        { "WK_NRAPistolInstructorMan", 1 },
        { "WK_BullseyeMatchProgramme", 1 },
        { "WK_KYConcealedCarryGuide", 0.5 },
        { "WK_USPSARulebook", 1 },
        { "WK_VietnamRiflemanNotes", 0.5 },
        { "WK_HighPowerNewsletter", 1 },
        { "WK_RevolverSpeedloaderCard", 0.5 },
        { "WK_CombatShootingDrills", 1 },
        { "WK_GunsmithStripping", 1 },
        { "WK_ShotgunReloadingCard", 1 },
        { "WK_RangemasterDrillBook", 1 },
    })
end

if dist.MechanicShelfBooks and dist.MechanicShelfBooks.items then
    addMany(dist.MechanicShelfBooks.items, {
        { "WK_AutoBodyHammerNotes", 1 },
        { "WK_ASEStudyGuide", 1 },
        { "WK_KYVehicleInspection", 1 },
        { "WK_BriggsStrattonRepair", 1 },
        { "WK_DieselTroubleshoot", 1 },
        { "WK_FordPickupShopMan", 1 },
        { "WK_ChevyTechServiceBull", 1 },
        { "WK_AutoBodyWeldingRef", 1 },
    })
end

if dist.MetalShopTools and dist.MetalShopTools.items then
    addMany(dist.MetalShopTools.items, {
        { "WK_BladesmithToolCare", 1 },
        { "WK_KnifemakerTestCutLog", 1 },
        { "WK_BlacksmithHammerCard", 1 },
        { "WK_SteelmillProcessRef", 1 },
        { "WK_KnifemakerForgeWeld", 1 },
        { "WK_MotorControlSchem", 0.5 },
    })
end

if dist.PoliceDesk and dist.PoliceDesk.items then
    addMany(dist.PoliceDesk.items, {
        { "WK_PoliceAcademyHandgun", 0.5 },
        { "WK_CombatShootingDrills", 0.5 },
        { "WK_PoliceRecruitFitness", 0.5 },
    })
end

if dist.PoliceFilingCabinet and dist.PoliceFilingCabinet.items then
    addMany(dist.PoliceFilingCabinet.items, {
        { "WK_NRAPistolInstructorMan", 0.5 },
        { "WK_KYConcealedCarryGuide", 1 },
        { "WK_FBIQualScorebook", 1 },
        { "WK_PoliceAcademyHandgun", 1 },
        { "WK_RevolverSpeedloaderCard", 1 },
        { "WK_RangemasterDrillBook", 0.5 },
        { "WK_NightstickTrainingMan", 1 },
        { "WK_RiotBatonInstructorRef", 1 },
        { "WK_PoliceRecruitFitness", 1 },
        { "WK_BloodhoundHandlerCard", 1 },
    })
end

if dist.ToolCabinetFarming and dist.ToolCabinetFarming.items then
    addMany(dist.ToolCabinetFarming.items, {
        { "WK_BushHogOperatorRef", 1 },
        { "WK_CornDetasselingCard", 1 },
        { "WK_KaiserBladeFieldRef", 0.5 },
        { "WK_FarrierShoeingNotes", 0.5 },
        { "WK_KYExtensionCookbook", 0.5 },
        { "WK_BriggsStrattonRepair", 0.5 },
        { "WK_FFAVocAgText", 1 },
        { "WK_KYExtensionAgBull", 1 },
        { "WK_FertSpreaderCalCard", 1 },
        { "WK_USDACropRotation", 1 },
        { "WK_NoTillFarmingMan", 1 },
        { "WK_KYTobaccoGrowGuide", 1 },
        { "WK_KYCattlemensNews", 1 },
        { "WK_FFALivestockJudging", 1 },
        { "WK_TysonPoultryGrower", 1 },
        { "WK_SheepGoatBreeder", 1 },
        { "WK_SwineProductionMan", 1 },
        { "WK_DairyHerdMgmt", 1 },
        { "WK_DeerProcessorGuide", 0.5 },
        { "WK_WildGameProcessor", 0.5 },
        { "WK_FarmStrengthManual", 1 },
        { "WK_KYWildflowerGuide", 1 },
        { "WK_USDAAnimalDamage", 1 },
    })
end

if dist.ToolStoreMisc and dist.ToolStoreMisc.items then
    addMany(dist.ToolStoreMisc.items, {
        { "WK_TimberCruiserHandbook", 1 },
        { "WK_AppalachianFellingNotes", 1 },
        { "WK_MountainRescueIceAxe", 1 },
        { "WK_BackcountryHatchetCard", 1 },
        { "WK_TechnicalRescueAxeRef", 0.5 },
        { "WK_KaiserBladeFieldRef", 1 },
        { "WK_JewelersFileCard", 1 },
        { "WK_ShopApprenticeToolLog", 1 },
        { "WK_BowSawSetGuide", 1 },
        { "WK_ProductionFramerCard", 1 },
        { "WK_MasonsHammerRef", 1 },
        { "WK_RoofersFlashingCard", 1 },
        { "WK_LandClearingMaul", 1 },
        { "WK_BIATraditionalBrick", 1 },
        { "WK_StonecutterApprenNote", 1 },
        { "WK_ConcreteFinishersRef", 1 },
        { "WK_FieldstoneWalls", 1 },
        { "WK_PavingStoneInstall", 1 },
        { "WK_CabinetmakerJoinery", 1 },
        { "WK_RoofFramingCalcCard", 1 },
        { "WK_LogHomeBuildersRef", 1 },
        { "WK_FurnitureMakerNotes", 1 },
    })
end

if dist.UniversityFilingCabinet_Glassmaking and dist.UniversityFilingCabinet_Glassmaking.items then
    addMany(dist.UniversityFilingCabinet_Glassmaking.items, {
        { "WK_PenlandStudioGlass", 1 },
        { "WK_CorningEngineering", 1 },
        { "WK_BorosilicateLampwork", 1 },
    })
end

if dist.WeldingWorkshopTools and dist.WeldingWorkshopTools.items then
    addMany(dist.WeldingWorkshopTools.items, {
        { "WK_AWSCertWelderManual", 1 },
        { "WK_PipefittersWelding", 1 },
        { "WK_AluminumMIGRef", 1 },
        { "WK_UAWWeldingShopSOP", 1 },
        { "WK_StickRodSelectionGuide", 1 },
        { "WK_AerospaceTIGNotes", 1 },
    })
end

if dist.WildWestBlacksmith and dist.WildWestBlacksmith.items then
    addMany(dist.WildWestBlacksmith.items, {
        { "WK_ABANANewsletter", 1 },
        { "WK_FarrierShoeingNotes", 1 },
        { "WK_FrontierForgeRef", 1 },
        { "WK_SwordsmithApprDiary", 1 },
        { "WK_ColonialIronworker", 1 },
    })
end

