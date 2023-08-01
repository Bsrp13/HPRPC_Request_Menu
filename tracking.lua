local isTracking = false

HPRPCMenu.CreateMenu("TrackingMenu", 'Tracking Menu')
HPRPCMenu.SetSubTitle("TrackingMenu", "Select a player to track")

RegisterNetEvent("bl_tracking:openMenu")
AddEventHandler("bl_tracking:openMenu", function()
    
    HPRPCMenu.OpenMenu('TrackingMenu')
    while HPRPCMenu.IsMenuOpened('TrackingMenu') do
        if isTracking then
            if HPRPCMenu.Button('~r~END TRACKING~r~') then
                isTracking = false
                HPRPCMenu.SetSubTitle("TrackingMenu", "Select a player to track")
                ClearGpsPlayerWaypoint()
            end
        end

        local players   = GetActivePlayers()
        local ourCoords = GetEntityCoords(GetPlayerPed(-1))

        for k,v in pairs(players) do
            local playerCoords = GetEntityCoords(GetPlayerPed(v))
            if HPRPCMenu.Button( '[' .. GetPlayerServerId(v) .. '] ' .. GetPlayerName(v), math.floor(#(playerCoords-ourCoords), 2) .. 'm' ) then
                HPRPCMenu.SetSubTitle("TrackingMenu", "TRACKING PLAYER: " .. '[' .. GetPlayerServerId(v) .. '] ' .. GetPlayerName(v))
                isTracking = v
            end
        end 

        HPRPCMenu.Display()
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        if isTracking then
            SetNewWaypoint( GetEntityCoords(GetPlayerPed(isTracking)) )
        end
        Citizen.Wait(500)
    end
end)