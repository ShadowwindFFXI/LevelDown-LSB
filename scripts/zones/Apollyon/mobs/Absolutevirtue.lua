-----------------------------------
-----------------------------------
-- Area: Apollyon
--  Mob: Absolute Virtue
-----------------------------------

local absolutevirtue = {}

local debug = true
local function debugPrint(msg)
    if debug then
        print("[Absolute Virtue] " .. tostring(msg))
    end
end

local avStates = {}

local mobConfig = {
    spawn = { x = 1.0479, y = 0.0000, z = -144.4186, rot = 192 },
    
    immunities = {
        xi.immunity.SLEEP,
        xi.immunity.GRAVITY,
        xi.immunity.BIND,
        xi.immunity.STUN,
        xi.immunity.SILENCE,
        xi.immunity.PARALYZE,
        xi.immunity.BLIND,
        xi.immunity.SLOW,
        xi.immunity.POISON,
        xi.immunity.ELEGY,
        xi.immunity.REQUIEM,
    },

    av = {
        name = "Absolute Virtue",
        look = '0000620500000000000000000000000000000000',
        groupId = 56,
        groupZoneId = 33,
        hppMod = 0,
        modelSize = 5,
    }
}

local combos =
{
    [xi.jsa.CHAINSPELL    ] = {
        { xi.jsa.CHAINSPELL, xi.jsa.MANAFONT },
        { xi.jsa.CHAINSPELL, xi.jsa.SOUL_VOICE }
    },
    [xi.jsa.MIGHTY_STRIKES] = { xi.jsa.MIGHTY_STRIKES, xi.jsa.HUNDRED_FISTS },
    [xi.jsa.MEIKYO_SHISUI ] = { xi.jsa.MEIKYO_SHISUI,  xi.jsa.EES_AERN,     xi.jsa.EES_AERN,     xi.jsa.EES_AERN },
    [xi.jsa.INVINCIBLE    ] = { xi.jsa.INVINCIBLE,     xi.jsa.BENEDICTION,  xi.jsa.MIJIN_GAKURE },
    [xi.jsa.CALL_WYVERN   ] = { xi.jsa.CALL_WYVERN,    xi.jsa.FAMILIAR,     xi.jsa.ASTRAL_FLOW },
}

local playerAbilityToMobSP =
{
    [xi.ja.MIGHTY_STRIKES] = xi.jsa.MIGHTY_STRIKES,
    [xi.ja.HUNDRED_FISTS]  = xi.jsa.HUNDRED_FISTS,
    [xi.ja.BENEDICTION]    = xi.jsa.BENEDICTION,
    [xi.ja.MANAFONT]       = xi.jsa.MANAFONT,
    [xi.ja.CHAINSPELL]     = xi.jsa.CHAINSPELL,
    [xi.ja.PERFECT_DODGE]  = xi.jsa.PERFECT_DODGE,
    [xi.ja.INVINCIBLE]     = xi.jsa.INVINCIBLE,
    [xi.ja.BLOOD_WEAPON]   = xi.jsa.BLOOD_WEAPON,
    [xi.ja.FAMILIAR]       = xi.jsa.FAMILIAR,
    [xi.ja.SOUL_VOICE]     = xi.jsa.SOUL_VOICE,
    [xi.ja.EAGLE_EYE_SHOT] = xi.jsa.EES_AERN,
    [xi.ja.MEIKYO_SHISUI]  = xi.jsa.MEIKYO_SHISUI,
    [xi.ja.MIJIN_GAKURE]   = xi.jsa.MIJIN_GAKURE,
    [xi.ja.ASTRAL_FLOW]    = xi.jsa.ASTRAL_FLOW,
    [xi.ja.CALL_WYVERN]    = xi.jsa.CALL_WYVERN,
}

