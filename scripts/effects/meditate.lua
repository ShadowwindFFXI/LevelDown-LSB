-----------------------------------
-- xi.effect.MEDITATE
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local gain   = effect:getPower()
    local isMain = target:getMainJob() == xi.job.SAM
    local cap    = (isMain and 1000 or 600) * 10

    local tp = target:getTP()
    local newTP = math.min(tp + gain, cap)

    target:setTP(newTP)
end

effectObject.onEffectTick = function(target, effect)
    local tp     = target:getTP()
    local gain   = effect:getPower()      -- already scaled
    local isMain = target:getMainJob() == xi.job.SAM
    local cap    = (isMain and 1000 or 600) * 10

    if tp >= cap then
        target:delStatusEffect(xi.effect.MEDITATE)
        return
    end

    local newTP = math.min(tp + gain, cap)
    target:setTP(newTP)
end

effectObject.onEffectLose = function(target, effect)

end

return effectObject
