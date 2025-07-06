DZCamera = {
    x = 0,
    y = 0,
    z = 0,
    minSpeed = 0.2,
    maxSpeed = 2.0
}

function DZCamera:GetCameraPosition()
    return self.x, self.y, self.z
end

function DZCamera:ResetCameraPosition()
    self.x = 12786.0
    self.y = 2554.0
    self.z = 0

    self:SetCameraPosition(self.x, self.y, self.z)
end

function DZCamera.GetCameraZoom()
    return getCore():getZoom(0)
end

function DZCamera:SetCameraPosition(x, y, z)
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
    local zoomLevel = DZCamera.GetCameraZoom()
    local speed = zoomLevel * 0.25 -- Adjust speed based on zoom level
    speed = math.max(speed, DZCamera.minSpeed) -- Ensure speed does not go below minimum
    speed = math.min(speed, DZCamera.maxSpeed) -- Ensure speed does not exceed maximum

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

        DZCamera:SetCameraPosition(x, y, z)
    end
end

local function OnPlayerMove(player)
    DZCamera.x = player:getX()
    DZCamera.y = player:getY()
    DZCamera.z = player:getZ()
end

Events.OnGameStart.Add(OnPlayerMove)
Events.OnKeyKeepPressed.Add(UpdateCameraMovement)
