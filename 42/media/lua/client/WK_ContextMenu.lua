require "WK_ReadAction"

-- Maps bare item type → perk name string.
-- Built lazily so Perks.X is read after the game engine is ready.
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
        }
    end
    return WK_DOCS
end

-- Tag the item with a literatureTitle so inventory-tracking mods can identify it.
local function tagLiterature(item, bareType)
    local ok, md = pcall(function() return item:getModData() end)
    if ok and md and not md.literatureTitle then
        md.literatureTitle = "Base." .. bareType
    end
end

local function onFillInventoryContextMenu(playerNum, context, items)
    local player = getSpecificPlayer(playerNum)
    if not player then return end

    local docs = getWKDocs()
    local actualItems = ISInventoryPane.getActualItems(items)
    local seen = {}
    for _, item in ipairs(actualItems) do
        local ok, itemType = pcall(function() return item:getType() end)
        if ok and itemType then
            local bareType = itemType:match("%.(.+)$") or itemType
            local perkName = docs[bareType]
            if perkName then
                tagLiterature(item, bareType)
                if not seen[bareType] then
                    seen[bareType] = true
                    local readKey = "WK_read_" .. bareType
                    if player:getModData()[readKey] then
                        local opt = context:addOption("Already read", item, nil)
                        opt.notAvailable = true
                    else
                        context:addOption("Read", item, WK_ContextMenu.onRead, player, perkName, bareType)
                    end
                end
            end
        end
    end
end

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

WK_ContextMenu = {}

function WK_ContextMenu.onRead(item, player, perkName, itemType)
    ISTimedActionQueue.add(WKReadAction:new(player, item, perkName, itemType))
end

Events.OnFillInventoryObjectContextMenu.Add(onFillInventoryContextMenu)
