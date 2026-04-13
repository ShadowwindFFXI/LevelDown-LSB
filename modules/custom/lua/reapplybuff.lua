
-----------------------------------
require("modules/module_utils")
-----------------------------------
local m = Module:new("reapplybuff")


m:addOverride("xi.effects.dedication.onEffectTick", function(target,effect)
super(target,effect)

if target:getCharVar('BuffJob') ~= target:getMainJob() then
   target:setCharVar('Buff',0)
   target:setCharVar('BuffJob',0)
   target:setCharVar('BuffLvl',0)
   target:delStatusEffect(xi.effect.DEDICATION)

local power        = 50
local regainPower  = 25
local refreshPower = 10
local regenPower   = 10
            local jobNameByNum = {}
                for k, v in pairs(xi.job) do
                    jobNameByNum[v] = k
                end
   if target:getCharVar('[ParagonQuest]'..jobNameByNum[target:getMainJob()]) == 10 then
      power        = 35
      regainPower  = 25
      refreshPower = 10
      regenPower   = 10
   elseif target:getCharVar('[ParagonQuest]'..jobNameByNum[target:getMainJob()]) == 20 then
      power        = 25
      regainPower  = 15
      refreshPower = 7
      regenPower   = 7
   elseif target:getCharVar('[ParagonQuest]'..jobNameByNum[target:getMainJob()]) == 30 then
      power        = 15
      regainPower  = 7
      refreshPower = 3
      regenPower   = 3
   end
    -- Remove bonus mods..
    target:delMod(xi.mod.ATT, power)
    target:delMod(xi.mod.RACC, power)
    target:delMod(xi.mod.RATT, power)
    target:delMod(xi.mod.ACC, power)
    target:delMod(xi.mod.MATT, power)
    target:delMod(xi.mod.MACC, power)
    target:delMod(xi.mod.RDEF, power)
    target:delMod(xi.mod.DEF, power)
    target:delMod(xi.mod.MDEF, power)
end
end)


m:addOverride("xi.effects.dedication.onEffectLose", function(target,effect)
super(target,effect)
if target:getCharVar('Buff') == 1 then
   local expPower = 500
   local jobNameByNum = {}
   for k, v in pairs(xi.job) do jobNameByNum[v] = k end
   local paragon = target:getCharVar('[ParagonQuest]'..jobNameByNum[target:getMainJob()])
   if paragon == 10 then expPower = 350
   elseif paragon == 20 then expPower = 250
   elseif paragon == 30 then expPower = 100 end

   target:addStatusEffect(xi.effect.DEDICATION, {power = expPower, tick = 3, duration = 0, origin = target, subPower = 30000}) -- max 30000 or server crash
   target:printToPlayer('===>>> !Buff Reapplied Automatically', xi.msg.channel.SYSTEM_3)
end
end)

m:addOverride("xi.effects.commitment.onEffectLose", function(target,effect)
super(target,effect)
if target:getCharVar('Buff') == 2 then
   target:addStatusEffect(xi.effect.COMMITMENT, { power = 200, duration = 0, origin = target, subPower = 30000}) -- max 30000 or server crash
   target:printToPlayer('===>>> !Buff Reapplied Automatically', xi.msg.channel.SYSTEM_3)
end
end)


return m
