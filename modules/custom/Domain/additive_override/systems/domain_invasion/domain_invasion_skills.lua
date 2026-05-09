-----------------------------------
-- Domain Invasion Skills
-----------------------------------
require("modules/module_utils")
require("scripts/globals/mobskills")
require("scripts/utils/utils")
-----------------------------------
local m = Module:new("domain_invasion_skills")

local skills =
{
    ["aquatic_lance"] = function(target, mob, skill)
        local power = math.random(225, 425)
        local info = xi.mobskills.mobBreathMove(mob, target, skill, 0.2, 1.25, xi.element.WATER, power)
        info.dmg = utils.conalDamageAdjustment(mob, target, skill, info.dmg, 0.9)

        local dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WATER)
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.MAGIC_DEF_DOWN, 30, 0, 60)
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, 30, 0, 60)
        return dmg
    end,

    ["aqua_fortis"] = function(target, mob, skill)
        local typeEffect = xi.effect.POISON
        local power = mob:getMainLvl() / 8 + 10

        xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 3, 60)

        local dmgmod   = 1
        local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 1.8, xi.element.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
        local dmg      = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
        return dmg
    end,

    ["barreling_smash"] = function(target, mob, skill)
        local currentHP = target:getHP()
        local damage = 0

        if currentHP / target:getMaxHP() > 0.2 then
            damage = currentHP * .95
        else
            damage = currentHP
        end

        local info = { dmg = damage, hitslanded = 1 }
        local dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
        mob:resetEnmity(target)
        return dmg
    end,

    ["batholithic_shell"] = function(target, mob, skill)
        local duration = math.random(30, 60)

        xi.mobskills.mobBuffMove(mob, xi.effect.BLAZE_SPIKES, math.random(1, 10), 0, duration)
        xi.mobskills.mobBuffMove(mob, xi.effect.STONESKIN, math.random(1000, 1500), 0, duration)
        xi.mobskills.mobBuffMove(mob, xi.effect.HASTE, 2500, 0, duration)
        xi.mobskills.mobBuffMove(mob, xi.effect.ATTACK_BOOST, 15, 0, duration)
        xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_ATK_BOOST, 20, 0, duration)
        skill:setMsg(xi.msg.basic.NONE)
        return 0
    end,

    ["biting_abrogation"] = function(target, mob, skill)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 50, 0, math.random(15, 30))

        local dmgmod    = 1
        local info  = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 5, xi.element.ICE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
        local dmg       = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
        local dispelled = math.random(2, 4)

        for i = 1, dispelled do
            target:dispelStatusEffect()
        end

        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
        return dmg
    end,

    ["blistering_roar"] = function(target, mob, skill)
        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, 1, 1, 2, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
        local dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_3)
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.TERROR, 1, 0, 3)
        xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, 100, 0, 60)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
        mob:resetEnmity(target)
        return dmg
    end,

    ["brain_freeze"] = function(target, mob, skill)
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.INT_DOWN, 30, 0, 60)
        local power = math.random(225, 325)
        local info = xi.mobskills.mobBreathMove(mob, target, skill, 0.25, 2.5, xi.element.ICE, power)
        local dmg    = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.BREATH, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.ICE)
        return dmg
    end,

    ["brownout"] = function(target, mob, skill)
        local power = math.random(225, 425)
        local duration = math.random(15, 30)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 25, 0, duration)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 1250, 0, duration)

        local info = xi.mobskills.mobBreathMove(mob, target, skill, 0.25, 2.5, xi.element.THUNDER, power)
        local dmg    = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.BREATH, xi.damageType.THUNDER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.THUNDER)
        return dmg
    end,

    ["canopierce"] = function(target, mob, skill)
        local typeEffect = xi.effect.RASP

        xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 10, 0, math.random(15, 30))

        local dmgmod   = 1.5
        local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 5, xi.element.EARTH, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
        local dmg      = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
        return dmg
    end,

    ["cranial_thrust"] = function(target, mob, skill)
        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, 1, 1, 2.0, 0)
        local dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.MAX_HP_DOWN, 25, 0, 60)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
        return dmg
    end,

    ["crashing_thunder"] = function(target, mob, skill)
        local dmgmod   = 1
        local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.element.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
        local dmg      = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.THUNDER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 2)
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.THUNDER)
        return dmg
    end,

    ["crushing_gaze"] = function(target, mob, skill)
        local power = math.random(225, 325)
        local duration = math.random(15, 30)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 25, 0, duration)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 1250, 0, duration)

        local info = xi.mobskills.mobBreathMove(mob, target, skill, 0.25, 2.5, xi.element.EARTH, power)
        local dmg    = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.BREATH, xi.damageType.EARTH, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.EARTH)
        return dmg
    end,

    ["droning_whirlwind"] = function(target, mob, skill)
        local dmgmod = .5
        local info  = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 9, xi.element.WIND, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
        local dmg       = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
        local dispelled = math.random(2, 3)

        for i = 1, dispelled do
            target:dispelStatusEffect()
        end

        xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_DEF_BOOST, 30, 0, 60)
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
        return dmg
    end,

    ["embalming_earth"] = function(target, mob, skill)
        local dmgmod   = 1
        local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 5, xi.element.EARTH, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
        local dmg      = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 3000, 0, 120)
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
        return dmg
    end,

    ["firefly_fandango"] = function(target, mob, skill)
        local dmgmod   = 2
        local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.element.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
        local dmg      = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 50, 0, 15)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.FLASH, 200, 3, 3)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAX_MP_DOWN, 42, 0, 120)

        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
        return dmg
    end,

    ["foul_breath"] = function(target, mob, skill)
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DISEASE, 1, 0, math.random(15, 30))
        local power = math.random(175, 225)
        local info = xi.mobskills.mobBreathMove(mob, target, skill, 0.25, 2.5, xi.element.FIRE, power)
        local dmg    = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.BREATH, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.FIRE)
        return dmg
    end,

    ["glacial_tomb"] = function(target, mob, skill)
        local typeEffect = xi.effect.ENCUMBRANCE_I
        local duration = math.random(5, 15)

        xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 0xFFFF, 0, duration)

        local dmgmod     = 1.75
        local baseDamage = mob:getWeaponDmg() * 3.7
        local info   = xi.mobskills.mobMagicalMove(mob, target, skill, baseDamage, xi.element.ICE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
        local dmg        = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
        return dmg
    end,

    ["glassy_nova"] = function(target, mob, skill)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.FROST, 15, 3, 120)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STR_DOWN, 20, 3, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.VIT_DOWN, 20, 3, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEX_DOWN, 20, 3, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.AGI_DOWN, 20, 3, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MND_DOWN, 20, 3, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.INT_DOWN, 20, 3, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CHR_DOWN, 20, 3, 60)

        local dmgmod    = 1
        local info  = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 5, xi.element.ICE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
        local dmg       = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
        local dispelled = math.random(2, 3)

        if dmg > 0 then
            for i = 1, dispelled do
                target:dispelStatusEffect()
            end
        end

        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
        return dmg
    end,

    ["gnash"] = function(target, mob, skill)
        local currentHP = target:getHP()
        local damage = 0

        if currentHP / target:getMaxHP() > 0.2 then
            damage = currentHP * .50
        else
            damage = currentHP
        end

        local info = { dmg = damage, hitslanded = 1 }
        local dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
        return dmg
    end,

    ["hypnic_lamp"] = function(target, mob, skill)
        local typeEffect = xi.effect.SLEEP_I
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, math.random(15, 20)))
        return typeEffect
    end,

    ["impenetrable_carapace"] = function(target, mob, skill)
        xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_DEF_BOOST, 30, 0, 90)
        skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, 30, 0, 90))
        return xi.effect.DEFENSE_BOOST
    end,

    ["incinerating_lahar"] = function(target, mob, skill)
        local typeEffect = xi.effect.WEAKNESS

        local dmgmod   = 1.5
        local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.6, xi.element.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
        local dmg      = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, math.random(3, 5))

        return dmg
    end,

    ["incisive_apotheosis"] =
    {
        onMobSkillCheck = function(target, mob, skill)
            local mobhp = mob:getHPP()
            if mobhp < 26 or mob:getLocalVar("aura") == 0 then
                return 0
            else
                return 1
            end
        end,

        onMobWeaponSkill = function(target, mob, skill)
            local typeEffect = xi.effect.WEAKNESS
            skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, math.random(5, 10)))
            mob:resetEnmity(target)
            return typeEffect
        end,
    },

    ["incisive_denouement"] =
    {
        onMobSkillCheck = function(target, mob, skill)
            if mob:getHPP() < 50 then
                return 0
            else
                return 1
            end
        end,

        onMobWeaponSkill = function(target, mob, skill)
            local info = xi.mobskills.mobPhysicalMove(mob, target, skill, 1, 1, 4.5, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1, 1, 1)
            local dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

            mob:resetEnmity(target)
            target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
            return dmg
        end,
    },

    ["mandibular_lashing"] = function(target, mob, skill)
        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, 1, 1, 3.5, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
        local dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
        local typeEffectOne = xi.effect.STUN
        local typeEffectTwo = xi.effect.POISON

        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffectOne, 1, 0, math.random(1, 3))
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffectTwo, math.random(5, 15), 0, math.random(15, 30))
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)

        return dmg
    end,

    ["marine_mayhem"] = function(target, mob, skill)
        local typeEffectOne = xi.effect.DROWN
        local typeEffectTwo = xi.effect.ATTACK_DOWN
        local duration = math.random(15, 45)

        xi.mobskills.mobStatusEffectMove(mob, target, typeEffectOne, math.random(5, 15), 0, duration)
        xi.mobskills.mobStatusEffectMove(mob, target, typeEffectTwo, math.random(15, 25), 0, duration)

        local dmgmod     = 1
        local baseDamage = mob:getWeaponDmg() * 4.2
        local info   = xi.mobskills.mobMagicalMove(mob, target, skill, baseDamage, xi.element.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
        local dmg        = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
        return dmg
    end,

    ["molting_plumage"] = function(target, mob, skill)
        local power = math.random(225, 425)
        local info = xi.mobskills.mobBreathMove(mob, target, skill, 0.2, 1.25, xi.element.WIND, power)
        info.dmg = utils.conalDamageAdjustment(mob, target, skill, info.dmg, 0.9)

        local dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.BREATH, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
        local dispelled = math.random(2, 3)

        if dmg > 0 then
            for i = 1, dispelled do
                target:dispelStatusEffect()
            end
        end

        target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WIND)
        return dmg
    end,

    ["nectarous_deluge"] = function(target, mob, skill)
        local power = math.random(225, 325)
        local duration = math.random(15, 30)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, math.random(10, 20), 0, duration)

        local info = xi.mobskills.mobBreathMove(mob, target, skill, 0.25, 2.5, xi.element.WATER, power)
        local dmg    = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

        target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WATER)
        return dmg
    end,

    ["nepenthic_plunge"] = function(target, mob, skill)
        local power = math.random(225, 325)
        local duration = math.random(15, 30)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 25, 0, duration)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DROWN, math.random(10, 20), 0, duration)

        local info = xi.mobskills.mobBreathMove(mob, target, skill, 0.25, 2.5, xi.element.WATER, power)
        local dmg    = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

        target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WATER)
        return dmg
    end,

    ["pelagic_cleaver"] = function(target, mob, skill)
        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, 1, 1, 2.0, 0, 1, 1, 1)
        local dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.MAX_HP_DOWN, 25, 0, 60)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
        return dmg
    end,

    ["pentapeck"] = function(target, mob, skill)
        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, 3, 1, 0.8, 0, 1, 1, 1)
        local dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
        
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.AMNESIA, 1, 0, 60)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
        return dmg
    end,

    ["permafrost_requiem"] = function(target, mob, skill)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.TERROR, 1, 0, math.random(3, 5))

        local dmgmod   = 1
        local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 5, xi.element.ICE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
        local dmg      = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
        return dmg
    end,

    ["polar_roar"] = function(target, mob, skill)
        local dmgmod   = 1
        local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.element.ICE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
        local dmg      = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 15, 0, math.random(5, 10))
        return dmg
    end,

    ["potted_plant"] = function(target, mob, skill)
        local dmgmod   = .5
        local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 9, xi.element.EARTH, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
        local dmg      = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 15, 0, 5)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 1250, 0, 30)
        return dmg
    end,

    ["protolithic_puncture"] = function(target, mob, skill)
        local currentHP = target:getHP()
        local damage = 0

        if currentHP / target:getMaxHP() > 0.2 then
            damage = currentHP * .50
        else
            damage = currentHP
        end

        local info = { dmg = damage, hitslanded = 1 }
        local dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
        mob:resetEnmity(target)
        return dmg
    end,

    ["pyroclastic_surge"] = function(target, mob, skill)
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.ADDLE, 50, 3, 30)

        local dmgmod   = 2
        local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.6, xi.element.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
        local dmg      = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)

        return dmg
    end,

    ["rending_deluge"] = function(target, mob, skill)
        local dmgmod   = 1
        local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.5, xi.element.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
        local dmg      = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

        target:dispelStatusEffect()
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
        return dmg
    end,

    ["retinal_glare"] = function(target, mob, skill)
        local power = math.random(225, 325)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.FLASH, 200, 0, math.random(3, 5))

        local info = xi.mobskills.mobBreathMove(mob, target, skill, 0.25, 2.5, xi.element.LIGHT, power)
        local dmg    = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.BREATH, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

        target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.LIGHT)
        return dmg
    end,

    ["reverse_current"] = function(target, mob, skill)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 3)

        local dmgmod   = 1
        local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 6, xi.element.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
        local dmg      = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.THUNDER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.THUNDER)
        return dmg
    end,

    ["reverberating_cry"] = function(target, mob, skill)
        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, 1, 1, 4, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
        local dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)

        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.MAGIC_DEF_DOWN, 30, 0, 60)
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, 30, 0, 60)
        return dmg
    end,

    ["riptide_eupnea"] = function(target, mob, skill)
        local duration = 120

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAX_HP_DOWN, 15, 0, duration)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ENCUMBRANCE_I, 0xFFFF, 0, duration)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 15, 0, duration)

        local dmgmod     = 1
        local info   = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4.2, xi.element.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
        local dmg        = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
        return dmg
    end,

    ["root_of_the_problem"] = function(target, mob, skill)
        local effectFirst = mob:stealStatusEffect(target, xi.effectFlag.DISPELABLE)
        local effectSecond = mob:stealStatusEffect(target, xi.effectFlag.DISPELABLE)
        local dmg = 0
        target:setTP(target:getTP() * 0.5)
        
        if effectFirst ~= 0 then
            local count = 1
            if effectSecond ~= 0 then count = count + 1 end
            skill:setMsg(xi.msg.basic.EFFECT_DRAINED)
            return count
        else
            local power = math.random(400, 650)
            local info = { dmg = power, hitslanded = 1 }
            dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

            skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))
            return dmg
        end
    end,

    ["scalding_breath"] = function(target, mob, skill)
        local dmgmod   = 1
        local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 9, xi.element.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
        local dmg      = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BURN, 30, 3, 60)
        return dmg
    end,

    ["searing_serration"] = function(target, mob, skill)
        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, 4, 1, 0.6, 0, 1, 1, 1)
        local dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
        return dmg
    end,

    ["seaspray"] = function(target, mob, skill)
        local power = math.random(225, 325)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 1250, 0, math.random(15, 30))

        local info = xi.mobskills.mobBreathMove(mob, target, skill, 0.25, 2.5, xi.element.WATER, power)
        local dmg    = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WATER)
        return dmg
    end,

    ["seismic_tail"] = function(target, mob, skill)
        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, 1, 1, 1.5, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1, 2, 3)
        local dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
        return dmg
    end,

    ["sparkstorm"] = function(target, mob, skill)
        local dmgmod   = 3
        local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.6, xi.element.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
        local dmg      = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.THUNDER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.THUNDER)
        return dmg
    end,

    ["static_prison"] = function(target, mob, skill)
        local dmgmod   = .6
        local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 9, xi.element.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
        local dmg      = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.THUNDER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.THUNDER)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, math.random(1, 3))
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SHOCK, 15, 3, 30)

        return dmg
    end,

    ["stinger_volley"] = function(target, mob, skill)
        local power = math.random(225, 325)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CURSE_II, 1, 0, math.random(5, 10))
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 50, 0, 60)

        local info = xi.mobskills.mobBreathMove(mob, target, skill, 0.25, 2.5, xi.element.WIND, power)
        local dmg    = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.BREATH, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WIND)
        return dmg
    end,

    ["stink_bomb"] = function(target, mob, skill)
        local duration = math.random(15, 30)
        local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 9, xi.element.EARTH, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
        local dmg      = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 30, 0, duration)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 30, 0, duration)
        return dmg
    end,

    ["sundering_snip"] = function(target, mob, skill)
        local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.6, xi.element.WATER, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
        local dmg      = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
        return dmg
    end,

    ["sweeping_gouge"] = function(target, mob, skill)
        local info     = xi.mobskills.mobPhysicalMove(mob, target, skill, 1, 1, 2, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
        local dmg      = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, 25, 0, 120)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
        return dmg
    end,

    ["swooping_frenzy"] = function(target, mob, skill)
        local power = math.random(225, 325)
        local info = xi.mobskills.mobBreathMove(mob, target, skill, 0.2, 1.25, xi.element.WIND, power)
        info.dmg = utils.conalDamageAdjustment(mob, target, skill, info.dmg, 0.9)

        local dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.BREATH, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAGIC_DEF_DOWN, 20, 0, 60)
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, 30, 0, 60)
        target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WIND)
        return dmg
    end,

    ["sylvan_slumber"] = function(target, mob, skill)
        local typeEffect = xi.effect.SLEEP_I
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, math.random(20, 30)))
        return typeEffect
    end,

    ["tail_thwack"] = function(target, mob, skill)
        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, 2, 1, 1.5, 0, 1, 1, 1)
        local dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, 30, 0, 60)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
        return dmg
    end,

    ["tickling_tendrils"] = function(target, mob, skill)
        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, 5, 1, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.2, 1.5)
        local dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, math.random(1, 3))
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
        return dmg
    end,

    ["tidal_guillotine"] = function(target, mob, skill)
        local currentHP = target:getHP()
        local baseDamage = 0

        if currentHP / target:getMaxHP() > 0.2 then
            baseDamage = currentHP * .50
        else
            baseDamage = currentHP
        end

        local info = { dmg = baseDamage, hitslanded = 1 }
        
        local damage = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

        target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
        return damage
    end,

    ["tiiimbeeer"] = function(target, mob, skill)
        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, 1, 10, 3, 0, 1, 1, 1)
        local dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 15, 0, 30)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CURSE_I, 25, 0, 20)
        return dmg
    end,

    ["torpefying_charge"] = function(target, mob, skill)
        local typeEffect = xi.effect.PARALYSIS
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 35, 0, 25))
        return typeEffect
    end,

    ["tyrannical_blow"] = function(target, mob, skill)
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PLAGUE, 5, 3, 20)

        local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.element.FIRE, 1.5, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
        local dmg      = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
        if target:hasStatusEffect(xi.effect.ELEMENTALRES_DOWN) then
            target:delStatusEffectSilent(xi.effect.ELEMENTALRES_DOWN)
        end

        return dmg
    end,

    ["uproot"] = function(target, mob, skill)
        local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.6, xi.element.LIGHT, 3, xi.mobskills.magicalTpBonus.NO_EFFECT)
        local dmg      = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
        return dmg
    end,

    ["vespine_hurricane"] = function(target, mob, skill)
        local power = math.random(225, 325)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAGIC_DEF_DOWN, 20, 0, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ATTACK_DOWN, 25, 0, 60)

        local info = xi.mobskills.mobBreathMove(mob, target, skill, 0.25, 2.5, xi.element.WIND, power)
        local dmg    = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.BREATH, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WIND)
        return dmg
    end,

    ["vile_belch"] = function(target, mob, skill)
        local duration = math.random(15, 30)
        local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 9, xi.element.WATER, .6, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
        local dmg      = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, duration)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 5, 3, duration)

        return dmg
    end,

    ["viscid_spindrift"] = function(target, mob, skill)
        local duration = 30
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ATTACK_DOWN, 15, 0, duration)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAGIC_ACC_DOWN, 15, 0, duration)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 15, 0, duration)

        local info   = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4.2, xi.element.WATER, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
        local dmg        = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
        return dmg
    end,

    ["volcanic_stasis"] = function(target, mob, skill)
        local power = math.random(225, 425)
        local info = xi.mobskills.mobBreathMove(mob, target, skill, 0.2, 1.25, xi.element.FIRE, power)
        info.dmg = utils.conalDamageAdjustment(mob, target, skill, info.dmg, 0.9)

        local dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.BREATH, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
        local dispelled = math.random(2, 3)

        if dmg > 0 then
            for i = 1, dispelled do
                target:dispelStatusEffect()
            end
        end

        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 3)
        target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.FIRE)
        return dmg
    end,

    ["zealous_snort"] = function(target, mob, skill)
        xi.mobskills.mobBuffMove(mob, xi.effect.HASTE, 2500, 0, 60)
        xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_DEF_BOOST, 30, 0, 60)
        xi.mobskills.mobBuffMove(mob, xi.effect.COUNTERSTANCE, 10, 0, 60)
        skill:setMsg(xi.msg.basic.NONE)
        return 0
    end,

    ["atropine_spore"] = function(target, mob, skill)
        local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 5, xi.element.DARK, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
        local dmg      = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, math.random(15, 30))
        return dmg
    end,

    ["night_stalker"] = function(target, mob, skill)
        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, 1, 1, 1, 0, 1, 1, 1)
        local dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
        
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BIO, 15, 3, math.random(20, 40))
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
        target:setTP(0)
        return dmg
    end,

    ["deracinator"] = function(target, mob, skill)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 18, 0, math.random(10, 15))
        local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.element.DARK, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
        local dmg      = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
        return dmg
    end,

    ["full_bloom"] = function(target, mob, skill)
        skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.STONESKIN, math.random(1000, 2000), 0, 300))
        return xi.effect.STONESKIN
    end,
}

--  for skillName, skillFunc in pairs(skills) do
--      local skillPath = string.format("xi.actions.mobskills.%s", skillName)
--      xi.module.ensureTable(skillPath)
--  
--      if type(skillFunc) == "table" then
--          m:addOverride(skillPath .. ".onMobWeaponSkill", skillFunc.onMobWeaponSkill)
--          m:addOverride(skillPath .. ".onMobSkillCheck",  skillFunc.onMobSkillCheck)
--  
--      else
--          m:addOverride(skillPath .. ".onMobWeaponSkill", skillFunc)
--          m:addOverride(skillPath .. ".onMobSkillCheck", function(target, mob, skill)
--              return 0
--          end)
--      end
--  end

return m