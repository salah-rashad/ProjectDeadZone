local SurvivorClass = require("DZ/models/SurvivorClass")

--- @class SurvivorClasses
--- @field public Fighter SurvivorClass
--- @field public Recon SurvivorClass
--- @field public Engineer SurvivorClass
--- @field public Scavenger SurvivorClass
--- @field public Medic SurvivorClass
local SurvivorClasses = {
    Fighter = SurvivorClass:new("DZ_Fighter_", "Fighter", "ArmyCamoGreen", "Base.Axe", {"Brave", "Strong"}),
    Recon = SurvivorClass:new("DZ_Recon_", "Recon", "Hiker", "Base.HuntingKnife", {"Sneaky", "FastRunner"}),
    Engineer = SurvivorClass:new("DZ_Engineer_", "Engineer", "Boilersuit_BlueRed", "Base.Wrench",
        {"FastLearner", "Lucky"}),
    Scavenger = SurvivorClass:new("DZ_Scavenger_", "Scavenger", "Casual", "Base.BaseballBat", {"Lucky", "Organized"}),
    Medic = SurvivorClass:new("DZ_Medic_", "Medic", "Doctor", "Base.KitchenKnife", {"FastHealer", "LightEater"})
}

function SurvivorClasses:asTable()
    return {self.Fighter, self.Recon, self.Engineer, self.Scavenger, self.Medic}
end

function SurvivorClasses:getRandom()
    return self:asTable()[ZombRand(#self:asTable() + 1)]
end

return SurvivorClasses
