Config = Config or {}

-- Configuration for the coordinates and orientation of the planes
local spawnCoordsPlaneLSIA = Config.spawnCoordsPlaneLSIA
local arrivalCoordsLSIA = Config.arrivalCoordsLSIA
local headingPlaneLSIA = Config.headingPlaneLSIA  -- Orientation (rotation) in degrees
local headingPlayerLSIA = Config.headingPlayerLSIA

local spawnCoordsPlaneCayo = Config.spawnCoordsPlaneCayo
local arrivalCoordsCayo = Config.arrivalCoordsCayo
local headingPlaneCayo = Config.headingPlaneCayo  -- Orientation (rotation) in degrees
local headingPlayerCayo = Config.headingPlayerCayo

-- Configuration for teleportation
local teleportCoords = vector3(-717.67, 1434.25, -82.47936)
local teleportBackCoords = vector3(-717.61, 1438.85, -81.5)  -- New teleportation point

local teleportFadeTime = Config.teleportFadeTime -- Fade out time in milliseconds

-- Variables to store the planes
local plane1, plane2

-- Variable to track the last departure point
local lastUsedPlane = nil  -- Can be "plane1" or "plane2"

-- Function to show a help notification (always defined)
local function showHelpNotification(text)
    if Config.TargetSystem == false then
        BeginTextCommandDisplayHelp("STRING")
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandDisplayHelp(0, false, true, -1)
    end
end

-- Function to handle interaction with both planes and landing point
local function handleInteractions()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local distanceToPlane1 = #(playerCoords - spawnCoordsPlaneLSIA)
    local distanceToPlane2 = #(playerCoords - spawnCoordsPlaneCayo)
    local distanceToLanding = #(playerCoords - teleportBackCoords)
    
    local nearInteraction = false
    
    if distanceToPlane1 < 20.0 or distanceToPlane2 < 20.0 or distanceToLanding < 10.0 then
        nearInteraction = true
        
        if distanceToPlane1 < 8.0 then
            showHelpNotification(Config.NotificationText)
            if IsControlJustReleased(1, Config.Key) then
                DoScreenFadeOut(teleportFadeTime)
                Wait(teleportFadeTime)
                SetEntityCoords(playerPed, teleportCoords.x, teleportCoords.y, teleportCoords.z)
                lastUsedPlane = "plane1"
                DoScreenFadeIn(teleportFadeTime)
            end
        elseif distanceToPlane2 < 8.0 then
            showHelpNotification(Config.NotificationText)
            if IsControlJustReleased(1, Config.Key) then
                DoScreenFadeOut(teleportFadeTime)
                Wait(teleportFadeTime)
                SetEntityCoords(playerPed, teleportCoords.x, teleportCoords.y, teleportCoords.z)
                lastUsedPlane = "plane2"
                DoScreenFadeIn(teleportFadeTime)
            end
        elseif distanceToLanding < 1.0 then
            showHelpNotification("Press ~INPUT_CONTEXT~ to land")
            if IsControlJustReleased(1, Config.Key) then
                DoScreenFadeOut(teleportFadeTime)
                Wait(teleportFadeTime)
                if lastUsedPlane == "plane1" then
                    SetEntityCoords(playerPed, arrivalCoordsCayo.x, arrivalCoordsCayo.y, arrivalCoordsCayo.z)
                    SetEntityHeading(playerPed, headingPlayerCayo)
                else
                    SetEntityCoords(playerPed, arrivalCoordsLSIA.x, arrivalCoordsLSIA.y, arrivalCoordsLSIA.z)
                    SetEntityHeading(playerPed, headingPlayerLSIA)
                end
                SetGameplayCamRelativeHeading(0.0)
                SetGameplayCamRelativePitch(0.0, 1.0)
                DoScreenFadeIn(teleportFadeTime)
            end
        end
    end
    
    return nearInteraction
end

-- Function to handle interaction with the first plane
local function handlePlane1Interaction()
	
	local adjustedCoords = vector3(spawnCoordsPlaneLSIA.x + 2.267, spawnCoordsPlaneLSIA.y + 3.928, spawnCoordsPlaneLSIA.z + 2.0)
	
    if Config.TargetSystem == 'ox_target' then
        exports.ox_target:addBoxZone({
            coords = adjustedCoords,  
            size = vec3(5, 5, 2),
            rotation = headingPlaneLSIA,
            options = {
                {
                    name = 'enter_plane1',
                    event = 'enterPlane1',
                    icon = 'fas fa-plane',
                    label = Config.TargetText,
                }
            }
        })
    elseif Config.TargetSystem == 'qb-target' then
        exports['qb-target']:AddBoxZone('plane1', adjustedCoords, 5.0, 5.0, {
            name = 'plane1',
            heading = headingPlaneLSIA,
            minZ = spawnCoordsPlaneLSIA.z - 1.0,
            maxZ = spawnCoordsPlaneLSIA.z + 3.0,
        }, {
            options = {
                {
                    type = 'client',
                    event = 'enterPlane1',
                    icon = 'fas fa-plane',
                    label = Config.TargetText,
                }
            },
            distance = 2.5
        })
    else
        Citizen.CreateThread(function()
            while true do
                checkInteractionPlane1()
                Citizen.Wait(0)
            end
        end)
    end
end

