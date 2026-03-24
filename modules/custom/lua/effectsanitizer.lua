-----------------------------------
-- Effect Sanitizer Module
-- Checks players for invalid status effects (wrong job or excessive duration)
-- Automatically scans every Vana'diel hour (~2.4 minutes)
-----------------------------------
require("modules/module_utils")
-----------------------------------

local m = Module:new("effectsanitizer")

local enableRemoval = true -- Set to true to automatically remove invalid effects

-- Configuration Table
-- effect: The ID of the status effect to check.
-- threshold: Max allowed remaining duration in seconds. Effect removed if higher.
-- jobs: Table of allowed main jobs for this effect. Effect removed if player's main job is not in list.
--       Set to nil to skip job check.
local checks = {
    { effect = xi.effect.MIGHTY_STRIKES,   threshold = 240,  jobs = { xi.job.WAR } },
    { effect = xi.effect.HUNDRED_FISTS,    threshold = 240,  jobs = { xi.job.MNK } },
    { effect = xi.effect.MANAFONT,         threshold = 240,  jobs = { xi.job.BLM } },
    { effect = xi.effect.CHAINSPELL,       threshold = 240,  jobs = { xi.job.RDM } },
    { effect = xi.effect.PERFECT_DODGE,    threshold = 240,  jobs = { xi.job.THF } },
    { effect = xi.effect.INVINCIBLE,       threshold = 240,  jobs = { xi.job.PLD } },
    { effect = xi.effect.BLOOD_WEAPON,     threshold = 240,  jobs = { xi.job.DRK } },
    { effect = xi.effect.SOUL_VOICE,       threshold = 480,  jobs = { xi.job.BRD } },
    { effect = xi.effect.MEIKYO_SHISUI,    threshold = 240,  jobs = { xi.job.SAM } },
    { effect = xi.effect.SPIRIT_SURGE,     threshold = 240,  jobs = { xi.job.DRG } },
    { effect = xi.effect.AZURE_LORE,       threshold = 240,  jobs = { xi.job.BLU } },
    { effect = xi.effect.OVERDRIVE,        threshold = 240, jobs = { xi.job.PUP } },
    { effect = xi.effect.TRANCE,           threshold = 240,  jobs = { xi.job.DNC } },
    { effect = xi.effect.TABULA_RASA,      threshold = 240, jobs = { xi.job.SCH } },
    { effect = xi.effect.BOLSTER,          threshold = 240, jobs = { xi.job.GEO } },
    { effect = xi.effect.ELEMENTAL_SFORZO, threshold = 240,  jobs = { xi.job.RUN } },
}

local function reportToGMs(msg)
    for i = 0, 299 do
        local zone = GetZone(i)
        if zone then
            local players = zone:getPlayers()
            for _, p in pairs(players) do
                if p:getGMLevel() > 0 then
                    p:printToPlayer(msg, xi.msg.channel.SYSTEM_3)
                end
            end
        end
    end
end

local function checkPlayer(player)
    if not player or not player:isPC() or player:getGMLevel() > 0 then return end

    local mainJob = player:getMainJob()
    
    for _, config in ipairs(checks) do
        if player:hasStatusEffect(config.effect) then
            local effect = player:getStatusEffect(config.effect)
            local duration = effect:getTimeRemaining() / 1000 -- ms to seconds
            local remove = false
            local reason = ""

            -- Check Duration
            if config.threshold and duration > config.threshold then
                remove = true
                reason = string.format("Duration (%.1fs) > Threshold (%ds)", duration, config.threshold)
            end

            -- Check Job
            if config.jobs then
                local jobMatch = false
                for _, job in ipairs(config.jobs) do
                    if mainJob == job then
                        jobMatch = true
                        break
                    end
                end
                if not jobMatch then
                    remove = true
                    if reason ~= "" then
                        reason = reason .. ", "
                    end
                    reason = reason .. "Job Mismatch"
                end
            end

            if remove then
                local msg = string.format("[EffectSanitizer] Detected invalid effect %d on %s. Reason: %s", config.effect, player:getName(), reason)
                print(msg)
                reportToGMs(msg)

                if enableRemoval then
                    player:delStatusEffect(config.effect)
                    player:printToPlayer(string.format("System removed invalid status effect (ID: %d). Reason: %s", config.effect, reason), xi.msg.channel.SYSTEM_3)
                end
            end
        end
    end
end

local function scanWorld()
    -- Iterate all zones
    local count = 0
    for i = 0, 299 do
        local zone = GetZone(i)
        if zone then
            local players = zone:getPlayers()
            for _, p in pairs(players) do
                checkPlayer(p)
                count = count + 1
            end
        end
    end
    -- print(string.format("[EffectSanitizer] Auto-scan checked %d players.", count))
    return count
end

-- Hook into Lower Jeuno's GameHour tick to run the scan roughly every 2.4 minutes.
-- Lower Jeuno is used as a "Heartbeat" zone since it is frequently loaded.
m:addOverride("xi.zones.Mine_Shaft_2716.Zone.onGameHour", function(zone)
    scanWorld()
end)

return m