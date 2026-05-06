-----------------------------------
-- Area: Outer Ra'Kaznar [U1]
--  Mob: Apocalypse Nigh (HTBF)
-----------------------------------

local apocalypsenigh = {}

local debug = true
local function debugPrint(msg)
    if debug then print("[Apocalypse Nigh] " .. tostring(msg)) end
end

local mobConfig = {
    kamlanaut_spawn = { x = 351.4231, y = -164.0000, z = -407.9874, rot = 94 },
    ealdnarche_spawn = { x = 351.4231, y = -164.0000, z = -410.9874, rot = 94 },

    immunities = {
        xi.immunity.DARK_SLEEP,
        xi.immunity.SILENCE,
        xi.immunity.TERROR,
    },
    
    kamlanaut = {
        name = "Kamlanaut",
        look = '00001f0300000000000000000000000000000000',
        groupId = 3,
        groupZoneId = 36,
        hppMod = 0,
        modelSize = 5,
    },
    
    ealdnarche = {
        name = "Eald'narche",
        look = '00000b0300000000000000000000000000000000',
        groupId = 4,
        groupZoneId = 36,
        hppMod = 0,
        modelSize = 5,
    }
}

local skillToAbsorb = {
    [xi.mobSkill.FIRE_BLADE_1     ] = xi.mod.FIRE_ABSORB,
    [xi.mobSkill.FROST_BLADE_1    ] = xi.mod.ICE_ABSORB,
    [xi.mobSkill.WIND_BLADE_1     ] = xi.mod.WIND_ABSORB,
    [xi.mobSkill.EARTH_BLADE_1    ] = xi.mod.EARTH_ABSORB,
    [xi.mobSkill.LIGHTNING_BLADE_1] = xi.mod.LTNG_ABSORB,
    [xi.mobSkill.WATER_BLADE_1    ] = xi.mod.WATER_ABSORB,
}

local function applyConfrontation(mob, confId)
    if confId and confId > 0 then
        mob:addStatusEffect(xi.effect.CONFRONTATION, { power = confId, origin = mob })
        mob:getStatusEffect(xi.effect.CONFRONTATION):delEffectFlag(xi.effectFlag.DEATH)
    end
end

local function applyCustomConfig(mob)
    if mobConfig.immunities then
        for _, immunity in ipairs(mobConfig.immunities) do
            mob:addImmunity(immunity)
        end
    end
    mob:setMod(xi.mod.BIND_RES_RANK, 11)
    mob:setMod(xi.mod.BLIND_RES_RANK, 11)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 11)
    mob:setMod(xi.mod.PARALYZE_RES_RANK, 11)
    mob:setMod(xi.mod.POISON_RES_RANK, 11)
    mob:setMod(xi.mod.SLOW_RES_RANK, 11)
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

local function checkAllDead(m)
    debugPrint(m:getName() .. " died.")
    local confId = m:hasStatusEffect(xi.effect.CONFRONTATION) and m:getStatusEffect(xi.effect.CONFRONTATION):getPower() or 0
    if confId > 0 and xi.confrontation.lookup[confId] then
        local allDead = true
        for _, id in ipairs(xi.confrontation.lookup[confId].mobIds) do
            local otherMob = GetMobByID(id)
            if otherMob and otherMob:isAlive() and otherMob:getID() ~= m:getID() then 
                allDead = false 
                break 
            end
        end
        
        if allDead then
            debugPrint("All bosses defeated. Triggering win condition.")
        end
    end
end

local function linkBosses(m, target)
    local confId = m:hasStatusEffect(xi.effect.CONFRONTATION) and m:getStatusEffect(xi.effect.CONFRONTATION):getPower() or 0
    if confId > 0 and xi.confrontation.lookup[confId] then
        for _, id in ipairs(xi.confrontation.lookup[confId].mobIds) do
            local otherMob = GetMobByID(id)
            if otherMob and otherMob:isAlive() and otherMob:getID() ~= m:getID() and not otherMob:isEngaged() then
                otherMob:updateEnmity(target)
            end
        end
    end
end

