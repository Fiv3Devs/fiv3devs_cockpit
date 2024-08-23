Config = {}
-- Choose between 'ox_target', 'qb-target', or false to use showHelpNotification
Config.TargetSystem = 'ox_target'  -- Options: 'ox_target', 'qb-target', false

Config.arrivalCoordsLSIA = vector3(-1271.57, -3376.78, 13.94) -- LSIA player arrival coordinates (in case you want to change them)

Config.arrivalCoordsCayo = vector3(4490.9, -4465.83, 4.22) -- Cayo player arrival coordinates (in case you want to change them)

Config.spawnCoordsPlaneLSIA = vector3(-1272.347, -3381.748, 12.9) -- LSIA plane coordinates (in case you want to change them)

Config.spawnCoordsPlaneCayo = vector3(4488.06, -4461.83, 3.23) -- Cayo plane coordinates (in case you want to change them)

Config.headingPlayerLSIA = 58.3 -- Heading for the LSIA player arrival

Config.headingPlaneLSIA = 328.11 -- Heading for the LSIA plane

Config.headingPlayerCayo = 286.48 -- Heading for the Cayo player arrival

Config.headingPlaneCayo = 195.73 -- Heading for the Cayo plane

Config.teleportFadeTime = 3000 -- How long should the teleport take (in milliseconds)

Config.NotificationText = "Press ~INPUT_CONTEXT~ to enter" -- Text to show when Config.TargetSystem is set to false

Config.Key = 51 -- Key to press when Config.TargetSystem is set to false

Config.TargetText = 'Enter Plane' -- Text to show when Config.TargetSystem is set to 'ox_target' or 'qb-target'

Config.TargetExitText = 'Land Plane' -- Text to show when Config.TargetSystem is set to 'ox_target' or 'qb-target'