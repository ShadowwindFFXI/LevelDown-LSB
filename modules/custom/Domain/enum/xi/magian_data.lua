-----------------------------------
-- Additional xi.magaian.data entries
-- Magian trials are listed for relic/mythic in the final column in the below
-- https://www.bg-wiki.com/ffxi/Category:Trial_of_the_Magians#Weapon_Trials
-- textOffset is what defines the WS shown in the details of the trial when trading to the moogle. Can pull it from here:
-- https://github.com/LandSandBoat/UpdateExtractor/blob/74ef674a8f8d82f215c2da1235c2042ac346532d/out/scripts/zones/RuLude_Gardens/Text.lua.raw.txt#L2690
-- using the base textOffset value of Mercy Stroke's first trial: 349 compared to the event id in the above
-- example for trial 994:
--  mercy stroke base event for offset 349 is 2767
--  which means the base event is 2418
--  mandalic stab requiring vermin is event 2769
--  which means the textOffset is 2769-2418 = 351
--  trial 995 is mandalic stab requiring undead, which is the next event in the raw extract so that offset is 352
-----------------------------------
-- require the file to reset the xi.magian.trials table, then append it below
-- This file is then required in the magian.lua file
require('scripts/globals/magian_data')
require("modules/module_utils")
local m = Module:new("enum_mag_data")

-----------------------------------
-- Walkthrough of implementing a weapon's trial
--   set the xi.item value in all caps
--   place it in every xi.item placeholder in the 3 trials (6 spots total)
--   update the DMG augments accordingly based on ffxiclopedia data (afaik this data is not in the DATs)
--   update bgwiki trial pages based on these DMG augments ("|Required.Augments=DMG:+X" for requirements in 2nd two and "|Augments=DMG:+X" for rewards in all three trials)
--   update ecosystem and weaponskill for all 3 trials (numRequired and defeatMob should be the same)
--   finally, the most tedious: update the textOffset
--     This can be done via trial and error, but best to reference the primary magian_data for a relic trial and offset based on that
-----------------------------------
-----------------------------------
-- Walkthrough of testing the trial
--   Give yourself the item using the item id
--   trade it to the magian moogle. All metadata can be verified via this one trade by traversing the menues (with enternity UNLOADED)
--     view details of the primary trial, ensure it specifices the correct requirements (the weaponskill is determined by the textOffset, credit is determined by the property useWeaponskill and cannot be confirmed here)
--     to ensure the trial chains properly, go to the bottom to view "resulting trials"
--     verify the same data for 2nd and third trial (required item, reward, details)
-----------------------------------

-----------------------------------
-- Mythic weapons mostly don't have xi.item entries
-- name key must match the item name in db! (i.e. don't do VAJRA_75 or something, but be the exact name that an item lua would reference)
-- Below is the template to fill out for each mythic: weapon enum entry, any value not defined, updated DMG augments to match the trial
-----------------------------------
-- xi.item. =
-- xi.magian.trials[] =
-- {
--     previousTrial = 0,
--     requiredItem  =
--     {
--         itemId = xi.item.,
--     },

--     textOffset     = ,
--     defeatMob      = false,
--     mobEcosystem   = xi.ecosystem.,
--     useWeaponskill = xi.weaponskill.,
--     numRequired    = 200,

--     rewardItem =
--     {
--         itemId       = xi.item.,
--         itemAugments =
--         {
--             [1] = { 740, 1 }, -- DMG:+2
--         },
--     },
-- }

-- xi.magian.trials[] =
-- {
--     previousTrial = ,
--     requiredItem  =
--     {
--         itemId       = xi.item.,
--         itemAugments =
--         {
--             [1] = { 740, 1 }, -- DMG:+2
--         },
--     },

--     textOffset     = ,
--     defeatMob      = true,
--     mobEcosystem   = xi.ecosystem.,
--     useWeaponskill = xi.weaponskill.,
--     numRequired    = 200,

--     rewardItem =
--     {
--         itemId       = xi.item.,
--         itemAugments =
--         {
--             [1] = { 740, 3 }, -- DMG:+4
--         },
--     },
-- }

-- xi.magian.trials[] =
-- {
--     previousTrial = ,
--     requiredItem  =
--     {
--         itemId       = xi.item.,
--         itemAugments =
--         {
--             [1] = { 740, 3 }, -- DMG:+4
--         },
--     },

--     textOffset     = ,
--     defeatMob      = true,
--     mobEcosystem   = xi.ecosystem.,
--     useWeaponskill = xi.weaponskill.,
--     numRequired    = 300,

--     rewardItem =
--     {
--         itemId       = xi.item.,
--         itemAugments =
--         {
--             [1] = { 740, 5 }, -- DMG:+6
--         },
--     },
-- }

------------------
-- Glanzfaust
-- First trial: https://www.bg-wiki.com/ffxi/Trial_1006
------------------
xi.item.GLANZFAUST = 18992
xi.magian.trials[1006] =
{
    previousTrial = 0,
    requiredItem  =
    {
        itemId = xi.item.GLANZFAUST,
    },

    textOffset     = 359,
    defeatMob      = false,
    mobEcosystem   = xi.ecosystem.BIRD,
    useWeaponskill = xi.weaponskill.ASCETICS_FURY,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.GLANZFAUST,
        itemAugments =
        {
            [1] = { 740, 1 }, -- DMG:+2
        },
    },
}

