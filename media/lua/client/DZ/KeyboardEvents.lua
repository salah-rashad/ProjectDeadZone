Events.OnKeyPressed.Add(function(key)
    -- Toggle the build menu
    if key == Keyboard.KEY_NUMPAD1 then
        DZ_UIManager.toggle("DZ_BuildingUI")
    end

    -- Toggle the inventory UI
    if key == Keyboard.KEY_NUMPAD2 then
        DZ_UIManager.toggle("DZ_InventoryUI")
        DZ_InventoryUI:refreshItemList()
    end

    -- Destroy all Custom UI elements
    if key == Keyboard.KEY_MULTIPLY then
        DZ_UIManager.destroyAll()
    end

    -- Load survivors
    if key == Keyboard.KEY_ADD then
        local SurvivorsLoader = require("DZ/Survivor/SurvivorsLoader")
        SurvivorsLoader.load()
    end
end)
