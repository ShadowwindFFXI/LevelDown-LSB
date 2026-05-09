-----------------------------------
-- Domain Officier
-----------------------------------
-- !pos -9 -6 -26 245
-----------------------------------
require("modules/module_utils")
require('scripts/globals/npc_util')
require("scripts/utils/utils")
-----------------------------------
local m = Module:new("npc_domain_officer")

local vars =
{
    progress = "PaidForMeritWs"
}

local nationCurrency =
{
    [xi.nation.SANDORIA] = "sandoria_cp",
    [xi.nation.BASTOK]   = "bastok_cp",
    [xi.nation.WINDURST] = "windurst_cp",
}

local currencyList =
{
    { "Conquest Points",   "conquest_points"   },
    { "Imperial Standing", "imperial_standing" },
    { "Allied Notes",      "allied_notes"      },
}

local itemNames =
{
    [1464] = "lancewood logs",
    [1466] = "relic irons",
    [1469] = "wootz ores",
    [1470] = "sparkling stones",
    [1474] = "infinity cores",
    [1516] = "griffon hides",
    [1517] = "giant frozen heads",
    [1518] = "colossal skulls",
    [1519] = "fresh orc livers",
    [1520] = "goblin grease",
    [1521] = "slime juice",
}

local refunds =
{
    { name = "Uk'uxkaj Cap",     id = 27766, value = 30000 },
    { name = "Uk'uxkaj Boots",   id = 28331, value = 30000 },
    { name = "Floral Gauntlets", id = 27137, value = 30000 },
    { name = "Vampirism",        id = 20706, value = 60000 },
    { name = "Taming Sari",      id = 20596, value = 60000 },

    { name = "Samnuha Tights",   id = 27295, value = 30000 },
    { name = "Samnuha Coat",     id = 26973, value = 30000 },
    { name = "Mediums Sabots",   id = 27493, value = 30000 },
    { name = "Merovingian",      id = 20796, value = 60000 },
    { name = "Ochu",             id = 20978, value = 60000 },

    { name = "Jumalik Helm",     id = 25603, value = 30000 },
    { name = "Jumalik Mail",     id = 26972, value = 30000 },
    { name = "Dampening Tam",    id = 25630, value = 30000 },
    { name = "Divinity",         id = 21088, value = 60000 },
    { name = "Malevolence",      id = 20595, value = 60000 },
}

