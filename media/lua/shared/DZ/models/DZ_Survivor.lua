-- local DZSurvivor = {}

-- function DZSurvivor:new()
--     local obj = {}
--     setmetatable(obj, self)
--     self.__index = self
--     return obj
-- end

-- function DZSurvivor:initialize()
--     -- Initialization code for the survivor
--     self.x = 0
--     self.y = 0
--     self.z = 0
--     self.alpha = 1.0
-- end

-- function DZSurvivor:setPosition(x, y, z)
--     self.x = x
--     self.y = y
--     self.z = z or 0
-- end

-- function DZSurvivor:getPosition()
--     return self.x, self.y, self.z
-- end

-- function DZSurvivor:MoveTo(x, y, z)
--     self:setPosition(x, y, z)
--     -- Additional logic for moving the survivor can be added here
-- end