local function handleDamageResists(mob)
    local nextThreshold = mob:getLocalVar('dmgThreshold')
    local currentHPP    = mob:getHPP()

    -- If AV heals above his current threshold tier, reset the threshold to match his new HP
    if currentHPP > nextThreshold + 10 then
        nextThreshold = math.floor(currentHPP / 10) * 10
        mob:setLocalVar('dmgThreshold', nextThreshold)
        
        local dmg = (100 - nextThreshold) * -100
        mob:setMod(xi.mod.UDMGPHYS, dmg)
        mob:setMod(xi.mod.UDMGRANGE, dmg)
        mob:setMod(xi.mod.UDMGMAGIC, dmg)
        mob:setMod(xi.mod.UDMGBREATH, dmg)
    end

    if currentHPP <= nextThreshold then
        local dmg = (100 - currentHPP) * -100 -- This modifiers are base 10000
        mob:setMod(xi.mod.UDMGPHYS, dmg)
        mob:setMod(xi.mod.UDMGRANGE, dmg)
        mob:setMod(xi.mod.UDMGMAGIC, dmg)
        mob:setMod(xi.mod.UDMGBREATH, dmg)
        mob:setLocalVar('dmgThreshold', nextThreshold - 10)
    end
end

local function isLocked(mob, sp)
    local state = avStates[mob:getID()]
    if not state or #state.sps == 0 then return true end

    for _, jsa in ipairs(state.sps) do
        if sp == jsa then return false end
    end
    return true
end

local function lock(mob, sp)
    local state = avStates[mob:getID()]
    if not state then return end

    for i, jsa in ipairs(state.sps) do
        if jsa == sp then
            debugPrint(string.format('locked: %d', sp))
            table.remove(state.sps, i)
            break
        end
    end

    for i, jsa in ipairs(state.braceletsps) do
        if jsa == sp then
            table.remove(state.braceletsps, i)
            break
        end
    end
end

