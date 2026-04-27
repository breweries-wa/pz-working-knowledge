-- Add Working Knowledge documents to relevant filing cabinet loot tables.
-- This file runs after vanilla distribution tables are loaded.

local function addToItems(itemsTable, typeName, weight)
    table.insert(itemsTable, typeName)
    table.insert(itemsTable, weight)
end

-- FilingCabinetGeneric covers: office, officestorage, medicaloffice, breakroom.
-- Weight 2 against Paperwork at 50 = rare but findable.
local generic = ProceduralDistributions.list.FilingCabinetGeneric
if generic and generic.items then
    addToItems(generic.items, "WK_LumberYardManual", 2)
end
