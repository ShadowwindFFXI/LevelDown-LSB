require("modules/module_utils")

local m = Module:new("Battlefieldportal")

-- ============================================================================
-- 3. Mog Garden Teleporter to Walk of Echoes
-- ============================================================================
m:addOverride("xi.zones.Mog_Garden.Zone.onInitialize", function(zone)
    pcall(function() super(zone) end)

    zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = "Battle Hub",
        look = 2321,
        x = 318.7322,
        y = -0.2848,
        z = -586.4543,
        rotation = 116,
        widescan = 1,
        onTrigger = function(player, npc)
            local menu = {
                title = "Travel to the Battlefield Hub?",
                options = {
                    { "Yes", function(p)
                        p:injectActionPacket(p:getID(), 6, 643, 0, 0, 0, 10, 1)
                        p:timer(1000, function(p_timed) p_timed:setPos(-420, 14, -49, 192, xi.zone.WALK_OF_ECHOES) end)
                    end },
                    { "No", function(p) end }
                }
            }
            player:timer(50, function(p_timed) p_timed:customMenu(menu) end)
            return true
        end,
    })
end)

return m