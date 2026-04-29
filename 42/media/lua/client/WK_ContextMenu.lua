require "TimedActions/ISReadABook"

-- Maps bare item type → perk name string.
-- Built lazily so game engine is ready before we access it.
local WK_DOCS = nil

local function getWKDocs()
    if not WK_DOCS then
        WK_DOCS = {
            -- Carpentry / Woodwork
            WK_LumberYardManual         = "Woodwork",
            WK_SpanTablesRef            = "Woodwork",
            WK_FinishCarpentryNotes     = "Woodwork",
            WK_NDSWoodConstruction      = "Woodwork",
            WK_FramingSquareCard        = "Woodwork",
            -- Aiming
            WK_KCPDFirearmsQual         = "Aiming",
            WK_RangeSafetyOfficerRef    = "Aiming",
            WK_DefensiveHandgunRef      = "Aiming",
            WK_SheriffQualLog           = "Aiming",
            -- Reloading
            WK_TacticalReloadRef        = "Reloading",
            WK_MagazineDrillCard        = "Reloading",
            WK_ArmorersWeaponsRef       = "Reloading",
            WK_PracticalShootingRef     = "Reloading",
            -- Axe
            WK_OSHALoggingRef           = "Axe",
            WK_ArboristFieldGuide       = "Axe",
            WK_ForcibleEntryRef         = "Axe",
            WK_FirefighterHandToolSOP   = "Axe",
            -- Long Blade
            WK_BrushClearingRef         = "LongBlade",
            WK_MacheteUseGuide          = "LongBlade",
            WK_ForestryContractorSOP    = "LongBlade",
            -- Maintenance
            WK_KnifeMaintenanceLog      = "Maintenance",
            WK_EdgeToolSharpeningRef    = "Maintenance",
            WK_HandToolConditionRef     = "Maintenance",
            WK_ImpactWeaponMaintSOP     = "Maintenance",
            WK_WhetstoneSelectionRef    = "Maintenance",
            -- Short Blade
            WK_MeatFabricationRef       = "SmallBlade",
            WK_NSFBladeSafetyRef        = "SmallBlade",
            WK_FishFabricationRef       = "SmallBlade",
            -- Short Blunt
            WK_KCPDImpactWeaponsRef     = "SmallBlunt",
            WK_OSHAHandToolSafety       = "SmallBlunt",
            WK_FramingHammerCard        = "SmallBlunt",
            WK_PlumbingQuickClearRef    = "SmallBlunt",
            -- Long Blunt
            WK_BaseballSwingRef         = "Blunt",
            WK_DemolitionHandToolRef    = "Blunt",
            WK_GolfSwingRef             = "Blunt",
            WK_CrowbarApplicationsRef   = "Blunt",
            -- Spear
            WK_KDFWRPrimitiveWeapons    = "Spear",
            WK_JavelinCoachingRef       = "Spear",
            WK_AtlatlSpearRef           = "Spear",
            WK_StageCombatSpearRef      = "Spear",
            -- Blacksmithing
            WK_ASTMMaterialSpecRef      = "Blacksmith",
            WK_ForgeHeatTreatGuide      = "Blacksmith",
            WK_IndustrialMetalworkRef   = "Blacksmith",
            WK_BlacksmithGuildStandards = "Blacksmith",
            -- Carving
            WK_WoodenHandleShaftRef     = "Carving",
            WK_FieldExpedientToolRef    = "Carving",
            WK_ArchaeologicalToolNotes  = "Carving",
            WK_TrapperBoneToolRef       = "Carving",
            WK_KnifeHandleFittingRef    = "Carving",
            -- Cooking
            WK_HACCPFoodSafetyPlan      = "Cooking",
            WK_TempTimeControlChart     = "Cooking",
            WK_LineCookStationRef       = "Cooking",
            WK_SauceStockLog            = "Cooking",
            WK_ServSafeRef              = "Cooking",
            -- Electrical
            WK_NECArticleRef            = "Electricity",
            WK_WireGaugeAmpacityRef     = "Electricity",
            WK_OSHAElectricalSafety     = "Electricity",
            WK_ConduitFillRef           = "Electricity",
            WK_PanelInspectionChecklist = "Electricity",
            -- Glassmaking
            WK_GlassAnnealingRef        = "Glassmaking",
            WK_FloatGlassManufRef       = "Glassmaking",
            WK_KilnFormingRef           = "Glassmaking",
            -- Knapping
            WK_LithicTechnologyRef          = "FlintKnapping",
            WK_PrimitiveSkillsKnappingRef   = "FlintKnapping",
            WK_LithicAnalysisStandards      = "FlintKnapping",
            -- Masonry
            WK_MortarMixRef             = "Masonry",
            WK_ASTMC90MasonryRef        = "Masonry",
            WK_BrickBlockInspectionRef  = "Masonry",
            WK_ConcreteMixRef           = "Masonry",
            -- Mechanics
            WK_OBDIICodeRef             = "Mechanics",
            WK_TorqueSpecsRef           = "Mechanics",
            WK_BrakeServiceRef          = "Mechanics",
            WK_AutoElecDiagRef          = "Mechanics",
            WK_FleetMaintenanceLog      = "Mechanics",
            -- Pottery
            WK_KilnFiringScheduleRef    = "Pottery",
            WK_GlazeChemistryRef        = "Pottery",
            WK_ClayBodyFormulationRef   = "Pottery",
            -- Tailoring
            WK_PatternGradingRef        = "Tailoring",
            WK_IndustrialSewingRef      = "Tailoring",
            WK_FiberFabricRef           = "Tailoring",
            WK_GarmentQualityRef        = "Tailoring",
            -- Welding
            WK_AWSD11WeldingRef         = "MetalWelding",
            WK_WeldingProcSpecRef       = "MetalWelding",
            WK_ElectrodeFillMetalRef    = "MetalWelding",
            WK_WeldInspectionRef        = "MetalWelding",
            WK_OSHAWeldingSafety        = "MetalWelding",
            -- Agriculture
            WK_KnoxExtensionGuide       = "Farming",
            WK_SoilTestInterpretRef     = "Farming",
            WK_PesticideApplicationRef  = "Farming",
            WK_IrrigationSchedulingRef  = "Farming",
            -- Animal Care
            WK_LivestockHealthRef       = "Husbandry",
            WK_VaccinationDosageRef     = "Husbandry",
            WK_ReproductiveMgmtBinder   = "Husbandry",
            WK_KDALivestockRef          = "Husbandry",
            -- Butchering
            WK_USDAMeatGradingRef       = "Butchering",
            WK_PrimalSubPrimalRef       = "Butchering",
            WK_HACCPMeatProcessing      = "Butchering",
            -- Running
            WK_LEFitnessStandardsRef    = "Sprinting",
            WK_FireAcademyFitnessRef    = "Sprinting",
            -- Strength
            WK_NIOSHLiftingRef          = "Strength",
            WK_ManualMaterialsHandRef   = "Strength",
            -- First Aid
            WK_WorkplaceFirstAidSOP     = "Doctor",
            WK_CPRAEDRef                = "Doctor",
            WK_OSHAFirstAidRef          = "Doctor",
            WK_EmergencyTriageRef       = "Doctor",
            -- Fishing
            WK_KYFishingRegs            = "Fishing",
            WK_FishIdentificationRef    = "Fishing",
            WK_RiggingTackleRef         = "Fishing",
            WK_CommercialFishingSafetyRef = "Fishing",
            -- Foraging
            WK_EdiblePlantsRef          = "PlantScavenging",
            WK_ToxicPlantRef            = "PlantScavenging",
            WK_WildcraftHerbalistRef    = "PlantScavenging",
            -- Tracking
            WK_WildlifeTrackSignRef     = "Tracking",
            WK_DeerMovementRef          = "Tracking",
            WK_KDFWRGameMgmtRef         = "Tracking",
            -- Trapping
            WK_WildlifeTrappingGuide    = "Trapping",
            WK_FurbearerRef             = "Trapping",
            WK_KDFWRTrapperRegs         = "Trapping",
            -- EXPANDED CONTENT v2
            -- Aiming
            WK_NRAPistolInstructorMan       = "Aiming",
            WK_BullseyeMatchProgramme       = "Aiming",
            WK_KYConcealedCarryGuide        = "Aiming",
            WK_FBIQualScorebook             = "Aiming",
            WK_USPSARulebook                = "Aiming",
            WK_BoyScoutRiflery              = "Aiming",
            WK_VietnamRiflemanNotes         = "Aiming",
            WK_HighPowerNewsletter          = "Aiming",
            -- Axe
            WK_TimberCruiserHandbook        = "Axe",
            WK_AppalachianFellingNotes      = "Axe",
            WK_BoyScoutAxemanship           = "Axe",
            WK_HewingTimbersGuide           = "Axe",
            WK_KMLALumberjackPaper          = "Axe",
            WK_WeyerhaeuserSafety           = "Axe",
            WK_EngineCompanyAxeRef          = "Axe",
            WK_KDFWRDeadwoodPamph           = "Axe",
            -- Blacksmithing
            WK_ABANANewsletter              = "Blacksmith",
            WK_FarrierShoeingNotes          = "Blacksmith",
            WK_FrontierForgeRef             = "Blacksmith",
            WK_SteelmillProcessRef          = "Blacksmith",
            WK_KnifemakerForgeWeld          = "Blacksmith",
            WK_ScoutMetalwork               = "Blacksmith",
            WK_SwordsmithApprDiary          = "Blacksmith",
            WK_ColonialIronworker           = "Blacksmith",
            -- Long Blunt
            WK_TrackMaintenanceSledge       = "Blunt",
            WK_RiotBatonInstructorRef       = "Blunt",
            WK_CricketBowlersGuide          = "Blunt",
            WK_LacrosseCoachManual          = "Blunt",
            WK_HockeyStickHandling          = "Blunt",
            WK_FirefighterHaliganRef        = "Blunt",
            WK_LandClearingMaul             = "Blunt",
            WK_PulaskiSwingScale            = "Blunt",
            -- Butchering
            WK_UnionStockyardsCut           = "Butchering",
            WK_DeerProcessorGuide           = "Butchering",
            WK_SausageProductionNotes       = "Butchering",
            WK_SmallSlaughterhouseSOP       = "Butchering",
            WK_KosherButcheringRef          = "Butchering",
            WK_CharcuterieProduction        = "Butchering",
            WK_HolidayTurkeyCard            = "Butchering",
            WK_CharcutierApprDiary          = "Butchering",
            WK_WildGameProcessor            = "Butchering",
            -- Carving
            WK_SpoonCarvingNotes            = "Carving",
            WK_CountryCarversBook           = "Carving",
            WK_ChipCarvingPattern           = "Carving",
            WK_WaldenWoodcrafter            = "Carving",
            WK_JuniorHighWoodshop           = "Carving",
            WK_AppalachianFolkArt           = "Carving",
            WK_BowyerTilleringNotes         = "Carving",
            -- Cooking
            WK_SullivanCulinaryText         = "Cooking",
            WK_KYExtensionCookbook          = "Cooking",
            WK_ArmyMessHallSOP              = "Cooking",
            WK_SchoolCafeteriaRef           = "Cooking",
            WK_PitBossBBQManual             = "Cooking",
            WK_HeritageCookbook1957         = "Cooking",
            WK_TruckStopGriddleNotes        = "Cooking",
            -- First Aid
            WK_ParamedicProtocolMan         = "Doctor",
            WK_ERTriageTextbook             = "Doctor",
            WK_NursingFundamentals          = "Doctor",
            WK_PharmacistDispensing         = "Doctor",
            WK_ArmyCombatMedic              = "Doctor",
            WK_NursingHomeCareMan           = "Doctor",
            WK_WoundCareSuturing            = "Doctor",
            WK_PediatricFirstAid            = "Doctor",
            -- Electrical
            WK_IBEWApprentBook              = "Electricity",
            WK_ResWiringText                = "Electricity",
            WK_MotorControlSchem            = "Electricity",
            WK_TransformerNamePlate         = "Electricity",
            WK_GroundingBondingRef          = "Electricity",
            WK_KYStateLicensingMan          = "Electricity",
            WK_UndergroundCableRef          = "Electricity",
            -- Agriculture
            WK_FFAVocAgText                 = "Farming",
            WK_KYExtensionAgBull            = "Farming",
            WK_UKAgEconNotes                = "Farming",
            WK_FertSpreaderCalCard          = "Farming",
            WK_USDACropRotation             = "Farming",
            WK_NoTillFarmingMan             = "Farming",
            WK_KYTobaccoGrowGuide           = "Farming",
            WK_RodaleOrganicPamph           = "Farming",
            -- Fishing
            WK_KYBassFishingClub            = "Fishing",
            WK_CrappieAnglersGuide          = "Fishing",
            WK_KYTroutStocking              = "Fishing",
            WK_FlyTyingPattern              = "Fishing",
            WK_KYRiverCatfishing            = "Fishing",
            WK_WalleyeFishingRef            = "Fishing",
            WK_NoodlingHandfishing          = "Fishing",
            WK_KYMusselRegs                 = "Fishing",
            -- Knapping
            WK_CherokeeArrowhead            = "FlintKnapping",
            WK_FieldArchKnapping            = "FlintKnapping",
            WK_PrimBowhunterFlint           = "FlintKnapping",
            WK_AmateurArchPamph             = "FlintKnapping",
            WK_ObsidianSourceRef            = "FlintKnapping",
            WK_RendezvousMtnMan             = "FlintKnapping",
            WK_KCMuseumLithicCat            = "FlintKnapping",
            WK_BSAPrimitiveSurvival         = "FlintKnapping",
            WK_ToolStoneQualityCard         = "FlintKnapping",
            -- Glassmaking
            WK_PenlandStudioGlass           = "Glassmaking",
            WK_CorningEngineering           = "Glassmaking",
            WK_StainedGlassChurch           = "Glassmaking",
            WK_BorosilicateLampwork         = "Glassmaking",
            WK_AntiqueBottleCollect         = "Glassmaking",
            WK_KilnFusedJewelry             = "Glassmaking",
            WK_TiffanyMethodRef             = "Glassmaking",
            WK_NeonSignBenders              = "Glassmaking",
            WK_BeadSocietyLampwork          = "Glassmaking",
            -- Animal Care
            WK_KYCattlemensNews             = "Husbandry",
            WK_FFALivestockJudging          = "Husbandry",
            WK_TysonPoultryGrower           = "Husbandry",
            WK_TrackVetDailyLog             = "Husbandry",
            WK_SheepGoatBreeder             = "Husbandry",
            WK_SwineProductionMan           = "Husbandry",
            WK_DairyHerdMgmt                = "Husbandry",
            WK_AgEdJudgingCard              = "Husbandry",
            -- Long Blade
            WK_BushHogOperatorRef           = "LongBlade",
            WK_KYHighwayBrushControl        = "LongBlade",
            WK_CornDetasselingCard          = "LongBlade",
            WK_AppalachianHerbalCutting     = "LongBlade",
            WK_StateParksTrailCrew          = "LongBlade",
            WK_KaiserBladeFieldRef          = "LongBlade",
            WK_SCAHeavyFightCard            = "LongBlade",
            WK_CaneCuttingManual            = "LongBlade",
            WK_LarpFightChoreography        = "LongBlade",
            -- Maintenance
            WK_JewelersFileCard             = "Maintenance",
            WK_ShopApprenticeToolLog        = "Maintenance",
            WK_BarberRazorStropping         = "Maintenance",
            WK_ScoutTroopToolCare           = "Maintenance",
            WK_BladesmithToolCare           = "Maintenance",
            WK_BowSawSetGuide               = "Maintenance",
            WK_AntiqueDealerCare            = "Maintenance",
            -- Masonry
            WK_BIATraditionalBrick          = "Masonry",
            WK_StonecutterApprenNote        = "Masonry",
            WK_ChimneySweepInspect          = "Masonry",
            WK_HistoricPointingMan          = "Masonry",
            WK_ConcreteFinishersRef         = "Masonry",
            WK_KCMasonsLocalNews            = "Masonry",
            WK_FieldstoneWalls              = "Masonry",
            WK_PavingStoneInstall           = "Masonry",
            -- Mechanics
            WK_ASEStudyGuide                = "Mechanics",
            WK_KYVehicleInspection          = "Mechanics",
            WK_BriggsStrattonRepair         = "Mechanics",
            WK_DieselTroubleshoot           = "Mechanics",
            WK_FordPickupShopMan            = "Mechanics",
            WK_ChevyTechServiceBull         = "Mechanics",
            WK_TruckingFleetPMSched         = "Mechanics",
            -- Welding
            WK_AWSCertWelderManual          = "MetalWelding",
            WK_PipefittersWelding           = "MetalWelding",
            WK_AluminumMIGRef               = "MetalWelding",
            WK_UAWWeldingShopSOP            = "MetalWelding",
            WK_AutoBodyWeldingRef           = "MetalWelding",
            WK_StickRodSelectionGuide       = "MetalWelding",
            WK_AerospaceTIGNotes            = "MetalWelding",
            -- Foraging
            WK_KYWildflowerGuide            = "PlantScavenging",
            WK_StalkingWildAsparagus        = "PlantScavenging",
            WK_HerbalPharmacyEnc            = "PlantScavenging",
            WK_WildMushroomHunt             = "PlantScavenging",
            WK_BackyardForaging             = "PlantScavenging",
            WK_EthnobotanyText              = "PlantScavenging",
            WK_TraditionalAppPlants         = "PlantScavenging",
            WK_HunterGatherersRef           = "PlantScavenging",
            WK_WildEdiblesCookbook          = "PlantScavenging",
            -- Pottery
            WK_UnivCeramicsText             = "Pottery",
            WK_PenlandWheelRef              = "Pottery",
            WK_RakuFiringNotes              = "Pottery",
            WK_SaltGlazeStoneware           = "Pottery",
            WK_AppFolkPotteryPamph          = "Pottery",
            WK_StudioKilnRepair             = "Pottery",
            WK_CommercialPotteryProc        = "Pottery",
            WK_ChildrenPotteryLesson        = "Pottery",
            WK_BeginnerWheelNotes           = "Pottery",
            -- Reloading
            WK_PoliceAcademyHandgun         = "Reloading",
            WK_RevolverSpeedloaderCard      = "Reloading",
            WK_CombatShootingDrills         = "Reloading",
            WK_GunsmithStripping            = "Reloading",
            WK_NavalGunnersManual           = "Reloading",
            WK_ShotgunReloadingCard         = "Reloading",
            WK_RangemasterDrillBook         = "Reloading",
            WK_GuardForceWeaponsManual      = "Reloading",
            -- Short Blade
            WK_SushiChefKnifeBook           = "SmallBlade",
            WK_TaxidermistCapingRef         = "SmallBlade",
            WK_EMTRescueKnifeCard           = "SmallBlade",
            WK_ButchersBoningGuide          = "SmallBlade",
            WK_SurgeonScalpelRef            = "SmallBlade",
            WK_ScoutCampcraftKnife          = "SmallBlade",
            WK_UFCWCutleryTechRef           = "SmallBlade",
            WK_KnifemakerTestCutLog         = "SmallBlade",
            WK_NorthwoodsFilletCard         = "SmallBlade",
            -- Short Blunt
            WK_NightstickTrainingMan        = "SmallBlunt",
            WK_RailroadSpikeMaul            = "SmallBlunt",
            WK_AutoBodyHammerNotes          = "SmallBlunt",
            WK_ProductionFramerCard         = "SmallBlunt",
            WK_BlacksmithHammerCard         = "SmallBlunt",
            WK_MasonsHammerRef              = "SmallBlunt",
            WK_CaverHammerPickRef           = "SmallBlunt",
            WK_RoofersFlashingCard          = "SmallBlunt",
            -- Spear
            WK_KDFWRBowfishingRef           = "Spear",
            WK_SCAPolearmRef                = "Spear",
            WK_CherokeeFishSpear            = "Spear",
            WK_TrackPoleVaultCard           = "Spear",
            WK_WWIIBayonetTraining          = "Spear",
            WK_KarateBoStaffMan             = "Spear",
            WK_ScoutsPolearmDemo            = "Spear",
            WK_PrimitiveSpearfishing        = "Spear",
            -- Running
            WK_HSTrackCoachManual           = "Sprinting",
            WK_NCAAStrengthCondition        = "Sprinting",
            WK_KYHSAARulebook               = "Sprinting",
            WK_BostonMarathonTrain          = "Sprinting",
            WK_SprintIntervalCard           = "Sprinting",
            WK_CrossCountryRef              = "Sprinting",
            WK_PoliceRecruitFitness         = "Sprinting",
            WK_ArmyAPFTManual               = "Sprinting",
            WK_HSFootballCondition          = "Sprinting",
            WK_BMXRacingTraining            = "Sprinting",
            -- Strength
            WK_USPFPowerlifting             = "Strength",
            WK_OlympicLiftingNotes          = "Strength",
            WK_StrongmanTrainingMan         = "Strength",
            WK_MuscleBuilderMag             = "Strength",
            WK_ArmyCombatLifter             = "Strength",
            WK_FarmStrengthManual           = "Strength",
            WK_RugbyStrengthMan             = "Strength",
            WK_FreightDockLiftCard          = "Strength",
            WK_CollegeStrengthLog           = "Strength",
            WK_HSWrestlingStrength          = "Strength",
            -- Tailoring
            WK_SearsPatternCatalog          = "Tailoring",
            WK_CarhartUnionShop             = "Tailoring",
            WK_AlterationsTailorCard        = "Tailoring",
            WK_HomeEcSewingText             = "Tailoring",
            WK_TheatricalCostumeShop        = "Tailoring",
            WK_HancockFabricsManual         = "Tailoring",
            WK_UpholstererGuide             = "Tailoring",
            WK_BridalSeamstressNotes        = "Tailoring",
            -- Tracking
            WK_ApacheScoutTracking          = "Tracking",
            WK_KYCoonHunting                = "Tracking",
            WK_SARTrackingTraining          = "Tracking",
            WK_TurkeyHuntingRef             = "Tracking",
            WK_BloodhoundHandlerCard        = "Tracking",
            WK_WildlifeBiologyText          = "Tracking",
            WK_BowHunterCamoMan             = "Tracking",
            WK_NavySEALReconPamph           = "Tracking",
            WK_SignReadingNotes             = "Tracking",
            -- Trapping
            WK_NTAFurHandlersGuide          = "Trapping",
            WK_KYBeaverTrapPamph            = "Trapping",
            WK_FoxHolerLureRecipes          = "Trapping",
            WK_ConibearSetTechnique         = "Trapping",
            WK_FootholdStakingRef           = "Trapping",
            WK_USDAAnimalDamage             = "Trapping",
            WK_KDFWRNuisanceWild            = "Trapping",
            WK_MuskratPeltStretch           = "Trapping",
            WK_FurAuctionGrading            = "Trapping",
            -- Carpentry
            WK_CabinetmakerJoinery          = "Woodwork",
            WK_RoofFramingCalcCard          = "Woodwork",
            WK_LogHomeBuildersRef           = "Woodwork",
            WK_AppTimberFramePamph          = "Woodwork",
            WK_ScoutCarpentryMerit          = "Woodwork",
            WK_FurnitureMakerNotes          = "Woodwork",
            WK_VocSchoolBuildTrades         = "Woodwork",
        }
    end
    return WK_DOCS
