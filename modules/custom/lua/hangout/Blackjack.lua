-- =============================================================================
-- file: Blackjack.lua
-- desc: Implements a Blackjack NPC where players can bet Gil against the dealer.
--       Features:
--       - Standard 52-card deck (shuffled per game).
--       - Hit / Stand mechanics.
--       - Dealer stands on 17.
--       - Blackjack pays 3:2.
--       - Push returns bet.
-- =============================================================================

require("modules/module_utils")
require("scripts/globals/npc_util")

---@type Module
local m = Module:new('Blackjack')

-- =============================================================================
-- CONFIGURATION
-- =============================================================================

local NPC_NAME = "Blackjack"
local NPC_LOOK = 2359 
local NPC_POS = { x = 330.7509, y = -3.1422, z = -545.8617, rot = 90 }

-- Server variable to track if the table is in use
local BLACKJACK_TABLE_BUSY_VAR = 'BlackjackTableBusy'

local BET_OPTIONS = {
    { label = "1k",   value = 1000 },
    { label = "10k",  value = 10000 },
    { label = "50k",  value = 50000 },
    { label = "100k", value = 100000 },
    { label = "1M", value = 1000000 },
}

-- =============================================================================
-- GAME STATE
-- =============================================================================

-- Stores active game sessions by player ID
-- Structure: games[playerID] = { deck = {}, playerHand = {}, dealerHand = {}, bet = 0 }
local games = {}

-- =============================================================================
-- UTILITY FUNCTIONS
-- =============================================================================

-- Helper to delay menu opening to prevent conflicts
local function delaySendMenu(player, menu)
    player:timer(50, function(p)
        p:customMenu(menu)
    end)
end

-- Returns the numeric value of a card (1-13)
-- 1 = Ace, 11 = Jack, 12 = Queen, 13 = King
local function getCardRank(card)
    return (card - 1) % 13 + 1
end

-- Returns the Blackjack value of a single card
local function getCardValue(card)
    local rank = getCardRank(card)
    if rank >= 10 then
        return 10
    elseif rank == 1 then
        return 11
    else
        return rank
    end
end

-- Returns the display name of a card
local function getCardName(card)
    local suits = {"Spades", "Hearts", "Diamonds", "Clubs"}
    local ranks = {"Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King"}
    
    local suitIdx = math.floor((card - 1) / 13) + 1
    local rankIdx = getCardRank(card)
    
    return ranks[rankIdx] .. " of " .. suits[suitIdx]
end

-- Calculates the total value of a hand, handling Aces automatically
local function getHandValue(hand)
    local value = 0
    local aces = 0
    
    for _, card in ipairs(hand) do
        local rank = getCardRank(card)
        local cardVal = rank
        
        if rank >= 10 then 
            cardVal = 10 
        elseif rank == 1 then
            cardVal = 11
            aces = aces + 1
        end
        
        value = value + cardVal
    end
    
    -- Adjust for Aces if bust
    while value > 21 and aces > 0 do
        value = value - 10
        aces = aces - 1
    end
    
    return value
end

-- Returns a string representation of a hand
local function getHandString(hand, hideFirstCard)
    local str = ""
    for i, card in ipairs(hand) do
        if hideFirstCard and i == 1 then
            str = str .. "[Hidden Card], "
        else
            str = str .. getCardName(card) .. ", "
        end
    end
    -- Remove trailing comma and space
    if #str > 2 then
        str = str:sub(1, -3)
    end
    return str
end

-- =============================================================================
-- GAME LOGIC
-- =============================================================================

local showBlackjackMenu -- Forward declaration

local function endGame(player)
    games[player:getID()] = nil
    -- Release the lock on the table so others can play
    SetServerVariable(BLACKJACK_TABLE_BUSY_VAR, 0)
end

-- Dealer's turn logic
local function dealerTurn(player, npc)
    local game = games[player:getID()]
    if not game then return end

    local pVal = getHandValue(game.playerHand)
    
    -- Reveal dealer's hand
    player:printToPlayer("Dealer reveals: " .. getHandString(game.dealerHand, false), xi.msg.channel.SYSTEM_3)
    
    local dVal = getHandValue(game.dealerHand)
    
    -- Dealer hits on anything less than 17
    while dVal < 17 do
        -- Draw card
        local newCard = table.remove(game.deck)
        table.insert(game.dealerHand, newCard)
        dVal = getHandValue(game.dealerHand)
        
        player:printToPlayer("Dealer hits and draws: " .. getCardName(newCard), xi.msg.channel.SYSTEM_3)
        player:timer(500, function() end) -- Small delay for effect (logic is instant though)
    end

    player:printToPlayer("Dealer stands with " .. dVal .. ".", xi.msg.channel.SYSTEM_3)

    -- Determine Winner
    if dVal > 21 then
        local winAmount = game.bet * 2
        player:printToPlayer("Dealer busts! You win " .. winAmount .. " Gil!", xi.msg.channel.SYSTEM_3)
        player:addGil(winAmount)
    elseif dVal > pVal then
        player:printToPlayer("Dealer wins. You lost " .. game.bet .. " Gil.", xi.msg.channel.SYSTEM_3)
    elseif pVal > dVal then
        local winAmount = game.bet * 2
        player:printToPlayer("You win! You receive " .. winAmount .. " Gil!", xi.msg.channel.SYSTEM_3)
        player:addGil(winAmount)
    else
        player:printToPlayer("Push. Your bet of " .. game.bet .. " Gil is returned.", xi.msg.channel.SYSTEM_3)
        player:addGil(game.bet)
    end
    
    endGame(player)
end

