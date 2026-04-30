require "TimedActions/ISReadABook"

-- Override ISReadABook timing for WK documents on BOTH client and server VMs.
--
-- Without this, the client uses our short maxTime (bar fills fast) while the
-- server uses vanilla getDuration() (much longer). They disagree, so the bar
-- fills before the action actually completes, causing the mismatch the player sees.
--
-- Placing this in shared/ ensures both VMs agree on the same maxTime, so the
-- progress bar and the reading animation finish together.

local origISReadABookNew = ISReadABook.new
function ISReadABook:new(character, item)
    local o = origISReadABookNew(self, character, item)
    if item then
        local ok, itemType = pcall(function() return item:getType() end)
        if ok and itemType then
            local bareType = itemType:match("%.(.+)$") or itemType
            -- All WK items follow the WK_ naming convention.
            if bareType:match("^WK_") then
                local time = 200
                if character:hasTrait(CharacterTrait.FAST_READER) then time = time * 0.7 end
                if character:hasTrait(CharacterTrait.SLOW_READER)  then time = time * 1.3 end
                o.maxTime = math.max(math.floor(time), 1)
            end
        end
    end
    return o
end
