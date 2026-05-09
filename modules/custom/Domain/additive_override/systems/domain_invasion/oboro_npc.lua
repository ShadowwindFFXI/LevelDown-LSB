------------------------------------
-- Oboro - 
-----------------------------------
require("modules/module_utils")
-----------------------------------
local m = Module:new("npc_oboro_")

local vars =
{
    ITEM = "[OBORO]itemID",
    WAIT = "[OBORO]itemWait",
}

local items =
{
    {
        "Minos",
        20860,
        {
            { "Gabbrath Horn",       3977, 2 },
            { "Toporok",            18223, 1 },
            { "Dark Amood",         18489, 1 },
        },
    },
    {
        "Nyepel",
        20534,
        {
            { "Rockfin Tooth",       3979, 2 },
            { "Koenig Knuckles",    16396, 1 },
            { "Behemoth Cesti",     16397, 1 },
        },
    },
    {
        "Sindri",
        21110,
        {
            { "Bztavian Stinger",   3980,  2 },
            { "Brise-os",           18873, 1 },
            { "Sacred Wand",        18393, 1 },
        },
    },
    {
        "Kaladanda",
        21173,
        {
            { "Waktza Rostrum",      4012, 2 },
            { "Iridal Staff",       18632, 1 },
            { "Chatoyant Staff",    18633, 1 },
        },
    },
    {
        "Egeking",
        20720,
        {
            { "Yggdreant Bole",      4014, 2 },
            { "Anelace",            16547, 1 },
            { "Apaisante",          18910, 1 },
        },
    },
    {
        "Sandung",
        20618,
        {
            { "Cehuetzi Claw",       8752, 2 },
            { "Odorous Knife",      18014, 1 },
            { "Garuda's Dagger",    17627, 1 },
        },
    },
    {
        "Priwen",
        28648,
        {
            { "Gabbrath Horn",       3977, 2 },
            { "Januwiyah",          16161, 1 },
            { "Tariqah",            16162, 1 },
        },
    },
    {
        "Cronus",
        20904,
        {
            { "Rockfin Tooth",       3979, 2 },
            { "Orichalcum Scythe",  18058, 1 },
            { "Smiting Scythe",     18957, 1 },
        },
    },
    {
        "Artoki",
        20811,
        {
            { "Bztavian Stinger",    3980, 2 },
            { "Veldt Axe",          17968, 1 },
            { "Furnace Tabarzin",   17949, 1 },
        },
    },
    {
        "Terpander",
        21407,
        {
            { "Waktza Rostrum",      4012, 2 },
            { "Shofar +1",          17832, 1 },
            { "Cythara Anglica +1", 17837, 1 },
        },
    },
    {
        "Lionsquall",
        21277,
        {
            { "Yggdreant Bole",      4014, 2 },
            { "Hellfire",           17251, 1 },
            { "Matchlock Gun +1",   17261, 1 },
        },
    },
    {
        "Kurikaranotachi",
        21039,
        {
            { "Cehuetzi Claw",       8752, 2 },
            { "Butachi",            18431, 1 },
            { "Shirogatana",        18439, 1 },
        },
    },
    {
        "Shigi",
        20994,
        {
            { "Gabbrath Horn",       3977, 2 },
            { "Hirenjaku",          18413, 1 },
            { "Izayoi",             18423, 1 },
        },
    },
    {
        "Areadbhar",
        20948,
        {
            { "Rockfin Tooth",       3979, 2 },
            { "Orichalcum Lance",   18105, 1 },
            { "Mezraq",             18110, 1 },
        },
    },
    {
        "Gridarvor",
        21174,
        {
            { "Bztavian Stinger",    3980, 2 },
            { "Flete Pole",         18628, 1 },
            { "Iridal Staff",       18632, 1 },
        },
    },
    {
        "Mimesis",
        20721,
        {
            { "Waktza Rostrum",      4012, 2 },
            { "Steel Kilij",        17739, 1 },
            { "Killer's Kilij",     18914, 1 },
        },
    },
    {
        "Deathlocke",
        21278,
        {
            { "Yggdreant Bole",      4014, 2 },
            { "Hexagun",            17222, 1 },
            { "Silver Cassandra",   19206, 1 },
        },
    },
    {
        "Ohtas",
        20535,
        {
            { "Cehuetzi Claw",       8752, 2 },
            { "Adaman Sainti",      18745, 1 },
            { "Buzbaz Sainti",      18791, 1 },
        },
    },
    {
        "Polyhymnia",
        20619,
        {
            { "Gabbrath Horn",       3977, 2 },
            { "Adder Jambiya",      18032, 1 },
            { "Behemoth Knife",     17628, 1 },
        },
    },
    {
        "Coeus",
        21175,
        {
            { "Rockfin Tooth",       3979, 2 },
            { "Iridal Staff",       18632, 1 },
            { "Chatoyant Staff",    18633, 1 },
        },
    },
    {
        "Dunna",
        21372,
        {
            { "Bztavian Stinger",    3980, 2 },
            { "Imperial Wootz Ingot", 686, 1 },
            { "Star Sapphire",       2359, 1 },
        },
    },
    {
        "Aettir",
        20761,
        {
            { "Waktza Rostrum",      4012, 2 },
            { "Pealing Nagan",      16954, 1 },
            { "Mythril Heart",      16950, 1 },
        },
    },
}

