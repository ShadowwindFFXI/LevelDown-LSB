-----------------------------------
-- Temporary buffs used in custom content
-----------------------------------
local m = Module:new("enum_buffs")

omixi       = omixi or {}
omixi.buffs =
{
    -----------------------------------
    -- Tier I Buffs
    -----------------------------------
    {
        name = "Archer's Aim",
        rank = 1,
        desc = "Accuracy+5 / R.Accuracy+5",
        mods =
        {
            { xi.mod.ACC,  5 },
            { xi.mod.MACC, 5 },
        },
    },
    {
        name = "Assailant's Ambush",
        rank = 1,
        desc = "DEX+3 / AGI+3",
        mods =
        {
            { xi.mod.DEX, 3 },
            { xi.mod.AGI, 3 },
        },
    },
    {
        name = "Brawler's Brawn",
        rank = 1,
        desc = "STR+2 / Attack+5",
        mods =
        {
            { xi.mod.STR, 2 },
            { xi.mod.ATT, 5 },
        },
    },

    -- TODO: Replace these three
    {
        name = "Archer's Aim",
        rank = 1,
        desc = "Accuracy+5 / R.Accuracy+5",
        mods =
        {
            { xi.mod.ACC,  5 },
            { xi.mod.MACC, 5 },
        },
    },
    {
        name = "Assailant's Ambush",
        rank = 1,
        desc = "DEX+3 / AGI+3",
        mods =
        {
            { xi.mod.DEX, 3 },
            { xi.mod.AGI, 3 },
        },
    },
    {
        name = "Brawler's Brawn",
        rank = 1,
        desc = "STR+2 / Attack+5",
        mods =
        {
            { xi.mod.STR, 2 },
            { xi.mod.ATT, 5 },
        },
    },
    -- END TODO

    {
        name = "Healer's Hands",
        rank = 1,
        desc = "MND+2 / Cure Potency+5%",
        mods =
        {
            { xi.mod.MND,          2 },
            { xi.mod.CURE_POTENCY, 5 },
        },
    },
    {
        name = "Soldier's Stamina",
        rank = 1,
        desc = "VIT+2 / HP+8%",
        mods =
        {
            { xi.mod.VIT, 2 },
            { xi.mod.HPP, 8 },
        },
    },
    {
        name = "Mage's Memory",
        rank = 1,
        desc = "INT+2 / MP+8%",
        mods =
        {
            { xi.mod.INT, 2 },
            { xi.mod.MPP, 8 },
        },
    },
    {
        name = "Roamer's Reprieve",
        rank = 1,
        desc = "HP/MP Recovered while healing+5",
        mods =
        {
            { xi.mod.HPHEAL, 5 },
            { xi.mod.MPHEAL, 5 },
        },
    },
    {
        name = "Marcher's Melody",
        rank = 1,
        desc = "CHR+3 / Waltz Potency+5%",
        mods =
        {
            { xi.mod.CHR,           3 },
            { xi.mod.WALTZ_POTENCY, 5 },
        },
    },
    {
        name = "Guardian's Glory",
        rank = 1,
        desc = "VIT+2 / Physical dmg taken-3%",
        mods =
        {
            { xi.mod.VIT,        2 },
            { xi.mod.DMGPHYS, -300 },
        },
    },
    {
        name = "Hoarder's Hostility",
        rank = 1,
        desc = "Enmity+2 / Gilfinder+2",
        mods =
        {
            { xi.mod.ENMITY,    2 },
            { xi.mod.GILFINDER, 2 },
        },
    },
    {
        name = "Hero's Heart",
        rank = 1,
        desc = "HP+30 / MP+30",
        mods =
        {
            { xi.mod.HP, 30 },
            { xi.mod.MP, 30 },
        },
    },
    {
        name = "Adept's Advance",
        rank = 1,
        desc = "Haste+5% / Fast Cast+5%",
        mods =
        {
            { xi.mod.HASTE_GEAR, 5 },
            { xi.mod.FASTCAST,   5 },
        },
    },
    {
        name = "Champion's Command",
        rank = 1,
        desc = "Combat Skills +5",
        mods =
        {
            { xi.mod.HTH,     5 },
            { xi.mod.DAGGER,  5 },
            { xi.mod.SWORD,   5 },
            { xi.mod.GSWORD,  5 },
            { xi.mod.AXE,     5 },
            { xi.mod.GAXE,    5 },
            { xi.mod.SCYTHE,  5 },
            { xi.mod.POLEARM, 5 },
            { xi.mod.KATANA,  5 },
            { xi.mod.GKATANA, 5 },
            { xi.mod.CLUB,    5 },
            { xi.mod.STAFF,   5 },
        },
    },

    -----------------------------------
    -- Tier II Buffs
    -----------------------------------
    {
        name = "Sage's Seersight",
        rank = 2,
        desc = "Magic Accuracy+3 / Accuracy+8",
        mods =
        {
            { xi.mod.ACC,  10 },
            { xi.mod.MACC,  5 },
        },
    },
    {
        name = "Fighter's Fury",
        rank = 2,
        desc = "STR+3 / Attack+8",
        mods =
        {
            { xi.mod.STR,  3 },
            { xi.mod.ATT, 10 },
        },
    },
    {
        name = "Plunderer's Precision",
        rank = 2,
        desc = "DEX+3 / Accuracy+8",
        mods =
        {
            { xi.mod.DEX, 3 },
            { xi.mod.ACC, 8},
        },
    },
    {
        name = "Wizard's Wisdom",
        rank = 2,
        desc = "INT+3 / Magic Atk. Bonus+5",
        mods =
        {
            { xi.mod.INT,  3 },
            { xi.mod.MATT, 5 },
        },
    },
    {
        name = "Trickster's Tenacity",
        rank = 2,
        desc = "AGI+3 / Evasion+8",
        mods =
        {
            { xi.mod.AGI, 3 },
            { xi.mod.EVA, 8 },
        },
    },
    {
        name = "Ronin's Revenge",
        rank = 2,
        desc = "Weaponskill Accuracy+3 / Store TP+8",
        mods =
        {
            { xi.mod.WSACC, 3 },
            { xi.mod.STORETP, 8 },
        },
    },
    {
        name = "Sniper's Salvo",
        rank = 2,
        desc = "Ranged Accuacy+8 / Ranged Attack+8",
        mods =
        {
            { xi.mod.RACC, 8 },
            { xi.mod.RATT, 8 },
        },
    },
    {
        name = "Braver's Bulwark",
        rank = 2,
        desc = "DEF+8 / Physical damage taken-5%",
        mods =
        {
            { xi.mod.DEF,        8 },
            { xi.mod.DMGPHYS, -500 },
        },
    },

    -----------------------------------
    -- Tier III Buffs
    -----------------------------------
    {
        name = "Rogue's Retribution",
        rank = 3,
        desc = "DEX+5 / Critical Hit Rate+10%",
        mods =
        {
            { xi.mod.DEX,          5 },
            { xi.mod.CRITHITRATE, 10 },
        },
    },
    {
        name = "Warlord's Wrath",
        rank = 3,
        desc = "Enmity+5 / Double Attack +10%",
        mods =
        {
            { xi.mod.ENMITY,         5 },
            { xi.mod.DOUBLE_ATTACK, 10 },
        },
    },
    {
        name = "Scholar's Swiftness",
        rank = 3,
        desc = "Fast Cast+10% / Movement Speed+10%",
        mods =
        {
            { xi.mod.FASTCAST,             10 },
            { xi.mod.MOVE_SPEED_STACKABLE, 10 },
        },
    },
    {
        name = "Rambler's Respite",
        rank = 3,
        desc = "HP/MP Recovered while healing+10",
        mods =
        {
            { xi.mod.HPHEAL, 10 },
            { xi.mod.MPHEAL, 10 },
        },
    },
    {
        name = "Cleric's Clarity",
        rank = 3,
        desc = "MND+5 / Cure Potency+10%",
        mods =
        {
            { xi.mod.MND,           5 },
            { xi.mod.CURE_POTENCY, 10 },
        },
    },
    {
        name = "Dancer's Delight",
        rank = 3,
        desc = "CHR+5 / Waltz Potency+10%",
        mods =
        {
            { xi.mod.CHR,            5 },
            { xi.mod.WALTZ_POTENCY, 10 },
        },
    },
    {
        name = "Thaumaturge's Tempest",
        rank = 3,
        desc = "INT+5 / Magic Atk. Bonus+10",
        mods =
        {
            { xi.mod.INT,   5 },
            { xi.mod.MATT, 10 },
        },
    },
    {
        name = "Stallwart's Sentinel",
        rank = 3,
        desc = "VIT+5 / Damage taken-10%",
        mods =
        {
            { xi.mod.VIT,         5 },
            { xi.mod.DMGPHYS, -1000 },
        },
    },
}

return m
