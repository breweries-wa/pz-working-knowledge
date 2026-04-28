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
-- PoliceFilingCabinet: firearms quals, impact weapon SOPs, fitness standards
if dist.PoliceFilingCabinet and dist.PoliceFilingCabinet.items then
    addMany(dist.PoliceFilingCabinet.items, {
        { "WK_KCPDFirearmsQual",       2 },
        { "WK_RangeSafetyOfficerRef",  2 },
        { "WK_DefensiveHandgunRef",     2 },
        { "WK_SheriffQualLog",         2 },
        { "WK_TacticalReloadRef",      2 },
        { "WK_MagazineDrillCard",      2 },
        { "WK_ArmorersWeaponsRef",     2 },
        { "WK_ImpactWeaponMaintSOP",   2 },
        { "WK_KCPDImpactWeaponsRef",   2 },
        { "WK_LEFitnessStandardsRef",  2 },
    })
end

-- PoliceDesk: operational references kept at the desk
if dist.PoliceDesk and dist.PoliceDesk.items then
    addMany(dist.PoliceDesk.items, {
        { "WK_KCPDFirearmsQual",       2 },
        { "WK_DefensiveHandgunRef",     2 },
        { "WK_TacticalReloadRef",      2 },
        { "WK_MagazineDrillCard",      2 },
        { "WK_ImpactWeaponMaintSOP",   2 },
        { "WK_KCPDImpactWeaponsRef",   2 },
    })
end

-- ── Gun Store ────────────────────────────────────────────────────────────────
-- GunStoreCounter: range/reload references behind the counter
if dist.GunStoreCounter and dist.GunStoreCounter.items then
    addMany(dist.GunStoreCounter.items, {
        { "WK_RangeSafetyOfficerRef",  2 },
        { "WK_MagazineDrillCard",      2 },
        { "WK_ArmorersWeaponsRef",     2 },
        { "WK_PracticalShootingRef",   2 },
    })
end

-- ── Fire Station ─────────────────────────────────────────────────────────────
-- FireStorageTools: forcible-entry, hand-tool SOPs, fitness, first aid
if dist.FireStorageTools and dist.FireStorageTools.items then
    addMany(dist.FireStorageTools.items, {
        { "WK_ForcibleEntryRef",          2 },
        { "WK_FirefighterHandToolSOP",    2 },
        { "WK_CPRAEDRef",                 2 },
        { "WK_EmergencyTriageRef",        2 },
        { "WK_FireAcademyFitnessRef",     2 },
        { "WK_WorkplaceFirstAidSOP",      2 },
    })
end

-- ── Blacksmith / Metal Shop ───────────────────────────────────────────────────
if dist.WildWestBlacksmith and dist.WildWestBlacksmith.items then
    addMany(dist.WildWestBlacksmith.items, {
        { "WK_ASTMMaterialSpecRef",      2 },
        { "WK_ForgeHeatTreatGuide",      2 },
        { "WK_IndustrialMetalworkRef",   2 },
        { "WK_BlacksmithGuildStandards", 2 },
    })
end

if dist.MetalShopTools and dist.MetalShopTools.items then
    addMany(dist.MetalShopTools.items, {
        { "WK_ASTMMaterialSpecRef",      2 },
        { "WK_ForgeHeatTreatGuide",      2 },
        { "WK_IndustrialMetalworkRef",   2 },
        { "WK_EdgeToolSharpeningRef",    2 },
        { "WK_WhetstoneSelectionRef",    2 },
    })
end

-- ── Welding Shop ─────────────────────────────────────────────────────────────
if dist.WeldingWorkshopTools and dist.WeldingWorkshopTools.items then
    addMany(dist.WeldingWorkshopTools.items, {
        { "WK_AWSD11WeldingRef",         2 },
        { "WK_WeldingProcSpecRef",       2 },
        { "WK_ElectrodeFillMetalRef",    2 },
        { "WK_WeldInspectionRef",        2 },
        { "WK_OSHAWeldingSafety",        2 },
    })
end

-- ── Auto Shop / Mechanic ──────────────────────────────────────────────────────
if dist.MechanicShelfBooks and dist.MechanicShelfBooks.items then
    addMany(dist.MechanicShelfBooks.items, {
        { "WK_OBDIICodeRef",             2 },
        { "WK_TorqueSpecsRef",           2 },
        { "WK_BrakeServiceRef",          2 },
        { "WK_AutoElecDiagRef",          2 },
        { "WK_FleetMaintenanceLog",      2 },
    })
