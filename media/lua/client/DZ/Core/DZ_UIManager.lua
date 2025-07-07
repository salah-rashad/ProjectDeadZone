-- DZ_UIManager: central control over Dead Zone UI panels
DZ_UIManager = {
    panels = {}
}

function DZ_UIManager.init()
    print("[DZ] UI Manager initialized")
end

-- Register a panel by ID and creation callback
function DZ_UIManager.register(id, constructor)
    if DZ_UIManager.panels[id] then
        print("[DZ] Panel with ID '" .. id .. "' already registered.")
        return
    end

    DZ_UIManager.panels[id] = {
        create = constructor,
        instance = nil
    }
end

-- Show or toggle the panel by ID
function DZ_UIManager.toggle(id, x, y)
    local panel = DZ_UIManager.panels[id]
    if not panel then
        print("[DZ] No panel registered for ID: " .. id)
        return
    end

    -- If exists, toggle visibility
    if panel.instance then
        panel.instance:setVisible(not panel.instance:getIsVisible())
        return
    end

    -- Else, create and show it
    panel.instance = panel.create(x or 100, y or 100)
    panel.instance:addToUIManager()
    panel.instance:setVisible(true)
end

-- Destroy a panel by ID
function DZ_UIManager.destroy(id)
    local panel = DZ_UIManager.panels[id]
    if panel and panel.instance then
        panel.instance:removeFromUIManager()
        panel.instance = nil
        print("[DZ] Panel '" .. id .. "' destroyed.")
    end
end

-- Destroy all registered panels (for hot reload/debug)
function DZ_UIManager.destroyAll()
    for id, panel in pairs(DZ_UIManager.panels) do
        if panel.instance then
            panel.instance:removeFromUIManager()
            panel.instance = nil
            print("[DZ] Destroyed: " .. id)
        end
    end
end
