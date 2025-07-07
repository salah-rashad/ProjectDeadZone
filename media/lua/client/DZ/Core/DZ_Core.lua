DZ_Core = DZ_Core or {}

DZ_Core.DEV_MODE = true

function DZ_Core.init()
    print("[DZ] Initializing Dead Zone core systems...")
    DZ_Core.gameState = {
        resources = {
            materials = 100,
            food = 50
        },
        buildings = {},
        survivors = {}
    }
end

DZ_Core.buildState = {
    isBuilding = false,
    current = nil,       -- { id = "Bed", time = 60, elapsed = 0 }
}


return DZ_Core