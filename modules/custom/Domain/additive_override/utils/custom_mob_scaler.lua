-----------------------------------
-- custom_mob_scaler
-----------------------------------
require('modules/module_utils')
require('scripts/globals/npc_util')
-----------------------------------
local m = Module:new('custom_mob_scaler')
-----------------------------------

-- how to use
--[[
    in require section:
    local cms  = require("modules/domain/additive_overrides/utils/custom_mob_scaler")

    onMobFight (function)
        cms.mobScalerPercentage(mob, target,
    {
        -- min players to start scale
        minplayers = 0,
        -- max players to stop scale
        maxplayers = 18,
        -- set HP scailing here (this is the increase per player)
        HP = 10000,
        -- define mods here (add mods to modMapping as needed)
        -- this will take the input value and multiply it by the number of players
        -- if not defined, no scailing will be applied to modifiers
        defmod = 3
    })

    onMobDespawn (function)
        cms.mobScalerCleanup(mob)

]]

-- define more mods as needed
local modMapping =
{
    defmod = xi.mod.DEF,
    attmod = xi.mod.ATT,
    accmod = xi.mod.ACC,
    evamod = xi.mod.EVA,
}

local function applyMods(mob, players, config)
    for k, modValue in pairs(modMapping) do
        if config[k] and config[k] ~= 0 then
            mob:addMod(modValue, players * config[k])
        end
    end
end

m.mobScalerPercentage = function (mob, target, config)
    if target:getObjType() ~= xi.objType.PC then
         return -- placeholder for trust/pet scale
    end


    local players      = target:getAlliance()
    local totalPlayers = mob:getLocalVar('playerCount')

    local minPlayers = config.minplayers or 0
    local maxPlayers = config.maxplayers or 18
    local setHP      = config.HP or 4500

    -- Early exit conditions
    if
        totalPlayers == #players or
        #players < minPlayers or
        totalPlayers > maxPlayers or
        #players <= totalPlayers
    then
        return
    end

    -- Race condition check
    if mob:getLocalVar('trigger') == 0 then
        mob:setLocalVar('trigger', 1)

        local baseHealth = mob:getLocalVar('baseHP')

        if baseHealth == 0 and #players > minPlayers then
            mob:setLocalVar('baseHP', mob:getMaxHP())
        elseif baseHealth > 0 then
            local newPlayers            = math.max(0, #players - minPlayers) - math.max(0, totalPlayers - minPlayers)
            local healthIncrease        = newPlayers * setHP
            local healthIncreasePercent = math.ceil((healthIncrease / baseHealth) * 100)

            mob:addMod(xi.mod.HPP, healthIncreasePercent)

            applyMods(mob, newPlayers, config)

            mob:updateHealth()
            mob:addHP(healthIncrease)

            if mob:getBattleTime() >= 5 then
                mob:injectActionPacket(mob:getID(), 4, 5000, 0, 0, 0, 0, 0)
            end

            -- Update the player count
            mob:setLocalVar('playerCount', #players)
        end

        mob:setLocalVar('trigger', 0)
    end
end

m.mobScalerCleanup = function (mob)
    mob:setLocalVar('playerCount', 0)
end

return m
