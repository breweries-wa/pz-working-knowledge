-- Logging confirmed this arrives as a plain Lua boolean, so a bare truthiness
-- test would do. Kept explicit anyway: only nil and false are falsy in Lua, so
-- if the value ever came through as a Java Boolean or a string it would read as
-- true no matter what it held, and every document would be destroyed. Vanilla
-- guards the same way (ISMiniMap.lua compares against true explicitly).
local function sandboxTrue(v)
    if v == true then return true end
    if v == false or v == nil then return false end
    return string.lower(tostring(v)) == "true"
end

-- Destroy one copy of a document in the player's inventory. Off by default;
-- wanted mainly on multiplayer servers that do not want one copy training the
-- whole group. Done server-side so a client cannot simply skip it.
local function consumeDocument(player, itemType)
    local inv = player:getInventory()
    if not inv then return end
    local item = inv:getFirstTypeRecurse("Base." .. itemType)
    if not item then return end
    local holder = item:getContainer() or inv
    holder:Remove(item)
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
        local rawConsume  = sv and sv.ConsumeOnRead
        local consume     = sandboxTrue(rawConsume)
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
