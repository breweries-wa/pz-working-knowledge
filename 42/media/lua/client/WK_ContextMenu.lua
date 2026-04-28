require "WK_ReadAction"

-- Maps bare item type → Perks enum value.
-- Built lazily on first use so Perks.X is read after the game engine is ready.
local WK_DOCS = nil

local function getWKDocs()
    if not WK_DOCS then
        WK_DOCS = {
            WK_LumberYardManual = Perks.Carpentry,
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
            local perkType = getWKDocs()[bareType]
            if perkType and not seen[bareType] then
                seen[bareType] = true
                if item:getModData()["WK_read"] then
                    local opt = context:addOption("Already read", item, nil)
                    opt.notAvailable = true
                else
                    context:addOption("Read", item, WK_ContextMenu.onRead, player, perkType)
                end
            end
        end
    end
end

WK_ContextMenu = {}

function WK_ContextMenu.onRead(item, player, perkType)
    ISTimedActionQueue.add(WKReadAction:new(player, item, perkType))
end

Events.OnFillInventoryObjectContextMenu.Add(onFillInventoryContextMenu)
