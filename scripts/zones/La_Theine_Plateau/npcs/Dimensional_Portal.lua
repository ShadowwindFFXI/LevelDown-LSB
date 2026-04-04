-----------------------------------
-- Area: La Theine Plateau
--  NPC: Dimensional Portal
-----------------------------------
local ID = zones[xi.zone.LA_THEINE_PLATEAU]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getCurrentMission(xi.mission.log_id.COP) >= xi.mission.id.cop.THE_WARRIORS_PATH and
        player:getCurrentMission(xi.mission.log_id.ROV) >= xi.mission.id.rov.UNCERTAIN_FUTURES
    then
        player:startEvent(926, 2)
    elseif player:getCurrentMission(xi.mission.log_id.COP) >= xi.mission.id.cop.THE_WARRIORS_PATH then
        player:startEvent(915)
    else
        player:messageSpecial(ID.text.ALREADY_OBTAINED_TELE + 1) -- Telepoint Disappeared
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 915 and option == 1 then
        player:setPos(-635.599, -2.799, 163.8, 193, 33) -- To AlTaieu (R)
    elseif csid == 926 and option == 1 then
        player:setPos(-635.599, -2.799, 163.8, 193, 33) -- To AlTaieu (R)
    elseif csid == 926 and option == 2 then
        player:setPos(-500.0230, -19.0838, -487.6860, 190, 291) -- To Reisenjim F-12
    end
end

return entity
