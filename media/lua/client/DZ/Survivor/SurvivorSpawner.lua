local SurvivorSpawner = {}

--- @param class SurvivorClass
--- @param x number
--- @param y number
--- @param z number
--- @return IsoPlayer|nil
function SurvivorSpawner.spawn(class, x, y, z)

    if not class then
        print("Invalid survivor class: " .. tostring(class))
        return nil
    end

    local cell = getWorld():getCell()
    local square = cell:getOrCreateGridSquare(x, y, z or 0)

    -- Add survivor description
    local desc = SurvivorDesc.new(true)
    desc:setForename("[" .. class.name .. "]")
    desc:setSurname("Survivor")
    desc:dressInNamedOutfit(class.outfit)

    -- Create the survivor
    local survivor = IsoPlayer.new(cell, desc, x, y, z or 0)
    survivor:setTagPrefix(class.name)
    survivor:resetModel()
    survivor:setDir(IsoDirections.S)

    -- Assign Survivor traits
    survivor:getTraits():clear()
    for _, trait in ipairs(class.traits) do
        survivor:getTraits():add(trait)
    end

    -- Assign Survivor Weapon
    if class.weapon then
        local weapon = InventoryItemFactory.CreateItem(class.weapon)
        if weapon then
            survivor:getInventory():AddItem(weapon)
            survivor:setPrimaryHandItem(weapon)
        end
    end

    survivor:setInvincible(false)
    survivor:setGhostMode(false)

    survivor:addToWorld()

    return survivor
end

return SurvivorSpawner