xi.magian.trials[1007] =
{
    previousTrial = 1006,
    requiredItem  =
    {
        itemId       = xi.item.GLANZFAUST,
        itemAugments =
        {
            [1] = { 740, 1 }, -- DMG:+2
        },
    },

    textOffset     = 360,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.AMORPH,
    useWeaponskill = xi.weaponskill.ASCETICS_FURY,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.GLANZFAUST,
        itemAugments =
        {
            [1] = { 740, 5 }, -- DMG:+6
        },
    },
}

xi.magian.trials[1828] =
{
    previousTrial = 1007,
    requiredItem  =
    {
        itemId       = xi.item.GLANZFAUST,
        itemAugments =
        {
            [1] = { 740, 5 }, -- DMG:+6
        },
    },

    textOffset     = 662,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.LIZARD,
    useWeaponskill = xi.weaponskill.ASCETICS_FURY,
    numRequired    = 300,

    rewardItem =
    {
        itemId       = xi.item.GLANZFAUST,
        itemAugments =
        {
            [1] = { 740, 7 }, -- DMG:+8
        },
    },
}

------------------
-- Kenkonken
-- First trial: https://www.bg-wiki.com/ffxi/Trial_1009
------------------
xi.item.KENKONKEN = 19008
xi.magian.trials[1009] =
{
    previousTrial = 0,
    requiredItem  =
    {
        itemId = xi.item.KENKONKEN,
    },

    textOffset     = 361,
    defeatMob      = false,
    mobEcosystem   = xi.ecosystem.BEAST,
    useWeaponskill = xi.weaponskill.STRINGING_PUMMEL,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.KENKONKEN,
        itemAugments =
        {
            [1] = { 740, 1 }, -- DMG:+2
        },
    },
}

xi.magian.trials[1010] =
{
    previousTrial = 1009,
    requiredItem  =
    {
        itemId       = xi.item.KENKONKEN,
        itemAugments =
        {
            [1] = { 740, 1 }, -- DMG:+2
        },
    },

    textOffset     = 362,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.ARCANA,
    useWeaponskill = xi.weaponskill.STRINGING_PUMMEL,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.KENKONKEN,
        itemAugments =
        {
            [1] = { 740, 4 }, -- DMG:+5
        },
    },
}

xi.magian.trials[1830] =
{
    previousTrial = 1010,
    requiredItem  =
    {
        itemId       = xi.item.KENKONKEN,
        itemAugments =
        {
            [1] = { 740, 4 }, -- DMG:+5
        },
    },

    textOffset     = 664,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.PLANTOID,
    useWeaponskill = xi.weaponskill.STRINGING_PUMMEL,
    numRequired    = 300,

    rewardItem =
    {
        itemId       = xi.item.KENKONKEN,
        itemAugments =
        {
            [1] = { 740, 5 }, -- DMG:+6
        },
    },
}

------------------
-- Vajra
-- First trial: https://www.bg-wiki.com/ffxi/Trial_994
------------------
xi.item.VAJRA = 18996
xi.magian.trials[994] =
{
    previousTrial = 0,
    requiredItem  =
    {
        itemId = xi.item.VAJRA,
    },

    textOffset     = 351,
    defeatMob      = false,
    mobEcosystem   = xi.ecosystem.VERMIN,
    useWeaponskill = xi.weaponskill.MANDALIC_STAB,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.VAJRA,
        itemAugments =
        {
            [1] = { 740, 1 }, -- DMG:+2
        },
    },
}

