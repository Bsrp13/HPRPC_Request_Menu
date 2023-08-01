local returnToStationCoords = vec(424.4144, -982.2894, 30.7113, 309.0417)
local menuOptions = {

    ['Fix Car'] = {
        allowed = function() return GetVehiclePedIsIn(PlayerPedId(), false) ~= 0 end,
        trigger = function() 
            attemptCarRepair()
        end
    },

    ['Change Colour'] = {
        allowed = function() 
        
            local allowedVehicles = {
                [`FBI2`] = true,
                [`dev1`] = true,
                [`dev2`] = true,
                [`dev3`] = true,
                [`dev4`] = true,
                [`admin4`] = true,
                [`cid1`] = true,
                [`cid2`] = true,
                [`cid3`] = true,
                [`cid4`] = true,
                [`cid5`] = true,
                [`cid8`] = true,
                [`arv7`] = true,
                [`arv8`] = true,
                [`arv11`] = true,
                [`arv12`] = true,
                [`arv13`] = true,
                [`nhs4`] = true,
                [`nhs13`] = true,
                [`dsu6`] = true,
                [`don1`] = true,
                [`don3`] = true,
                [`rpu6`] = true,
                [`rpu9`] = true,
                [`hfb6`] = true,
                [`npt11`] = true,
                [`police4`] = true,
                [`policeold2`] = true,
                [`sheriff2`] = true,
                [`cid9`] = true,
                [`gold`] = true,
                [`sheriff2`] = true
            }

            return allowedVehicles[GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))]

        end,
        isColourChanger = true
    },

    ['Change Appearance'] = {
        allowed = function() return true end,
        trigger = function() 
            ChangeAppearance()
        end
    },

    ['Request Moderator'] = {
        allowed = function() return true end,
        isModerator = true
    },

    ['Return to station'] = {
        allowed = function() 
        
            return true

        end,
        trigger = function()
            local cam = GetFollowPedCamViewMode()
		    SetFollowPedCamViewMode(1)
            DoScreenFadeOut(1000)
            while ( not IsScreenFadedOut() ) do
                Citizen.Wait(0)
            end		

            StartPlayerTeleport(PlayerId(), returnToStationCoords.x, returnToStationCoords.y, returnToStationCoords.z, returnToStationCoords.w, true, true, true)

            while IsPlayerTeleportActive() do
                Citizen.Wait(0)
            end


            DoScreenFadeIn(1000)
            SetFollowPedCamViewMode(cam)
        end
    },

    ['Request Superviser'] = {
        allowed = function() return true end,
        isGlob = true,
        globTitle = 'Superviser',
        ace = 'BRONZE'
    },
    ['Request Backup'] = {
        allowed = function() return true end,
        isGlob = true,
        globTitle = 'Backup',
        ace = 'PCSO'
    },
    ['Request RPU '] = {
        allowed = function() return true end,
        isGlob = true,
        globTitle = 'RPU ',
        ace = 'MPSRPU'
    },
    ['Request DSU '] = {
        allowed = function() return true end,
        isGlob = true,
        globTitle = 'DSU ',
        ace = 'MPSDSU'
    },
    ['Request LFB '] = {
        allowed = function() return true end,
        isGlob = true,
        globTitle = 'LFB ',
        ace = 'PLFB'
    },
    ['Request LAS '] = {
        allowed = function() return true end,
        isGlob = true,
        globTitle = 'LAS ',
        ace = 'STUPARA'
    },

    ['Request NPAS  '] = {
        allowed = function() return true end,
        isGlob = true,
        globTitle = 'NPAS  ',
        ace = 'MPSNPAS'
    },
    ['Request TFU  '] = {
        allowed = function() return true end,
        isGlob = true,
        globTitle = 'TFU  ',
        ace = 'MPSTFU'
    },
    ['Request Highways   '] = {
        allowed = function() return true end,
        isGlob = true,
        globTitle = 'Highways',
        ace = 'TRAFFICOFFICER'
    },
    ['Request Prisoner Transport '] = {
        allowed = function() return true end,
        isGlob = true,
        globTitle = 'Prisoner Transport ',
        ace = 'PCSO'
    }

}

local fixTime = 10

HPRPCMenu.CreateMenu("MainMenu", 'Interaction menu')
HPRPCMenu.SetSubTitle("MainMenu", "Select an option")


function attemptCarRepair()
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)

    if GetEntitySpeed(veh) ~= 0 then
        ShowNotification('~r~Vehicle must be stationary to repair!')
        return
    end

    local repairingStart = GetNetworkTime()
    ShowNotification('~g~Repairing!')
    while (repairingStart+(fixTime*1000)) >= GetNetworkTime() do
        SetVehicleEngineOn(veh, false, true, false)
        Citizen.Wait(1)
    end
    ShowNotification('~g~Repair successful!')
    SetVehicleFixed(veh)
    SetVehicleEngineOn(veh, true, true, false)

