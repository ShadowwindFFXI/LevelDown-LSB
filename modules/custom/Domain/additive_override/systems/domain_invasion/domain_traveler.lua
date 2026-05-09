-----------------------------------
-- Spicy Traveler
-----------------------------------
-- !pos -9 -6 -26 245
-----------------------------------
require("modules/module_utils")
require('scripts/globals/npc_util')
require("scripts/utils/utils")
-----------------------------------
local m = Module:new("spicy_traveler")

local locations =
{
    {  -99.912,    0.526,  365.000, 180, 261, "Ceizak Battlegrounds"  },
    { -100.344,   -0.589, -353.977,  66, 262, "Foret de Hennetiel"    },
    { -422.780,  -63.265,  466.000, 160, 265, "Morimar Basalt Fields" },
    { -450.680,    0.421,  -99.540, 135, 263, "Yorcia Weald"          },
    {   28.000,  -60.000,  180.000,   0, 266, "Marjami Ravine"        },
    {  275.975,   20.250,  323.825,  28, 267, "Kamihr Drifts"         },
    {  685.000, -405.000, -479.950,   0, 277, "Ra'Kaznar Turris"      },
}

local function onTrade(player, npc, trade)
    local spicyTravels = player:getCharVar("[Domain]SpicyTravels")

    -- Reward players with a domain ring once they reach 100 'flights'
    if npcUtil.tradeHasExactly(trade, { 15771, {"gil", 50000 }}) then
        if npcUtil.giveItem(player, 15771) then
            player:tradeComplete()
            npc:facePlayer(player, true)
            player:printToPlayer("Your ring has been re-charged!", 0, npc:getPacketName())
            -- Mechanism for players to replace their rings for whatever reason
        elseif
            npcUtil.tradeHasExactly(trade, {"gil", 500000 }) and
            spicyTravels >= 100
        then
            if npcUtil.giveItem(player, 15771) then
                player:tradeComplete()
                npc:facePlayer(player, true)
                player:printToPlayer("Your ring has been replaced, don't ask me for a new one!", 0, npc:getPacketName())
            end
        end
    end
end

local extraRewards =
{
    NQMat =
    {
        3980, -- Bztavian Stinger
        3979, -- Rockfin Tooth
        3977, -- Gabbrath Horn
        4014, -- Yggdreant Bole
        4012, -- Waktza Rostrum
        8752, -- Cehuetzi Claw
    },
    HQMat =
    {
        3981, -- Bztavian Wing
        3978, -- Rockfin Fin
        4015, -- Yggdreant Root
        4013, -- Waktza Crest
        8754, -- Cehuetzi Pelt
    },
}

local prowessRewards =
{
    { amount =  25, item = { { 8798, 5 } },          bonus = "All Attributes+"             }, -- H-P Bayld x5
    { amount =  50, item = xi.item.DOMAIN_COFFER,    bonus = "Accuracy+ / M.Accuracy+"     }, -- Accuracy+20 / M.Accuracy+15
    { amount =  75, item = "NQMat",                  bonus = "Amchuchu's Armoury"          }, -- Body Boost, Mana Boost, Dusty Elixir, Catholicon
    { amount = 100, item = xi.item.DOMAIN_COFFER_P1, bonus = "Attack+ / M.Attack+"         }, -- Attack+50 / M.Attack+25
    { amount = 125, item = "HQMat",                  bonus = "Dbl. Attack+% / Fast Cast+%" }, -- DA+5% / FC+5%
}

local missedNq = fmt("[Domain]Missed_{}", xi.item.DOMAIN_COFFER)
local missedHq = fmt("[Domain]Missed_{}", xi.item.DOMAIN_COFFER_P1)

