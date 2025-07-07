--- @type ISCollapsableWindow
SurvivorsBarUI = {}

-- local text1 =
--     "Players: <LINE> - MrBounty <LINE> - Dane <LINE> - xx <LINE> - xx <LINE> - xx <LINE> - xx <LINE> - xx <LINE> - xx <LINE> - xx <LINE> - xx <LINE> - xx"
-- local text2 =
--     "Players: <LINE> - xx <LINE> - xx <LINE> - xx <LINE> - xx <LINE> - xx <LINE> - xx <LINE> - xx <LINE> - xx <LINE> - xx"

local function selectSurvivor(button, args)
    --- @type PZNS_NPCSurvivor
    local survivor = args.survivor
    survivor.npcIsoPlayerObject:SayDebug("Hi there, I'm a survivor")
    SurvivorManager.selectedSurvivor = survivor
    -- SurvivorsBarUI:close()
end

local function onCreateUI()
    SurvivorsBarUI = NewUI()
    SurvivorsBarUI:setWidth(100)

    --[[  
   
    SurvivorsBarUI:addText("", "Choose your team", "Large", "Center")
    SurvivorsBarUI:nextLine()

    SurvivorsBarUI:addRichText("", text1)
    SurvivorsBarUI:addRichText("", text2)
    SurvivorsBarUI:setLineHeightPercent(0.2)
    SurvivorsBarUI:nextLine()

    SurvivorsBarUI:addText("t1", "11/12", nil, "Right")
    SurvivorsBarUI:addText("t2", "9/12", nil, "Center")
    UI["t1"]:setColor(1, 0, 0, 1)
    UI["t2"]:setColor(1, 1, 0, 0)
    SurvivorsBarUI:nextLine()

    SurvivorsBarUI:addButton("b1", "Blue", choose)
    SurvivorsBarUI:addButton("b2", "Red", choose)
    UI["b1"]:addArg("team", "blue")
    UI["b2"]:addArg("team", "red")
    
    SurvivorsBarUI:setBorderToAllElements(true) 
    
    ]]

    local size = 0
    for key, value in pairs(ActiveSurvivors) do
        size = size + 1
        local bKey = "button_" .. key -- button key
        SurvivorsBarUI:addButton(bKey, value.survivorName, selectSurvivor)
        --- @type ISButton
        local btn = SurvivorsBarUI[bKey]
        btn:addArg("survivor", value)
        btn:setTooltip(value.survivorName)
        SurvivorsBarUI:nextLine()
    end

    SurvivorsBarUI:setBorderToAllElements(true)
    SurvivorsBarUI:saveLayout()
end

Events.OnCustomUIKey.Add(function(key)
    if key == Keyboard.KEY_NUMPAD0 then
        if SurvivorsBarUI then
            SurvivorsBarUI:close()
        end
        onCreateUI()
    end
end)

-- Events.OnCreateUI.Add(onCreateUI)