end

-- ── ISReadABook hooks ────────────────────────────────────────────────────────

-- Override reading duration for WK items so they read quickly (like a
-- short reference card) rather than using the default multi-page timing.
local origISReadABookNew = ISReadABook.new
function ISReadABook:new(character, item)
    local o = origISReadABookNew(self, character, item)
    if item then
        local ok, itemType = pcall(function() return item:getType() end)
        if ok and itemType then
            local bareType = itemType:match("%.(.+)$") or itemType
            if getWKDocs()[bareType] then
                local time = 200
                if character:hasTrait(CharacterTrait.FAST_READER) then time = time * 0.7 end
                if character:hasTrait(CharacterTrait.SLOW_READER)  then time = time * 1.3 end
                o.maxTime = math.max(math.floor(time), 1)
            end
        end
    end
    return o
end

-- Grant XP when a WK document finishes reading.
local origISReadABookPerform = ISReadABook.perform
function ISReadABook:perform()
    origISReadABookPerform(self)
    if not self.item then return end
    local ok, itemType = pcall(function() return self.item:getType() end)
    if not ok or not itemType then return end
    local bareType = itemType:match("%.(.+)$") or itemType
    local perkName = getWKDocs()[bareType]
    if not perkName then return end

    local modData = self.character:getModData()
    local readKey = "WK_read_" .. bareType
    if modData[readKey] then return end  -- already granted XP this session

    modData[readKey] = true
    sendClientCommand(self.character, "WorkingKnowledge", "ReadDocument", {
        perk     = perkName,
        itemType = bareType,
    })
    local fullType = "Base." .. bareType
    if not modData.readMap then modData.readMap = {} end
    modData.readMap[fullType] = true
    -- Stamp literatureTitle so the checkmark persists after this session.
    local okMd, itemMd = pcall(function() return self.item:getModData() end)
    if okMd and itemMd then
        itemMd.literatureTitle = itemMd.literatureTitle or fullType
    end
    pcall(function() syncItemFields(self.character, self.item) end)
