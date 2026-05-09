-----------------------------------
-- Mob Util
-----------------------------------
require("modules/module_utils")
-----------------------------------
local m = Module:new("base_mob_util")

omixi          = omixi or {}
omixi.mob_util = omixi.mob_util or {}

-- Mob will ignore pets and focus master (Pet enmity is transferred)
omixi.mob_util.ignorePet = function(mob, target)
    if
        target ~= nil and
        target:getObjType() == xi.objType.PET
    then
        local master = target:getMaster()

        if master ~= nil then
            mob:addEnmity(master, mob:getCE(target), mob:getVE(target))
            mob:resetEnmity(target)
        end
    end
end

omixi.mob_util.wsPenalty = function(mob)
    mob:addListener("WEAPONSKILL_TAKE", "WS_PENALTY", function(mobArg, user, wsid)
        if wsid == 226 then -- Requiescat
            mob:setTP(1000)
        end
    end)
end

return m
