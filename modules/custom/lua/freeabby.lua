require('modules/module_utils')

local m = Module:new('freeabby')

m:addOverride('xi.abyssea.onZoneIn', function(player)
    super(player)
    player:addStatusEffect(xi.effect.VISITANT, { duration = 28800, origin = player }) -- 8hr 
end)

return m