local items =
{
    {
        "Consumables & Materials",
        {
            { "Teleport Ring: Holla",            14661,  500 },
            { "Teleport Ring: Dem",              14662,  500 },
            { "Teleport Ring: Mea",              14663,  500 },
            { "Siren's Hair",                     1313,  500 },
            { "Scintillant Ingot",                2275,  500 },
            { "Beech Log",                         692, 1000 },
            { "Khimaira Horn",                    2371, 1500 },
            { "Aether Dust",                      9470, 1500 },
            { "Gabbrath Horn",                    3977, 3000 },
            { "Rockfin Tooth",                    3979, 3000 },
            { "Bztavian stinger",                 3980, 3000 },
            { "Waktza Rostrum",                   4012, 3000 },
            { "Yggdreant Bole",                   4014, 3000 },
            { "Cehuetzi Claw",                    8752, 3000 },
            { "Cipher: Mayakov",                 10151, 5000 },
        },
    },
    {
        "Weapons & Armor",
        {
            { "Yorium Barbuta",                26733, 1500 },
            { "Yorium Cuirass",                26891, 1500 },
            { "Yorium Gauntlet",               27045, 1500 },
            { "Yorium Cuisses",                27232, 1500 },
            { "Yorium Sabatons",               27402, 1500 },
            { "Acro Helm",                     26734, 1500 },
            { "Acro Surcoat",                  26892, 1500 },
            { "Acro Gauntlets",                27046, 1500 },
            { "Acro Breeches",                 27233, 1500 },
            { "Acro Leggings",                 27403, 1500 },
            { "Taeon Chapeau",                 26735, 1500 },
            { "Taeon Tabard",                  26893, 1500 },
            { "Taeon Gloves",                  27047, 1500 },
            { "Taeon Tights",                  27234, 1500 },
            { "Taeon Boots",                   27404, 1500 },
            { "Telchine Cap",                  26736, 1500 },
            { "Telchine Chas",                 26894, 1500 },
            { "Telchine Gloves",               27048, 1500 },
            { "Telchine Braconi",              27235, 1500 },
            { "Telchine Pigaches",             27405, 1500 },
            { "Helios Band",                   26737, 1500 },
            { "Helios Jacket",                 26895, 1500 },
            { "Helios Gloves",                 27049, 1500 },
            { "Helios Spats",                  27236, 1500 },
            { "Helios Boots",                  27406, 1500 },
            { "Labraunda",                     21774, 4500 },
            { "Sagitta",                       21523, 4500 },
            { "Asclepius",                     22035, 4500 },
            { "Kaumodaki",                     22093, 4500 },
            { "Crocea Mors",                   21627, 4500 },
            { "Gandring",                      21575, 4500 },
            { "Moralltach",                    21630, 4500 },
            { "Father Time",                   21825, 4500 },
            { "Pangu",                         21717, 4500 },
            { "Barfawc",                       21578, 4500 },
            { "Sharanga",                      22149, 4500 },
            { "Fusenaikyo",                    21970, 4500 },
            { "Fudo Masamune",                 21917, 4500 },
            { "Aram",                          21878, 4500 },
            { "Draumstafir",                   22096, 4500 },
            { "Zomorrodnegar",                 21633, 4500 },
            { "Rostam",                        21581, 4500 },
            { "Xiucoatl",                      21526, 4500 },
            { "Setan Kober",                   21584, 4500 },
            { "Musa",                          22099, 4500 },
            { "Bhima",                         22038, 4500 },
            { "Morgelai",                      21669, 4500 },

        },
    },
    {
        "Accessories",
        {
		    { "Sand Charm",                    13095, 100  },
            { "Ioskeha Belt +1",               26334, 2500 },
            { "Moonbow Belt +1",               26341, 2500 },
            { "Sailfi Belt +1",                28428, 2500 },
            { "Mache Earring +1",              26081, 2500 },
            { "Moonbeam Nodowa",               26035, 2500 },
            { "Yetshila +1",                   21379, 2500 },
            { "Moonlight Ring",                26190, 2500 },
            { "Chirich Ring +1",               26182, 2500 },
            { "Stikini Ring +1",               26184, 2500 },
            { "Epaminondass Ring",             26214, 2500 },
            { "Ifrit Ring +1",                 27565, 2500 },
            { "Leviathan Ring +1",             27567, 2500 },
            { "Ramuh Ring +1",                 27569, 2500 },
            { "Titan Ring +1",                 27571, 2500 },
            { "Garuda Ring +1",                27597, 2500 },
            { "Shiva Ring +1",                 27573, 2500 },
            { "Carbuncle Ring +1",             27577, 2500 },
            { "Fenrir Ring / +1",              27579, 2500 },
            { "Ishvara earring",               27537, 2500 },
            { "Loricate Torque + 1",           26002, 1500 },
            { "Petrov Ring",                   10772, 2500 },
            { "Ginsen",                        21371, 1500 },
            { "Asperity Necklace",             28402, 2500 },
            { "Moldavite Earring",             14724, 3000 },
        },
    },
    {
        "Crafting & Hobbies",
        {
            { "Carver's Torque",               10948, 1500 },
            { "Tanner's Torque",               10952, 1500 },
            { "Smithy's Torque",               10949, 1500 },
            { "Goldsmith's Torque",            10950, 1500 },
            { "Boneworker's Torque",           10953, 1500 },
            { "Weaver's Torque",               10951, 1500 },
            { "Alchemist's Torque",            10954, 1500 },
            { "Culinarian Torque",             10955, 1500 },
            { "Fisher's Torque",               10925, 1500 },
            { "Field Torque",                  10926, 1500 },
            { "Field Rope",                    11769, 1500 },
        },
		"Stones",
        {
        --    { "Snowslit Stone",                  8930, 100 },
        --    { "Snowslit Stone +1",               8931, 200 },
        --    { "Snowslit Stone +2",               8932, 300 },
        --    { "Leafslit Stone",                  8933, 100 },
        --    { "Leafslit Stone +1",               8934, 200 },
        --    { "Leafslit Stone +2",               8935, 300 },
        --    { "Duskslit Stone",                  8936, 100 },
        --    { "Duskslit Stone +1",               8937, 200 },
        --    { "Duskslit Stone +2",               8938, 300 },
        --    { "Snowtip Stone",                   8939, 100 },
        --    { "Snowtip Stone +1",                8940, 200 },
        --    { "Snowtip Stone +2",                8941, 300 },
        --    { "Leaftip Stone",                   8942, 100 },
        --    { "Leaftip Stone +1",                8943, 200 },
        --    { "Leaftip Stone +2",                8944, 300 },
        --    { "Dusktip Stone",                   8945, 100 },
        --    { "Dusktip Stone +1",                8946, 200 },
        --    { "Dusktip Stone +2",                8947, 300 },
        --    { "Snowdim Stone",                   8948, 100 },
        --    { "Snowdim Stone +1",                8949, 200 },
        --    { "Snowdim Stone +2",                8950, 300 },
        --    { "Leafdim Stone",                   8951, 100 },
        --    { "Leafdim Stone +1",                8952, 200 },
        --    { "Leafdim Stone +2",                8953, 300 },
        --    { "Duskdim Stone",                   8954, 100 },
        --    { "Duskdim Stone +1",                8955, 200 },
        --    { "Duskdim Stone +2",                8956, 300 },
        --    { "Snoworb Stone",                   8957, 100 },
        --    { "Snoworb Stone +1",                8958, 200 },
        --    { "Snoworb Stone +2",                8959, 300 },
        --    { "Leaforb Stone",                   8960, 100 },
        --    { "Leaforb Stone +1",                8961, 200 },
        --    { "Leaforb Stone +2",                8962, 300 },
        --    { "Duskorb Stone",                   8963, 100 },
        --    { "Duskorb Stone +1",                8964, 200 },
        --    { "Duskorb Stone +2",                8965, 300 },
        }
    },
    {
        "Battlefields",
        {
            { "Domain NM", "[CQ]DOMAIN_NM", 20000 },
        },
    },
}

