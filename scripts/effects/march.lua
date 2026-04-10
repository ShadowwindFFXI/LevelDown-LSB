-----------------------------------
-- xi.effect.MARCH
-- getPower returns the TIER (e.g. 1, 2, 3, 4)
-- DO NOT ALTER ANY OF THE EFFECT VALUES! DO NOT ALTER EFFECT POWER!
-- TODO: Find a better way of doing this. Need to account for varying modifiers + CASTER's skill (not target)
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local power = effect:getPower()
    local subPower = effect:getSubPower()
    local isHonorMarch = false

    if subPower == xi.magic.spell.HONOR_MARCH then
        isHonorMarch = true
        subPower = 0 -- Prevent adding the spell ID as a DEX stat
    end

    target:addMod(xi.mod.HASTE_MAGIC, power)

    target:addMod(xi.mod.DEX, subPower) -- Apply Stat Buff from AUGMENT_SONG_STAT

    -- Honor March grants bonus Accuracy and Attack
    if isHonorMarch then
        local original_power = math.ceil((power * 1024) / 10000)
        local att = math.floor(original_power * 4 / 3)
        local acc = math.floor(original_power / 3)
        target:addMod(xi.mod.ATT, att)
        target:addMod(xi.mod.RATT, att)
        target:addMod(xi.mod.ACC, acc)
        target:addMod(xi.mod.RACC, acc)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local power = effect:getPower()
    local subPower = effect:getSubPower()
    local isHonorMarch = false

    if subPower == xi.magic.spell.HONOR_MARCH then
        isHonorMarch = true
        subPower = 0
    end

    target:delMod(xi.mod.HASTE_MAGIC, power)

    target:delMod(xi.mod.DEX, subPower) -- Remove Stat Buff from AUGMENT_SONG_STAT

    if isHonorMarch then
        local original_power = math.ceil((power * 1024) / 10000)
        local att = math.floor(original_power * 4 / 3)
        local acc = math.floor(original_power / 3)
        target:delMod(xi.mod.ATT, att)
        target:delMod(xi.mod.RATT, att)
        target:delMod(xi.mod.ACC, acc)
        target:delMod(xi.mod.RACC, acc)
    end
end

return effectObject
