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

local LEVELS      = { 0.25, 0.5, 1.0, 2.0, 4.0 }
local LEVEL_NAMES = { "Very Rare", "Rare", "Normal", "Common", "Abundant" }

-- Read the spawn rate from both sources that expose it. They can disagree:
-- this file runs when server Lua loads, and if the save's sandbox values have
-- not been applied yet, one of them still reports the default. Logging both
-- makes that visible rather than silently registering everything at 1x.
local viaVars, viaOptions

if SandboxVars and SandboxVars.WorkingKnowledge then
    viaVars = SandboxVars.WorkingKnowledge.SpawnRate
end

local opts = getSandboxOptions and getSandboxOptions()
if opts then
    local opt = opts:getOptionByName("WorkingKnowledge.SpawnRate") --[[@as {getValue:fun():integer}|nil]]
    if opt then
        viaOptions = opt:getValue()
    end
end

local level     = viaVars or viaOptions
local spawnMult = (level and LEVELS[level]) or 1.0

print("[WorkingKnowledge] spawn rate: SandboxVars=" .. tostring(viaVars)
      .. ", getSandboxOptions=" .. tostring(viaOptions)
      .. " -> " .. tostring(LEVEL_NAMES[level or 0] or "DEFAULTED")
      .. " (x" .. tostring(spawnMult) .. ")")

if viaVars and viaOptions and viaVars ~= viaOptions then
    print("[WorkingKnowledge] WARNING: sandbox sources disagree, using " .. tostring(level))
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

-- Report the rate actually in effect for one pool per tier, derived from the
-- live table rather than from the tier constants, so the log reflects what the
-- game will really do.
local function effectiveRate(distName)
    local pool   = WK_LootPools.list[distName]
    local target = dist[distName]
    if not pool or not target or not target.rolls then return "?" end
    local expected = target.rolls * (pool.weight * spawnMult) / 100
    if expected <= 0 then return "?" end
    return string.format("1 in %.1f", 1 / expected)
end

print("[WorkingKnowledge] effective: FilingCabinetGeneric " .. effectiveRate("FilingCabinetGeneric")
      .. ", PoliceFilingCabinet " .. effectiveRate("PoliceFilingCabinet")
      .. ", PotteryStudioTools " .. effectiveRate("PotteryStudioTools"))
