--- @class SurvivorClass
--- @field public idPrefix string Prefix for survivor IDs
--- @field public name string Name of the survivor class
--- @field public outfit string Outfit name for the survivor
--- @field public weapon string Weapon type assigned to the survivor
--- @field public traits string[] List of traits associated with the survivor
--- Represents a survivor class in the Dead Zone mod for Project Zomboid.
local SurvivorClass = {
    idPrefix = "",
    name = "",
    outfit = "",
    weapon = "",
    traits = {}
}

SurvivorClass.__index = SurvivorClass

function SurvivorClass:new(idPrefix, name, outfit, weapon, traits)
    local cls = {}
    setmetatable(cls, SurvivorClass)
    cls.idPrefix = idPrefix
    cls.name = name
    cls.outfit = outfit
    cls.weapon = weapon
    cls.traits = traits
    return cls
end

return SurvivorClass

--[[ SurvivorClass = {
    Templates = {
        Fighter = {
            idPrefix = "DZ_Fighter_",
            name = "Fighter",
            outfit = "ArmyCamoGreen",
            weapon = "Base.Axe",
            traits = { "Brave", "Strong" }
        },
        Recon = {
            idPrefix = "DZ_Recon_",
            name = "Recon",
            outfit = "Hiker",
            weapon = "Base.HuntingKnife",
            traits = { "Sneaky", "FastRunner" }
        },
        Engineer = {
            idPrefix = "DZ_Engineer_",
            name = "Engineer",
            outfit = "Mechanic",
            weapon = "Base.Wrench",
            traits = { "FastLearner", "Lucky" }
        },
        Scavenger = {
            idPrefix = "DZ_Scavenger_",
            name = "Scavenger",
            outfit = "Casual",
            weapon = "Base.BaseballBat",
            traits = { "Lucky", "Organized" }
        },
        Medic = {
            idPrefix = "DZ_Medic_",
            name = "Medic",
            outfit = "Doctor",
            weapon = "Base.KitchenKnife",
            traits = { "FastHealer", "LightEater"}
        }
    }
}

function SurvivorClass.get(templateName)
    return SurvivorClass.Templates[templateName]
end

return SurvivorClass ]]
