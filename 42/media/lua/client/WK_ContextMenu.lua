require "WK_ReadAction"

-- Maps bare item type → perk name string.
-- Built lazily so Perks.X is read after the game engine is ready.
local WK_DOCS = nil

local function getWKDocs()
    if not WK_DOCS then
        WK_DOCS = {
            WK_LumberYardManual = "Woodwork",
        }
    end
    return WK_DOCS
end

local function onFillInventoryContextMenu(playerNum, context, items)
    local player = getSpecificPlayer(playerNum)
    if not player then return end

    local actualItems = ISInventoryPane.getActualItems(items)
    local seen = {}
    for _, item in ipairs(actualItems) do
        local ok, itemType = pcall(function() return item:getType() end)
        if ok and itemType then
            local bareType = itemType:match("%.(.+)$") or itemType
            local perkName = getWKDocs()[bareType]
            if perkName and not seen[bareType] then
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

WK_ContextMenu = {}

function WK_ContextMenu.onRead(item, player, perkName, itemType)
    ISTimedActionQueue.add(WKReadAction:new(player, item, perkName, itemType))
end

Events.OnFillInventoryObjectContextMenu.Add(onFillInventoryContextMenu)
