-----------------------------------
-- Domain Trader
-----------------------------------
-- Provides temporary items for domain shards
-- Transports players to the next Domain
-----------------------------------
require("modules/module_utils")
require('scripts/globals/npc_util')
require("scripts/utils/utils")
-----------------------------------
local m = Module:new("npc_domain_trader")

local bundles =
{
    melee =
    {
        { "Pearlscale",        5714 },
        { "Dusty Elixir",      5433 },
        { "Lucid Potion I",    5824 },
        { "Healing Powder",    5322 },
        { "Catholicon",        4206 },
        { "Lucid Ether I",     5827 },
        { "Lucid Ether II",    5828 },
        { "Mana Powder",       4255 },
        { "Braver's Drink",    5390 },
        { "Spiritual Incense", 5243 },
        { "Body Boost",        4147 },
        { "Mana Boost",        4200 },
    },

    mage = 
    {
        { "Pearlscale",        5714 },
        { "Dusty Elixir",      5433 },
        { "Lucid Potion I",    5824 },
        { "Healing Powder",    5322 },
        { "Catholicon",        4206 },
        { "Lucid Ether I",     5827 },
        { "Lucid Ether II",    5828 },
        { "Mana Powder",       4255 },
        { "Braver's Drink",    5390 },
        { "Spiritual Incense", 5243 },
        { "Body Boost",        4147 },
        { "Mana Boost",        4200 },
    },
    pets =
    {
        { "Pearlscale",        5714 },
        { "Dusty Elixir",      5433 },
        { "Lucid Potion I",    5824 },
        { "Healing Powder",    5322 },
        { "Lucid Ether I",     5827 },
        { "Mana Powder",       4255 },
        { "Catholicon +1",     4208 },
        { "Healing Salve I",   5835 },
        { "Healing Salve II",  5836 },
        { "Clear Salve I",     5837 },
        { "Clear Salve II",    5838 },
        { "Braver's Drink",    5390 },
        { "Lucid Wings I",     5834 },
        { "Body Boost",        4147 },
        { "Mana Boost",        4200 },
    },
}

local tempItems =
{
    { "Pearlscale",         5714,           20 },
    { "Morimar's Might",    bundles.melee, 300 },
    { "Ingrid's Insight",   bundles.mage,  300 },
    { "Darrcuiln's Spoils", bundles.pets,  300 },
    { "Paralyze Pot",       4159,           20 }, -- To help with paralysis spam
    { "Dusty Elixir",       5433,           25 }, -- 25% HP/MP
    { "Lucid Potion I",     5824,           15 }, -- 500 HP
    { "Lucid Potion II",    5825,           25 }, -- 1000 HP
    { "Healing Powder",     5322,           30 }, -- 25% HP AoE 10'
    { "Lucid Ether I",      5827,           15 }, -- 250 MP
    { "Lucid Ether II",     5828,           25 }, -- 500 MP
    { "Mana Powder",        4255,           30 }, -- 25% MP AoE 10'
    { "Catholicon",         4206,           15 }, -- 3 Status Ailments Removed
    { "Catholicon +1",      4208,           25 }, -- 6 Status Ailments Removed
    { "Healing Salve I",    5835,           15 }, -- 50% Pet HP
    { "Healing Salve II",   5836,           25 }, -- 100% Pet HP
    { "Clear Salve I",      5837,           10 }, -- 1-2 Pet Status Ailments Removed
    { "Clear Salve II",     5838,           15 }, -- All Pet Status Ailments Removed
    { "Braver's Drink",     5390,           50 }, -- +15 Attributes for 3 Minutes
    { "Carnal Incense",     5243,          100 }, -- Immune Physical Damage 20 seconds
    { "Spiritual Incense",  5243,          100 }, -- Immune Magical Damage 20 seconds
    { "Lucid Wings I",      5834,          100 }, -- AoE +500 TP
    { "Body Boost",         4147,          150 }, -- +50% HP for 15 Minutes
    { "Mana Boost",         4200,          150 }, -- +50% MP for 15 Minutes
}

local function delaySendMenu(player, menu)
    player:timer(100, function(playerArg)
        playerArg:customMenu(menu)
    end)
end

