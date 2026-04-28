-- Admin utility. From the F5 Lua console, run:
--   WKAdmin.clearAll()
-- Clears all WK read flags from your character (server-authoritative).
-- Requires admin access level.

WKAdmin = {}

function WKAdmin.clearAll()
    local player = getSpecificPlayer(0)
    if not player then return end
    local modData = player:getModData()
    for k, _ in pairs(modData) do
        if string.find(k, "^WK_read_") then
            modData[k] = nil
        end
    end
    sendClientCommand(player, "WorkingKnowledge", "AdminClearAll", {})
    print("[WK] Read states cleared.")
end
