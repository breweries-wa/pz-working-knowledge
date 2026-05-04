Events.OnClientCommand.Add(function(module, command, player, args)
    if module ~= "WorkingKnowledge" then return end

    if command == "ReadDocument" then
        local perkStr  = args.perk
        local itemType = args.itemType
        local readKey  = "WK_read_" .. itemType

        local modData = player:getModData()
        if modData[readKey] then return end

        modData[readKey] = true
        -- Keep the vanilla readMap in sync so the inventory checkmark survives
        -- the next server→client modData sync on hosted/dedicated servers.
        if not modData.readMap then modData.readMap = {} end
        modData.readMap["Base." .. itemType] = true

        local ok, perk = pcall(function() return Perks[perkStr] end)
        if not ok or not perk then return end

        local grant = (SandboxVars.WorkingKnowledge and SandboxVars.WorkingKnowledge.XPGrant) or 50
        addXp(player, perk, grant)

    elseif command == "AdminClearAll" then
        local lvl = player:getAccessLevel()
        if lvl ~= "Admin" and lvl ~= "Moderator" then return end
        local modData = player:getModData()
        for k, _ in pairs(modData) do
            if string.find(k, "^WK_read_") then
                modData[k] = nil
            end
        end
    end
end)
