----------------------------------------
require("modules/module_utils")
require("scripts/globals/npc_util")
----------------------------------------

local m = Module:new("skiprankmission")

    local function skip_cop (player)
    local missionCoP = {101, 110, 118, 128, 138, 218, 228, 238, 248, 257, 258, 318, 325, 335, 341, 350, 358, 368, 418, 428, 438, 448,
                        518, 530, 543, 552, 560, 568, 578, 618, 628, 638, 648, 718, 728, 738, 748, 758, 800, 818, 828, 840, 850}
    for i = 1, #missionCoP do
        player:addMission(6, missionCoP[i])
        player:completeMission(6, missionCoP[i])
    end
        player:addMission(6, 850) -- 
        player:addKeyItem(708) -- Mysterious Amulet
        player:addKeyItem(1111) -- Delkfutt Key 1111
        player:addKeyItem(591) -- Light of Dem
        player:addKeyItem(590) -- Light of Holla
        player:addKeyItem(592) -- Light of Mea
        player:addKeyItem(604) -- Pso'Xja Pass
        player:addKeyItem(593) -- Light of Vahzl
        player:addKeyItem(594) -- Light of Al'Taieu
    end

    local function skip_roz (player)
    local missionZM = {0, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 23, 24, 26, 27, 28, 30}
    for i = 1, #missionZM do
        player:addMission(3, missionZM[i])
        player:completeMission(3, missionZM[i])
    end
        player:addMission(3, 31) -- RoZ: Awakening
        player:addKeyItem(238) -- Sacrifical Chamber Key
        player:addKeyItem(247) -- Prismatic Fragment
        player:addKeyItem(452) -- Cerulean Crystal
    end

    local function skip_asa (player)
    local missionASA = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}
    for i = 1, #missionASA do
        player:addMission(11, missionASA[i])
        player:completeMission(3, missionASA[i])
    end
        player:addMission(3, 31) -- A_SHANTOTTO_ASCENSION_FIN
    end

    local function skip_soa (player)
    local missionSOA = {0, 1, 3, 5, 6, 7, 8, 9, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 23, 26, 27, 29,
                       30 ,31, 34, 35, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 55, 56, 57,
                       58, 59, 61, 62, 63, 66, 67, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 84,
                       85, 86, 87, 88, 89, 90 ,91 ,92 ,93, 94, 95, 96, 98, 99, 100, 101, 102, 103, 104, 105, 107, 108, 109, 110,
                       111, 112, 113, 114, 116, 117, 118, 120, 121, 123, 125, 129}
    for i = 1, #missionSOA do
        player:addMission(12, missionSOA[i])
        player:completeMission(12, missionSOA[i])
    end
        player:addMission(12, 130) -- THE_LIGHT_WITHIN
        player:addKeyItem(2280) -- HABITUAL_BEHAVIOR_BAROMETER
    end



    local function skip_toau (player)
    local missionTOAU = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29,
                       30 ,31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47}
    for i = 1, #missionTOAU do
        player:addMission(4, missionTOAU[i])
        player:completeMission(4, missionTOAU[i])
    end
        player:addMission(4, 47) -- 
        player:addKeyItem(780) -- PSC Wildcat Badge
        player:addKeyItem(783) -- PFC Wildcat Badge
        player:addKeyItem(784) -- SP Wildcat Badge
        player:addKeyItem(794) -- LC Wildcat Badge
        player:addKeyItem(795) -- C Wildcat Badge
        player:addKeyItem(825) -- S Wildcat Badge
        player:addKeyItem(826) -- SM Wildcat Badge
        player:addKeyItem(827) -- CS Wildcat Badge
        player:addKeyItem(894) -- SL Wildcat Badge
        player:addKeyItem(900) -- FL Wildcat Badge
        player:addKeyItem(909) -- CAPTAIN Wildcat Badge
        player:addKeyItem(812) -- Astral Compass
        player:addKeyItem(781) -- Boarding_permit

    end

    local function skip_wotg (player)
    local missionWOTG = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29,
                       30 ,31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53}
    for i = 1, #missionWOTG do
        player:addMission(5, missionWOTG[i])
        player:completeMission(5, missionWOTG[i])
    end
        player:addMission(5, 53) -- 
        player:addKeyItem(910) -- Pure White Feather
    end

    local function skip_rov (player)
    local missionROV = {0, 2, 3, 4, 6, 10, 12, 18, 20, 22, 26, 28, 30, 32, 34, 36, 40, 42, 44, 46, 48, 50, 52, 54, 56, 60, 62, 64, 66,
                        68, 70, 72, 78, 80, 83, 86, 92, 94, 96, 98, 100, 102, 103, 104, 106, 108, 110, 114, 116, 118, 120, 122, 124,
                        126, 130, 132, 136, 142, 144, 146, 150, 152, 154, 155, 156, 158, 160, 161, 162, 164, 166, 170, 172, 174, 178,
                        180, 184, 188, 190, 192, 194, 196, 198, 200, 202, 206, 210, 212, 216, 218, 220, 222, 224, 226}
    for i = 1, #missionROV do
        player:addMission(13, missionROV[i])
        player:completeMission(13, missionROV[i])
    end
        player:addMission(13, 226) -- 
        player:addKeyItem(2884) -- Rhapsody of white
        player:addKeyItem(2885) -- Rhapsody of umber
        player:addKeyItem(2886) -- Rhapsody of azure
        player:addKeyItem(2887) -- Rhapsody of crimson
        player:addKeyItem(2888) -- Rhapsody of emerald
        player:addKeyItem(2889) -- Rhapsody of mauve
        player:addKeyItem(2890) -- Rhapsody of fuchsia
        player:addKeyItem(2891) -- Rhapsody of puce
        player:addKeyItem(2892) -- Rhapsody of ochre
        player:addKeyItem(2989) -- dimensional compass
        player:addKeyItem(2893) -- scintillating phapsody
        player:addKeyItem(3026) -- Phoenix Blessing

    end

    local function skip_srank (player)
    local missionSR = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23}
        for i = 1, #missionSR do
             player:addMission(0, missionSR[i])
             player:completeMission(0, missionSR[i])
        end
            player:setRank(10)
            player:addMission(0, 23) -- 
            player:addKeyItem(35) -- Adventurers Certificate
            player:addKeyItem(8) -- Airship pass
    end

    local function skip_brank (player)
    local missionBR = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23}
         for i = 1, #missionBR do
             player:addMission(1, missionBR[i])
             player:completeMission(1, missionBR[i])
        end
            player:setRank(10)
            player:addMission(1, 23) -- 
            player:addKeyItem(35) -- Adventurers Certificate
            player:addKeyItem(8) -- Airship pass
    end

    local function skip_wrank (player)
    local missionWR = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23}
        for i = 1, #missionWR do
             player:addMission(2, missionWR[i])
             player:completeMission(2, missionWR[i])
        end
            player:setRank(10)
            player:addMission(2, 23) -- 
            player:addKeyItem(35) -- Adventurers Certificate
            player:addKeyItem(8) -- Airship pass
            player:addKeyItem(195) -- Portal Charm
            player:addKeyItem(36) -- Starway stairway bauble
    end

