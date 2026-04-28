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
