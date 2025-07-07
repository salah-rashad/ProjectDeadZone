DZ_DebugCommands = {}

function DZ_DebugCommands.init()
    Events.OnGameStart.Add(function()
        DZ_DebugCommands.register()
    end)
end

function DZ_DebugCommands.register()
    -- Events.OnKeyPressed.Add(function(key)
    --     if key == Keyboard.KEY_MULTIPLY then -- "*" key
    --         if DZ_BuildMenu and dz_buildMenu then
    --             print("[DZ] Refreshing Build Menu...")
    --             dz_buildMenu:clearChildren()
    --             dz_buildMenu:populateButtons()
    --         end
    --     end
    -- end)

    -- Events.OnCustomUIKey.Add(function(key)
    --     if command == "dz_refresh_ui" then
    --         getPlayer():Say("🔄 UI refreshed")
    --         if DZ_BuildMenu and dz_buildMenu then
    --             dz_buildMenu:clearChildren()
    --             dz_buildMenu:populateButtons()
    --         end
    --     end
    -- end)
end

DZ_DebugCommands.init()
