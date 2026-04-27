require "WK_ReadAction"

-- Maps item type → Perks enum value.
-- Keys are the bare item ID without module prefix (e.g. "WK_LumberYardManual").
-- item:getType() may return "Base.WK_LumberYardManual" or "WK_LumberYardManual"
-- depending on context; we strip the prefix before lookup.
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

        local bareType = itemType:match("%.(.+)$") or itemType
        local perkType = WK_DOCS[bareType]
        if perkType then
            if item:getModData()["WK_read"] then
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
