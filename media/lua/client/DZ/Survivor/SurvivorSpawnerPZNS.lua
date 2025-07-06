local PZNS_NPCsManager = require("04_data_management/PZNS_NPCsManager")
local PZNS_UtilsNPCs = require("02_mod_utils/PZNS_UtilsNPCs")
local PZNS_WorldUtils = require("02_mod_utils/PZNS_WorldUtils")
local PZNS_UtilsDataNPCs = require("02_mod_utils/PZNS_UtilsDataNPCs")

local SurvivorSpawner = {}

--- @param class SurvivorClass
--- @param x number world X
--- @param y number world Y
--- @param z number floor (default 0)
--- @return PZNS_NPCSurvivor|nil
function SurvivorSpawner.spawn(class, x, y, z)

    if class == nil then
        print("DZ-SurvivorSpawner - unknown class: " .. tostring(class))
        return nil
    end

    -- unique survivorID so PZNS can persist each NPC
    local survivorID = class.idPrefix .. tostring(getTimestamp())

    -- already active? then nothing to do
    local existing = PZNS_NPCsManager.getActiveNPCBySurvivorID(survivorID)
    if existing then
        return existing
    end

    -- only spawn if player’s loaded cells can see it
    local player = getPlayer()
    if not player then
        return nil
    end

    if not PZNS_WorldUtils.PZNS_IsSquareInPlayerSpawnRange(player, x, y, z or 0) then
        return nil
    end

    local square = getCell():getOrCreateGridSquare(x, y, z or 0)
    PZNS_WorldUtils.PZNS_ClearZombiesFromSquare(square, 3)

    --- create NPC through framework
    local surname = "[" .. class.name .. "]"
    local forename = "Survivor"
    local isFemale = ZombRand(2) == 0
    local npc = PZNS_NPCsManager.createNPCSurvivor(survivorID, isFemale, forename, surname, square)
    if not npc then
        print("DZ-SurvivorSpawner - failed to create NPC " .. survivorID)
        return nil
    end

    -- apply template data
    if class.outfit then
        PZNS_UtilsNPCs.PZNS_AddEquipClothingNPCSurvivor(npc, "Base." .. "Boilersuit")
    end
    if class.weapon then
        PZNS_UtilsNPCs.PZNS_AddEquipWeaponNPCSurvivor(npc, class.weapon)
        PZNS_UtilsNPCs.PZNS_SetLoadedGun(npc) -- handles clips if it’s a gun
    end
    if class.traits then
        for _, tr in ipairs(class.traits) do
            PZNS_UtilsNPCs.PZNS_AddNPCSurvivorTraits(npc, tr)
        end
    end

    -- apply options

    -- Persist immediately
    PZNS_UtilsDataNPCs.PZNS_SaveNPCData(survivorID, npc)
    print("DZ-SurvivorSpawner - spawned " .. survivorID)

    return npc
end

return SurvivorSpawner
