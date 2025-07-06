local SurvivorsLoader = require("DZ/Survivor/SurvivorsLoader")

local function OnGameStart()
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

local function LoadSurvivors()
    SurvivorsLoader.load()
end

Events.OnGameStart.Add(OnGameStart)
Events.OnKeyPressed.Add(function(key)
    if key == Keyboard.KEY_ADD then
        LoadSurvivors()
    end
end)
