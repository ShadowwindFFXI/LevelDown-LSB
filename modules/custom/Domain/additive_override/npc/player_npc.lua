---------------------------------------
-- Custom Player NPC's
----------------------------------------
require("modules/module_utils")
require("scripts/globals/npc_util")
----------------------------------------

local m = Module:new("playernpc")
omixi.util.liveReload(m, {
    ["Attohwa_Chasm"] =
	{
        {
            objtype   = xi.objType.NPC,
            name      = "Villanelle",
            look = omixi.util.look({
                race = xi.race.MITHRA,
                face = omixi.face.A6,
                head = 4589, -- Envy Crown
                body = 8685, -- Envy Cyclas
                hand = 12781, --  Envy Gauntlets
                legs = 16877, -- Envy Flanchard
                feet = 20973, -- Envy Sollerets 
                main = 544, --  Mpu gandring
				offh = 787, -- Onion Sword III
            }),
            x         = 276.9977,
            y         = -19.0011,
            z         = -82.8284,
            rotation  = 99,
            onTrigger = function(player, npc)
                    local stock =
                    {
                        { 15543,2500000 }, -- Raja's Ring
                        { 15544,2500000 }, -- Sattva Ring
                        { 15545,2500000 }, -- Tamas Ring
                        { 14812,2500000 }, -- Loquac. Earring
                        { 14813,2500000 }, -- Brutal Earring
                        { 14739,2500000 }, -- Suppanomimi 
                    	{ 14741,2500000 }, -- Abyssal Earring 
                        { 14742,2500000 }, -- Beastly Earring
                        { 14743,2500000 }, -- Bushinomimi
                        { 14740,2500000 }, -- Knight's Earring
                    	{ 28402,5000000 }, -- Asperity Necklace
                        { 28523,5000000 }, -- Heartseeker Earring 
                        { 28522,5000000 }, -- Dudgeon Earring
                        { 28520,5000000 }, -- Steelflash Earring 
                        { 28521,5000000 }, -- Bladeborn Earring 
                        { 28401,5000000 }, -- Eddy Necklace  
                    	{ 28525,5000000 }, -- Psystorm Earring 
                        { 28524,5000000 }, -- Lifestorm Earring 
                    	{ 10431,1000000 }, -- Decennial Tiara
                    }
            npc:facePlayer(player,true)
            player:printToPlayer(' You climbed all this way, for this? ',0,'Villanelle')
            xi.shop.general(player,stock)
            end,	
        },
	},
	["Misareaux_Coast"] =
    {
        {
            objtype   = xi.objType.NPC,
            name      = "Demetrie",
            look = omixi.util.look({
                race = xi.race.HUME_M,
                face = omixi.face.B8,
                head = 388, -- Shaded Spectacles
                body = 252, -- Samnuha Coat
                hand = 252, -- Seiryu's Kote
                legs = 252, -- Savant's Pants
                feet = 252, -- Savant's Loafers
                main = 573, -- Caladbolg
            }),
            x         = -111.9279,
            y         = -16.0669,
            z         = 548.2332,
            rotation  = 184,
            onTrade   = function(player, npc, trade)
            end,
            onTrigger = function(player, npc)
            player:printToPlayer('So... you want to die today huh? Leave me the hell alone!' , 0, npc:getPacketName())
            npcUtil.fishingAnimation(npc, 1)
		    end,
			
        },
	},
	["Southern_San_dOria"] =
	{
	    {
            objtype   = xi.objType.NPC,
            name      = "Hadu",
            look = omixi.util.look({
                race = xi.race.MITHRA,
                face = omixi.face.B8,
                head = 83, 
                body = 135, 
                hand = 82, 
                legs = 83, 
                feet = 131, 
                main = 331,
            }),
            x         = 94.0899,
            y         = 4.000,
            z         = 68.918,
            rotation  = 20,
            onTrade   = function(player, npc, trade)
            end,
            onTrigger = function(player, npc)
            player:printToPlayer('All that buildup, and that was the best you could do?' , 0, npc:getPacketName())
		    end,	
		
		},
		{
            objtype   = xi.objType.NPC,
            name      = "Aerhys",
            look = omixi.util.look({
                race = xi.race.MITHRA,
                face = omixi.face.A8,
--              head = 83, 
                body = 287, 
                hand = 75, 
                legs = 75, 
                feet = 287, 
                main = 814,
				offh = 513,
            }),
            x         = 78,
            y         = 2,
            z         = 7.6,
            rotation  = 19,
            onTrade   = function(player, npc, trade)
            end,
            onTrigger = function(player, npc)
            player:printToPlayer('Meowdy parrrtner! My youre lookin a little rough arrround the edges. Maybe sprrruce up your look a bit! ' , 0, npc:getPacketName())
		    end,	
				
		},
				{
            objtype   = xi.objType.NPC,
            name      = "Starless",
            look = omixi.util.look({
                race = xi.race.TARU_M,
                face = omixi.face.B6,
                head = 388, 
                body = 297, 
                hand = 465, 
                legs = 166, 
                feet = 580, 
                main = 381,
				offh = 419,
            }),
            x         = 78.876,
            y         = 2,
            z         = 8.515,
            rotation  = 19,
            onTrade   = function(player, npc, trade)
            end,
            onTrigger = function(player, npc)
            player:printToPlayer('Oh, moogley-my! That sure is a boring-woring weapon youve got there!' , 0, npc:getPacketName())
            player:printToPlayer('Ive got some awesomely awesome fantacular weaponry that you could use to liven things up a bit!',0, npc:getPacketName())
		    end,	
				
		},
    },
	
})

return m