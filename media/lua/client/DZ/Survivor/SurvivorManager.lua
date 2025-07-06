local SurvivorClasses = require("DZ/SurvivorClasses")

--- @class SurvivorManager
--- @field public selectedSurvivor PZNS_NPCSurvivor|nil
SurvivorManager = {
    selectedSurvivor = nil
}

--- @type table<string, PZNS_NPCSurvivor>
ActiveSurvivors = PZNS_ActiveNPCs

function SurvivorManager:totalSurvivors()
    local size = 0
    for k, v in pairs(PZNS_ActiveNPCs) do
        size = size + 1
        print(v.survivorID)
    end
    return size
end

function SurvivorManager:spawnRandomSurvivor(x, y, z)
    local SurvivorSpawner = require("DZ/Survivor/SurvivorSpawnerPZNS")
    local newSurvivor = SurvivorSpawner.spawn(SurvivorClasses:getRandom(), x, y, z)

    if newSurvivor == nil then
        print("Failed to spawn survivor at: " .. x .. ", " .. y .. ", " .. z)
        return
    else
        print("Spawned new survivor at: " .. x .. ", " .. y .. ", " .. z)
        print("Total survivors: " .. self:totalSurvivors())
        -- triggerEvent("OnSurvivorAdded", newSurvivor)
    end
end

-- LuaEventManager.AddEvent("OnSurvivorAdded")

return SurvivorManager