xi.magian.trials[995] =
{
    previousTrial = 994,
    requiredItem  =
    {
        itemId       = xi.item.VAJRA,
        itemAugments =
        {
            [1] = { 740, 1 }, -- DMG:+2
        },
    },

    textOffset     = 352,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.UNDEAD,
    useWeaponskill = xi.weaponskill.MANDALIC_STAB,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.VAJRA,
        itemAugments =
        {
            [1] = { 740, 3 }, -- DMG:+4
        },
    },
}

xi.magian.trials[1820] =
{
    previousTrial = 995,
    requiredItem  =
    {
        itemId       = xi.item.VAJRA,
        itemAugments =
        {
            [1] = { 740, 3 }, -- DMG:+4
        },
    },

    textOffset     = 654,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.AQUAN,
    useWeaponskill = xi.weaponskill.MANDALIC_STAB,
    numRequired    = 300,

    rewardItem =
    {
        itemId       = xi.item.VAJRA,
        itemAugments =
        {
            [1] = { 740, 5 }, -- DMG:+6
        },
    },
}

------------------
-- Carnwenhan
-- First trial: https://www.bg-wiki.com/ffxi/Trial_997
------------------
xi.item.CARNWENHAN = 19000
xi.magian.trials[997] =
{
    previousTrial = 0,
    requiredItem  =
    {
        itemId = xi.item.CARNWENHAN,
    },

    textOffset     = 353,
    defeatMob      = false,
    mobEcosystem   = xi.ecosystem.AMORPH,
    useWeaponskill = xi.weaponskill.MORDANT_RIME,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.CARNWENHAN,
        itemAugments =
        {
            [1] = { 740, 0 }, -- DMG:+1
        },
    },
}

xi.magian.trials[998] =
{
    previousTrial = 997,
    requiredItem  =
    {
        itemId       = xi.item.CARNWENHAN,
        itemAugments =
        {
            [1] = { 740, 0 }, -- DMG:+1
        },
    },

    textOffset     = 354,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.BIRD,
    useWeaponskill = xi.weaponskill.MORDANT_RIME,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.CARNWENHAN,
        itemAugments =
        {
            [1] = { 740, 2 }, -- DMG:+3
        },
    },
}

xi.magian.trials[1822] =
{
    previousTrial = 998,
    requiredItem  =
    {
        itemId       = xi.item.CARNWENHAN,
        itemAugments =
        {
            [1] = { 740, 2 }, -- DMG:+3
        },
    },

    textOffset     = 656,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.BEAST,
    useWeaponskill = xi.weaponskill.MORDANT_RIME,
    numRequired    = 300,

    rewardItem =
    {
        itemId       = xi.item.CARNWENHAN,
        itemAugments =
        {
            [1] = { 740, 3 }, -- DMG:+4
        },
    },
}

------------------
-- Terpsichore
-- First trial: https://www.bg-wiki.com/ffxi/Trial_1000
------------------
if not xi.item.TERPSICHORE then
    xi.item.TERPSICHORE_75 = 0 -- workaround due to oversight in magian.lua. This will be reset in modules/enum
end

xi.item.TERPSICHORE = 18989
xi.magian.trials[1000] =
{
    previousTrial = 0,
    requiredItem  =
    {
        itemId = xi.item.TERPSICHORE,
    },

    textOffset     = 355,
    defeatMob      = false,
    mobEcosystem   = xi.ecosystem.UNDEAD,
    useWeaponskill = xi.weaponskill.PYRRHIC_KLEOS,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.TERPSICHORE,
        itemAugments =
        {
            [1] = { 740, 1 }, -- DMG:+2
        },
    },
}

xi.magian.trials[1001] =
{
    previousTrial = 1000,
    requiredItem  =
    {
        itemId       = xi.item.TERPSICHORE,
        itemAugments =
        {
            [1] = { 740, 1 }, -- DMG:+2
        },
    },

    textOffset     = 356,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.AQUAN,
    useWeaponskill = xi.weaponskill.PYRRHIC_KLEOS,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.TERPSICHORE,
        itemAugments =
        {
            [1] = { 740, 3 }, -- DMG:+4
        },
    },
}

xi.magian.trials[1824] =
{
    previousTrial = 1001,
    requiredItem  =
    {
        itemId       = xi.item.TERPSICHORE,
        itemAugments =
        {
            [1] = { 740, 3 }, -- DMG:+4
        },
    },

    textOffset     = 658,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.BIRD,
    useWeaponskill = xi.weaponskill.PYRRHIC_KLEOS,
    numRequired    = 300,

    rewardItem =
    {
        itemId       = xi.item.TERPSICHORE,
        itemAugments =
        {
            [1] = { 740, 5 }, -- DMG:+6
        },
    },
}

