DZ_Camera = DZ_Camera or {}

function DZ_Camera.init()
    DZ_Camera.x = 0
    DZ_Camera.y = 0
    DZ_Camera.z = 0
    DZ_Camera.minSpeed = 0.2
    DZ_Camera.maxSpeed = 2.0

    -- disable or remove the player's control
    local player = getPlayer()
    if player then
        -- player:setAlpha(0.0)                        -- Set transparency to fully transparent
        player:setGodMod(true) -- Enable god mode
        player:setInvisible(true) -- Make player invisible
        player:setGhostMode(true) -- Enable ghost mode
        player:setNoClip(true) -- Enable no-clip mode makes the player pass through walls
        player:setIgnoreMovement(true) -- Ignore movement input
        player:setIgnoreAimingInput(true) -- Ignore aiming input
        -- player:setForceAim(true)                    -- Force aiming mode
        player:setCanSeeAll(true) -- Reveal the map
        player:setCanHearAll(true) -- Enable hearing all sounds
        player:setTimedActionInstantCheat(true) -- Instant actions
    end
end

function DZ_Camera:GetCameraPosition()
    return self.x, self.y, self.z
end

function DZ_Camera:ResetCameraPosition()
    self.x = 12786.0
    self.y = 2554.0
    self.z = 0

    self:SetCameraPosition(self.x, self.y, self.z)
end

function DZ_Camera.GetCameraZoom()
    return getCore():getZoom(0)
end

function DZ_Camera:SetCameraPosition(x, y, z)
    local player = getPlayer()
    if player then
        self.x = x
        self.y = y
        self.z = z
        player:setX(x)
        player:setY(y)
        player:setZ(z or 0)
    end
end

-- Basic WASD movement
local function UpdateCameraMovement(key)
    local zoomLevel = DZ_Camera.GetCameraZoom()
    local speed = zoomLevel * 0.25 -- Adjust speed based on zoom level
    speed = math.max(speed, DZ_Camera.minSpeed) -- Ensure speed does not go below minimum
    speed = math.min(speed, DZ_Camera.maxSpeed) -- Ensure speed does not exceed maximum

    local player = getPlayer()
    if player then
        local x, y, z = player:getX(), player:getY(), player:getZ()

        if key == Keyboard.KEY_W then
            x = x - speed
            y = y - speed
        end
        if key == Keyboard.KEY_S then
            x = x + speed
            y = y + speed
        end
        if key == Keyboard.KEY_A then
            x = x - speed
            y = y + speed
        end
        if key == Keyboard.KEY_D then
            x = x + speed
            y = y - speed
        end

        DZ_Camera:SetCameraPosition(x, y, z)
    end
end

local function OnPlayerMove(player)
    DZ_Camera.x = player:getX()
    DZ_Camera.y = player:getY()
    DZ_Camera.z = player:getZ()
end

Events.OnGameStart.Add(OnPlayerMove)
Events.OnKeyKeepPressed.Add(UpdateCameraMovement)