local function onTrigger(player, npc)
    npc:facePlayer(player, true)

    if player:getMainLvl() < 75 then
        player:printToPlayer("You must reach Level 75 to use This GM's Travels.", xi.msg.channel.SYSTEM_3)
        return
    end

    local missedNqQty = player:getCharVar(missedNq)
    local missedHqQty = player:getCharVar(missedHq)

    if missedNqQty > 0 then
        omixi.util.dialog(player, {
            "Hey, it looks like your dropped this.",
        }, npc:getPacketName(), { npc = npc })

        if npcUtil.giveItem(player, { { xi.item.DOMAIN_COFFER, missedNqQty } }) then
            player:setCharVar(missedNq, 0)
        end

        return
    end

    if missedHqQty > 0 then
        omixi.util.dialog(player, {
            "Hey, it looks like your dropped this.",
        }, npc:getPacketName(), { npc = npc })

        if npcUtil.giveItem(player, { { xi.item.DOMAIN_COFFER_P1, missedHqQty } }) then
            player:setCharVar(missedHq, 0)
        end

        return
    end

    local currentMidnight     = getVanaMidnight()
    local questMidnight       = player:getCharVar("[DQ]Midnight")
    local dailyQuestCompleted = player:getCharVar("[DQ]Completed")
    local spicyTravels        = player:getCharVar("[Domain]SpicyTravels") + 1
    local slacker             = player:getCharVar("[Domain]Slacker")
    local lockoutTime         = player:getCharVar("[Domain]Lockout")
    local diLocation          = GetServerVariable("[Domain]NM")
    local location            = locations[diLocation]

    -- Cosmetic variables for number prints
    local lastNum             = string.sub(spicyTravels, -1)
    local daySuffix           = "th"
    local titleText           = ""
    local zoneName            = ""
    local tpCost              = 5000

    -- Determine which suffix we append to the number
    if lastNum == "1" then
        daySuffix = "st"
    elseif lastNum == "2" then
        daySuffix = "nd"
    elseif lastNum == "3" then
        daySuffix = "rd"
    end

    local domainsCompleted = player:getCharVar("[Domain]Completed")
    local dailiesCompleted = player:getCharVar("[DQ]Completed")
    local rewards = player:getCharVar("[Domain]Prowess_Reward")

    if player:getLocalVar("DOMAIN_REWARD") ~= 0 then
        return
    end

    for rewardIndex, prowessReward in pairs(prowessRewards) do
        if
            domainsCompleted >= prowessReward.amount and
            not utils.mask.getBit(rewards, rewardIndex)
        then
            omixi.util.dialog(player, {
                fmt("In recognition of your amazing efforts today and for conquering {} domains, I'd like to offer you this additional reward!", prowessReward.amount),
                { emote = xi.emote.BOW },
            }, npc:getPacketName(), { npc = npc })

            player:setLocalVar("DOMAIN_REWARD", 1)
            player:timer(3000, function()
                local rewardItem = prowessReward.item

                if type(rewardItem) == "string" then
                    rewardItem = extraRewards[rewardItem][math.random(1, #extraRewards[rewardItem])]
                end

                if npcUtil.giveItem(player, rewardItem) then
                    local result = utils.mask.setBit(rewards, rewardIndex, true)

                    player:setCharVar("[Domain]Prowess_Reward", result, JstMidnight())
                    player:sys("New Prowess Bonus: \129\154 {} \129\154", prowessReward.bonus)
                end

                player:setLocalVar("DOMAIN_REWARD", 0)
            end)

            return
        end
    end

    local dailyBonus = utils.clamp(math.floor(domainsCompleted / 5) + dailiesCompleted, 0, 5)
    local prowessMsg = fmt("Domain Prowess: {}{}", string.rep("\129\154", dailyBonus), string.rep("\129\153", 5 - dailyBonus))

    if domainsCompleted >= 125 then
        prowessMsg = fmt("{} +5", prowessMsg)
    elseif domainsCompleted >= 100 then
        prowessMsg = fmt("{} +4", prowessMsg)
    elseif domainsCompleted >= 75 then
        prowessMsg = fmt("{} +3", prowessMsg)
    elseif domainsCompleted >= 50 then
        prowessMsg = fmt("{} +2", prowessMsg)
    elseif domainsCompleted >= 25 then
        prowessMsg = fmt("{} +1", prowessMsg)
    end

    prowessMsg = fmt("{} ({} Daily Quests, {} Domains Conquered)", prowessMsg, dailiesCompleted, domainsCompleted)

    omixi.util.dialog(player, {
        fmt("Domain Invasion is currently happening in {}. Need a lift? The ride's free if you've accumulated enough Domain Prowess today.", location[6]),
        {
            message = prowessMsg,
        },
    })

    -- Players fly for free if they have at least 2 daily quests (or 10 domains) complete
    if dailyBonus >= 2 then
        titleText = "Take a lift from a stranger? (It's FREE!)"
        tpCost    = 0
    else
        titleText = string.format("Risk it for %ug? (%i available).", tpCost, player:getGil())
    end

    player:timer(1000, function(playerArg)
        local menu =
        {
            title = string.format(titleText),

            options =
            {
                {
                    "Yes",
                    function(playerArg)
                        if playerArg:getGil() < tpCost then
                            player:printToPlayer("You don't have enough gil to take this ride!", 0, npc:getPacketName())
                            return
                        end

                        playerArg:setCharVar("[Domain]SpicyTravels", spicyTravels)
                        if spicyTravels == 100 then
                            if npcUtil.giveItem(playerArg, 15771) then
                                npc:lookAt(playerArg:getPos())
                                playerArg:timer(1000, function(playerArgTimer)
                                    playerArg:printToPlayer("I guess you've earned this ...", 0, npc:getPacketName())
                                end)
                            end
                        else
                            -- Restore player's HP/MP
                            player:addHP(player:getMaxHP())
                            player:addMP(player:getMaxMP())
                            player:resetAbilities()

                            playerArg:delGil(tpCost)
                            playerArg:timer(1000, function(playerArgTimer)
                                npc:lookAt(playerArgTimer:getPos())
                                player:printToPlayer(string.format("Thank you for choosing Air-Stinkie, this makes your %i%s flight with us!", spicyTravels, daySuffix), 0, npc:getPacketName())
                            end)
                            playerArg:timer(2000, function (playerArgTimer)
                                playerArgTimer:injectActionPacket(playerArg:getID(), 6, 600, 0, 0, 0, 0, 0)
                                npcUtil.giveItem(playerArgTimer, xi.item.SCROLL_OF_INSTANT_WARP)
                            end)
                            playerArg:timer(3500, function(playerArgTimer)
                                playerArgTimer:setPos(location[1], location[2], location[3], location[4], location[5])
                            end)
                        end
                    end,
                },
                {
                    "Hell, No.",
                    function(playerArg)
                        playerArg:printToPlayer("Fine, I dont like your attitude anyways!", 0, npc:getPacketName())
                    end,
                },
            },
        }
        player:customMenu(menu)
    end)
end


omixi.util.liveReload(m, {
    ["Lower_Jeuno"] =
    {
        {
            objtype   = xi.objType.NPC,
            name      = "[GM] Traveler",
            look = omixi.util.look({
                race = xi.race.HUME_M,
                face = omixi.face.B8,
                head = 30, -- Shaded Spectacles
                body = 30, -- Samnuha Coat
                hand = 30, -- Seiryu's Kote
                legs = 30, -- Savant's Pants
                feet = 30, -- Savant's Loafers
                main = 390, -- Caladbolg
				offh = 22,
            }),
            x         = 4.699,
            y         = -6.00,
            z         = -10.334,
            rotation  = 83,
            onTrade   = onTrade,
            onTrigger = onTrigger,
        },
    },
    ["Upper_Jeuno"] =
    {
        {
            objtype   = xi.objType.NPC,
            name      = "Epic Traveler",
            look = omixi.util.look({
                race = xi.race.TARU_M,
                face = omixi.face.A1,
                head = 299,
                body = 299,
                hand = 299,
                legs = 299,
                feet = 299,
				main = 480,
            }),
            x         = -57.151,
            y         = 1.000,
            z         = 12.160,
            rotation  = 170,
            onTrade   = onTrade,
            onTrigger = onTrigger,
        },
    },
    ["Celennia_Memorial_Library"] =
    {
        {
            objtype   = xi.objType.NPC,
            name      = "Hadu Traveler",
            look = omixi.util.look({
                race = xi.race.TARU_M,
                face = omixi.face.A1,
                head = 299,
                body = 331,
                hand = 299,
                legs = 299,
                feet = 299,
				main = 480,
            }),
            x         = -99.175,
            y         = -2.149,
            z         = -86.865,
            rotation  = 62,
            onTrade   = onTrade,
            onTrigger = onTrigger,
        },
    },
})

return m