------------------
-- Murgleis
-- First trial: https://www.bg-wiki.com/ffxi/Trial_1015
------------------
-- it's actually named this in the db
xi.item.MURGLEIS_75 = 18995
xi.magian.trials[1015] =
{
    previousTrial = 0,
    requiredItem  =
    {
        itemId = xi.item.MURGLEIS_75,
    },

    textOffset     = 365,
    defeatMob      = false,
    mobEcosystem   = xi.ecosystem.AMORPH,
    useWeaponskill = xi.weaponskill.DEATH_BLOSSOM,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.MURGLEIS_75,
        itemAugments =
        {
            [1] = { 740, 0 }, -- DMG:+1
        },
    },
}

xi.magian.trials[1016] =
{
    previousTrial = 1015,
    requiredItem  =
    {
        itemId       = xi.item.MURGLEIS_75,
        itemAugments =
        {
            [1] = { 740, 0 }, -- DMG:+1
        },
    },

    textOffset     = 366,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.PLANTOID,
    useWeaponskill = xi.weaponskill.DEATH_BLOSSOM,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.MURGLEIS_75,
        itemAugments =
        {
            [1] = { 740, 2 }, -- DMG:+3
        },
    },
}

xi.magian.trials[1834] =
{
    previousTrial = 1016,
    requiredItem  =
    {
        itemId       = xi.item.MURGLEIS_75,
        itemAugments =
        {
            [1] = { 740, 2 }, -- DMG:+3
        },
    },

    textOffset     = 668,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.BEAST,
    useWeaponskill = xi.weaponskill.DEATH_BLOSSOM,
    numRequired    = 300,

    rewardItem =
    {
        itemId       = xi.item.MURGLEIS_75,
        itemAugments =
        {
            [1] = { 740, 3 }, -- DMG:+4
        },
    },
}

------------------
-- Burtgang
-- First trial: https://www.bg-wiki.com/ffxi/Trial_1018
------------------
xi.item.BURTGANG = 18997
xi.magian.trials[1018] =
{
    previousTrial = 0,
    requiredItem  =
    {
        itemId = xi.item.BURTGANG,
    },

    textOffset     = 367,
    defeatMob      = false,
    mobEcosystem   = xi.ecosystem.LIZARD,
    useWeaponskill = xi.weaponskill.ATONEMENT,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.BURTGANG,
        itemAugments =
        {
            [1] = { 740, 0 }, -- DMG:+1
        },
    },
}

xi.magian.trials[1019] =
{
    previousTrial = 1018,
    requiredItem  =
    {
        itemId       = xi.item.BURTGANG,
        itemAugments =
        {
            [1] = { 740, 0 }, -- DMG:+1
        },
    },

    textOffset     = 368,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.DRAGON,
    useWeaponskill = xi.weaponskill.ATONEMENT,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.BURTGANG,
        itemAugments =
        {
            [1] = { 740, 2 }, -- DMG:+3
        },
    },
}

xi.magian.trials[1836] =
{
    previousTrial = 1019,
    requiredItem  =
    {
        itemId       = xi.item.BURTGANG,
        itemAugments =
        {
            [1] = { 740, 2 }, -- DMG:+3
        },
    },

    textOffset     = 670,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.VERMIN,
    useWeaponskill = xi.weaponskill.ATONEMENT,
    numRequired    = 300,

    rewardItem =
    {
        itemId       = xi.item.BURTGANG,
        itemAugments =
        {
            [1] = { 740, 3 }, -- DMG:+4
        },
    },
}

------------------
-- Tizona
-- First trial: https://www.bg-wiki.com/ffxi/Trial_1021
------------------
xi.item.TIZONA = 19006
xi.magian.trials[1021] =
{
    previousTrial = 0,
    requiredItem  =
    {
        itemId = xi.item.TIZONA,
    },

    textOffset     = 369,
    defeatMob      = false,
    mobEcosystem   = xi.ecosystem.VERMIN,
    useWeaponskill = xi.weaponskill.EXPIACION,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.TIZONA,
        itemAugments =
        {
            [1] = { 740, 0 }, -- DMG:+1
        },
    },
}

xi.magian.trials[1022] =
{
    previousTrial = 1021,
    requiredItem  =
    {
        itemId       = xi.item.TIZONA,
        itemAugments =
        {
            [1] = { 740, 0 }, -- DMG:+1
        },
    },

    textOffset     = 370,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.AQUAN,
    useWeaponskill = xi.weaponskill.EXPIACION,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.TIZONA,
        itemAugments =
        {
            [1] = { 740, 2 }, -- DMG:+3
        },
    },
}

