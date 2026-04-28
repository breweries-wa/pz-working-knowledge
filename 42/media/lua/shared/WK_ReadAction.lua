require "TimedActions/ISBaseTimedAction"

WKReadAction = ISBaseTimedAction:derive("WKReadAction")

function WKReadAction:isValid()
    if not self.item then return false end
    local ok, container = pcall(function() return self.item:getContainer() end)
    return ok and container ~= nil
end

function WKReadAction:perform()
    local readKey = "WK_read_" .. self.itemType
    local modData = self.character:getModData()
    if not modData[readKey] then
        modData[readKey] = true  -- local mark so context menu updates immediately
        sendClientCommand(self.character, "WorkingKnowledge", "ReadDocument", {
            perk     = self.perkName,
            itemType = self.itemType,
        })

        local fullType = "Base." .. self.itemType

        -- Ensure the item is tagged so inventory-tracking mods can identify it.
        local okMd, itemMd = pcall(function() return self.item:getModData() end)
        if okMd and itemMd and not itemMd.literatureTitle then
            itemMd.literatureTitle = fullType
        end

        -- Write into the player's readMap so inventory-tracking mods know it's been read.
        if not modData.readMap then modData.readMap = {} end
        modData.readMap[fullType] = true
    end
    ISBaseTimedAction.perform(self)
end

function WKReadAction:new(character, item, perkName, itemType)
    local o = ISBaseTimedAction.new(self, character)
    o.item     = item
    o.perkName = perkName   -- string, e.g. "Woodwork"
    o.itemType = itemType   -- bare type, e.g. "WK_LumberYardManual"
    o.maxTime  = 100
    return o
end