-- Function to handle interaction with the second plane
local function handlePlane2Interaction()

	local adjustedCoords = vector3(spawnCoordsPlaneCayo.x + 1.23, spawnCoordsPlaneCayo.y - 4.37, spawnCoordsPlaneCayo.z + 1.8)

    if Config.TargetSystem == 'ox_target' then
        exports.ox_target:addBoxZone({
            coords = adjustedCoords,
            size = vec3(5, 5, 2),
            rotation = headingPlaneCayo,
            options = {
                {
                    name = 'enter_plane2',
                    event = 'enterPlane2',
                    icon = 'fas fa-plane',
                    label = Config.TargetText,
                }
            }
        })
    elseif Config.TargetSystem == 'qb-target' then
        exports['qb-target']:AddBoxZone('plane2', adjustedCoords, 5.0, 5.0, {
            name = 'plane2',
            heading = headingPlaneCayo,
            minZ = spawnCoordsPlaneCayo.z - 1.0,
            maxZ = spawnCoordsPlaneCayo.z + 3.0,
        }, {
            options = {
                {
                    type = 'client',
                    event = 'enterPlane2',
                    icon = 'fas fa-plane',
                    label = Config.TargetText,
                }
            },
            distance = 2.5
        })
    else
        Citizen.CreateThread(function()
            while true do
                checkInteractionPlane2()
                Citizen.Wait(0)
            end
        end)
    end
end

-- Event handling for entering the planes
RegisterNetEvent('enterPlane1')
AddEventHandler('enterPlane1', function()
    -- Fade out, teleport, and update last used plane
    DoScreenFadeOut(teleportFadeTime)
    Wait(teleportFadeTime)
    SetEntityCoords(PlayerPedId(), teleportCoords.x, teleportCoords.y, teleportCoords.z)
    lastUsedPlane = "plane1"
    DoScreenFadeIn(teleportFadeTime)
end)

RegisterNetEvent('enterPlane2')
AddEventHandler('enterPlane2', function()
    -- Fade out, teleport, and update last used plane
    DoScreenFadeOut(teleportFadeTime)
    Wait(teleportFadeTime)
    SetEntityCoords(PlayerPedId(), teleportCoords.x, teleportCoords.y, teleportCoords.z)
    lastUsedPlane = "plane2"
    DoScreenFadeIn(teleportFadeTime)
end)

-- Main thread for handling interactions
Citizen.CreateThread(function()
    while true do
        if Config.TargetSystem == false then
            local nearInteraction = handleInteractions()
            if nearInteraction then
                Citizen.Wait(0)  -- Check every frame when near an interaction point
            else
                Citizen.Wait(1000)  -- Check every second when far from interaction points
            end
        else
            Citizen.Wait(1000)  -- Wait longer if using a target system
        end
    end
end)

-- Function to handle interaction with the landing point
local function handleLandingPointInteraction()
    if Config.TargetSystem == 'ox_target' then
        exports.ox_target:addBoxZone({
            coords = teleportBackCoords,
            size = vec3(2, 2, 2),
            rotation = 0,
            options = {
                {
                    name = 'land_plane',
                    event = 'landPlane',
                    icon = 'fas fa-plane-arrival',
                    label = Config.TargetExitText,
                }
            }
        })
    elseif Config.TargetSystem == 'qb-target' then
        exports['qb-target']:AddBoxZone('landing_point', teleportBackCoords, 2.0, 2.0, {
            name = 'landing_point',
            heading = 0,
            minZ = teleportBackCoords.z - 1.0,
            maxZ = teleportBackCoords.z + 1.0,
        }, {
            options = {
                {
                    type = 'client',
                    event = 'landPlane',
                    icon = 'fas fa-plane-arrival',
                    label = Config.TargetExitText,
                }
            },
            distance = 2.5
        })
    else
        Citizen.CreateThread(function()
            while true do
                checkInteractionTeleportBack()
                Citizen.Wait(0)
            end
        end)
    end
end

-- Event handling for landing the plane
RegisterNetEvent('landPlane')
AddEventHandler('landPlane', function()
    -- Trigger the fade out effect
    DoScreenFadeOut(teleportFadeTime)
    Wait(teleportFadeTime)

    local playerPed = PlayerPedId()

    -- Teleport the player to the opposite plane
    if lastUsedPlane == "plane1" then
        SetEntityCoords(playerPed, arrivalCoordsCayo.x, arrivalCoordsCayo.y, arrivalCoordsCayo.z)
        SetEntityHeading(playerPed, headingPlayerCayo)
        -- Set the camera to face headingPlayerCayo
        SetGameplayCamRelativeHeading(0.0)
        SetGameplayCamRelativePitch(0.0, 1.0)
    else
        SetEntityCoords(playerPed, arrivalCoordsLSIA.x, arrivalCoordsLSIA.y, arrivalCoordsLSIA.z)
        SetEntityHeading(playerPed, headingPlayerLSIA)
        -- Set the camera to face headingPlayerLSIA
        SetGameplayCamRelativeHeading(0.0)
        SetGameplayCamRelativePitch(0.0, 1.0)
    end

    -- Remove the fade out effect
    DoScreenFadeIn(teleportFadeTime)
end)

-- Event triggered when the script starts
AddEventHandler('onClientResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    if Config.TargetSystem == 'ox_target' or Config.TargetSystem == 'qb-target' then
        handlePlane1Interaction()
		handlePlane2Interaction()
		handleLandingPointInteraction()
    end
end)

-- Loop for handling camera shake near the teleportation point
Citizen.CreateThread(function()
    while true do
        local ped = GetPlayerPed(-1)
        local playerCoords = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(-717.67, 1434.25, -81.27936, playerCoords, true)

        if distance < 15.0 then
            ShakeGameplayCam("SKY_DIVING_SHAKE", 0.15)
            Citizen.Wait(5000)  -- Wait 5 seconds before checking again
        else
            ShakeGameplayCam(false)
            Citizen.Wait(1000)  -- Check less frequently if the player is far away
        end
    end
end)
