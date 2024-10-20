-----------------------------------
-- Area: Abyssea - Tahrongi
--  NPC: Cruor Prospector
-- Type: Cruor NPC
-- !pos 132.000 -75.856 -822.000 15
-----------------------------------
---@type TNpcEntity
local entity = {}

local itemType = xi.abyssea.itemType
---@type TProspectorItems
local prospectorItems =
{
    [itemType.ITEM] = xi.abyssea.visionsCruorProspectorItems,

    [itemType.TEMP] = xi.abyssea.visionsCruorProspectorTemps,

    [itemType.KEYITEM] =
    {
    --  Sel     Item                                Cost
        [1] = { xi.ki.MAP_OF_ABYSSEA_TAHRONGI,      3500 },
        [2] = { xi.ki.IVORY_ABYSSITE_OF_SOJOURN,    6000 },
        [3] = { xi.ki.IVORY_ABYSSITE_OF_CONFLUENCE, 4800 },
        [4] = { xi.ki.IVORY_ABYSSITE_OF_EXPERTISE,  4800 },
        [7] = { xi.ki.CLEAR_DEMILUNE_ABYSSITE,       300 },
    },

    [itemType.ENHANCEMENT] = xi.abyssea.visionsCruorProspectorBuffs,
}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.abyssea.visionsCruorProspectorOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.visionsCruorProspectorOnEventFinish(player, csid, option, prospectorItems)
end

return entity
