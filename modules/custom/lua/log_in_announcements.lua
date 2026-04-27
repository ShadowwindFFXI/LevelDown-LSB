require('modules/module_utils')
require('scripts/globals/mobs')
require('scripts/globals/player')
-----------------------------------
local m = Module:new('log_in_announcements')

local openingDecoration = '\129\154'
local mid1Decoration = '\129\155'
local mid2Decoration = '\129\154'
local closingDecoration = '\129\154'
local end1Decoration = '\129\154'
local end2Decoration = '\129\155'

m:addOverride('xi.player.onGameIn', function(player, firstLogin, zoning)
        -- Check if it's an initial login before super() clears it to 0
        local isGameLogin = player:getLocalVar('gameLogin') == 1

        super(player, firstLogin, zoning)

        if isGameLogin then
            player:timer(2500, function(playerArg)
                local worldMessage = string.format('%s has logged in!', playerArg:getName())
                local decoratedMessage = string.format('%s %s %s %s %s %s %s', openingDecoration, mid1Decoration, mid2Decoration, worldMessage, end1Decoration, end2Decoration, closingDecoration)
                playerArg:printToArea(decoratedMessage, xi.msg.channel.SYSTEM_3, 0, '')
            end)
        end
end)

return m
