-----------------------------------
-- Crystal Warrior - Prestige system
-----------------------------------
require("modules/module_utils")
-----------------------------------
local m = Module:new("enum_prestige")

local max5  = {    1,    2,    3,    4,    5 }
local max5p = { -100, -200, -300, -400, -500 }
local max12 = {    3,    5,    8,   10,   12 }
local max50 = {   10,   20,   30,   40,   50 }

omixi          = omixi or {}
omixi.prestige =
{
    [xi.job.WAR] = { xi.mod.STR,                 max5,  "STR+{}"                },
    [xi.job.MNK] = { xi.mod.HPP,                 max12, "HP +{}%"               },
    [xi.job.WHM] = { xi.mod.CURE_POTENCY_II,     max5 , "Cure Potency II +{}%"  },
    [xi.job.BLM] = { xi.mod.MATT,                max5,  "Magic. Atk. Bonus +{}" },
    [xi.job.RDM] = { xi.mod.FASTCAST,            max5,  "Fast Cast +{}%"        },
    [xi.job.THF] = { "TREASURE_HUNTER",          max5,  "Treasure Hunter +{}"   },

    [xi.job.PLD] = { xi.mod.UDMGPHYS,            max5p, "Phys. dmg. taken {}%"  },
    [xi.job.DRK] = { xi.mod.ATT,                 max12, "Attack+{}"             },
    [xi.job.BST] = { xi.mod.BEAST_KILLER,        max12, "Beast Killer +{}"      },
    [xi.job.BRD] = { xi.mod.SONG_DURATION_BONUS, max12, "Song Duration +{}%"    },
    [xi.job.RNG] = { xi.mod.RATT,                max12, "Ranged Attack+{}"      },

    [xi.job.SAM] = { xi.mod.STORETP,             max5,  "Store TP +{}"          },
    [xi.job.NIN] = { xi.mod.RACC,                max12, "Ranged Accuracy+{}"    },
    [xi.job.DRG] = { xi.mod.ACC,                 max12, "Accuracy+{}"           },
    [xi.job.SMN] = { xi.mod.MPP,                 max12, "MP +{}%"               },

    [xi.job.BLU] = { xi.mod.MACC,                max12, "Magic Accuracy +{}"    },
    [xi.job.COR] = { "EXP_GIL",                  max50, "EXP to Gil +{}%"       }, -- Handled in cw_prestige.lua
    [xi.job.PUP] = { xi.mod.DEX,                 max5,  "DEX+{}"                },

    [xi.job.DNC] = { xi.mod.EVA,                 max12, "Evasion+{}"            },
    [xi.job.SCH] = { xi.mod.INT,                 max5,  "INT+{}"                },

    [xi.job.GEO] = { xi.mod.MPHEAL,              max12, "MP Recovered healing +{}" },
    [xi.job.RUN] = { xi.mod.UDMGMAGIC,           max5p, "Magic dmg. taken {}%"     },
}

omixi.prestigeDesc = function(jobID, tier)
    if omixi.prestige[jobID][2][tier] < 0 then
        return fmt(omixi.prestige[jobID][3], math.floor(omixi.prestige[jobID][2][tier] / 100))
    else
        return fmt(omixi.prestige[jobID][3], omixi.prestige[jobID][2][tier])
    end
end

return m