local function delaySendMenu(player, menu)
    player:timer(100, function(playerArg)
        playerArg:customMenu(menu)
    end)
end

local function completeTransaction(player, npc, item)
    local balance      = player:getCurrency("domain_points")
    local itemName     = item[1]
    local itemID       = item[2]
    local itemCost     = item[3]
    local confirmMenu  =
    {
        title   = string.format("Spend %i points? (%i available)", itemCost, balance),
        options =
        {
            {
                "No, I've changed my mind.",
                function()
                end,
            },
            {
                string.format("Purchase: %s", itemName),
                function(playerArg)
                    if balance >= itemCost and itemID ~= nil then
                        if type(itemID) == "string" then
                            if player:getCharVar(itemID) > 0 then
                                omixi.util.dialog(player, {
                                    "You have already been authorized to initiate a Domain NM battle."
                                }, npc:getPacketName(), { npc = npc })
                                return
                            else
                                player:setCharVar(itemID, 1)
                                player:delCurrency('domain_points', -itemCost)
                                player:sys("You've been authorized to initiate a Domain NM battle!")
                                omixi.util.dialog(player, {
                                    "To commence the battle, approach a Domain Seal in La Theine Plateau, Konschtat Highlands, or Tahrongi Canyon.",
                                }, npc:getPacketName(), { npc = npc })
                            end
                        else
                            if npcUtil.giveItem(player, itemID) then
                                player:delCurrency('domain_points', -itemCost)
                            else
                                omixi.util.dialog(player, {
                                    "Come back when you're able to hold that."
                                }, npc:getPacketName(), { npc = npc })
                            end
                        end
                    else
                        omixi.util.dialog(player, {
                            "You can't afford this item yet.",
                        }, npc:getPacketName(), { npc = npc })
                    end
                end,
            },
        },
    }

    delaySendMenu(player, confirmMenu)
