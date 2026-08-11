-- Swap Working Knowledge loot placeholders for real documents.
--
-- WK_Distributions registers one placeholder item per procedural distribution.
-- ItemPickerJava fires OnFillContainer immediately after filling a container
-- (see fillContainerTypeInternal call sites), which is where we exchange each
-- placeholder for a random document from that pool.

local WK_LootPools = require "WK_LootPools"

-- placeholder item type -> document list
local byPlaceholder = {}
for _, pool in pairs(WK_LootPools.list) do
    byPlaceholder[pool.placeholder] = pool.docs
end

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

    if not found then return end

    for i = 1, #found do
        local entry = found[i]
        local docs = entry.docs
        container:Remove(entry.item)
        container:AddItem("Base." .. docs[ZombRand(#docs) + 1])
    end
end

Events.OnFillContainer.Add(replacePlaceholders)
