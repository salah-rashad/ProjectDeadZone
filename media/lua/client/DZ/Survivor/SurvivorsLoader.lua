
local SurvivorsLoader = {}

function SurvivorsLoader.load()

    local x, y, z = DZCamera.x, DZCamera.y, DZCamera.z
    SurvivorManager:spawnRandomSurvivor(x, y, z)
end

return SurvivorsLoader

--[[

    SurvivorsLoader is responsible for loading and spawning survivors in the game.
    It uses the SurvivorSpawner to create a new survivor and adds it to the SurvivorManager.

    Usage:
    - Call SurvivorsLoader.load() to spawn a new survivor at the player's current position.

]] -- 