end

ShowNotification = function(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(msg)
	DrawNotification(0,1)
end


local colours = {"Red", "Blue", "Black", "Pink", "White", "Green"}
currIndex = 1

function VehicleColorChange(color)
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)

    if color == "Red" then
        SetVehicleColours(veh, 31, 31)
        SetVehicleExtraColours(veh, 31)
    elseif color == "Blue" then
        SetVehicleColours(veh, 64, 64)
        SetVehicleExtraColours(veh, 64)
    elseif color == "Black" then
        SetVehicleColours(veh, 0, 0)
        SetVehicleExtraColours(veh, 0)
    elseif color == "Yellow" then
        SetVehicleColours(veh, 89, 89)
        SetVehicleExtraColours(veh, 89)
    elseif color == "Pink" then
        SetVehicleColours(veh, 135, 135)
        SetVehicleExtraColours(veh, 135)
    elseif color == "White" then
        SetVehicleColours(veh, 111, 111)
        SetVehicleExtraColours(veh, 111)
    elseif color == "Green" then
        SetVehicleColours(veh, 53, 53)
        SetVehicleExtraColours(veh, 53)
    end
end

function ChangeAppearance()
    local config = {
        ped = false,
        headBlend = true,
        faceFeatures = true,
        headOverlays = true,
        components = false,
        props = false,
      }
    
      exports['fivem-appearance']:startPlayerCustomization(function (appearance)
        if (appearance) then
          print('Saved')
        else
          print('Canceled')
        end
      end, config)
end

local menuOpen = false
local canTrack = true

Citizen.CreateThread(function()
    TriggerServerEvent('bl_tracking:canITrack')
end)

RegisterNetEvent("bl_tracking:responseYes")
AddEventHandler("bl_tracking:responseYes", function()
    canTrack = true
end)

AddTextEntry('mod_text', 'Enter the text for a moderator')
AddTextEntry('mod_text2', 'Enter the text to send')

RegisterCommand('openMenu', function()

    menuOpen = not menuOpen
    
    if menuOpen then
        HPRPCMenu.OpenMenu("MainMenu")
    else
        HPRPCMenu.CloseMenu("MainMenu")
    end

    while HPRPCMenu.IsMenuOpened("MainMenu") do

        if canTrack and HPRPCMenu.Button('~g~Tracking Menu') then
            HPRPCMenu.CloseMenu()
            TriggerEvent('bl_tracking:openMenu')
        end

        for k,v in pairs(menuOptions) do
            if v.allowed() then
                if not v.isColourChanger and not v.isModerator and not v.isGlob and HPRPCMenu.Button(k) then
                    v.trigger()
                end

                if v.isColourChanger then
                    if HPRPCMenu.ComboBox("Change Vehicles Colour", colours, currIndex, currIndex, function(a1,a2,a3)
                        currIndex = a1
                    end) then
                        VehicleColorChange(colours[currIndex])
                    end
                end

                if v.isModerator then
                    pressed, inputText =  HPRPCMenu.InputButton(k, 'mod_text', '', 255)
                    if pressed and inputText~='' then
                        TriggerServerEvent('BroadCastModMessage', inputText)
                        ShowNotification('Your messages was sent to all available moderators.')
                    end
                end

                if v.isGlob then
                    pressed, inputText =  HPRPCMenu.InputButton(k, 'mod_text2', '', 255)
                    if pressed and inputText~='' then   
                        local coords = GetEntityCoords(PlayerPedId())
                        local var1, var2 = GetStreetNameAtCoord(coords, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
                        hash1 = GetStreetNameFromHashKey(var1);
                        hash2 = GetStreetNameFromHashKey(var2);
                        local zone = GetNameOfZone(coords);
		                local zoneLabel = GetLabelText(zone);

                        local street2;
                        if (hash2 == '') then
                            street2 = zoneLabel;
                        else
                            street2 = hash2..', '..zoneLabel;
                        end


                        
                        TriggerServerEvent('BroadCastGlobalMessage', v.globTitle, inputText .. '\nLocation: ' .. street2, v.ace)
                        ShowNotification('Your messages was sent!')
                    end
                end
            end
        end

        HPRPCMenu.Display()
        Citizen.Wait(0)
    end

    menuOpen = false


end)

RegisterNetEvent("HeresAdminmessage")
AddEventHandler("HeresAdminmessage", function(msg)
    ShowNotification(msg)
end)