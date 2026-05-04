-- Admin utility. From the F5 Lua console, run:
--   WKAdmin.clearAll()
-- Clears all WK read flags from your character so documents can be read again.
-- Works in singleplayer and multiplayer. On multiplayer servers, also sends
-- the AdminClearAll command to clear the server-side XP-grant guard (requires
-- admin or moderator access level on the server).

WKAdmin = {}

function WKAdmin.clearAll()
    local player = getSpecificPlayer(0)
    if not player then return end
    local modData = player:getModData()
    for k, _ in pairs(modData) do
        if string.find(k, "^WK_read_") or string.find(k, "^WK_xp_") then
            modData[k] = nil
        end
    end
    sendClientCommand(player, "WorkingKnowledge", "AdminClearAll", {})
    print("[WK] Read states cleared.")
end
