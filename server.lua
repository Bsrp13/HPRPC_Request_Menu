local moderatorAce = 'MODERATOR'
local trackingAce = 'PCSO'

RegisterNetEvent("BroadCastModMessage")
AddEventHandler("BroadCastModMessage", function(message)
    local src = source
    local name = GetPlayerName(src)

    print(GetPlayers())

    for _, playerId in ipairs(GetPlayers()) do
        if IsPlayerAceAllowed(playerId, moderatorAce) then
            TriggerClientEvent('HeresAdminmessage', playerId, 'Moderator Message\nFrom: ' .. name .. '\nID:'..src..'\nText: ' .. message)
        end
    end      
end)


RegisterNetEvent("BroadCastGlobalMessage")
AddEventHandler("BroadCastGlobalMessage", function(title, message)
    local src = source
    local name = GetPlayerName(src)

    TriggerClientEvent('HeresAdminmessage', -1, title .. '\nFrom: ' .. name .. '\nID:'..src..'\nText: ' .. message)    
end)


RegisterNetEvent("BroadCastGlobalMessage")
AddEventHandler("BroadCastGlobalMessage", function(title, message, ace)
    local src = source
    local name = GetPlayerName(src)

    for _, playerId in ipairs(GetPlayers()) do
        --if IsPlayerAceAllowed(playerId, ace) then
            TriggerClientEvent('HeresAdminmessage', playerId, title .. '\nFrom: ' .. name .. '\nID:'..src..'\nText: ' .. message)    
        --end
    end
end)

RegisterNetEvent("bl_tracking:canITrack")
AddEventHandler("bl_tracking:canITrack", function()
    local src = source
    if IsPlayerAceAllowed(src, trackingAce) then
        TriggerClientEvent('bl_tracking:responseYes', src)
    end
end)