xi.magian.trials[1838] =
{
    previousTrial = 1022,
    requiredItem  =
    {
        itemId       = xi.item.TIZONA,
        itemAugments =
        {
            [1] = { 740, 2 }, -- DMG:+3
        },
    },

    textOffset     = 672,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.ARCANA,
    useWeaponskill = xi.weaponskill.EXPIACION,
    numRequired    = 300,

    rewardItem =
    {
        itemId       = xi.item.TIZONA,
        itemAugments =
        {
            [1] = { 740, 4 }, -- DMG:+5
        },
    },
}

------------------
-- Aymur
-- First trial: https://www.bg-wiki.com/ffxi/Trial_1030
------------------

------------------
-- Conqueror
-- First trial: https://www.bg-wiki.com/ffxi/Trial_1036
------------------

------------------
-- Liberator
-- First trial: https://www.bg-wiki.com/ffxi/Trial_1048
------------------

------------------
-- Ryunohige
-- First trial: https://www.bg-wiki.com/ffxi/Trial_1042
------------------
xi.item.RYUNOHIGE = 19004
xi.magian.trials[1042] =
{
    previousTrial = 0,
    requiredItem  =
    {
        itemId = xi.item.RYUNOHIGE,
    },

    textOffset     = 383,
    defeatMob      = false,
    mobEcosystem   = xi.ecosystem.UNDEAD,
    useWeaponskill = xi.weaponskill.DRAKESBANE,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.RYUNOHIGE,
        itemAugments =
        {
            [1] = { 740, 2 }, -- DMG:+3
        },
    },
}

xi.magian.trials[1043] =
{
    previousTrial = 1042,
    requiredItem  =
    {
        itemId       = xi.item.RYUNOHIGE,
        itemAugments =
        {
            [1] = { 740, 2 }, -- DMG:+3
        },
    },

    textOffset     = 384,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.PLANTOID,
    useWeaponskill = xi.weaponskill.DRAKESBANE,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.RYUNOHIGE,
        itemAugments =
        {
            [1] = { 740, 6 }, -- DMG:+7
        },
    },
}

xi.magian.trials[1852] =
{
    previousTrial = 1043,
    requiredItem  =
    {
        itemId       = xi.item.RYUNOHIGE,
        itemAugments =
        {
            [1] = { 740, 6 }, -- DMG:+7
        },
    },

    textOffset     = 686,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.AQUAN,
    useWeaponskill = xi.weaponskill.DRAKESBANE,
    numRequired    = 300,

    rewardItem =
    {
        itemId       = xi.item.RYUNOHIGE,
        itemAugments =
        {
            [1] = { 740, 8 }, -- DMG:+9
        },
    },
}

------------------
-- Nagi
-- First trial: https://www.bg-wiki.com/ffxi/Trial_1054
------------------
xi.item.NAGI = 19003
xi.magian.trials[1054] =
{
    previousTrial = 0,
    requiredItem  =
    {
        itemId = xi.item.NAGI,
    },

    textOffset     = 391,
    defeatMob      = false,
    mobEcosystem   = xi.ecosystem.AQUAN,
    useWeaponskill = xi.weaponskill.BLADE_KAMU,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.NAGI,
        itemAugments =
        {
            [1] = { 740, 1 }, -- DMG:+2
        },
    },
}

xi.magian.trials[1055] =
{
    previousTrial = 1054,
    requiredItem  =
    {
        itemId       = xi.item.NAGI,
        itemAugments =
        {
            [1] = { 740, 1 }, -- DMG:+2
        },
    },

    textOffset     = 392,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.LIZARD,
    useWeaponskill = xi.weaponskill.BLADE_KAMU,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.NAGI,
        itemAugments =
        {
            [1] = { 740, 3 }, -- DMG:+4
        },
    },
}

xi.magian.trials[1860] =
{
    previousTrial = 1055,
    requiredItem  =
    {
        itemId       = xi.item.NAGI,
        itemAugments =
        {
            [1] = { 740, 3 }, -- DMG:+4
        },
    },

    textOffset     = 694,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.PLANTOID,
    useWeaponskill = xi.weaponskill.BLADE_KAMU,
    numRequired    = 300,

    rewardItem =
    {
        itemId       = xi.item.NAGI,
        itemAugments =
        {
            [1] = { 740, 4 }, -- DMG:+5
        },
    },
}