local menu  = {}
local page1 = {}
local page2 = {}
local delaySendMenu = function(player)
      player:timer(50, function(playerArg)
        playerArg:customMenu(menu)
    end)
end

menu =
{
    title = 'Skip Missions?',
    options = {},
}

page1 =
{
    {
        'Skip Nation',
        function(player)
            local playnat = player:getNation()        
             player:printToPlayer('Skipping your Nations missions!', 0, 'Wanheda')
                   if playnat == 0 then
                       skip_srank(player)
                   elseif playnat == 1 then
                       skip_brank(player)
                   elseif playnat == 2 then
                       skip_wrank(player)
                   end
        end,
    },
    {
        'Skip RoZ',
        function(player)
            player:printToPlayer('Skipping Missions for Rize of Zilart', 0, 'Wanheda')
            skip_roz(player)
        end,
    },
    {
        'Skip CoP',
        function(player)
            player:printToPlayer('Skipping Missions for Chains of Promethia', 0, 'Wanheda')
            skip_cop(player)
        end,
    },
	{
        'Skip ToAu',
        function(player)
            player:printToPlayer('Skipping Missions for Treasures of Aht Urhgan', 0, 'Wanheda')
            skip_toau(player)
        end,
    },
    {
        'Next Page',
        function(player)
                menu.options = page2
                delaySendMenu(player)
        end,
    },
}
page2 =
{

    {
        'Skip WoTg',
        function(player)
            player:printToPlayer('Skipping Missions for Wings fo the Goddess', 0, 'Wanheda')
            skip_wotg(player)
        end,
    },
    {
        'Skip RoV',
        function(player)
            player:printToPlayer('Skipping Missions for Rhapsodies of Vanadiel', 0, 'Wanheda')
            skip_rov(player)
        end,
    },
    {
        'Skip SoA',
        function(player)
            player:printToPlayer('Skipping Missions for Seekers of Adoulin', 0, 'Wanheda')
            skip_soa(player)
        end,
    },
    {
        'Skip AsA',
        function(player)
            player:printToPlayer('Skipping Missions for A Shantotto Ascension', 0, 'Wanheda')
            skip_asa(player)
        end,
    },
    {
        'Skip ALL',
        function(player)
            local playnat = player:getNation()        
             player:printToPlayer('Skipping your Nations missions!', 0, 'Wanheda')
                   if playnat == 0 then
                       skip_srank(player)
                   elseif playnat == 1 then
                       skip_brank(player)
                   elseif playnat == 2 then
                       skip_wrank(player)
                   end
            player:printToPlayer('Skipping Missions for Rize of Zilart', 0, 'Wanheda')
            skip_roz(player)
            player:printToPlayer('Skipping Missions for Chains of Promethia', 0, 'Wanheda')
            skip_cop(player)
            player:printToPlayer('Skipping Missions for Treasures of Aht Urhgan', 0, 'Wanheda')
            skip_toau(player)
            player:printToPlayer('Skipping Missions for Wings fo the Goddess', 0, 'Wanheda')
            skip_wotg(player)
            player:printToPlayer('Skipping Missions for Rhapsodies of Vanadiel', 0, 'Wanheda')
            skip_rov(player)
            player:printToPlayer('Skipping Missions for Seekers of Adoulin', 0, 'Wanheda')
            skip_soa(player)
            player:printToPlayer('Skipping Missions for A Shantotto Ascension', 0, 'Wanheda')
            skip_asa(player)
        end,
    },
    {
        'Back',
        function(player)
                menu.options = page1
                delaySendMenu(player)
        end,
    },
}

