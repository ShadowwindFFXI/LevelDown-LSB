----------------------------------------
require("modules/module_utils")
require("scripts/globals/npc_util")
----------------------------------------
-- Area: Norg (Zone 252)
--  NPC: Vael'Zaneth
--   ID: 16839109
-- Model: Atma_Fabricant
--  Pos : X: 18.1419  Y: 0.0025  Z: 25.0302  Rot: 91
-- Desc: Exchanges Domain Points for Trust Ciphers
--       from the Alter Ego Extravaganza (all sets)
--
-- FILE PLACEMENT:
--   modules/custom/lua/VaelZaneth.lua
--
-- ACTIVATION:
--   Add "VaelZaneth" to modules/MODULE_LIST.txt
--
-- LOOK ID:
--   Replace the numeric look value below with the correct model ID:
--     SELECT look FROM npc_list WHERE npcid = 16839109;

local m    = Module:new("VaelZaneth")
local menu = {}

local function delaySendMenu(player)
    player:timer(50, function(p)
        p:customMenu(menu)
    end)
end

local cipherItems =
{
    { name = "Ferreous Coffin",  item = xi.item.CIPHER_OF_F_COFFINS_ALTER_EGO,   cost = 10 },
    { name = "Cid",              item = xi.item.CIPHER_OF_CIDS_ALTER_EGO,         cost = 10 },
    { name = "Gilgamesh",        item = xi.item.CIPHER_OF_GILGAMESHS_ALTER_EGO,   cost = 10 },
    { name = "Qultada",          item = xi.item.CIPHER_OF_QULTADAS_ALTER_EGO,     cost = 10 },
    { name = "King of Hearts",   item = xi.item.CIPHER_OF_KINGS_ALTER_EGO,        cost = 10 },
    { name = "Leonoyne",         item = xi.item.CIPHER_OF_LEONOYNES_ALTER_EGO,    cost = 10 },
    { name = "Noillurie",        item = xi.item.CIPHER_OF_NOILLURIES_ALTER_EGO,   cost = 10 },
    { name = "Maximilian",       item = xi.item.CIPHER_OF_MAXIMILIANS_ALTER_EGO,  cost = 10 },
    { name = "Elivira",          item = xi.item.CIPHER_OF_ELIVIRAS_ALTER_EGO,     cost = 10 },
    { name = "Kayeel-Payeel",    item = xi.item.CIPHER_OF_KAYEELS_ALTER_EGO,      cost = 10 },
    { name = "Lhu Mhakracca",    item = xi.item.CIPHER_OF_LHUS_ALTER_EGO,         cost = 10 },
    { name = "Rahal",            item = xi.item.CIPHER_OF_RAHALS_ALTER_EGO,       cost = 10 },
    { name = "Kukki-Chebukki",   item = xi.item.CIPHER_OF_KUKKIS_ALTER_EGO,       cost = 10 },
}

local function doPurchase(player, npc, cipher)
    local npcName         = npc:getPacketName()
    local domainInvPoints = player:getCurrency("domain_points")

    if player:hasItem(cipher.item) then
        player:printToPlayer(string.format("You already possess the cipher for %s.", cipher.name), 0, npcName)
        return
    end

    if domainInvPoints < cipher.cost then
        player:printToPlayer(string.format("You do not have enough Domain Points. %s costs %d points and you only have %d.", cipher.name, cipher.cost, domainInvPoints), 0, npcName)
        return
    end

    if npcUtil.giveItem(player, { { cipher.item, 1 } }) then
        player:delCurrency("domain_points", cipher.cost)
        player:printToPlayer(string.format("Purchase complete! Cipher: %s obtained. %d Domain Points deducted. Remaining balance: %d.", cipher.name, cipher.cost, domainInvPoints - cipher.cost), 0, npcName)
    end
end

local function showCipherMenu(player, npc, page)
    local itemsPerPage = 3
    local totalPages   = math.ceil(#cipherItems / itemsPerPage)
    page = math.max(1, math.min(page, totalPages))

    local startIndex = (page - 1) * itemsPerPage + 1
    local endIndex   = math.min(startIndex + itemsPerPage - 1, #cipherItems)

    menu.title   = string.format("Trust Ciphers (Page %d/%d)", page, totalPages)
    menu.options = {}

    for i = startIndex, endIndex do
        local c = cipherItems[i]
        table.insert(menu.options, {
            string.format("%s (%d pts)", c.name, c.cost),
            function(playerArg)
                playerArg:timer(50, function(p) doPurchase(p, npc, c) end)
            end
        })
    end

    if page > 1 then
        table.insert(menu.options, {
            "Previous Page",
            function(playerArg)
                playerArg:timer(50, function(p) showCipherMenu(p, npc, page - 1) end)
            end
        })
    end

    if page < totalPages then
        table.insert(menu.options, {
            "Next Page",
            function(playerArg)
                playerArg:timer(50, function(p) showCipherMenu(p, npc, page + 1) end)
            end
        })
    end

    table.insert(menu.options, { "Leave", function(playerArg) end })

    delaySendMenu(player)
end

m:addOverride("xi.zones.Norg.Zone.onInitialize", function(zone)
    super(zone)

    local VaelZaneth = zone:insertDynamicEntity({
        objtype  = xi.objType.NPC,
        name     = "Vael'Zaneth",
        look     = '01000808FC100221C930B9408950006000700000',
        x        = 18.1419,
        y        = 0.0025,
        z        = 25.0302,
        rotation = 91,
        widescan = 1,

        onTrigger = function(player, npc)
            local npcName         = npc:getPacketName()
            local domainInvPoints = player:getCurrency("domain_points")

            player:printToPlayer(string.format("Greetings, adventurer. I deal in Trust Ciphers from the Alter Ego Extravaganza. You currently have %d Domain Points.", domainInvPoints), 0, npcName)

            showCipherMenu(player, npc, 1)

            return true
        end,
    })
    utils.unused(VaelZaneth)
end)

return m
