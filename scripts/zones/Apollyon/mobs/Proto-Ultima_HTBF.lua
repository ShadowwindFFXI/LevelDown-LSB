-----------------------------------
-- Area: Apollyon
--  Mob: Proto-Ultima (HTBF)
-----------------------------------

local protoultima = {}

local debug = true
local function debugPrint(msg)
    if debug then
        print("[Proto-Ultima] " .. tostring(msg))
    end
end

local mobConfig = {
    spawn = { x = 1.0479, y = 0.0000, z = -144.4186, rot = 192 },
    
    immunities = {
        xi.immunity.GRAVITY,
        xi.immunity.BIND,
        xi.immunity.SILENCE,
        xi.immunity.BLIND,
        xi.immunity.LIGHT_SLEEP,
        xi.immunity.DARK_SLEEP,
        xi.immunity.TERROR,
    },

    ultima = {
        name = "Proto-Ultima",
        look = '0000340400000000000000000000000000000000',
        groupId = 52,
        groupZoneId = 37,
        hppMod = 0,
    }
}

local citadelBusterTimers =
{
    [0] = 0,
    [1] = 10000,
    [2] = 10000,
    [3] = 5000,
    [4] = 1000,
    [5] = 1000,
    [6] = 1000,
    [7] = 1000,
    [8] = 1000,
    [9] = 500,
}
--================
local citadelMessages = {
    [1] = "Proto-Ultima is charging antimatter!",
    [2] = "20 seconds to discharge.",
    [3] = "10 seconds to discharge.",
    [4] = "5 seconds to discharge.",
    [5] = "4 seconds to discharge.",
    [6] = "3 seconds to discharge.",
    [7] = "2 seconds to discharge.",
    [8] = "1 second to discharge."
}

local function sendCitadelMessage(mob, state)
    local msg = citadelMessages[state + 1]
    if msg then
        local z = mob:getZone()
        if z then
            for _, p in pairs(z:getPlayers()) do
                p:printToPlayer(msg, xi.msg.channel.SYSTEM_3)
            end
        end
    end
end

local executeCitadelBusterState
executeCitadelBusterState = function(mob)
    if mob:isDead() then
        return
    end

    local state = mob:getLocalVar('citadelBusterState')
    if state < 8 then
        sendCitadelMessage(mob, state)
    elseif state == 8 then
        mob:useMobAbility(1540)
    else
        mob:setLocalVar('citadelBusterState', 0)
        mob:setMagicCastingEnabled(true)
        mob:setAutoAttackEnabled(true)
        mob:setMobAbilityEnabled(true)
        mob:setLocalVar('citadelBusterTime', os.time() + math.random(90, 100))
        return
    end

    state = state + 1
    mob:setLocalVar('citadelBusterState', state)
    mob:timer(citadelBusterTimers[state], function(mobArg)
        executeCitadelBusterState(mobArg)
    end)
end

local function applyCustomConfig(mob)
    if mobConfig.immunities then
        for _, immunity in ipairs(mobConfig.immunities) do
            mob:addImmunity(immunity)
        end
    end

    mob:setMagicCastingEnabled(false)
    mob:setAutoAttackEnabled(true)
    mob:setMobAbilityEnabled(true)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 729)
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