-- Player Hit logic
local function playerHit(player, npc)
    local game = games[player:getID()]
    if not game then return end

    local newCard = table.remove(game.deck)
    table.insert(game.playerHand, newCard)
    
    local pVal = getHandValue(game.playerHand)
    
    player:printToPlayer("You drew: " .. getCardName(newCard), xi.msg.channel.SYSTEM_3)
    
    if pVal > 21 then
        player:printToPlayer("Bust! (" .. pVal .. ") You lost " .. game.bet .. " Gil.", xi.msg.channel.SYSTEM_3)
        endGame(player)
        return false -- Game Over
    end
    
    return true -- Continue playing
end

-- Starts a new game
local function startGame(player, betAmount, npc)
    if player:getGil() < betAmount then
        player:printToPlayer("You do not have enough Gil to place that bet.", xi.msg.channel.SYSTEM_3)
        return
    end

    -- Lock the table for this player
    SetServerVariable(BLACKJACK_TABLE_BUSY_VAR, player:getID())

    player:delGil(betAmount)
    player:printToPlayer("Bet placed: " .. betAmount .. " Gil.", xi.msg.channel.SYSTEM_3)

    -- Initialize and shuffle deck (1-52)
    local deck = {}
    for i = 1, 52 do table.insert(deck, i) end
    for i = #deck, 2, -1 do
        local j = math.random(i)
        deck[i], deck[j] = deck[j], deck[i]
    end

    local game = {
        deck = deck,
        playerHand = {},
        dealerHand = {},
        bet = betAmount
    }

    -- Initial Deal
    table.insert(game.playerHand, table.remove(deck))
    table.insert(game.dealerHand, table.remove(deck))
    table.insert(game.playerHand, table.remove(deck))
    table.insert(game.dealerHand, table.remove(deck))

    games[player:getID()] = game

    local pVal = getHandValue(game.playerHand)
    local dVal = getHandValue(game.dealerHand)

    -- Check for Blackjack immediately
    if pVal == 21 then
        if dVal == 21 then
            player:printToPlayer("Push! Both you and the dealer have Blackjack. Bet returned.", xi.msg.channel.SYSTEM_3)
            player:addGil(betAmount)
        else
            -- Blackjack pays 3:2 (2.5x total return)
            local winAmount = math.floor(betAmount * 2.5)
            player:printToPlayer("Blackjack! You win " .. winAmount .. " Gil!", xi.msg.channel.SYSTEM_3)
            player:addGil(winAmount)
        end
        endGame(player)
        return
    end

    if dVal == 21 then
        -- Dealer Blackjack (Instant loss for player if player doesn't have BJ)
        player:printToPlayer("Dealer has Blackjack! " .. getHandString(game.dealerHand, false), xi.msg.channel.SYSTEM_3)
        player:printToPlayer("You lost " .. betAmount .. " Gil.", xi.msg.channel.SYSTEM_3)
        endGame(player)
        return
    end


    -- Trigger the game menu
    showBlackjackMenu(player, npc)
end

showBlackjackMenu = function(player, npc)
    local busyPlayerID = GetServerVariable(BLACKJACK_TABLE_BUSY_VAR) or 0
    local playerID = player:getID()

    -- If the table is busy with someone else, tell the player and stop.
    if busyPlayerID ~= 0 and busyPlayerID ~= playerID then
        player:printToPlayer("The dealer is currently busy with another player. Please wait.", xi.msg.channel.SYSTEM_3)
        return
    end

    local game = games[player:getID()]
    
    if game then
        -- Game in progress menu
        local pVal = getHandValue(game.playerHand)
        
        -- Print hand info to player chat
        player:printToPlayer("---------------------------------", xi.msg.channel.SYSTEM_3)
        player:printToPlayer(string.format("Your Hand: %s", getHandString(game.playerHand, false)), xi.msg.channel.SYSTEM_3)
        player:printToPlayer(string.format("Dealer Shows: %s", getHandString(game.dealerHand, true)), xi.msg.channel.SYSTEM_3)
        player:printToPlayer("---------------------------------", xi.msg.channel.SYSTEM_3)

        local dShowVal = getCardValue(game.dealerHand[2])

        
        local menu = {
            title = string.format("P: %d  |  D: %d", pVal, dShowVal),
            options = {
                { "Hit", function(p) 
                    if playerHit(p, npc) then
                        -- Re-open menu if not bust
                        p:timer(200, function(p2) showBlackjackMenu(p2, npc) end)
                    end
                end },
                { "Stand", function(p) 
                    dealerTurn(p, npc)
                end }
            }
        }
        delaySendMenu(player, menu)
    else
        -- New Game Menu
        local menu = {
            title = "Blackjack | Pays 3:2. Dealer stands on 17",
            options = {}
        }
        
        -- Add bet options
        for _, option in ipairs(BET_OPTIONS) do
            table.insert(menu.options, {
                "Bet " .. option.label,
                function(p) startGame(p, option.value, npc) end
            })
        end
        
        table.insert(menu.options, { "Exit", function(p) end })
        
        delaySendMenu(player, menu)
    end
end

-- =============================================================================
-- NPC DEFINITION
-- =============================================================================

m:addOverride('xi.zones.Mog_Garden.Zone.onInitialize', function(zone)
    -- Call original onInitialize if it exists
    pcall(function() super(zone) end)

        -- Ensure the table is not locked on server/zone start
    SetServerVariable(BLACKJACK_TABLE_BUSY_VAR, 0)

    zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = NPC_NAME,
        look = NPC_LOOK,
        x = NPC_POS.x, 
        y = NPC_POS.y, 
        z = NPC_POS.z, 
        rotation = NPC_POS.rot,
        widescan = 1,
        
        onTrigger = function(player, npc)
            showBlackjackMenu(player, npc)
            return true
        end,
    })
end)

return m
