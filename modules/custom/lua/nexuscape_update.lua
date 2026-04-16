-----------------------------------
require("modules/module_utils")
-----------------------------------

local m = Module:new("nexuscape_update")
-----------------------------------------------------------------------------------
--- adjust nexus cape---------------------------------------------
-----------------------------------------------------------------------------------

m:addOverride("xi.items.nexus_cape.onItemCheck", function(target)
    -- Guard against null target from equip/unequip checks
    if target == nil then
        return 0 
    end

    local function player_hate()
        local party = target:getParty()
        if party then
            for _, partyMember in pairs(party) do
                 if partyMember:hasEnmity() then
                    return true
                 end
            end
        end
        return false
    end

    local result = xi.msg.basic.ITEM_UNABLE_TO_USE
    local leader = target:getPartyLeader()

    if leader ~= nil then
        if leader:hasStatusEffect(xi.effect.BATTLEFIELD) or
           player_hate() == true or
           leader:isEngaged() or
           target:getID() == leader:getID() or
           leader:getZoneID() == 222 then -- update to not allow nexus cap to transport player to Provenance
                    result = xi.msg.basic.ITEM_UNABLE_TO_USE_PARTY_LEADER
        else
                    result = 0
        end
    end

    return result
end)

m:addOverride("xi.items.nexus_cape.onItemUse", function(target)
    if target == nil then return end
    
    local leader = target:getPartyLeader()
    if leader ~= nil then
        target:setPos(leader:getXPos(), leader:getYPos(), leader:getZPos(), leader:getRotPos(), leader:getZoneID())
    end
end)

return m