-- Swap Working Knowledge loot placeholders for real documents.
--
-- WK_Distributions registers one placeholder item per procedural distribution.
-- ItemPickerJava fires OnFillContainer immediately after filling a container,
-- which is where we exchange each placeholder for a random document from that
-- pool.

local WK_LootPools = require "WK_LootPools"

-- placeholder item type -> document list
local byPlaceholder = {}
for _, pool in pairs(WK_LootPools.list) do
    byPlaceholder[pool.placeholder] = pool.docs
end

-- ---------------------------------------------------------------------------
-- TEMPORARY INSTRUMENTATION
-- Records every container the game fills, keyed by room and container type,
-- with how many received a document. Written to Zomboid/WK_lootlog.csv.
-- Remove this block once the rates are settled.
-- ---------------------------------------------------------------------------
local track   = {}
local nFills  = 0
local nDocs   = 0
local lastDump = 0
local nextFull = 2500

local function bump(room, ctype, hit)
    local key = tostring(room) .. "|" .. tostring(ctype)
    local t = track[key]
    if not t then
        t = { room = tostring(room), ctype = tostring(ctype), n = 0, h = 0 }
        track[key] = t
    end
    t.n = t.n + 1
    if hit then t.h = t.h + 1 end
end

local function dump(full)
    print("[WorkingKnowledge] lootlog: " .. nFills .. " fills, " .. nDocs .. " documents placed")
    if not full then return end
    -- getFileWriter is a client-only global, so the table goes to the log.
    -- One row per room + container type; parsed offline.
    for _, t in pairs(track) do
        print("[WorkingKnowledge] WKROW " .. t.room .. "|" .. t.ctype .. "|" .. t.n .. "|" .. t.h)
    end
end

-- ---------------------------------------------------------------------------

local function replacePlaceholders(roomName, containerType, container)
    if not container then return end

    -- OnFillContainer does not always hand back an ItemContainer. Four of the
    -- ten trigger sites in ItemPickerJava pass containerDist.bags instead --
    -- the "Zombie Bag" path and the nested-bag paths inside doRollItemInternal
    -- -- which is an ItemPickerContainer, a distribution definition with no
    -- getItems(). Indexing it throws in Kahlua, so bail out on anything that
    -- is not a real container. Those paths fill bags from outfit bag
    -- distributions, which WK never registers into, so nothing is missed.
    if not instanceof(container, "ItemContainer") then return end

    local items = container:getItems()
    if not items then return end

    -- Collect before mutating; removing while iterating the live list skips entries.
    local found
    for i = 0, items:size() - 1 do
        local item = items:get(i)
        if item then
            local docs = byPlaceholder[item:getType()]
            if docs and #docs > 0 then
                found = found or {}
                table.insert(found, { item = item, docs = docs })
            end
        end
    end

    nFills = nFills + 1
    bump(roomName, containerType, found ~= nil)

    -- Flush on fill count rather than a game-time event: vanilla can wedge the
    -- main thread (RBBurntCorpse looping on multi-tile removal), which stops
    -- game time and would lose everything collected so far.
    if nFills - lastDump >= 500 then
        lastDump = nFills
        dump(nFills >= nextFull)
        if nFills >= nextFull then nextFull = nFills + 2500 end
    end

    if not found then return end

    for i = 1, #found do
        local entry = found[i]
        local docs  = entry.docs
        container:Remove(entry.item)
        container:AddItem("Base." .. docs[ZombRand(#docs) + 1])
        nDocs = nDocs + 1
    end
end

Events.OnFillContainer.Add(replacePlaceholders)