local function bindToConfrontation(mobRef, attempts)
    local z = mobRef:getZone()
    if not z then return end
    
    local confId = z:getLocalVar("ActiveCustomHTBF_ConfrontationID")
    if confId > 0 and xi.confrontation.lookup[confId] then
        applyConfrontation(mobRef, confId)
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
        mobRef:setLocalVar("ApocalypseNigh_Diff_Index", diffIndex)
        debugPrint(mobRef:getName() .. " bound to Confrontation ID: " .. confId)
    else
        if attempts > 0 then
            mobRef:timer(500, function(m2) bindToConfrontation(m2, attempts - 1) end)
        end
    end
end

apocalypsenigh.spawn = function(zone)
    debugPrint("Apocalypse_Nigh_HTBF.spawn called.")
    local k_x, k_y, k_z, k_rot = mobConfig.kamlanaut_spawn.x, mobConfig.kamlanaut_spawn.y, mobConfig.kamlanaut_spawn.z, mobConfig.kamlanaut_spawn.rot
    local e_x, e_y, e_z, e_rot = mobConfig.ealdnarche_spawn.x, mobConfig.ealdnarche_spawn.y, mobConfig.ealdnarche_spawn.z, mobConfig.ealdnarche_spawn.rot

    local kamlanaut = zone:insertDynamicEntity({
        objtype = xi.objType.MOB,
        name = mobConfig.kamlanaut.name,
        look = mobConfig.kamlanaut.look,
        groupId = mobConfig.kamlanaut.groupId,
        groupZoneId = mobConfig.kamlanaut.groupZoneId,
        x = k_x, y = k_y, z = k_z, rotation = k_rot,
        minLevel = 119, maxLevel = 119,
        
        onMobSpawn = function(m)
            m:setDropID(0)
            m:setMobMod(xi.mobMod.NO_DROPS, 1)
            m:setMobMod(xi.mobMod.ROAM_DISTANCE, 0)
            m:setBaseSpeed(0)
            
            applyCustomConfig(m)
            m:setMobMod(xi.mobMod.MAGIC_COOL, 20)
            m:setMobMod(xi.mobMod.MAGIC_DELAY, 10)
            m:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
            m:setMobMod(xi.mobMod.SKILL_LIST, 0)
            
            bindToConfrontation(m, 10)
        end,
        onMobEngage = function(m, target)
            m:setLocalVar('nextEnSkill', os.time() + 10)
            linkBosses(m, target)
        end,
        onMobFight = function(m, target)
            if m:getLocalVar("speed_restored") == 0 then
                m:setLocalVar("speed_restored", 1)
                m:setBaseSpeed(40)
            end
            if xi.combat.behavior.isEntityBusy(m) then return end
            if os.time() > m:getLocalVar('nextEnSkill') then
                local skill = math.random(xi.mobSkill.FIRE_BLADE_1, xi.mobSkill.WATER_BLADE_1)
                m:useMobAbility(skill)
                m:setLocalVar('nextEnSkill', os.time() + 30)
            end
        end,
        onMobWeaponSkillChoose = function(m, target)
            local tpList = { xi.mobSkill.GREAT_WHEEL_1, xi.mobSkill.LIGHT_BLADE_1 }
            return tpList[math.random(1, #tpList)]
        end,
        onMobWeaponSkill = function(target, m, skill)
            local sId = skill:getID()
            local absorbId = skillToAbsorb[sId]
            if absorbId then
                local previousAbsorb = m:getLocalVar('currentAbsorb')
                if previousAbsorb > 0 then m:setMod(previousAbsorb, 0) end
                m:setLocalVar('currentAbsorb', absorbId)
                m:setMod(absorbId, 100)
            else
                local wsCount = m:getLocalVar('wsCount')
                local wsMax = m:getLocalVar('wsMax')
                if wsCount == 0 then
                    wsMax = math.random(0, 2)
                    m:setLocalVar('wsMax', wsMax)
                end
                if wsCount < wsMax then
                    m:setLocalVar('wsCount', wsCount + 1)
                    m:timer(3000, function(mArg)
                        mArg:useMobAbility(sId)
                    end)
                else
                    m:setLocalVar('wsCount', 0)
                end
            end
        end,
        onMobSpellChoose = function(m, target)
            local spellList = {
                [1] = { xi.magic.spell.DISPELGA,  target, false, xi.action.type.DAMAGE_TARGET,      nil,               0, 100 },
                [2] = { xi.magic.spell.SLOWGA,    target, false, xi.action.type.ENFEEBLING_TARGET,  xi.effect.SLOW,    3, 100 },
                [3] = { xi.magic.spell.SILENCEGA, target, false, xi.action.type.ENFEEBLING_TARGET,  xi.effect.SILENCE, 0, 100 },
                [4] = { xi.magic.spell.GRAVIGA,   target, false, xi.action.type.ENFEEBLING_TARGET,  xi.effect.WEIGHT,  0, 100 },
            }
            return xi.combat.behavior.chooseAction(m, target, nil, spellList)
        end,
        onMobDeath = function(m, player, optParams) checkAllDead(m) end,
        releaseIdOnDisappear = true,
    })

    local ealdnarche = zone:insertDynamicEntity({
        objtype = xi.objType.MOB,
        name = mobConfig.ealdnarche.name,
        look = mobConfig.ealdnarche.look,
        groupId = mobConfig.ealdnarche.groupId,
        groupZoneId = mobConfig.ealdnarche.groupZoneId,
        x = e_x, y = e_y, z = e_z, rotation = e_rot,
        minLevel = 119, maxLevel = 119,
        
        onMobSpawn = function(m)
            m:setDropID(0)
            m:setMobMod(xi.mobMod.NO_DROPS, 1)
            m:setMobMod(xi.mobMod.ROAM_DISTANCE, 0)
            m:setBaseSpeed(0)
            
            applyCustomConfig(m)
            m:setMobMod(xi.mobMod.TELEPORT_CD, 30)
            m:setMobMod(xi.mobMod.TELEPORT_START, 988)
            m:setMobMod(xi.mobMod.TELEPORT_END, 989)
            m:setMobMod(xi.mobMod.TELEPORT_TYPE, 1)
            m:setMod(xi.mod.EVA, 330)
            m:setMod(xi.mod.MATT, 150)
            m:setMod(xi.mod.MDEF, 50)
            m:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
            m:setMobMod(xi.mobMod.SKILL_LIST, 0)
            
            bindToConfrontation(m, 10)
        end,
        onMobEngage = function(m, target)
            linkBosses(m, target)
        end,
        onMobFight = function(m, target)
            if m:getLocalVar("speed_restored") == 0 then
                m:setLocalVar("speed_restored", 1)
                m:setBaseSpeed(40)
            end
        end,
        onMobWeaponSkillChoose = function(m, target)
            local spellList = {
                xi.mobSkill.OMEGA_JAVELIN_1,
                xi.mobSkill.STELLAR_BURST_1,
                xi.mobSkill.VORTEX_1,
            }
            return spellList[math.random(1, #spellList)]
        end,
        onMobSpellChoose = function(m, target)
            local spellList = {
                [1] = { xi.magic.spell.THUNDAGA_III, target, false, xi.action.type.DAMAGE_TARGET,      nil,                0, 100 },
                [2] = { xi.magic.spell.BLIZZAGA_III, target, false, xi.action.type.DAMAGE_TARGET,      nil,                0, 100 },
                [3] = { xi.magic.spell.FIRAGA_III,   target, false, xi.action.type.DAMAGE_TARGET,      nil,                0, 100 },
                [4] = { xi.magic.spell.AEROGA_III,   target, false, xi.action.type.DAMAGE_TARGET,      nil,                0, 100 },
                [5] = { xi.magic.spell.WATERGA_III,  target, false, xi.action.type.DAMAGE_TARGET,      nil,                0, 100 },
                [6] = { xi.magic.spell.STONEGA_III,  target, false, xi.action.type.DAMAGE_TARGET,      nil,                0, 100 },
                [7] = { xi.magic.spell.SLEEPGA_II,   target, false, xi.action.type.ENFEEBLING_TARGET,  xi.effect.SLEEP_II, 0, 100 },
                [8] = { xi.magic.spell.BINDGA,       target, false, xi.action.type.ENFEEBLING_TARGET,  xi.effect.BIND,     0, 100 },
            }
            return xi.combat.behavior.chooseAction(m, target, nil, spellList)
        end,
        onMobDeath = function(m, player, optParams) checkAllDead(m) end,
        releaseIdOnDisappear = true,
    })

    if kamlanaut then kamlanaut:setSpawn(k_x, k_y, k_z, k_rot); kamlanaut:spawn() end
    if ealdnarche then ealdnarche:setSpawn(e_x, e_y, e_z, e_rot); ealdnarche:spawn() end
end

return apocalypsenigh