require "TimedActions/ISBaseTimedAction"

WKReadAction = ISBaseTimedAction:derive("WKReadAction")

function WKReadAction:isValid()
    return self.item ~= nil and self.character:getInventory():contains(self.item)
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

        -- Has Been Read compatibility: write into HBR's readMaps directly.
        -- HBR has no global API; it reads from player modData and shared ModData.
        local fullType = "Base." .. self.itemType
        local okMd, itemMd = pcall(function() return self.item:getModData() end)
        if okMd and itemMd and not itemMd.literatureTitle then
            itemMd.literatureTitle = fullType
        end
        if modData.readMap then
            modData.readMap[fullType] = true
        end
        local okSmd, smd = pcall(function() return ModData.get("P4HasBeenRead") end)
        if okSmd and smd and smd.readMap then
            smd.readMap[fullType] = true
        end
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