end

-- ── Literature tagging ───────────────────────────────────────────────────────

-- Stamp literatureTitle on items so ISInventoryPane can draw the checkmark.
local function tagLiterature(item, bareType)
    local ok, md = pcall(function() return item:getModData() end)
    if ok and md and not md.literatureTitle then
        md.literatureTitle = "Base." .. bareType
    end
end

-- Tag WK items whenever the inventory context menu opens.
local function onFillInventoryContextMenu(playerNum, context, items)
    local docs = getWKDocs()
    local actualItems = ISInventoryPane.getActualItems(items)
    for _, item in ipairs(actualItems) do
        local ok, itemType = pcall(function() return item:getType() end)
        if ok and itemType then
            local bareType = itemType:match("%.(.+)$") or itemType
            if docs[bareType] then
                tagLiterature(item, bareType)
            end
        end
    end
end
Events.OnFillInventoryObjectContextMenu.Add(onFillInventoryContextMenu)

-- Tag any WK items already in the player's inventory on save load.
local function onGameStart()
    local player = getSpecificPlayer(0)
    if not player then return end
    local inv = player:getInventory()
    if not inv then return end
    local docs = getWKDocs()
    local invItems = inv:getItems()
    for i = 0, invItems:size() - 1 do
        local ok, item = pcall(function() return invItems:get(i) end)
        if ok and item then
            local ok2, itemType = pcall(function() return item:getType() end)
            if ok2 and itemType then
                local bareType = itemType:match("%.(.+)$") or itemType
                if docs[bareType] then
                    tagLiterature(item, bareType)
                end
            end
        end
    end
end
Events.OnGameStart.Add(onGameStart)