end

local function confirmPurchase(player, npc, item)
    if item[3] == 0 then
        unlockWs(player, npc, item)
    else
        completeTransaction(player, npc, item)
    end
end

local function purchaseMaterials(player, npc)
    npc:facePlayer(player, true)

    xi.shop.general(player, {
        1464, 5000,  -- Lancewood Log
        1474, 5000,  -- Infinity Core
        1521, 5000,  -- Slime Juice
        1518, 5000,  -- Colossal Skull
        1520, 5000,  -- Goblin Grease
        1516, 5000,  -- Griffon Hide
        1517, 5000,  -- Giant Frozen Head
        1466, 5000,  -- Relic Iron
        1519, 5000,  -- Fresh Orc Liver
        1469, 5000,  -- Wootz Ore
        1470, 5000,  -- Sparkling Stone
    })
end

local function spendCurrency(player, npc, row)
    local currency = row[2]
    local cost     = row[3]
    local points   = row[4]

    if currency == "conquest_points" then
        currency = nationCurrency[player:getNation()]
    end

    local currencyName = string.gsub(row[2], "_", " ")

    player:timer(1000, function()
        if points >= cost then
            player:delCurrency(currency, cost)
            player:setCharVar("PaidForMeritWs", 1)
            player:tradeComplete()

            omixi.util.dialog(player, {
                { message = "\129\154 Aeonic Phase 1 Complete \129\154" },
                "Talk to me again for the next steps.",
            }, npc:getPacketName(), { npc = npc })
        else

            omixi.util.dialog(player, {
                fmt("You will need more {} before you can do that.", currencyName)
            }, npc:getPacketName(), { npc = npc })
        end
    end)
end

local function listMaterial(player, npc, row)
    local mat1 = row[2][1][1]
    local mat2 = row[2][2][1]

    omixi.util.dialog(player, {
        fmt("For {}, you'll need 10 {} and 10 {}.", row[1], itemNames[mat1], itemNames[mat2])
    }, npc:getPacketName(), { npc = npc })
end

local qtyList =
{
    {  "x1",  1 },
    {  "x2",  2 },
    {  "x3",  3 },
    {  "x6",  6 },
    { "x12", 12 },
    { "x24", 24 },
    { "x36", 36 },
    { "x99", 99 },
}

local function onTrigger(player, npc)

    local options =
    {
        {
            "Spend Domain points",
            function()
                local balance = player:getCurrency("domain_points")
                local title   = string.format("Current balance: %u", balance)

                omixi.util.dialog(player, {
                    fmt("You have {} domain points available to spend. Choose wisely.", balance),
                }, npc:getPacketName(), { npc = npc })

                omixi.util.categoryMenu(player, npc, items, confirmPurchase, title)
            end,
        },
    }

    delaySendMenu(player, {
        title   = "What do you want?",
        options = options,
    })
end

omixi.util.liveReload(m, {
    ["Upper_Jeuno"] =
    {
        {
            objtype   = xi.objType.NPC,
            name      = "Officer Aliron",
            look      = omixi.util.look({
                race = xi.race.TARU_M,
                face = omixi.face.A8,
                head = 73, -- Shaded Spectacles
                body = 331, -- Samnuha Coat
                hand =  0, -- Seiryu's Kote
                legs = 306, -- Savant's Pants
                feet = 306, -- Savant's Loafers
                main = 752, -- Rune Staff
            }),
            x         = -61.948,
            y         = -0.199,
            z         = 27.454,
            rotation  = 42,
            onTrade   = onTrade,
            onTrigger = onTrigger,
        },
    },
})

return m
