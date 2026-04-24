-----------------------------------
-- An Errand! The Professor's Price
-- A Moogle Kupo d'Etat M6
-- !addmission 10 5
-- qm1 : !pos 420 -10 745 194
-- ORB_OF_SWORDS  : !addkeyitem 1139
-- ORB_OF_CUPS    : !addkeyitem 1140
-- ORB_OF_BATONS  : !addkeyitem 1141
-- ORB_OF_COINS   : !addkeyitem 1142
-- RIPE_STARFRUIT : !addkeyitem 1143
-- Shantotto      : !pos 122 -2 112 239
-----------------------------------
local horutotoID = zones[xi.zone.OUTER_HORUTOTO_RUINS]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.AMK, xi.mission.id.amk.AN_ERRAND_THE_PROFESSORS_PRICE)

mission.reward =
{
    nextMission = { xi.mission.log_id.AMK, xi.mission.id.amk.SHOCK_ARRANT_ABUSE_OF_AUTHORITY },
}

-- TODO: Test and make sure this works
local orbKeyItems =
{
    -- keyItem, mod, immune value, vulnerable value
    { xi.ki.ORB_OF_SWORDS, xi.mod.SLASH_SDT  },
    { xi.ki.ORB_OF_CUPS,   xi.mod.IMPACT_SDT },
    { xi.ki.ORB_OF_BATONS, xi.mod.PIERCE_SDT },
    { xi.ki.ORB_OF_COINS,  xi.mod.UDMGMAGIC  },
}

local beginCardianFight = function(player, npc)
    local numToSpawn = 15

    local modsToAdd = {}

    -- Count KI's so we know how many Cardians to spawn
    local removedKIs = 0
    for _, entry in ipairs(orbKeyItems) do
        local keyItemId = entry[1]
        local immunity  = entry[2]

        if player:hasKeyItem(keyItemId) then
            table.insert(modsToAdd, { immunity, 0 })

            player:delKeyItem(keyItemId)
            removedKIs = removedKIs + 1
        else
            table.insert(modsToAdd, { immunity, -10000 })
        end
    end

    if removedKIs == 3 then
        numToSpawn = 10
    elseif removedKIs == 4 then
        numToSpawn = 5
    end

    local cardianIds = {}
    for cardianId = horutotoID.mob.CUSTOM_CARDIAN_OFFSET, horutotoID.mob.CUSTOM_CARDIAN_OFFSET + numToSpawn - 1, 1 do
        table.insert(cardianIds, cardianId)
    end

    -- Bypassing the buggy C++ confrontation core completely!
    -- We will manually spawn the mobs, apply buffs, and use a Lua tracker loop.
    local confID = npc:getID()
    local party = player:getParty() or { player }
    local registeredPlayers = {}

    for _, member in ipairs(party) do
        if member:getZoneID() == player:getZoneID() then
            -- Scrub old buffs and apply fresh ones
            member:delStatusEffectSilent(xi.effect.CONFRONTATION)
            member:addStatusEffect(xi.effect.CONFRONTATION, { power = confID, origin = member })
            member:getStatusEffect(xi.effect.CONFRONTATION):delEffectFlag(xi.effectFlag.DEATH)
            table.insert(registeredPlayers, member)
        end
    end

    local spawnedMobs = {}
    for _, mobId in ipairs(cardianIds) do
        local mob = GetMobByID(mobId)
        if mob then
            if not mob:isSpawned() then
                SpawnMob(mobId)
            end
        end
    end

    -- Delay slightly to apply mods and begin tracking loop
    npc:timer(1000, function()
        for _, mobId in ipairs(cardianIds) do
            local mob = GetMobByID(mobId)
            if mob and mob:isSpawned() then
                -- Explicitly buff the mob
                mob:delStatusEffectSilent(xi.effect.CONFRONTATION)
                mob:addStatusEffect(xi.effect.CONFRONTATION, { power = confID, origin = mob })
                mob:getStatusEffect(xi.effect.CONFRONTATION):delEffectFlag(xi.effectFlag.DEATH)

                for _, entry in ipairs(modsToAdd) do
                    mob:setMod(entry[1], entry[2])
                end
                table.insert(spawnedMobs, mob)
            end
        end

        -- Custom Lua Battle Tracker Loop (Similar to Custom HTBF scripts)
        local function checkBattle()
            local validPlayerCount = 0
            local validMobCount = 0

            -- Check active players
            for _, p in ipairs(registeredPlayers) do
                if p:getZoneID() == npc:getZoneID() and p:isAlive() and p:hasStatusEffect(xi.effect.CONFRONTATION) then
                    validPlayerCount = validPlayerCount + 1
                end
            end

            -- Check active mobs
            for _, m in ipairs(spawnedMobs) do
                if m:isSpawned() and m:isAlive() then
                    validMobCount = validMobCount + 1
                end
            end

            -- Win Condition: All mobs are dead
            if validMobCount == 0 and validPlayerCount > 0 then
                for _, p in ipairs(registeredPlayers) do
                    p:delStatusEffectSilent(xi.effect.CONFRONTATION)
                    if p:isPC() and p:getZoneID() == npc:getZoneID() then
                        local messageMob = GetMobByID(cardianIds[1])
                        if messageMob then
                            p:messageText(messageMob, horutotoID.text.INITIATING_TRANSMISSION)
                        end
                        npcUtil.giveKeyItem(p, xi.ki.RIPE_STARFRUIT)
                        npcUtil.giveKeyItem(p, xi.ki.PEACH_CORAL_KEY)
                    end
                end
                return -- End loop
            end

            -- Lose Condition: All players wiped/fled
            if validPlayerCount == 0 then
                for _, p in ipairs(registeredPlayers) do
                    p:delStatusEffectSilent(xi.effect.CONFRONTATION)
                end
                for _, m in ipairs(spawnedMobs) do
                    if m:isSpawned() then
                        DespawnMob(m:getID())
                    end
                end
                return -- End loop
            end

            -- Battle is still ongoing, check again in 2 seconds
            npc:timer(2000, checkBattle)
        end

        -- Start the tracker
        checkBattle()
    end)