protoultima.spawn = function(zone)
    debugPrint("protoultima.spawn called.")
    local x, y, z, rot = mobConfig.spawn.x, mobConfig.spawn.y, mobConfig.spawn.z, mobConfig.spawn.rot

    local mob = zone:insertDynamicEntity({
        objtype = xi.objType.MOB,
        name = mobConfig.ultima.name,
        look = mobConfig.ultima.look,
        groupId = mobConfig.ultima.groupId,
        groupZoneId = mobConfig.ultima.groupZoneId,
        x = x,
        y = y,
        z = z,
        rotation = rot,
        minLevel = 119,
        maxLevel = 119,
        modelSize = 5,
        
        onMobSpawn = function(m)
            m:setDropID(0)
            m:setMobMod(xi.mobMod.NO_DROPS, 1)
            m:setMobMod(xi.mobMod.ROAM_DISTANCE, 0)
            m:setMobMod(xi.mobMod.NO_MOVE, 1)
            m:setBaseSpeed(0)
            
            applyCustomConfig(m)

            if mobConfig.ultima.hppMod and mobConfig.ultima.hppMod ~= 0 then
                m:addMod(xi.mod.HPP, mobConfig.ultima.hppMod)
                m:updateHealth()
                m:setHP(m:getMaxHP())
            end
            
            local pos = m:getPos()
            debugPrint("Proto-Ultima successfully spawned into the world at X: " .. pos.x .. " Y: " .. pos.y .. " Z: " .. pos.z)
            
            local function attemptSetup(mobRef, attempts)
                local z2 = mobRef:getZone()
                if not z2 then return end
                
                local confId = z2:getLocalVar("ActiveCustomHTBF_ConfrontationID")
                
                if confId > 0 and xi.confrontation.lookup[confId] then
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
                    mobRef:setLocalVar("Ultima_Diff_Index", diffIndex)
                    debugPrint("Proto-Ultima bound to Confrontation ID: " .. confId .. " at Difficulty Index: " .. diffIndex)
                else
                    if attempts > 0 then
                        mobRef:timer(500, function(m2) attemptSetup(m2, attempts - 1) end)
                    end
                end
            end
            
            attemptSetup(m, 10)
        end,

        onMobEngage = function(m, target)
            debugPrint("Proto-Ultima engaged by " .. target:getName())
            m:setMobMod(xi.mobMod.NO_MOVE, 0)
        end,
        
        onMobFight = function(m, target)
            if m:getLocalVar("speed_restored") == 0 then
                m:setLocalVar("speed_restored", 1)
                m:setBaseSpeed(60) 
            end
            
            local spawnPos = m:getSpawnPos()
            local drawInTable =
            {
                conditions =
                {
                    target:checkDistance(spawnPos.x, spawnPos.y, spawnPos.z) > 25,
                },
                position = m:getPos(),
                wait = 3,
            }
            if drawInTable.conditions[1] then
                m:setMobMod(xi.mobMod.NO_MOVE, 1)
                utils.drawIn(target, drawInTable)
            else
                m:setMobMod(xi.mobMod.NO_MOVE, 0)
            end

            if xi.combat.behavior.isEntityBusy(m) then
                return
            end

            local phase = m:getLocalVar('phase')
            if m:getHPP() < (5 - (phase + 1)) * 20 then
                m:useMobAbility(1524) -- use Dissipation on phase change
                phase = phase + 1

                if phase == 1 then
                    m:setMobMod(xi.mobMod.SKILL_LIST, 1193)
                elseif phase == 2 then
                    m:setMobMod(xi.mobMod.SKILL_LIST, 1194)
                    m:timer(1000, function(mobArg)
                        if mobArg:isAlive() then mobArg:setMagicCastingEnabled(true) end
                    end)
                elseif phase == 3 then
                    m:setMobMod(xi.mobMod.SKILL_LIST, 1195)
                elseif phase == 4 then
                    m:setMobMod(xi.mobMod.SKILL_LIST, 1196)
                    m:setMod(xi.mod.REGAIN, 100)
                    m:setLocalVar('citadelBusterTime', os.time() + math.random(20, 30))
                end

                m:setLocalVar('phase', phase)
            elseif phase == 4 and os.time() >= m:getLocalVar('citadelBusterTime') and m:getLocalVar('citadelBusterState') == 0 then
                m:setMobAbilityEnabled(false)
                m:setMagicCastingEnabled(false)
                m:setAutoAttackEnabled(false)
                local citadelBusterDrawInTable =
                {
                    conditions =
                    {
                        m:checkDistance(target) >= 15,
                    },
                    position = m:getPos(),
                }
                utils.drawIn(target, citadelBusterDrawInTable)
                executeCitadelBusterState(m)
            end
        end,
        
        onMobWeaponSkill = function(target, m, skill)
            if skill:getID() == 1268 then
                m:timer(4000, function(mobArg)
                    if mobArg:isAlive() then
                        local ability = math.random(1262, 1267)
                        mobArg:useMobAbility(ability)
                    end
                end)
            end
        end,
        
        onMobDeath = function(m, player, optParams)
            debugPrint("Proto-Ultima died.")
            if player then
                player:addTitle(xi.title.TEMENOS_LIBERATOR)
            end
            
            local confId = m:hasStatusEffect(xi.effect.CONFRONTATION) and m:getStatusEffect(xi.effect.CONFRONTATION):getPower() or 0
            if confId > 0 and xi.confrontation.lookup[confId] then
                xi.confrontation.lookup[confId].mobIds = {}
            end
        end,
        
        onMobDespawn = function(m)
            debugPrint("Proto-Ultima despawned.")
        end,

        releaseIdOnDisappear = true,
    })

    if mob then 
        mob:setSpawn(x, y, z, rot)
        mob:spawn() 
    else
        debugPrint("WARNING: Failed to insert dynamic entity for Proto-Ultima!")
    end
end
return protoultima