omixi.util.liveReload(m, {
    ["Celennia_Memorial_Library"] =
    {
        {
            objtype   = xi.objType.NPC,
            name      = "Wanheda",
            look = omixi.util.look({
                race = xi.race.TARU_F,
                face = omixi.face.A3,
                head = 332, -- Shaded Spectacles
                body = 338, -- Samnuha Coat
                hand = 338, -- Seiryu's Kote
                legs = 339, -- Savant's Pants
                feet = 339, -- Savant's Loafers
                main = 833, -- Epeolarty
            }),
            x         = -108.2594,
            y         = -2.1500,
            z         = -91.7542,
            rotation  = 46,
            onTrade   = function(player, npc, trade)
--            if npcUtil.tradeHasExactly(trade, xi.item.CARBUNCLES_RUBY) then -- 1125
--		        player:confirmTrade()
--                player:printToPlayer('You have given me what i seek!', 0, npc:getPacketName())
--                player:printToPlayer('There is no going back after this, so choose wisley!', 0, npc:getPacketName())
--                menu.options = page1
--                delaySendMenu(player)
--		  end
        end,

            onTrigger = function(player, npc)
			local levelLimit      = player:hasKeyItem(xi.ki.VIAL_OF_CHAOSS_BLOOD) and 1 or 2
			if 
			    levelLimit == 1 
			then
			player:printToPlayer('HA HA HA HA HA Nice try silly head.!', 0, npc:getPacketName())
			return
			end
--			if player:hasKeyItem(xi.ki.AFTER_PARTY_PASS) then
--		        player:printToPlayer('Holy Shit where did you get that After Party Pass!', 0, npc:getPacketName())
                player:printToPlayer('I guess you do you... Enjoy!', 0, npc:getPacketName())
                menu.options = page1
                delaySendMenu(player)
            
--			else
--       player:printToPlayer('So... you want to take the easy way out huh?', 0, npc:getPacketName())
--        player:printToPlayer('Tell you what, bring me a carby ruby and Ill unlock one thing at a time.', 0, npc:getPacketName())
		npc:facePlayer(player, true)
--       end
		end,
        },

		{
            objtype   = xi.objType.NPC,
            name      = "Sandy Balls",
            look = omixi.util.look({
                race = xi.race.TARU_M,
                face = 29,
                head = 304,
                body = 344,
                hand = 344,
                legs = 344,
                feet = 344,
            }),
                x = -100.6375,
                y = -2.1500,
                z = -93.8841,
                rotation  = 123,
                onTrigger = function(player, npc)
                local levelLimit      = player:hasKeyItem(xi.ki.VIAL_OF_CHAOSS_BLOOD) and 1 or 2
                if 
			    levelLimit == 1 
                then
                player:printToPlayer('Better luck next time.!', 0, npc:getPacketName())
                return
                end
                local keyIds =
                {
                    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20 ,21, 22, 23,
                    24, 25 ,26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44,
                    45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60 ,61, 62, 63, 64, 65,
                    66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86,
                    87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106,
                    107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121,
                }
            
                -- add teleports
                for _, v in ipairs(keyIds) do
                    if not player:hasTeleport(xi.teleport.type.HOMEPOINT,  v % 32, math.floor(v / 32)) then
                    player:addTeleport(xi.teleport.type.HOMEPOINT, v % 32, math.floor(v / 32))
                end
                end
            
                player:printToPlayer(string.format('%s now has all homepoints.', player:getName()))
                end,
        },        
	    {
            objtype   = xi.objType.NPC,
            name      = "Pokey Balls",
            look = omixi.util.look({
                race = xi.race.TARU_M,
                face = 29,
                head = 344,
                body = 344,
                hand = 344,
                legs = 344,
                feet = 344,
            }),
            x         = -101.9950,
            y         = -2.1500,
            z         = -97.6626,
            rotation  = 169,
			onTrigger = function(player, npc)
                local levelLimit      = player:hasKeyItem(xi.ki.VIAL_OF_CHAOSS_BLOOD) and 1 or 2
                if 
			    levelLimit == 1 
                then
                player:printToPlayer('Yea I am not getting in trouble for you!', 0, npc:getPacketName())
                return
                end
			    local keyIds =
                {
                    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20 ,21, 22, 23,
                    24, 25 ,26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44,
                    45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60 ,61, 62, 63, 64, 65,
                    66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86,
                    87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 
                }
                
                -- add survival
                for _, v in ipairs(keyIds) do
                    if not player:hasTeleport(xi.teleport.type.SURVIVAL,  v % 32, math.floor(v / 32)) then
                    player:addTeleport(xi.teleport.type.SURVIVAL,v % 32, math.floor(v / 32))
                end
                end
                
                player:printToPlayer(string.format('%s now has all survival guides.', player:getName()))
				end,
        },
		{
            objtype = xi.objType.NPC,
            name = "Cait Sith",
            look = 2197,
            x = -109.0064,
            y = -2.1500,
            z = -96.0600,
            rotation = 236,
            widescan = 1,
		    
            onTrade = function(player, npc, trade)
                 player:printToPlayer("No, thanks!", 0, npc:getPacketName())
            end,
		    
            onTrigger = function(player,npc)
            local levelLimit      = player:hasKeyItem(xi.ki.VIAL_OF_CHAOSS_BLOOD) and 1 or 2
                if 
			    levelLimit == 1 
                then
                player:printToPlayer('I saw this in a movie once, sorry cant help you!', 0, npc:getPacketName())
                return
                end
			local maxlevel = xi.settings.main.MAX_LEVEL
                player:printToPlayer('Welcome to OmicronXI, here is a Head Start for you!', 0, npc:getPacketName())
				player:printToPlayer('Level Cap is now 99, SJ Quest Complete and Merit/JP KI!', 0, npc:getPacketName())
                player:setLevelCap(maxlevel)
    	    	player:unlockJob(0)
    	    	for i = xi.job.PLD, xi.job.RUN do
                player:unlockJob(i)
                end
                for i = xi.ki.MAP_OF_THE_SAN_DORIA_AREA, xi.ki.MAP_OF_DIO_ABDHALJS_GHELSBA do
                player:addKeyItem(i)
                end
                for i = xi.ki.MAP_OF_AL_ZAHBI, xi.ki.MAP_OF_RAKAZNAR do
                player:addKeyItem(i)
                end
                for i = xi.ki.MAP_OF_RALA_WATERWAYS_U, xi.ki.MAP_OF_RAKAZNAR_U do
                player:addKeyItem(i)
                end
                for i = xi.ki.MAP_OF_ESCHA_ZITAH, xi.ki.MAP_OF_REISENJIMA do
                player:addKeyItem(i)
                end
    	    	npcUtil.giveKeyItem(player, xi.ki.LIMIT_BREAKER)
    	    	npcUtil.giveKeyItem(player, xi.ki.JOB_BREAKER)
                 
             end,
        },
{
            objtype   = xi.objType.NPC,
            name      = "Hidden Goblix",
            look      = 128,
            x         = -100.1871,
            y         = -2.1499,
            z         = -84.4728,
            rotation  = 202,
            widescan  = 1,

            onTrigger = function(player, npc)
                
                -- 1. Helper Function for Menu Delay
                local function openMenu(p, menuDef)
                    p:timer(50, function(pArg)
                        pArg:customMenu(menuDef)
                    end)
                end

                -- 2. Define the Menu
                local entryMenu = {
                    title = "Where do you want to be alone?",
                    options = {
                        {
                            "Sandoria [Solitude]",
                            function(playerArg)
                                -- Check if already in an instance
                                local currentInstance = playerArg:getInstance()
                                if currentInstance and currentInstance:getID() == 40001 then
                                    playerArg:printToPlayer("You are already inside Sandoria Instance!")
                                    return
                                end

                                -- Attempt to enter Sandoria (40001)
                                -- Triggering Dyna_D_Sandoria.lua
                                playerArg:createInstance(40001, 0) 
                                playerArg:printToPlayer("Requesting Entry to Sandoria [Solitude]...")
                            end,
                        },
                        {
                            "Windurst [Solitude]",
                            function(playerArg)
                                -- Check if already in an instance
                                local currentInstance = playerArg:getInstance()
                                if currentInstance and currentInstance:getID() == 40002 then
                                    playerArg:printToPlayer("You are already inside Windurst Instance!")
                                    return
                                end

                                -- Attempt to enter Windurst (40002)
                                -- Triggering Dyna_D_Windurst.lua
                                playerArg:createInstance(40002, 0)
                                playerArg:printToPlayer("Requesting Entry to Windurst [Solitude]...")
                            end,
                        },
                        {
                            "Nevermind",
                            function(playerArg) end,
                        }
                    }
                }

                -- 3. Open it
                openMenu(player, entryMenu)
            end,
        },
	},	
})

return m