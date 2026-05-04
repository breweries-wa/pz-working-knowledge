require "TimedActions/ISReadABook"

-- Override ISReadABook:getDuration for WK documents.
--
-- The vanilla new() does:  o.maxTime = o:getDuration()
-- Any server-side duration check also goes through getDuration().
-- Overriding getDuration() here ensures EVERY code path — client new(),
-- server new(), and any Java-level validation — returns 200 for WK items,
-- so the progress bar and the server action finish at the same moment.
--
-- Previous approach patched maxTime inside new() AFTER getDuration() ran.
-- That fixed the client bar but left the server free to use a stale value,
-- causing the bar to fill while the reading animation kept running.

local origGetDuration = ISReadABook.getDuration

function ISReadABook:getDuration()
    if self.item then
        local ok, itemType = pcall(function() return self.item:getType() end)
        if ok and itemType then
            local bareType = itemType:match("%.(.+)$") or itemType
            if bareType:match("^WK_") then
                local time = 200
                if self.character then
                    if self.character:hasTrait(CharacterTrait.FAST_READER) then
                        time = time * 0.7
                    end
                    if self.character:hasTrait(CharacterTrait.SLOW_READER) then
                        time = time * 1.3
                    end
                end
                return math.max(math.floor(time), 1)
            end
        end
    end
    return origGetDuration(self)
end
