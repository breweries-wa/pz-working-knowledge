require "WK_ReadAction"

-- Maps item type → Perks enum value.
-- Item type is whatever item:getType() returns at runtime (checked on first test).
local WK_DOCS = {
    WK_LumberYardManual = Perks.Carpentry,
}

local function onFillInventoryContextMenu(playerNum, context, items)
    local player = getSpecificPlayer(playerNum)
    if not player then return end

    local actualItems = ISInventoryPane.getActualItems(items)
    for _, item in ipairs(actualItems) do
        local ok, itemType = pcall(function() return item:getType() end)
        if not ok or not itemType then goto continue end

        local perkType = WK_DOCS[itemType]
        if perkType then
            local key = "WK_read_" .. itemType
            if player:getModData()[key] then
                local opt = context:addOption("Already read", item, nil)
                opt.notAvailable = true
            else
                context:addOption("Read", item, WK_ContextMenu.onRead, player, perkType)
            end
        end

        ::continue::
    end
end

WK_ContextMenu = {}

function WK_ContextMenu.onRead(item, player, perkType)
    ISTimedActionQueue.add(WKReadAction:new(player, item, perkType))
end

Events.OnFillInventoryObjectContextMenu.Add(onFillInventoryContextMenu)
