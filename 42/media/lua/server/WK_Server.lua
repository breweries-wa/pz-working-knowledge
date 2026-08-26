-- Destroy one copy of a document in the player's inventory. Off by default;
-- wanted mainly on multiplayer servers that do not want one copy training the
-- whole group. Done server-side so a client cannot simply skip it.
--
-- Removing from the container alone only changes the server's own view, so in
-- multiplayer the document stayed in the player's inventory. The removal has to
-- be broadcast as well. removeFromHands comes first because the document is
-- held while it is being read. This mirrors what vanilla does, e.g.
-- ISBuildUtil.lua consuming build materials.
local function consumeDocument(player, itemType)
    local inv = player:getInventory()
    if not inv then return end
    local item = inv:getFirstTypeRecurse("Base." .. itemType)
    if not item then return end

    player:removeFromHands(item)
    local holder = item:getContainer() or inv
    holder:Remove(item)
    sendRemoveItemFromContainer(holder, item)
end

Events.OnClientCommand.Add(function(module, command, player, args)
    if module ~= "WorkingKnowledge" then return end

    if command == "ReadDocument" then
        local perkStr  = args.perk
        local itemType = args.itemType

        -- Use a server-only key for the XP-grant guard.  The client sets
        -- WK_read_* for its own UI state, and in singleplayer both sides
        -- share the same modData Java object — so if we checked WK_read_*
        -- here the client's pre-emptive write would block every XP grant.
        local xpKey = "WK_xp_" .. itemType

        local modData    = player:getModData()
        local sv          = SandboxVars.WorkingKnowledge
        -- Compared against true rather than tested for truthiness, the way
        -- vanilla does (ISMiniMap.lua). Logging confirmed it arrives as a plain
        -- Lua boolean, so either works; this one cannot go wrong.
        local consume     = sv ~= nil and sv.ConsumeOnRead == true
        local alreadyRead = modData[xpKey] and true or false

        -- A document that has already been read grants no XP, but it must still
        -- be destroyed when the option is on, otherwise spare copies pile up in
        -- the inventory and look like the mod has stopped working.
        if alreadyRead then
            if consume then consumeDocument(player, itemType) end
            return
        end

        modData[xpKey] = true
        -- Keep the vanilla readMap in sync so the inventory checkmark survives
        -- the next server→client modData sync on hosted/dedicated servers.
        if not modData.readMap then modData.readMap = {} end
        modData.readMap["Base." .. itemType] = true

        local ok, perk = pcall(function() return Perks[perkStr] end)
        if not ok or not perk then
            if consume then consumeDocument(player, itemType) end
            return
        end

        local grant = (SandboxVars.WorkingKnowledge and SandboxVars.WorkingKnowledge.XPGrant) or 50
        addXp(player, perk --[[@as PerkFactory.Perk]], grant)

        if consume then consumeDocument(player, itemType) end

    elseif command == "AdminClearAll" then
        local lvl = player:getAccessLevel()
        if lvl ~= "Admin" and lvl ~= "Moderator" then return end
        local modData = player:getModData()
        for k, _ in pairs(modData) do
            if string.find(k, "^WK_read_") or string.find(k, "^WK_xp_") then
                modData[k] = nil
            end
        end
    end
end)