local itemLookup = {}

for _, itemInfo in pairs(items) do
    local tbl = {}

    for _, matInfo in pairs(itemInfo[3]) do
        table.insert(tbl, { matInfo[2], matInfo[3] } )
    end

    -- All weapons require H-P Bayld x200
    table.insert(tbl, { 8798, 200 })

    -- Pre-create trade table for efficiency
    itemInfo.mats = tbl

    -- Assigns string name to ID for easy lookup
    itemLookup[itemInfo[2]] = itemInfo[1]
end

local function delaySendMenu(player, menu)
    player:timer(100, function(playerArg)
        playerArg:customMenu(menu)
    end)
end

local function learnMore(player, npc, item)
    local str = ""

    for index, matInfo in pairs(item[3]) do
        str = str .. matInfo[1] .. " x" .. matInfo[3]

        if index < #item[3] then
            str = str .. ", "
        end
    end

    player:printToPlayer(string.format("Oboro : %s? For that one, I'll require:\n %s.", item[1], str), xi.msg.channel.NS_SAY)
    player:printToPlayer("Oboro : To complete the order, there's also a fee of High-Purity Bayld x200.", xi.msg.channel.NS_SAY)
    player:printToPlayer(" Once you've acquired all of these materials, bring them to me.", xi.msg.channel.NS_SAY)
end

local function orderUpdate(player, npc)
    local itemID = player:getCharVar(vars.ITEM)

    local itemName  = itemLookup[itemID]

    -- If there is no pending order, skip the rest
    if itemID == 0 then
        return false
    end

    local itemWait = player:getCharVar(vars.WAIT)
    local now      = os.time()

    if now < itemWait then
        local remaining = math.ceil((itemWait - now) / 3600)
        local itemName  = itemLookup[itemID]

        npc:facePlayer(player, true)
        player:printToPlayer(string.format("Oboro : Your order for %s will be ready to collect in %u days (Vana'diel time).", itemName, remaining), xi.msg.channel.NS_SAY)
    else
        npc:facePlayer(player, true)
        player:printToPlayer("Oboro : Your order is complete!", xi.msg.channel.NS_SAY)

        if npcUtil.giveItem(player, itemID) then
            player:setCharVar(vars.ITEM, 0)
            player:setCharVar(vars.WAIT, 0)
        end
    end

    return true
end

local function confirmTransaction(player, npc, item, index)
    local confirmMenu  =
    {
        title   = string.format("Is this the one you want?", item.name),
        options =
        {
            {
                "No, I've changed my mind.",
                function()
                end,
            },
            {
                string.format("Create: %s", item[1]),
                function(playerArg)
                    npc:facePlayer(player, true)

                    player:setCharVar(vars.ITEM, items[index][2])
                    player:setCharVar(vars.WAIT, JstMidnight())

                    player:tradeComplete()

                    orderUpdate(player, npc)
                end,
            },
        },
    }

    delaySendMenu(player, confirmMenu)
end

local function checkRequirements(player, npc)
    local playerisR10 =
        player:getRank(xi.nation.SANDORIA) == 10 or
        player:getRank(xi.nation.BASTOK)   == 10 or
        player:getRank(xi.nation.WINDURST) == 10

    local qolReqs =

        playerisR10 and
        player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_WARRIORS_PATH)

    if qolReqs then
        return true
    else
            player:printToPlayer("You must be Rank 10 and have access to Al'Taieu to use Oboro's services", xi.msg.channel.SYSTEM_3)
        end

        npc:facePlayer(player, true)
        player:printToPlayer("Oboro : Unfortunately, you don't meet the requirements to use my services.", xi.msg.channel.NS_SAY)

        return false
    end


xi.module.ensureTable("xi.zones.Port_Jeuno.npcs.Oboro")
omixi.util.reloadOverride(m, "xi.zones.Port_Jeuno.npcs.Oboro.onTrigger", function(player, npc)
    -- If there is a pending order, don't give menu
    if orderUpdate(player, npc) then
        return
    end

    if not checkRequirements(player, npc) then
        return
    end

    npc:facePlayer(player, true)
    player:printToPlayer("Oboro : Which weapon would you like to learn about?", xi.msg.channel.NS_SAY)
    omixi.util.simpleMenu(player, npc, items, learnMore, "Select an item:")
end)

omixi.util.reloadOverride(m, "xi.zones.Port_Jeuno.npcs.Oboro.onTrade", function(player, npc, trade)
    -- If there is a pending order, don't give menu
    if orderUpdate(player, npc) then
        return
    end

    if not checkRequirements(player, npc) then
        return
    end

    for index, itemInfo in pairs(items) do
        if npcUtil.tradeHasExactly(trade, itemInfo.mats) then
            npc:facePlayer(player, true)
            confirmTransaction(player, npc, itemInfo, index)
        end
    end
end)

return m
