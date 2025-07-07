--- @type ISPanel
DZ_BuildingUI = ISPanel:derive("DZ_BuildingUI")

function DZ_BuildingUI:initialise()
    ISPanel.initialise(self)
    self:populateButtons()
end

function DZ_BuildingUI:new(x, y, w, h)
    local panel = ISPanel.new(self, x, y, w, h)
    panel.backgroundColor = {
        r = 0.1,
        g = 0.1,
        b = 0.1,
        a = 0.7
    }
    panel:initialise()
    return panel
end

function DZ_BuildingUI:populateButtons()
    print("[DZ] Populating build buttons...")

    if not DZ_BuildingDefs then
        print("[DZ] ERROR: DZ_BuildingDefs not loaded!")
        return
    end

    local y = 10
    for id, def in pairs(DZ_BuildingDefs) do
        print("[DZ] Adding building: " .. tostring(id))
        local btn = ISButton:new(10, y, self.width - 20, 30, def.displayName, self, DZ_BuildingUI.onClickBuild)
        btn.internal = id
        self:addChild(btn)
        y = y + 35
    end
end

function DZ_BuildingUI:onClickBuild(button)
    local id = button.internal
    local def = DZ_BuildingDefs[id]
    local cost = def.cost or {}
    local materials = cost.materials or 0

    if DZ_Core.buildState.isBuilding then
        print("[DZ] Already building something.")
        return
    end

    if DZ_Core.gameState.resources.materials >= materials then
        local item = getPlayer():getInventory():AddItem(def.worldObject.itemId)
        if not item then
            print("[DZ] Failed to add item to inventory: " .. tostring(def.worldObject.itemId))
            return
        end
        DZ_Core.gameState.resources.materials = DZ_Core.gameState.resources.materials - materials
        print("[DZ] item added to inventory: " .. tostring(item))
    else
        print("[DZ] Not enough materials to build: " .. def.displayName)
    end

    --[[ if DZ_Core.gameState.resources.materials >= materials then
        DZ_Core.gameState.resources.materials = DZ_Core.gameState.resources.materials - materials

        -- Start building
        DZ_Core.buildState.isBuilding = true
        DZ_Core.buildState.current = {
            id = id,
            button = button,
            time = def.buildTime
        }

        button:setEnable(false)

        local timerID = "dz_build_" .. id

        timer:Create(timerID, def.buildTime, 1, function()
            print("[DZ] Build complete: " .. def.displayName)

            if DZ_Core.buildState.current and DZ_Core.buildState.current.button then
                -- state.current.button:setTitle("✅ Built")
                button:setEnable(true)
            end

            DZ_BuildMenu.placeBuiltStructure(def)

            DZ_Core.buildState.isBuilding = false
            DZ_Core.buildState.current = nil
        end)

        print("[DZ] Started build: " .. def.displayName .. " (" .. def.buildTime .. "s)")
    else
        print("[DZ] Not enough materials to build: " .. def.displayName)
    end ]]
end

function DZ_BuildingUI:render()
    ISPanel.render(self)

    local state = DZ_Core.buildState
    if state.isBuilding and state.current and state.current.button then
        local btn = state.current.button
        local id = state.current.id
        local totalTime = state.current.time
        local timerID = "dz_build_" .. id

        local timeLeft = timer:TimeLeft(timerID)
        if not timeLeft then
            return
        end

        local pct = math.min(1 - (timeLeft / totalTime), 1)

        local x = btn:getX()
        local y = btn:getY()
        local w = btn:getWidth()
        local h = btn:getHeight()

        self:drawRect(x, y, w, h, 0.2, 1, 1, 1)
        self:drawRect(x, y, w * pct, h, 0.5, 0.2, 0.8, 0.9)
    end
end

function DZ_BuildingUI.placeBuiltStructure(def)
    local player = getSpecificPlayer(0)
    if not player then
        return
    end

    local square = player:getCurrentSquare()
    if not square then
        return
    end

    local worldDef = def.worldObject or {}
    local sprite = worldDef.sprite or "carpentry_01_52"

    local obj = IsoObject.new(square, "113029", true)
    obj:setName(def.displayName)
    -- obj:setIsContainer(false)
    -- obj:setCanPassThrough(worldDef.passThrough or false)

    square:AddSpecialObject(obj)
    square:RecalcProperties()
    print("[DZ] Structure placed: " .. def.displayName .. " at " .. square:getX() .. "," .. square:getY())
end
