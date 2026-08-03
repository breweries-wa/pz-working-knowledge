-- Add Working Knowledge documents to relevant loot tables.
-- This file runs after vanilla distribution tables are loaded.
--
-- Each distribution receives ONE placeholder entry rather than one entry per
-- document. ItemPickerJava.fillContainerTypeInternal rolls every entry in a
-- container's item list independently, once per roll, and resolves each entry
-- through ScriptManager.FindItem several times -- so list length is a direct
-- per-container CPU cost. FilingCabinetGeneric alone previously contributed 213
-- entries on top of vanilla's 22.
--
-- Pools and weights live in WK_LootPools; the placeholder is swapped for a real
-- document by WK_LootReplace.

local WK_LootPools = require "WK_LootPools"

-- Spawn rate sandbox option (1-5) -> weight multiplier.
-- 1=Very Rare (x0.25), 2=Rare (x0.5), 3=Normal (x1), 4=Common (x2), 5=Abundant (x4)
local spawnMult = 1.0
local opts = getSandboxOptions and getSandboxOptions()
if opts then
    local opt = opts:getOptionByName("WorkingKnowledge.SpawnRate") --[[@as {getValue:fun():integer}|nil]]
    if opt then
        local levels = { 0.25, 0.5, 1.0, 2.0, 4.0 }
        spawnMult = levels[opt:getValue()] or 1.0
    end
end

local dist = ProceduralDistributions.list
local registered, missing = 0, 0

for distName, pool in pairs(WK_LootPools.list) do
    local target = dist[distName]
    if target and target.items then
        table.insert(target.items, pool.placeholder)
        table.insert(target.items, pool.weight * spawnMult)
        registered = registered + 1
    else
        missing = missing + 1
        print("[WorkingKnowledge] distribution not found: " .. distName)
    end
end

print("[WorkingKnowledge] registered " .. registered .. " loot placeholders"
      .. (missing > 0 and (", " .. missing .. " missing") or ""))
