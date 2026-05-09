-----------------------------------
-- Lookup for weaponskill type
-----------------------------------
local m = Module:new("enum_skill")

xi           = xi or {}
xi.skillName =
{
    [xi.skill.HAND_TO_HAND] = "Hand-to-Hand",
    [xi.skill.DAGGER]       = "Dagger",
    [xi.skill.SWORD]        = "Sword",
    [xi.skill.GREAT_SWORD]  = "Great Sword",
    [xi.skill.AXE]          = "Axe",
    [xi.skill.GREAT_AXE]    = "Great Axe",
    [xi.skill.SCYTHE]       = "Scythe",
    [xi.skill.POLEARM]      = "Polearm",
    [xi.skill.KATANA]       = "Katana",
    [xi.skill.GREAT_KATANA] = "Great Katana",
    [xi.skill.CLUB]         = "Club",
    [xi.skill.STAFF]        = "Staff",
    [xi.skill.ARCHERY]      = "Archery",
    [xi.skill.MARKSMANSHIP] = "Marksmanship",

    [xi.skill.FISHING]      = "Fishing",
    [xi.skill.WOODWORKING]  = "Woodworking",
    [xi.skill.SMITHING]     = "Smithing",
    [xi.skill.GOLDSMITHING] = "Goldsmithing",
    [xi.skill.CLOTHCRAFT]   = "Clothcraft",
    [xi.skill.LEATHERCRAFT] = "Leathercraft",
    [xi.skill.BONECRAFT]    = "Bonecraft",
    [xi.skill.ALCHEMY]      = "Alchemy",
    [xi.skill.COOKING]      = "Cooking",
}

return m
