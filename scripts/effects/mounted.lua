-----------------------------
-- xi.effect.MOUNTED
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    -- Escha Silt check
    if target:isPC() then
        local eschaZones = {
            [xi.zone.ESCHA_ZITAH] = true,
            [xi.zone.ESCHA_RUAUN] = true,
            [xi.zone.REISENJIMA] = true,
        }
        local zoneId = target:getZoneID()

        if eschaZones[zoneId] then
            local siltCost = 1000
            if target:getCurrency('escha_silt') < siltCost then
                target:printToPlayer("You do not have enough Escha silt to summon a mount here.", xi.msg.channel.SYSTEM_3)
                return false -- This will prevent the effect from being applied.
            else
                target:delCurrency('escha_silt', siltCost)
                target:printToPlayer(string.format("You spend %d Escha silt to summon your mount.", siltCost), xi.msg.channel.SYSTEM_3)
            end
        end
    end

    local mountId = effect:getPower()
    -- Retail sends a music change packet (packet ID 0x5F) in both cases.

    local animation = xi.animation.NONE

    if
        mountId == xi.mount.CHOCOBO or
        mountId == xi.mount.NOBLE_CHOCOBO
    then
        target:changeMusic(4, 212)
        animation = xi.anim.CHOCOBO
    else
        target:changeMusic(4, 84)
        animation = xi.anim.MOUNT
    end

    if not target:isInEvent() then
        target:setAnimation(animation)
    end

    -- Chocobo and mounts uncharm current pet
    local pet = target:getPet()
    if pet ~= nil and pet:isCharmed() then
        target:despawnPet()
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    if not target:isInEvent() then -- Paranoia safety check
        target:setAnimation(xi.anim.NONE)
    end

    -- Remove CharVars from player participating in chocobo riding game
    if target:isPC() then
        xi.chocoboGame.dismountChoco(target)
    end
end

return effectObject