------------------
-- Kogarasumaru
-- First trial: https://www.bg-wiki.com/ffxi/Trial_1060
------------------
xi.item.KOGARASUMARU = 19002
xi.magian.trials[1060] =
{
    previousTrial = 0,
    requiredItem  =
    {
        itemId = xi.item.KOGARASUMARU,
    },

    textOffset     = 395,
    defeatMob      = false,
    mobEcosystem   = xi.ecosystem.UNDEAD,
    useWeaponskill = xi.weaponskill.TACHI_RANA,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.KOGARASUMARU,
        itemAugments =
        {
            [1] = { 740, 1 }, -- DMG:+2
        },
    },
}

xi.magian.trials[1061] =
{
    previousTrial = 1060,
    requiredItem  =
    {
        itemId       = xi.item.KOGARASUMARU,
        itemAugments =
        {
            [1] = { 740, 1 }, -- DMG:+2
        },
    },

    textOffset     = 396,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.BIRD,
    useWeaponskill = xi.weaponskill.TACHI_RANA,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.KOGARASUMARU,
        itemAugments =
        {
            [1] = { 740, 4 }, -- DMG:+5
        },
    },
}

xi.magian.trials[1864] =
{
    previousTrial = 1061,
    requiredItem  =
    {
        itemId       = xi.item.KOGARASUMARU,
        itemAugments =
        {
            [1] = { 740, 4 }, -- DMG:+5
        },
    },

    textOffset     = 698,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.DRAGON,
    useWeaponskill = xi.weaponskill.TACHI_RANA,
    numRequired    = 300,

    rewardItem =
    {
        itemId       = xi.item.KOGARASUMARU,
        itemAugments =
        {
            [1] = { 740, 6 }, -- DMG:+7
        },
    },
}

------------------
-- Yagrush
-- First trial: https://www.bg-wiki.com/ffxi/Trial_1066
------------------
xi.item.YAGRUSH = 18993
xi.magian.trials[1066] =
{
    previousTrial = 0,
    requiredItem  =
    {
        itemId = xi.item.YAGRUSH,
    },

    textOffset     = 399,
    defeatMob      = false,
    mobEcosystem   = xi.ecosystem.BIRD,
    useWeaponskill = xi.weaponskill.MYSTIC_BOON,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.YAGRUSH,
        itemAugments =
        {
            [1] = { 740, 0 }, -- DMG:+1
        },
    },
}

xi.magian.trials[1067] =
{
    previousTrial = 1066,
    requiredItem  =
    {
        itemId       = xi.item.YAGRUSH,
        itemAugments =
        {
            [1] = { 740, 0 }, -- DMG:+1
        },
    },

    textOffset     = 400,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.DRAGON,
    useWeaponskill = xi.weaponskill.MYSTIC_BOON,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.YAGRUSH,
        itemAugments =
        {
            [1] = { 740, 3 }, -- DMG:+4
        },
    },
}

xi.magian.trials[1868] =
{
    previousTrial = 1067,
    requiredItem  =
    {
        itemId       = xi.item.YAGRUSH,
        itemAugments =
        {
            [1] = { 740, 3 }, -- DMG:+4
        },
    },

    textOffset     = 702,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.ARCANA,
    useWeaponskill = xi.weaponskill.MYSTIC_BOON,
    numRequired    = 300,

    rewardItem =
    {
        itemId       = xi.item.YAGRUSH,
        itemAugments =
        {
            [1] = { 740, 5 }, -- DMG:+6
        },
    },
}

------------------
-- Nirvana
-- First trial: https://www.bg-wiki.com/ffxi/Trial_1075
------------------
xi.item.NIRVANA = 19005
xi.magian.trials[1075] =
{
    previousTrial = 0,
    requiredItem  =
    {
        itemId = xi.item.NIRVANA,
    },

    textOffset     = 405,
    defeatMob      = false,
    mobEcosystem   = xi.ecosystem.BEAST,
    useWeaponskill = xi.weaponskill.GARLAND_OF_BLISS,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.NIRVANA,
        itemAugments =
        {
            [1] = { 740, 3 }, -- DMG:+4
        },
    },
}

xi.magian.trials[1076] =
{
    previousTrial = 1075,
    requiredItem  =
    {
        itemId       = xi.item.NIRVANA,
        itemAugments =
        {
            [1] = { 740, 3 }, -- DMG:+4
        },
    },

    textOffset     = 406,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.ARCANA,
    useWeaponskill = xi.weaponskill.GARLAND_OF_BLISS,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.NIRVANA,
        itemAugments =
        {
            [1] = { 740, 10 }, -- DMG:+11
        },
    },
}