end

if dist.MechanicShelfBrakes and dist.MechanicShelfBrakes.items then
    addToItems(dist.MechanicShelfBrakes.items, "WK_BrakeServiceRef", 2)
end

if dist.MechanicShelfElectric and dist.MechanicShelfElectric.items then
    addToItems(dist.MechanicShelfElectric.items, "WK_AutoElecDiagRef", 2)
end

if dist.CarDealerFilingCabinet and dist.CarDealerFilingCabinet.items then
    addMany(dist.CarDealerFilingCabinet.items, {
        { "WK_OBDIICodeRef",             2 },
        { "WK_TorqueSpecsRef",           2 },
        { "WK_FleetMaintenanceLog",      2 },
    })
end

-- ── Electrician ───────────────────────────────────────────────────────────────
if dist.ElectricianTools and dist.ElectricianTools.items then
    addMany(dist.ElectricianTools.items, {
        { "WK_NECArticleRef",            2 },
        { "WK_WireGaugeAmpacityRef",     2 },
        { "WK_OSHAElectricalSafety",     2 },
        { "WK_ConduitFillRef",           2 },
        { "WK_PanelInspectionChecklist", 2 },
    })
end

-- ── Glassmaking ───────────────────────────────────────────────────────────────
if dist.UniversityFilingCabinet_Glassmaking and dist.UniversityFilingCabinet_Glassmaking.items then
    addMany(dist.UniversityFilingCabinet_Glassmaking.items, {
        { "WK_GlassAnnealingRef",        2 },
        { "WK_KilnFormingRef",           2 },
        { "WK_FloatGlassManufRef",       2 },
    })
end

-- ── Farming / Agriculture ─────────────────────────────────────────────────────
if dist.ToolCabinetFarming and dist.ToolCabinetFarming.items then
    addMany(dist.ToolCabinetFarming.items, {
        { "WK_KnoxExtensionGuide",       2 },
        { "WK_SoilTestInterpretRef",     2 },
        { "WK_PesticideApplicationRef",  2 },
        { "WK_IrrigationSchedulingRef",  2 },
        { "WK_LivestockHealthRef",       2 },
        { "WK_VaccinationDosageRef",     2 },
        { "WK_KDALivestockRef",          2 },
    })
end

-- ── Butcher ───────────────────────────────────────────────────────────────────
if dist.ButcherLiterature and dist.ButcherLiterature.items then
    addMany(dist.ButcherLiterature.items, {
        { "WK_USDAMeatGradingRef",       2 },
        { "WK_PrimalSubPrimalRef",       2 },
        { "WK_HACCPMeatProcessing",      2 },
        { "WK_MeatFabricationRef",       2 },
    })
end

-- ── Tool Store (back room) ────────────────────────────────────────────────────
if dist.ToolStoreMisc and dist.ToolStoreMisc.items then
    addMany(dist.ToolStoreMisc.items, {
        { "WK_FramingHammerCard",        2 },
        { "WK_CrowbarApplicationsRef",   2 },
        { "WK_FramingSquareCard",        2 },
        { "WK_EdgeToolSharpeningRef",    2 },
        { "WK_WhetstoneSelectionRef",    2 },
        { "WK_WoodenHandleShaftRef",     2 },
        { "WK_KnifeHandleFittingRef",    2 },
        { "WK_MortarMixRef",             2 },
        { "WK_HandToolConditionRef",     2 },
        { "WK_OSHAHandToolSafety",       2 },
    })
end

-- ── Generic desk: golf club / rec center back-office docs ────────────────────
if dist.DeskGeneric and dist.DeskGeneric.items then
    addMany(dist.DeskGeneric.items, {
        { "WK_GolfSwingRef",             2 },
        { "WK_BaseballSwingRef",         2 },
        { "WK_LEFitnessStandardsRef",    1 },
    })
end

