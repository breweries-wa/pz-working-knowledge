require "TimedActions/ISReadABook"

WKReadAction = ISReadABook:derive("WKReadAction")

function WKReadAction:isValid()
    -- Don't allow re-reading
    if self.character:getModData()["WK_read_" .. self.itemType] then
        return false
    end
    -- Item must be in player's inventory (same as vanilla reading)
    if isClient() then
        return self.item ~= nil and self.character:getInventory():containsID(self.item:getID())
    else
        return self.item ~= nil and self.character:getInventory():contains(self.item)
    end
end

function WKReadAction:perform()
    local readKey = "WK_read_" .. self.itemType
    local modData = self.character:getModData()
    if not modData[readKey] then
        modData[readKey] = true
        sendClientCommand(self.character, "WorkingKnowledge", "ReadDocument", {
            perk     = self.perkName,
            itemType = self.itemType,
        })
        -- Set literatureTitle before calling ISReadABook.perform so it can
        -- call addReadLiterature() with the correct value (HBR hooks this).
        local fullType = "Base." .. self.itemType
        local okMd, itemMd = pcall(function() return self.item:getModData() end)
        if okMd and itemMd then
            itemMd.literatureTitle = itemMd.literatureTitle or fullType
        end
        if not modData.readMap then modData.readMap = {} end
        modData.readMap[fullType] = true
    end
    -- Delegate to ISReadABook for sound, animation cleanup, and literature tracking.
    ISReadABook.perform(self)
end

function WKReadAction:new(character, item, perkName, itemType)
    local o = ISReadABook.new(self, character, item)
    o.perkName = perkName
    o.itemType = itemType
    return o
end