-----------------------------------
-- Temp Item Shop
-----------------------------------
local function addTempItem(player, itemName, itemID, itemCost)
    if player:addTempItem(itemID) then
        if itemCost ~= nil then
            player:incrementCharVar("[Domain]Shards", -itemCost)
        end

        player:printToPlayer(string.format("%s obtains the temporary item: %s!", player:getName(), itemName), xi.msg.channel.NS_SAY)
    else
        player:printToPlayer("You already possess that temporary item.", xi.msg.channel.NS_SAY)
    end
end

local function confirmPurchase(player, npc, item)
    local shards = player:getCharVar("[Domain]Shards")

    if shards < item[3] then
        npc:facePlayer(player, true)
        player:printToPlayer(string.format("%s : You can't afford that.", npc:getPacketName()))
        return
    end

    delaySendMenu(player, {
        title   = string.format("Buy %s for %u shards?", item[1], item[3]),
        options =
        {
            {
                "Yes",
                function()
                    local ID = zones[player:getZoneID()]

                    if type(item[2]) == "table" then
                        for _, tempItem in pairs(item[2]) do
                            addTempItem(player, tempItem[1], tempItem[2])
                        end

                        player:incrementCharVar("[Domain]Shards", -item[3])
                    else
                       addTempItem(player, item[1], item[2], item[3])
                    end
                end,
            },
            {
                "No",
                function()
                end,
            },
        },
    })
end

local domains =
{
    { name = "Ceizak Battlegrounds",  zoneID = xi.zone.CEIZAK_BATTLEGROUNDS,  pos = {  -99.912,    0.526,  365.000, 180, 261 } },
    { name = "Foret de Hennetiel",    zoneID = xi.zone.FORET_DE_HENNETIEL,    pos = { -100.344,   -0.589, -353.977,  66, 262 } },
    { name = "Morimar Basalt Fields", zoneID = xi.zone.MORIMAR_BASALT_FIELDS, pos = { -422.780,  -63.265,  466.000, 160, 265 } },
    { name = "Yorcia Weald",          zoneID = xi.zone.YORCIA_WEALD,          pos = { -450.680,    0.421,  -99.540, 135, 263 } },
    { name = "Marjami Ravine",        zoneID = xi.zone.MARJAMI_RAVINE,        pos = {   28.000,  -60.000,  180.000,   0, 266 } },
    { name = "Kamihr Drifts",         zoneID = xi.zone.KAMIHR_DRIFTS,         pos = {  275.975,   20.250,  323.825,  28, 267 } },
}

local function getBonus(player)
    local domainsCompleted = math.floor(player:getCharVar("[Domain]Completed") / 5)
    local dailiesCompleted = player:getCharVar("[DQ]Completed")

    return utils.clamp(domainsCompleted + dailiesCompleted, 0, 5)
end

local function printProwessMessage(player, dailyBonus)
    local domainsCompleted = player:getCharVar("[Domain]Completed")
    local dailiesCompleted = player:getCharVar("[DQ]Completed")
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

    player:sys("{} ({} Daily Quests, {} Domains Conquered)", prowessMsg, dailiesCompleted, domainsCompleted)
end

local function onTriggerShop(player, npc)
    local currentNM  = GetServerVariable("[Domain]NM")
    local zoneID     = npc:getZoneID()

    if domains[currentNM].zoneID ~= zoneID then
        local dailyBonus = getBonus(player)

        printProwessMessage(player, dailyBonus)

        if getBonus(player) < 2 then
            player:fmt("You haven't accumulated enough daily Domain Prowess to use the travel service.")
            return
        end

        npc:facePlayer(player, true) 
        delaySendMenu(player, {
            title   = fmt("Travel to {}?", domains[currentNM].name),
            options =
            {
                {
                    "Not yet",
                    function()
                    end,
                },
                {
                    "Let's go!",
                    function()
                        -- Restore player's HP/MP
                        player:addHP(player:getMaxHP())
                        player:addMP(player:getMaxMP())
                        player:resetAbilities()

                        player:timer(500, function()
                            player:injectActionPacket(player:getID(), 6, 600, 0, 0, 0, 0, 0)

                            if not player:hasItem(xi.item.SCROLL_OF_INSTANT_WARP) then
                                npcUtil.giveItem(player, xi.item.SCROLL_OF_INSTANT_WARP)
                            end
                        end)

                        player:timer(1500, function(player)
                            player:setPos(unpack(domains[currentNM].pos))
                        end)
                    end,
                },
            }
        })

        return
    end

    local shards = player:getCharVar("[Domain]Shards")

    npc:facePlayer(player, true)
    omixi.util.simpleShop(player, npc, tempItems, confirmPurchase, fmt("Purchase temp items ({} shards):", shards))
