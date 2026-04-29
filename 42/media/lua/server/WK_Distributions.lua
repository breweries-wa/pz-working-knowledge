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
        { "WK_GolfSwingRef",          0.5 },
        { "WK_BaseballSwingRef",      0.5 },
        { "WK_LEFitnessStandardsRef", 0.3 },
    })
end

-- ── FilingCabinetGeneric ─────────────────────────────────────────────────────
-- Covers offices, office storage, medical offices, break rooms.
-- Weights kept low: ~40 items are added, so cumulative odds add up fast.
-- Safety/compliance docs at 0.2; niche trade docs at 0.1.
if dist.FilingCabinetGeneric and dist.FilingCabinetGeneric.items then
    addMany(dist.FilingCabinetGeneric.items, {
        -- Carpentry / construction (contractor offices, lumber yards)
        { "WK_LumberYardManual",         0.2  },
        { "WK_SpanTablesRef",            0.2  },
        { "WK_NDSWoodConstruction",      0.2  },
        { "WK_FinishCarpentryNotes",     0.1  },
        { "WK_FramingSquareCard",        0.1  },
        -- Aiming / law enforcement
        { "WK_SheriffQualLog",           0.1  },
        -- Maintenance / tool care
        { "WK_KnifeMaintenanceLog",      0.1  },
        { "WK_HandToolConditionRef",     0.2  },
        -- OSHA / workplace safety (very broadly applicable)
        { "WK_OSHALoggingRef",           0.2  },
        { "WK_OSHAHandToolSafety",       0.2  },
        { "WK_OSHAElectricalSafety",     0.2  },
        { "WK_OSHAWeldingSafety",        0.2  },
        { "WK_OSHAFirstAidRef",          0.2  },
        -- Construction / masonry
        { "WK_MortarMixRef",             0.1  },
        { "WK_ASTMC90MasonryRef",        0.1  },
        { "WK_BrickBlockInspectionRef",  0.1  },
        { "WK_ConcreteMixRef",           0.1  },
        -- Electrical
        { "WK_NECArticleRef",            0.1  },
        { "WK_WireGaugeAmpacityRef",     0.1  },
        { "WK_ConduitFillRef",           0.1  },
        { "WK_PanelInspectionChecklist", 0.1  },
        -- Mechanics / fleet
        { "WK_FleetMaintenanceLog",      0.1  },
        -- Cooking / food safety
        { "WK_HACCPFoodSafetyPlan",      0.2  },
        { "WK_TempTimeControlChart",     0.2  },
        { "WK_ServSafeRef",              0.2  },
        { "WK_LineCookStationRef",       0.1  },
        -- First Aid / medical
        { "WK_WorkplaceFirstAidSOP",     0.2  },
        { "WK_CPRAEDRef",                0.2  },
        { "WK_EmergencyTriageRef",       0.1  },
        -- Tailoring / textile industry
        { "WK_PatternGradingRef",        0.1  },
        { "WK_IndustrialSewingRef",      0.1  },
        { "WK_FiberFabricRef",           0.1  },
        { "WK_GarmentQualityRef",        0.1  },
        -- Agriculture / extension office
        { "WK_KnoxExtensionGuide",       0.1  },
        { "WK_SoilTestInterpretRef",     0.1  },
        { "WK_PesticideApplicationRef",  0.2  },
        { "WK_IrrigationSchedulingRef",  0.1  },
        -- Animal Care (vet clinic, farm office)
        { "WK_LivestockHealthRef",       0.1  },
        { "WK_VaccinationDosageRef",     0.1  },
        { "WK_ReproductiveMgmtBinder",   0.1  },
        { "WK_KDALivestockRef",          0.1  },
        -- Butchering / food processing
        { "WK_USDAMeatGradingRef",       0.1  },
        { "WK_HACCPMeatProcessing",      0.1  },
        -- Running / fitness
        { "WK_LEFitnessStandardsRef",    0.1  },
        { "WK_FireAcademyFitnessRef",    0.1  },
        -- Strength / ergonomics
        { "WK_NIOSHLiftingRef",          0.2  },
        { "WK_ManualMaterialsHandRef",   0.2  },
        -- Fishing (tackle shop back office, marina)
        { "WK_KYFishingRegs",            0.1  },
        { "WK_CommercialFishingSafetyRef", 0.1 },
        -- Foraging / botany (university, extension office)
        { "WK_EdiblePlantsRef",          0.1  },
        { "WK_ToxicPlantRef",            0.1  },
        -- Tracking / wildlife management (KDFW offices)
        { "WK_KDFWRGameMgmtRef",         0.1  },
        -- Trapping (KDFW, fur trade offices)
        { "WK_KDFWRTrapperRegs",         0.1  },
        -- Blacksmithing / materials (industrial offices)
        { "WK_ASTMMaterialSpecRef",      0.1  },
        { "WK_IndustrialMetalworkRef",   0.1  },
        -- Welding (fab shop, construction office)
        { "WK_WeldingProcSpecRef",       0.1  },
        { "WK_WeldInspectionRef",        0.1  },
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
        { "WK_BullseyeMatchProgramme", 0.3 },
        { "WK_BoyScoutRiflery", 1 },
        { "WK_HighPowerNewsletter", 0.3 },
        { "WK_BoyScoutAxemanship", 1 },
        { "WK_SCAHeavyFightCard", 1 },
        { "WK_LarpFightChoreography", 1 },
        { "WK_ScoutTroopToolCare", 1 },
        { "WK_ScoutCampcraftKnife", 1 },
        { "WK_CricketBowlersGuide", 1 },
        { "WK_LacrosseCoachManual", 1 },
        { "WK_HockeyStickHandling", 1 },
        { "WK_SCAPolearmRef", 1 },
        { "WK_TrackPoleVaultCard", 1 },
        { "WK_KarateBoStaffMan", 1 },
        { "WK_ScoutsPolearmDemo", 1 },
        { "WK_ScoutMetalwork", 1 },
        { "WK_SpoonCarvingNotes", 1 },
        { "WK_ChipCarvingPattern", 1 },
        { "WK_WaldenWoodcrafter", 1 },
        { "WK_JuniorHighWoodshop", 1 },
        { "WK_AppalachianFolkArt", 1 },
        { "WK_KilnFusedJewelry", 1 },
        { "WK_BeadSocietyLampwork", 1 },
        { "WK_RendezvousMtnMan", 1 },
        { "WK_BSAPrimitiveSurvival", 1 },
        { "WK_ChildrenPotteryLesson", 1 },
        { "WK_BeginnerWheelNotes", 1 },
        { "WK_HomeEcSewingText", 1 },
        { "WK_AgEdJudgingCard", 1 },
        { "WK_HSTrackCoachManual", 1 },
        { "WK_KYHSAARulebook", 1 },
        { "WK_SprintIntervalCard", 1 },
        { "WK_CrossCountryRef", 1 },
        { "WK_HSFootballCondition", 1 },
        { "WK_BMXRacingTraining", 1 },
        { "WK_RugbyStrengthMan", 1 },
        { "WK_HSWrestlingStrength", 1 },
        { "WK_PediatricFirstAid", 1 },
        { "WK_ScoutCarpentryMerit", 1 },
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
        { "WK_FBIQualScorebook", 0.1 },
        { "WK_BoyScoutRiflery", 0.1 },
        { "WK_VietnamRiflemanNotes", 1 },
        { "WK_NavalGunnersManual", 1 },
        { "WK_GuardForceWeaponsManual", 1 },
        { "WK_TimberCruiserHandbook", 0.1 },
        { "WK_BoyScoutAxemanship", 0.1 },
        { "WK_KMLALumberjackPaper", 0.1 },
        { "WK_WeyerhaeuserSafety", 1 },
        { "WK_KDFWRDeadwoodPamph", 1 },
        { "WK_KYHighwayBrushControl", 1 },
        { "WK_CornDetasselingCard", 0.1 },
        { "WK_AppalachianHerbalCutting", 1 },
        { "WK_StateParksTrailCrew", 1 },
        { "WK_CaneCuttingManual", 1 },
        { "WK_ShopApprenticeToolLog", 0.1 },
        { "WK_BarberRazorStropping", 1 },
        { "WK_AntiqueDealerCare", 1 },
        { "WK_SushiChefKnifeBook", 1 },
        { "WK_TaxidermistCapingRef", 1 },
        { "WK_SurgeonScalpelRef", 1 },
        { "WK_UFCWCutleryTechRef", 0.1 },
        { "WK_NorthwoodsFilletCard", 1 },
        { "WK_RailroadSpikeMaul", 1 },
        { "WK_CaverHammerPickRef", 1 },
        { "WK_TrackMaintenanceSledge", 1 },
        { "WK_KDFWRBowfishingRef", 1 },
        { "WK_CherokeeFishSpear", 1 },
        { "WK_WWIIBayonetTraining", 1 },
        { "WK_PrimitiveSpearfishing", 1 },
        { "WK_ABANANewsletter", 0.1 },
        { "WK_SteelmillProcessRef", 0.1 },
        { "WK_CountryCarversBook", 1 },
        { "WK_AppalachianFolkArt", 0.1 },
        { "WK_BowyerTilleringNotes", 1 },
        { "WK_SullivanCulinaryText", 1 },
        { "WK_KYExtensionCookbook", 1 },
        { "WK_ArmyMessHallSOP", 1 },
        { "WK_SchoolCafeteriaRef", 1 },
        { "WK_PitBossBBQManual", 1 },
        { "WK_HeritageCookbook1957", 1 },
        { "WK_TruckStopGriddleNotes", 1 },
        { "WK_IBEWApprentBook", 0.1 },
        { "WK_GroundingBondingRef", 0.1 },
        { "WK_KYStateLicensingMan", 1 },
        { "WK_CorningEngineering", 0.1 },
        { "WK_StainedGlassChurch", 1 },
        { "WK_AntiqueBottleCollect", 1 },
        { "WK_TiffanyMethodRef", 1 },
        { "WK_NeonSignBenders", 1 },
        { "WK_CherokeeArrowhead", 1 },
        { "WK_FieldArchKnapping", 1 },
        { "WK_PrimBowhunterFlint", 1 },
        { "WK_AmateurArchPamph", 1 },
        { "WK_ObsidianSourceRef", 1 },
        { "WK_KCMuseumLithicCat", 1 },
        { "WK_ToolStoneQualityCard", 1 },
        { "WK_BIATraditionalBrick", 0.1 },
        { "WK_ChimneySweepInspect", 1 },
        { "WK_HistoricPointingMan", 1 },
        { "WK_KCMasonsLocalNews", 1 },
        { "WK_KYVehicleInspection", 0.1 },
        { "WK_TruckingFleetPMSched", 0.1 },
        { "WK_UnivCeramicsText", 1 },
        { "WK_PenlandWheelRef", 1 },
        { "WK_RakuFiringNotes", 1 },
        { "WK_SaltGlazeStoneware", 1 },
        { "WK_AppFolkPotteryPamph", 1 },
        { "WK_StudioKilnRepair", 1 },
        { "WK_CommercialPotteryProc", 1 },
        { "WK_SearsPatternCatalog", 1 },
        { "WK_CarhartUnionShop", 1 },
        { "WK_AlterationsTailorCard", 1 },
        { "WK_HomeEcSewingText", 0.1 },
        { "WK_TheatricalCostumeShop", 1 },
        { "WK_HancockFabricsManual", 1 },
        { "WK_UpholstererGuide", 1 },
        { "WK_BridalSeamstressNotes", 1 },
        { "WK_AWSCertWelderManual", 0.1 },
        { "WK_UAWWeldingShopSOP", 0.1 },
        { "WK_FFAVocAgText", 0.1 },
        { "WK_KYExtensionAgBull", 0.1 },
        { "WK_UKAgEconNotes", 1 },
        { "WK_KYTobaccoGrowGuide", 0.1 },
        { "WK_RodaleOrganicPamph", 1 },
        { "WK_KYCattlemensNews", 0.1 },
        { "WK_TysonPoultryGrower", 0.1 },
        { "WK_TrackVetDailyLog", 1 },
        { "WK_UnionStockyardsCut", 0.1 },
        { "WK_SmallSlaughterhouseSOP", 0.1 },
        { "WK_CharcuterieProduction", 0.1 },
        { "WK_NCAAStrengthCondition", 1 },
        { "WK_BostonMarathonTrain", 1 },
        { "WK_ArmyAPFTManual", 1 },
        { "WK_USPFPowerlifting", 1 },
        { "WK_OlympicLiftingNotes", 1 },
        { "WK_StrongmanTrainingMan", 1 },
        { "WK_MuscleBuilderMag", 1 },
        { "WK_ArmyCombatLifter", 1 },
        { "WK_FreightDockLiftCard", 1 },
        { "WK_CollegeStrengthLog", 1 },
        { "WK_ParamedicProtocolMan", 0.1 },
        { "WK_ERTriageTextbook", 1 },
        { "WK_NursingFundamentals", 1 },
        { "WK_PharmacistDispensing", 1 },
        { "WK_ArmyCombatMedic", 0.1 },
        { "WK_NursingHomeCareMan", 1 },
        { "WK_WoundCareSuturing", 1 },
        { "WK_PediatricFirstAid", 0.1 },
        { "WK_KYBassFishingClub", 1 },
        { "WK_CrappieAnglersGuide", 1 },
        { "WK_KYTroutStocking", 1 },
        { "WK_FlyTyingPattern", 1 },
        { "WK_KYRiverCatfishing", 1 },
        { "WK_WalleyeFishingRef", 1 },
        { "WK_NoodlingHandfishing", 1 },
        { "WK_KYMusselRegs", 1 },
        { "WK_KYWildflowerGuide", 0.1 },
        { "WK_StalkingWildAsparagus", 1 },
        { "WK_HerbalPharmacyEnc", 1 },
        { "WK_WildMushroomHunt", 1 },
        { "WK_BackyardForaging", 1 },
        { "WK_EthnobotanyText", 1 },
        { "WK_TraditionalAppPlants", 1 },
        { "WK_HunterGatherersRef", 1 },
        { "WK_WildEdiblesCookbook", 1 },
        { "WK_ApacheScoutTracking", 1 },
        { "WK_KYCoonHunting", 1 },
        { "WK_SARTrackingTraining", 0.1 },
        { "WK_TurkeyHuntingRef", 1 },
        { "WK_WildlifeBiologyText", 1 },
        { "WK_BowHunterCamoMan", 1 },
        { "WK_NavySEALReconPamph", 1 },
        { "WK_SignReadingNotes", 1 },
        { "WK_NTAFurHandlersGuide", 1 },
        { "WK_KYBeaverTrapPamph", 1 },
        { "WK_FoxHolerLureRecipes", 1 },
        { "WK_ConibearSetTechnique", 1 },
        { "WK_FootholdStakingRef", 1 },
        { "WK_USDAAnimalDamage", 0.1 },
        { "WK_KDFWRNuisanceWild", 1 },
        { "WK_MuskratPeltStretch", 1 },
        { "WK_FurAuctionGrading", 1 },
        { "WK_LogHomeBuildersRef", 0.1 },
        { "WK_AppTimberFramePamph", 1 },
        { "WK_VocSchoolBuildTrades", 1 },
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
        { "WK_HewingTimbersGuide", 1 },
        { "WK_KMLALumberjackPaper", 1 },
        { "WK_WeyerhaeuserSafety", 0.5 },
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

