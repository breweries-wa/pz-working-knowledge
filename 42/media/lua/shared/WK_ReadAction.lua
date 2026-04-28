require "TimedActions/ISBaseTimedAction"

WKReadAction = ISBaseTimedAction:derive("WKReadAction")

function WKReadAction:isValid()
    return self.item ~= nil and self.character:getInventory():contains(self.item)
end

function WKReadAction:perform()
    local modData = self.item:getModData()
    if not modData["WK_read"] then
        local ok, perk = pcall(function() return PerkFactory.getPerk(self.perkType) end)
        if ok and perk then
            local grant = math.floor(perk:getXpForLevel(1) * 0.25)
            addXp(self.character, self.perkType, grant)
        end
        modData["WK_read"] = true
    end
    ISBaseTimedAction.perform(self)
end

function WKReadAction:new(character, item, perkType)
    local o = ISBaseTimedAction.new(self, character)
    o.item     = item
    o.perkType = perkType
    o.maxTime  = 100
    return o
end
