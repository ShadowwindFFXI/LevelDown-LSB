-----------------------------------
-- Area: Apollyon (Central)
--  Mob: Proto-Omega (HTBF)
-----------------------------------

local protoomega = {}

local debug = true
local function debugPrint(msg)
    if debug then
        print("[Proto-Omega] " .. tostring(msg))
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

    omega = {
        name = "Proto-Omega",
        -- Hex 0x013A (314)
        look = '0000370400000000000000000000000000000000',
        groupId = 53,
        groupZoneId = 38,
        hppMod = 0,
        modelSize = 5,
    }
}

local function quadrupedForm(mob)
    mob:setAnimationSub(1)
    mob:setMod(xi.mod.ATTP, 100)
    mob:setMod(xi.mod.UDMGPHYS, -9000)
    mob:setMod(xi.mod.UDMGRANGE, -9000)
    mob:setMod(xi.mod.UDMGMAGIC, -3000)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 727)
end

local function bipedForm(mob)
    mob:setAnimationSub(2)
    mob:setMod(xi.mod.ATTP, 200)
    mob:setMod(xi.mod.UDMGPHYS, -3000)
    mob:setMod(xi.mod.UDMGRANGE, -3000)
    mob:setMod(xi.mod.UDMGMAGIC, -9000)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 1188)
end

local function finalForm(mob)
    mob:setLocalVar('final', 1)
    mob:setAnimationSub(2)
    mob:setMod(xi.mod.ATTP, 250)
    mob:setMod(xi.mod.UDMGPHYS, -5000)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)
    mob:setMod(xi.mod.REGAIN, 100)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 1189)
end

local function applyCustomConfig(mob)
    if mobConfig.immunities then
        for _, immunity in ipairs(mobConfig.immunities) do
            mob:addImmunity(immunity)
        end
    end
    
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 25)
    mob:setMobMod(xi.mobMod.CANNOT_GUARD, 1)
    mob:setMod(xi.mod.COUNTER, 10)
    mob:setMod(xi.mod.REGAIN, 50)
    mob:setMod(xi.mod.REGEN, 25)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
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

protoomega.spawn = function(zone)
    debugPrint("protoomega.spawn called.")
    local x, y, z, rot = mobConfig.spawn.x, mobConfig.spawn.y, mobConfig.spawn.z, mobConfig.spawn.rot

    local mob = zone:insertDynamicEntity({
        objtype = xi.objType.MOB,
        name = mobConfig.omega.name,
        look = mobConfig.omega.look,
        groupId = mobConfig.omega.groupId,
        groupZoneId = mobConfig.omega.groupZoneId,
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
            
            applyCustomConfig(m)

            if mobConfig.omega.hppMod and mobConfig.omega.hppMod ~= 0 then
                m:addMod(xi.mod.HPP, mobConfig.omega.hppMod)
                m:updateHealth()
                m:setHP(m:getMaxHP())
            end
            
            local pos = m:getPos()
            debugPrint("Proto-Omega successfully spawned into the world at X: " .. pos.x .. " Y: " .. pos.y .. " Z: " .. pos.z)
            
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
                    mobRef:setLocalVar("Omega_Diff_Index", diffIndex)
                    debugPrint("Proto-Omega bound to Confrontation ID: " .. confId .. " at Difficulty Index: " .. diffIndex)
                else
                    if attempts > 0 then
                        mobRef:timer(500, function(m2) attemptSetup(m2, attempts - 1) end)
                    end
                end
            end
            
            quadrupedForm(m)
            attemptSetup(m, 10)
        end,

        onMobEngage = function(m, target)
            debugPrint("Proto-Omega engaged by " .. target:getName())
            m:setLocalVar('formTime', os.time() + 120)
        end,
        
        onMobFight = function(m, target)
            if m:getLocalVar("speed_restored") == 0 then
                m:setLocalVar("speed_restored", 1)
                m:setBaseSpeed(60) 
            end
            
            local now = os.time()

            if m:getLocalVar('final') == 1 then
                if now >= m:getLocalVar('gunpodTime') and m:getCurrentAction() == xi.action.category.BASIC_ATTACK then
                    m:setLocalVar('gunpodTime', now + 300)
                    m:useMobAbility(1532) -- Pod Ejection
                end
                return
            end

            if m:getHPP() <= 25 then
                finalForm(m)
                return
            end

            local formTime = m:getLocalVar('formTime')
            if now >= formTime and m:getCurrentAction() == xi.action.category.BASIC_ATTACK then
                m:setLocalVar('formTime', now + 120)
                if m:getAnimationSub() == 1 then
                    bipedForm(m)
                    m:wait(4500)
                    m:timer(4500, function(mobArg)
                        if mobArg:isAlive() and mobArg:getLocalVar('initialGunpod') == 0 then
                            mobArg:setLocalVar('initialGunpod', 1)
                            mobArg:useMobAbility(1532) -- Pod Ejection
                        end
                    end)
                else
                    quadrupedForm(m)
                    m:wait(4500)
                end
            end
        end,
        
        onAdditionalEffect = function(m, target, damage)
            return xi.mob.onAddEffect(m, target, damage, xi.mob.ae.STUN)
        end,
        
        onMobDeath = function(m, player, optParams)
            debugPrint("Proto-Omega died.")
            if player then
                player:addTitle(xi.title.APOLLYON_RAVAGER)
            end
            
            local confId = m:hasStatusEffect(xi.effect.CONFRONTATION) and m:getStatusEffect(xi.effect.CONFRONTATION):getPower() or 0
            if confId > 0 and xi.confrontation.lookup[confId] then
                xi.confrontation.lookup[confId].mobIds = {}
            end
        end,
        
        onMobDespawn = function(m)
            debugPrint("Proto-Omega despawned.")
        end,

        releaseIdOnDisappear = true,
    })

    if mob then 
        mob:setSpawn(x, y, z, rot)
        mob:spawn() 
    else
        debugPrint("WARNING: Failed to insert dynamic entity for Proto-Omega!")
    end
end

return protoomega