local function handleSP(mob)
    local state = avStates[mob:getID()]
    if not state then return end

    local now = os.time()
    if now > state.nextsp then
        if state.bracelets and #state.braceletsps ~= 0 then
            local trigger = state.braceletsps[math.random(1, #state.braceletsps)]
            local combo = combos[trigger]
            if trigger == xi.jsa.CHAINSPELL then
                combo = combos[xi.jsa.CHAINSPELL][math.random(1, 2)]
            end

            for _, jsa in ipairs(combo) do
                if not isLocked(mob, jsa) then
                    mob:setLocalVar(string.format('sp_%u', jsa), now)
                    debugPrint(string.format('%s using %d', mob:getName(), jsa))
                    mob:useMobAbility(jsa)

                    if jsa == xi.jsa.BENEDICTION then
                        state.beneCount = state.beneCount + 1
                        if state.beneCount >= state.beneLimit then
                            lock(mob, jsa)
                            debugPrint("Benediction limit reached! Locking Benediction.")
                        end
                    end
                end
            end
        elseif #state.sps ~= 0 then
            local sp = state.sps[math.random(1, #state.sps)]
            mob:setLocalVar(string.format('sp_%u', sp), now)
            debugPrint(string.format('%s using %d', mob:getName(), sp))
            mob:useMobAbility(sp)

            if sp == xi.jsa.BENEDICTION then
                state.beneCount = state.beneCount + 1
                if state.beneCount >= state.beneLimit then
                    lock(mob, sp)
                    debugPrint("Benediction limit reached! Locking Benediction.")
                end
            end
        end

        state.nextsp = now + math.random(45, 90)
    end
end

local function applyCustomConfig(mob)
    if mobConfig.immunities then
        for _, immunity in ipairs(mobConfig.immunities) do
            mob:addImmunity(immunity)
        end
    end
    
    mob:setMobMod(xi.mobMod.ABILITY_RESPONSE, 1)
    mob:setMobMod(xi.mobMod.AOE_HIT_ALL, 1)
end

local function applyDifficultyMods(mob, diffIndex, confId)
    if not confId or confId == 0 then return end
    local lookup = xi.confrontation.lookup[confId]
    if not lookup then return end

    local prefix = "Custom_HTBF"
    local config = xi.custom_htbf and xi.custom_htbf.configs[lookup.configIndex]
    
    if not config then return end

    local appliedVar = prefix .. "_Mods_Applied"
    if mob:getLocalVar(appliedVar) == 1 then return end
    mob:setLocalVar(appliedVar, 1)

    local diff = config.difficulties[diffIndex]
    if not diff then return end

    if diff.mobLevel then mob:setMobLevel(diff.mobLevel) end
    if diff.hppMod then
        mob:addMod(xi.mod.HPP, diff.hppMod)
        mob:updateHealth()
        mob:setHP(mob:getMaxHP())
    end

    local multiplier = diff.statModMultiplier or 1.0
    local combinedMobMods = {}
    if config.mobMods then for _, v in ipairs(config.mobMods) do table.insert(combinedMobMods, v) end end
    if diff.mobMods then for _, v in ipairs(diff.mobMods) do table.insert(combinedMobMods, v) end end

    if #combinedMobMods > 0 then
        for _, modData in ipairs(combinedMobMods) do
            local modID = modData.mod
            local targetVal = math.floor(modData.val * multiplier)

            if modData.target then
                local current = 0
                if modID == xi.mod.STR then current = mob:getStat(xi.mod.STR)
                elseif modID == xi.mod.DEX then current = mob:getStat(xi.mod.DEX)
                elseif modID == xi.mod.VIT then current = mob:getStat(xi.mod.VIT)
                elseif modID == xi.mod.AGI then current = mob:getStat(xi.mod.AGI)
                elseif modID == xi.mod.INT then current = mob:getStat(xi.mod.INT)
                elseif modID == xi.mod.MND then current = mob:getStat(xi.mod.MND)
                elseif modID == xi.mod.CHR then current = mob:getStat(xi.mod.CHR)
                elseif modID == xi.mod.ATT then current = mob:getStat(xi.mod.ATT)
                elseif modID == xi.mod.DEF then current = mob:getStat(xi.mod.DEF)
                elseif modID == xi.mod.ACC then current = mob:getMod(xi.mod.ACC)
                elseif modID == xi.mod.EVA then current = mob:getStat(xi.mod.EVA)
                elseif modID == xi.mod.RATT then current = mob:getMod(xi.mod.RATT)
                elseif modID == xi.mod.RACC then current = mob:getMod(xi.mod.RACC)
                elseif modID == xi.mod.MATT then current = mob:getMod(xi.mod.MATT)
                elseif modID == xi.mod.MACC then current = mob:getMod(xi.mod.MACC)
                elseif modID == xi.mod.MEVA then current = mob:getMod(xi.mod.MEVA)
                elseif modID == xi.mod.MDEF then current = mob:getMod(xi.mod.MDEF)
                end
                local diffVal = targetVal - current
                mob:addMod(modID, diffVal)
            elseif modData.set then
                mob:setMod(modID, targetVal)
            else
                mob:addMod(modID, targetVal)
            end
        end
    end
end

absolutevirtue.spawn = function(zone)
    debugPrint("absolutevirtue.spawn called.")
    local x, y, z, rot = mobConfig.spawn.x, mobConfig.spawn.y, mobConfig.spawn.z, mobConfig.spawn.rot

    local mob = zone:insertDynamicEntity({
        objtype = xi.objType.MOB,
        name = mobConfig.av.name,
        look = mobConfig.av.look,
        groupId = mobConfig.av.groupId,
        groupZoneId = mobConfig.av.groupZoneId,
        x = x,
        y = y,
        z = z,
        rotation = rot,
        minLevel = 119,
        maxLevel = 119,
        
        onMobSpawn = function(m)
            m:setDropID(0)
            m:setMobMod(xi.mobMod.NO_DROPS, 1)
            m:setMobMod(xi.mobMod.ROAM_DISTANCE, 0)
            m:setBaseSpeed(0)

            avStates[m:getID()] = {
                regen = 250,
                beneCount = 0,
                beneLimit = 99,
                bracelets = false,
                sps = {
                    xi.jsa.MIGHTY_STRIKES, xi.jsa.BENEDICTION, xi.jsa.HUNDRED_FISTS,
                    xi.jsa.MANAFONT, xi.jsa.CHAINSPELL, xi.jsa.PERFECT_DODGE,
                    xi.jsa.INVINCIBLE, xi.jsa.BLOOD_WEAPON, xi.jsa.SOUL_VOICE,
                    xi.jsa.MEIKYO_SHISUI, xi.jsa.MIJIN_GAKURE, xi.jsa.EES_AERN,
                    xi.jsa.CALL_WYVERN, xi.jsa.FAMILIAR, xi.jsa.ASTRAL_FLOW,
                },
                braceletsps = {
                    xi.jsa.CHAINSPELL, xi.jsa.MIGHTY_STRIKES, xi.jsa.MEIKYO_SHISUI,
                    xi.jsa.INVINCIBLE, xi.jsa.CALL_WYVERN,
                },
                nextsp = 0
            }

            m:addMod(xi.mod.REGEN, 250)
            m:setLocalVar('dmgThreshold', 90)
            
            applyCustomConfig(m)

            if mobConfig.av.hppMod and mobConfig.av.hppMod ~= 0 then
                m:addMod(xi.mod.HPP, mobConfig.av.hppMod)
                m:updateHealth()
                m:setHP(m:getMaxHP())
            end
            
            local pos = m:getPos()
            debugPrint("Absolute Virtue successfully spawned into the world at X: " .. pos.x .. " Y: " .. pos.y .. " Z: " .. pos.z)
            
            local function attemptSetup(mobRef, attempts)
                local z2 = mobRef:getZone()
                if not z2 then return end
                
                local confId = z2:getLocalVar("ActiveCustomHTBF_ConfrontationID")
                
                if confId > 0 and xi.confrontation.lookup[confId] then
                    mobRef:delStatusEffect(xi.effect.CONFRONTATION)
                    mobRef:setLocalVar("Custom_HTBF_Mods_Applied", 0)
                    mobRef:addStatusEffect(xi.effect.CONFRONTATION, { power = confId, origin = mobRef })
                    mobRef:getStatusEffect(xi.effect.CONFRONTATION):delEffectFlag(xi.effectFlag.DEATH)
                    
                    local lookup = xi.confrontation.lookup[confId]
                    table.insert(lookup.mobIds, mobRef:getID())
                    
                    local diffIndex = 3
                    for _, pId in ipairs(lookup.registeredPlayerIds) do
                        local p = GetPlayerByID(pId)
                        if p then
                            local idx = p:getCharVar("Custom_HTBF_Diff_Index")
                            if idx > 0 then diffIndex = idx break end
                        end
                    end
                    
                    applyDifficultyMods(mobRef, diffIndex, confId)
                    mobRef:setLocalVar("AV_Diff_Index", diffIndex)
                    debugPrint("Absolute Virtue bound to Confrontation ID: " .. confId .. " at Difficulty Index: " .. diffIndex)

                    local beneLimits = {
                        [1] = { 1, 1 }, -- Very Easy (1 time)
                        [2] = { 1, 2 }, -- Easy (1 to 2 times)
                        [3] = { 2, 3 }, -- Normal (2 to 3 times)
                        [4] = { 3, 4 }, -- Difficult (3 to 4 times)
                        [5] = { 4, 5 }, -- Very Difficult (4 to 5 times)
                    }
                    local limitRange = beneLimits[diffIndex] or { 2, 3 }
                    local state = avStates[mobRef:getID()]
                    if state then
                        state.beneLimit = math.random(limitRange[1], limitRange[2])
                        debugPrint("Absolute Virtue Benediction Limit set to: " .. state.beneLimit)
                    end
                else
                    if attempts > 0 then
                        mobRef:timer(500, function(m2) attemptSetup(m2, attempts - 1) end)
                    end
                end
            end
            
            attemptSetup(m, 10)
        end,

        onMobEngage = function(m, target)
            debugPrint("Absolute Virtue engaged by " .. target:getName())
            local state = avStates[m:getID()]
            if state then
                state.nextsp = os.time() + math.random(45, 90)
            end
        end,
        
        onPlayerAbilityUse = function(m, player, ability)
            debugPrint(string.format('%s used ability: %s', player:getName(), ability:getName()))
            local abilityID = ability:getID()
            local sp = playerAbilityToMobSP[abilityID]
            if sp ~= nil and player:checkDistance(m) <= 15 then
                local now = os.time()
                local used = m:getLocalVar(string.format('sp_%u', sp))
                local lockWindowTime = 3
                if used ~= 0 and now < used + lockWindowTime then
                    debugPrint(string.format('%s used within lock window, trying to lock!', ability:getName()))
                    lock(m, sp)
                end
            end
        end,
        
        onMobFight = function(m, target)
            if m:getLocalVar("speed_restored") == 0 then
                m:setLocalVar("speed_restored", 1)
                m:setBaseSpeed(60) -- Enhanced movement speed (~150%)
            end
        
            handleDamageResists(m)
            handleSP(m)

            local state = avStates[m:getID()]
            if state and not state.bracelets and m:getHPP() <= 60 then
                state.bracelets = true
                m:queue(0, function(mobArg)
                    mobArg:setAnimationSub(2)
                    mobArg:stun(2000)

                    mobArg:addMod(xi.mod.STR, 50)
                    mobArg:addMod(xi.mod.DEX, 50)
                    mobArg:addMod(xi.mod.VIT, 50)
                    mobArg:addMod(xi.mod.AGI, 50)
                    mobArg:addMod(xi.mod.INT, 50)
                    mobArg:addMod(xi.mod.MND, 50)
                    mobArg:addMod(xi.mod.CHR, 50)
                    mobArg:addMod(xi.mod.ATT, 300)
                    mobArg:addMod(xi.mod.MATT, 50)
                end)
            end
        end,
        
        onSpellPrecast = function(m, spell)
            if spell:getID() == xi.magic.spell.METEOR then
                spell:setAoE(xi.magic.aoe.RADIAL)
                spell:setRadius(30)
                spell:setAnimation(280)
            end
        end,
        
        onMagicHit = function(m, caster, spell)
            local state = avStates[m:getID()]
            if not state then return end

            if spell:getSkillType() == xi.skill.ELEMENTAL_MAGIC and state.regen >= 2 and state.regen <= 48 then
                local isCasterPCOrPet = caster:isPC() or caster:isPet()
                if VanadielDayElement() == spell:getElement() and isCasterPCOrPet then
                    state.regen = state.regen - 2
                    m:delMod(xi.mod.REGEN, 2)
                else
                    state.regen = state.regen + 2
                    m:addMod(xi.mod.REGEN, 2)
                end
            end
        end,
        
        onMobDeath = function(m, player, optParams)
            debugPrint("Absolute Virtue died.")
            if player then
                if player:isPet() or player:isTrust() then
                    player = player:getMaster()
                end
                if player and player:isPC() then
                    player:addTitle(xi.title.VIRTUOUS_SAINT)
                end
            end
            avStates[m:getID()] = nil
        end,
        
        onMobDespawn = function(m)
            debugPrint("Absolute Virtue despawned.")
            avStates[m:getID()] = nil
        end,

        releaseIdOnDisappear = true,
    })

    if mob then 
        mob:setSpawn(x, y, z, rot)
        mob:spawn() 
    else
        debugPrint("WARNING: Failed to insert dynamic entity for Absolute Virtue!")
    end
end

return absolutevirtue
