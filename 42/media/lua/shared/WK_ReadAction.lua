require "TimedActions/ISBaseTimedAction"
require "TimedActions/ISReadABook"

WKReadAction = ISBaseTimedAction:derive("WKReadAction")

function WKReadAction:isValid()
    if self.character:getModData()["WK_read_" .. self.itemType] then return false end
    if isClient() then
        return self.item ~= nil and self.character:getInventory():containsID(self.item:getID())
    else
        return self.item ~= nil and self.character:getInventory():contains(self.item)
    end
end

function WKReadAction:start()
    self.item:setJobType(getText("ContextMenu_Read") .. " " .. self.item:getName())
    self.item:setJobDelta(0.0)
    self:setActionAnim(CharacterActionAnims.Read)
    self:setAnimVariable("ReadType", "book")
    self:setOverrideHandModels(nil, self.item)
    self.character:setReading(true)
    self.character:playSound("OpenBook")
end

function WKReadAction:stop()
    self.character:setReading(false)
    self.item:setJobDelta(0.0)
    self.character:playSound("CloseBook")
    ISBaseTimedAction.stop(self)
end

function WKReadAction:update()
    self.item:setJobDelta(self:getJobDelta())
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
        local fullType = "Base." .. self.itemType
        local okMd, itemMd = pcall(function() return self.item:getModData() end)
        if okMd and itemMd then
            itemMd.literatureTitle = itemMd.literatureTitle or fullType
        end
        if not modData.readMap then modData.readMap = {} end
        modData.readMap[fullType] = true
    end
    self.character:setReading(false)
    self.character:playSound("CloseBook")
    self.item:setJobDelta(0.0)
    pcall(function() self.item:getContainer():setDrawDirty(true) end)
    local fullType = "Base." .. self.itemType
    pcall(function() self.character:addReadLiterature(fullType) end)
    pcall(function() self.character:ReadLiterature(self.item) end)
    ISBaseTimedAction.perform(self)
end

function WKReadAction:new(character, item, perkName, itemType)
    local o = ISBaseTimedAction.new(self, character)
    o.item     = item
    o.perkName = perkName
    o.itemType = itemType
    -- Honor Fast Reader / Slow Reader traits like vanilla books do.
    local time = 200
    if character:hasTrait(CharacterTrait.FAST_READER) then time = time * 0.7 end
    if character:hasTrait(CharacterTrait.SLOW_READER)  then time = time * 1.3 end
    o.maxTime  = math.max(math.floor(time), 1)
    o.forceProgressBar = true
    return o
end
