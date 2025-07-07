require "DZ/Debug/DZ_DebugCommands"
require "DZ/Core/DZ_Core"
require "DZ/Core/DZ_UIManager"
require "DZ/Core/DZ_CameraManager"
require "DZ/UI/DZ_BuildMenu"

Events.OnGameStart.Add(function()
    if DZ_Core.DEV_MODE then
        DZ_DebugCommands.init()
    end

    DZ_Core.init()
    DZ_UIManager.init()
    DZ_Camera.init()
end)

DZ_UIManager.register("DZ_BuildingUI", function(x, y)
    return DZ_BuildingUI:new(100, 100, 200, 300)
end)

DZ_UIManager.register("DZ_InventoryUI", function(x, y)
    return DZ_InventoryUI:new(300, 100, 300, 300)
end)

-- HIDE VANILLA UI PANELS
-- ISInventoryPane:setVisible(false)
-- ISInventoryPane:removeFromUIManager()