xi.magian.trials[1875] =
{
    previousTrial = 1076,
    requiredItem  =
    {
        itemId       = xi.item.NIRVANA,
        itemAugments =
        {
            [1] = { 740, 10 }, -- DMG:+11
        },
    },

    textOffset     = 708,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.PLANTOID,
    useWeaponskill = xi.weaponskill.GARLAND_OF_BLISS,
    numRequired    = 300,

    rewardItem =
    {
        itemId       = xi.item.NIRVANA,
        itemAugments =
        {
            [1] = { 740, 12 }, -- DMG:+13
        },
    },
}

------------------
-- Laevateinn
-- First trial: https://www.bg-wiki.com/ffxi/Trial_1072
------------------
xi.item.LAEVATEINN = 18994
xi.magian.trials[1072] =
{
    previousTrial = 0,
    requiredItem  =
    {
        itemId = xi.item.LAEVATEINN,
    },

    textOffset     = 403,
    defeatMob      = false,
    mobEcosystem   = xi.ecosystem.VERMIN,
    useWeaponskill = xi.weaponskill.VIDOHUNIR,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.LAEVATEINN,
        itemAugments =
        {
            [1] = { 740, 3 }, -- DMG:+4
        },
    },
}

xi.magian.trials[1073] =
{
    previousTrial = 1072,
    requiredItem  =
    {
        itemId       = xi.item.LAEVATEINN,
        itemAugments =
        {
            [1] = { 740, 3 }, -- DMG:+4
        },
    },

    textOffset     = 404,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.UNDEAD,
    useWeaponskill = xi.weaponskill.VIDOHUNIR,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.LAEVATEINN,
        itemAugments =
        {
            [1] = { 740, 10 }, -- DMG:+11
        },
    },
}

xi.magian.trials[1872] =
{
    previousTrial = 1073,
    requiredItem  =
    {
        itemId       = xi.item.LAEVATEINN,
        itemAugments =
        {
            [1] = { 740, 10 }, -- DMG:+11
        },
    },

    textOffset     = 706,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.LIZARD,
    useWeaponskill = xi.weaponskill.VIDOHUNIR,
    numRequired    = 300,

    rewardItem =
    {
        itemId       = xi.item.LAEVATEINN,
        itemAugments =
        {
            [1] = { 740, 12 }, -- DMG:+13
        },
    },
}

------------------
-- Tupsimati
-- First trial: https://www.bg-wiki.com/ffxi/Trial_1078
------------------
xi.item.TUPSIMATI = 18990
xi.magian.trials[1078] =
{
    previousTrial = 0,
    requiredItem  =
    {
        itemId = xi.item.TUPSIMATI,
    },

    textOffset     = 407,
    defeatMob      = false,
    mobEcosystem   = xi.ecosystem.LIZARD,
    useWeaponskill = xi.weaponskill.OMNISCIENCE,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.TUPSIMATI,
        itemAugments =
        {
            [1] = { 740, 3 }, -- DMG:+4
        },
    },
}

xi.magian.trials[1079] =
{
    previousTrial = 1078,
    requiredItem  =
    {
        itemId       = xi.item.TUPSIMATI,
        itemAugments =
        {
            [1] = { 740, 3 }, -- DMG:+4
        },
    },

    textOffset     = 408,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.VERMIN,
    useWeaponskill = xi.weaponskill.OMNISCIENCE,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.TUPSIMATI,
        itemAugments =
        {
            [1] = { 740, 10 }, -- DMG:+11
        },
    },
}

xi.magian.trials[1876] =
{
    previousTrial = 1079,
    requiredItem  =
    {
        itemId       = xi.item.TUPSIMATI,
        itemAugments =
        {
            [1] = { 740, 10 }, -- DMG:+11
        },
    },

    textOffset     = 710,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.UNDEAD,
    useWeaponskill = xi.weaponskill.OMNISCIENCE,
    numRequired    = 300,

    rewardItem =
    {
        itemId       = xi.item.TUPSIMATI,
        itemAugments =
        {
            [1] = { 740, 12 }, -- DMG:+13
        },
    },
}

------------------
-- Gastraphetes
-- First trial: https://www.bg-wiki.com/ffxi/Trial_1084
------------------
xi.item.GASTRAPHETES = 19001
xi.magian.trials[1084] =
{
    previousTrial = 0,
    requiredItem  =
    {
        itemId = xi.item.GASTRAPHETES,
    },

    textOffset     = 411,
    defeatMob      = false,
    mobEcosystem   = xi.ecosystem.BIRD,
    useWeaponskill = xi.weaponskill.TRUEFLIGHT,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.GASTRAPHETES,
        itemAugments =
        {
            [1] = { 740, 0 }, -- DMG:+1
        },
    },
}