end


local npcs =
{
    ["Ceizak_Battlegrounds"] =
    {
        {
            name = "Domain Trader",
            pos  = { -110.068, 0.369, 379.259, 235 },
            look = omixi.util.look({
                race = xi.race.ELVAAN_F,
                face = omixi.face.A5,
                head = omixi.model.TAEON,
                body = omixi.model.TAEON,
                hand = omixi.model.TAEON,
                legs = omixi.model.TAEON,
                feet = omixi.model.TAEON,
            }),
            onTrigger = onTriggerShop,
        },
        {
            name         = "Pioneer Torch",
            pos          = { -110.729, 0.413, 380.711, 231 },
            look         = 2412,
            hideName     = true,
            untargetable = true,
        },
    },

    ["Foret_de_Hennetiel"] =
    {
        {
            name = "Domain Trader",
            pos  = { -88.699, 0.412, -351.8188, 128 },
            look = omixi.util.look({
                race = xi.race.HUME_F,
                face = omixi.face.B4,
                head = omixi.model.ORVAIL,
                body = omixi.model.ORVAIL,
                hand = omixi.model.ORVAIL,
                legs = omixi.model.ORVAIL,
                feet = omixi.model.ORVAIL,
            }),
            onTrigger = onTriggerShop,
        },
        {
            name         = "Pioneer Bivouac",
            pos          = { -86.716, -0.559, -349.357, 122 },
            look         = 2778,
            hideName     = true,
            untargetable = true,
        },
        {
            name         = "Pioneer Torch",
            pos          = { -87.027, -0.575, -353.174, 133 },
            look         = 2412,
            hideName     = true,
            untargetable = true,
        },
    },

    ["Morimar_Basalt_Fields"] =
    {
        {
            name = "Domain Trader",
            pos  = { -423.486, -64.345, 461.574, 224 },
            look = omixi.util.look({
                race = xi.race.ELVAAN_M,
                face = omixi.face.A6,
                head = 0,
                body = omixi.model.ACRO,
                hand = omixi.model.ACRO,
                legs = omixi.model.ACRO,
                feet = omixi.model.ACRO,
                main = 65,
            }),
            onTrigger = onTriggerShop,
        },
    },

    ["Yorcia_Weald"] =
    {
        {
            name = "Domain Trader",
            pos  = { -472.061, 0.640, -91.347, 235 },
            look = omixi.util.look({
                race = xi.race.TARU_F,
                face = omixi.face.A2,
                head = 0,
                body = omixi.model.HELIOS,
                hand = omixi.model.HELIOS,
                legs = omixi.model.HELIOS,
                feet = omixi.model.HELIOS,
            }),
            onTrigger = onTriggerShop,
        },
        {
            name         = "Pioneer Bivouac",
            pos          = { -471.738, 0.693, -94.042, 245 },
            look         = 2778,
            hideName     = true,
            untargetable = true,
        },
    },

    ["Marjami_Ravine"] =
    {
        {
            name = "Domain Trader",
            pos  = { 26.687, -60.000, 187.566, 53 },
            look = omixi.util.look({
                race = xi.race.MITHRA,
                face = omixi.face.A7,
                head = omixi.model.TAEON,
                body = omixi.model.TAEON,
                hand = omixi.model.TAEON,
                legs = omixi.model.TAEON,
                feet = omixi.model.TAEON,
            }),
            onTrigger = onTriggerShop,
        },
    },

    ["Kamihr_Drifts"] =
    {
        {
            name = "Domain Trader",
            pos  = { 288.160, 20.473, 327.741, 89 },
            look = omixi.util.look({
                race = xi.race.GALKA,
                face = omixi.face.A1,
                head = omixi.model.ORVAIL,
                body = omixi.model.ORVAIL,
                hand = omixi.model.ORVAIL,
                legs = omixi.model.ORVAIL,
                feet = omixi.model.ORVAIL,
            }),
            onTrigger = onTriggerShop,
        },
        {
            name         = "Pioneer Bivouac",
            pos          = { 286.507, 20.016, 331.255, 86 },
            look         = 2778,
            hideName     = true,
            untargetable = true,
        },
        {
            name         = "Pioneer Campfire",
            pos          = { 291.502, 20.055, 327.793, 89 },
            look         = 2411,
            hideName     = true,
            untargetable = true,
        },
    },
}

omixi.util.liveReload(m, npcs)

return m
