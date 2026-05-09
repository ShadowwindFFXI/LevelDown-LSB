-----------------------------------
-- Additional enum entries
-----------------------------------
local m = Module:new("enum_mod")

xi.mod.SURVEYOR = 2000 -- Reduce chance of broken HELM tools
-- from Xaver's patch PR4776, no need to set again
-- xi.mod.LATENT_SPEED_HEAD = 2001
-- xi.mod.LATENT_SPEED_BODY = 2002
-- xi.mod.LATENT_SPEED_FEET = 2003
xi.mod.FATIGUE           = 2004 -- Increase max fishing limit by percentage
xi.mod.GOLD_ARROW        = 2005 -- Increase % chance of gold arrows appearing during fishing
xi.mod.EXCAVATION_RESULT = 2006 -- Decreases break rate in Excavation


-- Populate lookup table for mod names
xi.modID = {}

for modName, modID in pairs(xi.mod) do
    xi.modID[modID] = modName
end

xi.itemFlagID =
{
    [1]  = "WALLHANGING",
    [2]  = "UNKNOWN",
    [3]  = "MYSTERY_BOX",
    [4]  = "MOG_GARDEN",
    [5]  = "MAIL2ACCOUNT",
    [6]  = "INSCRIBABLE",
    [7]  = "NOAUCTION",
    [8]  = "SCROLL",
    [9]  = "LINKSHELL",
    [10] = "CANUSE",
    [11] = "CANTRADENPC",
    [12] = "CANEQUIP",
    [13] = "NOSALE",
    [14] = "NODELIVERY",
    [15] = "EX",
    [16] = "RARE",
}

return m