xi.magian.trials[1085] =
{
    previousTrial = 1084,
    requiredItem  =
    {
        itemId       = xi.item.GASTRAPHETES,
        itemAugments =
        {
            [1] = { 740, 0 }, -- DMG:+1
        },
    },

    textOffset     = 412,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.AMORPH,
    useWeaponskill = xi.weaponskill.TRUEFLIGHT,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.GASTRAPHETES,
        itemAugments =
        {
            [1] = { 740, 1 }, -- DMG:+2
        },
    },
}

xi.magian.trials[1880] =
{
    previousTrial = 1085,
    requiredItem  =
    {
        itemId       = xi.item.GASTRAPHETES,
        itemAugments =
        {
            [1] = { 740, 1 }, -- DMG:+2
        },
    },

    textOffset     = 714,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.DRAGON,
    useWeaponskill = xi.weaponskill.TRUEFLIGHT,
    numRequired    = 300,

    rewardItem =
    {
        itemId       = xi.item.GASTRAPHETES,
        itemAugments =
        {
            [1] = { 740, 2 }, -- DMG:+3
        },
    },
}

------------------
-- Death Penalty
-- First trial: https://www.bg-wiki.com/ffxi/Trial_1087
------------------
xi.item.DEATH_PENALTY = 19007
xi.magian.trials[1087] =
{
    previousTrial = 0,
    requiredItem  =
    {
        itemId = xi.item.DEATH_PENALTY,
    },

    textOffset     = 413,
    defeatMob      = false,
    mobEcosystem   = xi.ecosystem.AQUAN,
    useWeaponskill = xi.weaponskill.LEADEN_SALUTE,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.DEATH_PENALTY,
        itemAugments =
        {
            [1] = { 740, 1 }, -- DMG:+2
        },
    },
}

xi.magian.trials[1088] =
{
    previousTrial = 1087,
    requiredItem  =
    {
        itemId       = xi.item.DEATH_PENALTY,
        itemAugments =
        {
            [1] = { 740, 1 }, -- DMG:+2
        },
    },

    textOffset     = 414,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.DRAGON,
    useWeaponskill = xi.weaponskill.LEADEN_SALUTE,
    numRequired    = 200,

    rewardItem =
    {
        itemId       = xi.item.DEATH_PENALTY,
        itemAugments =
        {
            [1] = { 740, 4 }, -- DMG:+5
        },
    },
}

xi.magian.trials[1882] =
{
    previousTrial = 1088,
    requiredItem  =
    {
        itemId       = xi.item.DEATH_PENALTY,
        itemAugments =
        {
            [1] = { 740, 4 }, -- DMG:+5
        },
    },

    textOffset     = 716,
    defeatMob      = true,
    mobEcosystem   = xi.ecosystem.UNDEAD,
    useWeaponskill = xi.weaponskill.LEADEN_SALUTE,
    numRequired    = 300,

    rewardItem =
    {
        itemId       = xi.item.DEATH_PENALTY,
        itemAugments =
        {
            [1] = { 740, 6 }, -- DMG:+7
        },
    },
}

-- Disable some magian trials to block players from screwing themselves
xi.magian.trials[1819] = nil -- Mandau (80)
xi.magian.trials[1827] = nil -- Spharai (80)
xi.magian.trials[1833] = nil -- Excalibur (80)
xi.magian.trials[1841] = nil -- Ragnarok (80)
xi.magian.trials[1843] = nil -- Guttler (80)
xi.magian.trials[1847] = nil -- Bravura (80)
xi.magian.trials[1851] = nil -- Gungnir (80)
xi.magian.trials[1855] = nil -- Apocalypse (80)
xi.magian.trials[1859] = nil -- Kikoku (80)
xi.magian.trials[1863] = nil -- Amanomurakumo (80)
xi.magian.trials[1867] = nil -- Mjollnir (80)
xi.magian.trials[1871] = nil -- Claustrum (80)
xi.magian.trials[1879] = nil -- Annihilator (80)
xi.magian.trials[1885] = nil -- Yoichinoyumi (80)
xi.magian.trials[2713] = nil -- Gjallarhorn (80)
xi.magian.trials[4401] = nil -- Aegis (80)

return m