-- ── FilingCabinetGeneric ─────────────────────────────────────────────────────
-- Covers offices, office storage, medical offices, break rooms.
-- Workplace safety and compliance docs at weight 1; niche trade docs at 0.5.
if dist.FilingCabinetGeneric and dist.FilingCabinetGeneric.items then
    addMany(dist.FilingCabinetGeneric.items, {
        -- Carpentry / construction (contractor offices, lumber yards)
        { "WK_LumberYardManual",         1   },
        { "WK_SpanTablesRef",            1   },
        { "WK_NDSWoodConstruction",      1   },
        { "WK_FinishCarpentryNotes",     0.5 },
        { "WK_FramingSquareCard",        0.5 },
        -- Aiming / law enforcement
        { "WK_SheriffQualLog",           0.5 },
        -- Maintenance / tool care
        { "WK_KnifeMaintenanceLog",      0.5 },
        { "WK_HandToolConditionRef",     1   },
        -- OSHA / workplace safety (very broadly applicable)
        { "WK_OSHALoggingRef",           1   },
        { "WK_OSHAHandToolSafety",       1   },
        { "WK_OSHAElectricalSafety",     1   },
        { "WK_OSHAWeldingSafety",        1   },
        { "WK_OSHAFirstAidRef",          1   },
        -- Construction / masonry
        { "WK_MortarMixRef",             0.5 },
        { "WK_ASTMC90MasonryRef",        0.5 },
        { "WK_BrickBlockInspectionRef",  0.5 },
        { "WK_ConcreteMixRef",           0.5 },
        -- Electrical
        { "WK_NECArticleRef",            0.5 },
        { "WK_WireGaugeAmpacityRef",     0.5 },
        { "WK_ConduitFillRef",           0.5 },
        { "WK_PanelInspectionChecklist", 0.5 },
        -- Mechanics / fleet
        { "WK_FleetMaintenanceLog",      0.5 },
        -- Cooking / food safety
        { "WK_HACCPFoodSafetyPlan",      1   },
        { "WK_TempTimeControlChart",     1   },
        { "WK_ServSafeRef",              1   },
        { "WK_LineCookStationRef",       0.5 },
        -- First Aid / medical
        { "WK_WorkplaceFirstAidSOP",     1   },
        { "WK_CPRAEDRef",                1   },
        { "WK_EmergencyTriageRef",       0.5 },
        -- Tailoring / textile industry
        { "WK_PatternGradingRef",        0.5 },
        { "WK_IndustrialSewingRef",      0.5 },
        { "WK_FiberFabricRef",           0.5 },
        { "WK_GarmentQualityRef",        0.5 },
        -- Agriculture / extension office
        { "WK_KnoxExtensionGuide",       0.5 },
        { "WK_SoilTestInterpretRef",     0.5 },
        { "WK_PesticideApplicationRef",  1   },
        { "WK_IrrigationSchedulingRef",  0.5 },
        -- Animal Care (vet clinic, farm office)
        { "WK_LivestockHealthRef",       0.5 },
        { "WK_VaccinationDosageRef",     0.5 },
        { "WK_ReproductiveMgmtBinder",   0.5 },
        { "WK_KDALivestockRef",          0.5 },
        -- Butchering / food processing
        { "WK_USDAMeatGradingRef",       0.5 },
        { "WK_HACCPMeatProcessing",      0.5 },
        -- Running / fitness
        { "WK_LEFitnessStandardsRef",    0.5 },
        { "WK_FireAcademyFitnessRef",    0.5 },
        -- Strength / ergonomics
        { "WK_NIOSHLiftingRef",          1   },
        { "WK_ManualMaterialsHandRef",   1   },
        -- Fishing (tackle shop back office, marina)
        { "WK_KYFishingRegs",            0.5 },
        { "WK_CommercialFishingSafetyRef", 0.5 },
        -- Foraging / botany (university, extension office)
        { "WK_EdiblePlantsRef",          0.5 },
        { "WK_ToxicPlantRef",            0.5 },
        -- Tracking / wildlife management (KDFW offices)
        { "WK_KDFWRGameMgmtRef",        0.5 },
        -- Trapping (KDFW, fur trade offices)
        { "WK_KDFWRTrapperRegs",         0.5 },
        -- Blacksmithing / materials (industrial offices)
        { "WK_ASTMMaterialSpecRef",      0.5 },
        { "WK_IndustrialMetalworkRef",   0.5 },
        -- Welding (fab shop, construction office)
        { "WK_WeldingProcSpecRef",       0.5 },
        { "WK_WeldInspectionRef",        0.5 },
    })
end