end

mission.sections =
{
    -- Go get the Starfruit
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission >= mission.missionId and
                missionStatus == 0 and
                not player:hasKeyItem(xi.ki.RIPE_STARFRUIT)
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Shantotto'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(508)
                end,
            },
        },

        [xi.zone.OUTER_HORUTOTO_RUINS] =
        {
            ['qm1'] =
            {
                -- Only need one KI orb to start fight
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.ORB_OF_SWORDS) or
                        player:hasKeyItem(xi.ki.ORB_OF_CUPS) or
                        player:hasKeyItem(xi.ki.ORB_OF_BATONS) or
                        player:hasKeyItem(xi.ki.ORB_OF_COINS)
                    then
                        -- Prompt to start the fight
                        return mission:progressEvent(100)
                    else
                        -- Remind that orbs are needed
                        return mission:messageSpecial(horutotoID.text.IF_HAD_ORBS, xi.ki.ORB_OF_SWORDS, xi.ki.ORB_OF_CUPS, xi.ki.ORB_OF_BATONS, xi.ki.ORB_OF_COINS)
                    end
                end,
            },

            onEventFinish =
            {
                [100] = function(player, csid, option, npc)
                    -- Violence was chosen, start fight
                    if option == 1 then
                        beginCardianFight(player, npc)
                    end
                end,
            },
        },
    },

    -- Got the Starfruit
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission >= mission.missionId and
                missionStatus == 0 and
                player:hasKeyItem(xi.ki.RIPE_STARFRUIT) and
                not player:needToZone()
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Shantotto'] =
            {
                onTrigger = function(player, npc)
                    local hasGil = player:getGil() >= 5000 and 0 or 1
                    return mission:progressEvent(507, 0, player:getGil(), hasGil)
                end,
            },

            onEventFinish =
            {
                [507] = function(player, csid, option, npc)
                    if option == 0 then -- Dont Pay
                        player:needToZone(true)
                    elseif option == 1 then -- Pay
                        player:delGil(5000)
                        player:delKeyItem(xi.ki.RIPE_STARFRUIT)
                        player:setMissionStatus(xi.mission.log_id.AMK, 1)
                    end
                end,
            },
        },

        [xi.zone.OUTER_HORUTOTO_RUINS] =
        {
            ['qm1'] =
            {
                onTrigger = function(player, npc)
                    return mission:messageSpecial(horutotoID.text.CANNOT_ENTER_BATTLEFIELD, xi.ki.RIPE_STARFRUIT):setPriority(1000)
                end,
            },
        },
    },

    -- Watch Shantotto uncurse the moogle and get digging instructions
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 1
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Shantotto'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(509)
                end,
            },
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['Inconspicuous_Door'] =
            {
                onTrigger = function(player, npc)
                    local diggingZone = xi.amk.helpers.getDiggingZone(player)
                    local diggingZoneCsId = xi.amk.helpers.digSites[diggingZone].eventID
                    return mission:progressEvent(10182, diggingZoneCsId)
                end,
            },

            onEventFinish =
            {
                [10182] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
