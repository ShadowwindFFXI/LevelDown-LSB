-- =============================================================================
-- file: TexasHoldEm.lua
-- desc: Implements a Casino Hold'em style NPC game.
--       - Player vs Dealer (Moogle).
--       - 52 Card Deck.
--       - Rules:
--         1. Ante Bet.
--         2. Deal Hole Cards (2 Player, 2 Dealer) + Flop (3 Community).
--         3. Player Decision: Fold (Lose Ante) or Call (Bet 2x Ante).
--         4. Deal Turn/River (2 Community).
--         5. Dealer Qualifies with Pair of 4s or better.
--         6. Compare best 5-card hands.
-- =============================================================================

require("modules/module_utils")
require("scripts/globals/npc_util")

---@type Module
local m = Module:new('Texasholdem')

-- =============================================================================
-- CONFIGURATION
-- =============================================================================

local NPC_NAME = "Texas Hold'em"
-- Standard Moogle Look
local NPC_LOOK = 2359 
-- Coordinates in Mog Garden (Near the Blackjack Dealer)
local NPC_POS = { x = 329.6825, y = -3.3386, z = -550.1247, rot = 3 }

local TABLE_BUSY_VAR = 'TexasHoldEmTableBusy'

local BET_OPTIONS = {
    { label = "1,000 Gil",   value = 1000 },
    { label = "10,000 Gil",  value = 10000 },
    { label = "50,000 Gil",  value = 50000 },
    { label = "100,000 Gil", value = 100000 },
    { label = "1,000,000 Gil", value = 1000000 },
}

-- =============================================================================
-- GAME STATE
-- =============================================================================

local games = {}

-- =============================================================================
-- CARD UTILITIES
-- =============================================================================

local SUIT_NAMES = {"Spades", "Hearts", "Diamonds", "Clubs"}
local RANK_NAMES = {"Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King"}

-- Returns 1-13 (1=Ace, 13=King)
local function getRank(card) return (card - 1) % 13 + 1 end
-- Returns 1-4
local function getSuit(card) return math.floor((card - 1) / 13) + 1 end
-- Returns 2-14 (Ace=14) for comparison
local function getRankHigh(card)
    local r = getRank(card)
    return r == 1 and 14 or r
end

local function getCardName(card)
    return RANK_NAMES[getRank(card)] .. " of " .. SUIT_NAMES[getSuit(card)]
end

local function getHandString(cards)
    local str = ""
    for _, c in ipairs(cards) do
        str = str .. getCardName(c) .. ", "
    end
    return str:sub(1, -3)
end

-- =============================================================================
-- HAND EVALUATOR
-- =============================================================================

-- Evaluates 7 cards and returns a score table: { type, k1, k2, k3, k4, k5 }
-- Types: 1=HighCard, 2=Pair, 3=TwoPair, 4=Trips, 5=Straight, 6=Flush, 7=FullHouse, 8=Quads, 9=StrFlush
local function evaluateHand(cards)
    local hand = {}
    for _, c in ipairs(cards) do
        table.insert(hand, { r = getRankHigh(c), s = getSuit(c) })
    end
    -- Sort descending by rank
    table.sort(hand, function(a,b) return a.r > b.r end)

    -- 1. Check Flush
    local suits = {0,0,0,0}
    for _, c in ipairs(hand) do suits[c.s] = suits[c.s] + 1 end
    local flushSuit = nil
    for s=1,4 do if suits[s] >= 5 then flushSuit = s break end end

    local flushHand = {} -- Ranks only
    if flushSuit then
        for _, c in ipairs(hand) do
            if c.s == flushSuit then table.insert(flushHand, c.r) end
        end
    end

    -- Helper: Check Straight in a list of descending ranks
    local function checkStraight(ranks)
        local unique = {}
        local last = -1
        for _, r in ipairs(ranks) do
            if r ~= last then table.insert(unique, r); last = r end
        end
        -- Add Ace as 1 at the end if Ace(14) exists
        if unique[1] == 14 then table.insert(unique, 1) end
        
        if #unique < 5 then return nil end
        
        for i = 1, #unique - 4 do
            if unique[i] - unique[i+4] == 4 then return unique[i] end
        end
        return nil
    end

    -- Straight Flush
    if flushSuit then
        local sfHigh = checkStraight(flushHand)
        if sfHigh then return { 9, sfHigh } end
    end

    -- Count Ranks
    local counts = {}
    for _, c in ipairs(hand) do counts[c.r] = (counts[c.r] or 0) + 1 end
    
    local quads, trips, pairsList = {}, {}, {}
    for r, n in pairs(counts) do
        if n == 4 then table.insert(quads, r)
        elseif n == 3 then table.insert(trips, r)
        elseif n == 2 then table.insert(pairsList, r)
        end
    end
    table.sort(quads, function(a,b) return a > b end)
    table.sort(trips, function(a,b) return a > b end)
    table.sort(pairsList, function(a,b) return a > b end)

    -- Quads
    if #quads > 0 then
        local q = quads[1]
        for _, c in ipairs(hand) do if c.r ~= q then return { 8, q, c.r } end end
    end

    -- Full House
    if #trips > 0 and (#trips >= 2 or #pairsList > 0) then
        local t = trips[1]
        local p = (#trips >= 2) and trips[2] or pairsList[1]
        return { 7, t, p }
    end

    -- Flush
    if flushSuit then
        return { 6, flushHand[1], flushHand[2], flushHand[3], flushHand[4], flushHand[5] }
    end

    -- Straight
    local allRanks = {}
    for _, c in ipairs(hand) do table.insert(allRanks, c.r) end
    local strHigh = checkStraight(allRanks)
    if strHigh then return { 5, strHigh } end

    -- Trips
    if #trips > 0 then
        local t = trips[1]
        local k = {}
        for _, c in ipairs(hand) do if c.r ~= t then table.insert(k, c.r) end end
        return { 4, t, k[1], k[2] }
    end

    -- Two Pair
    if #pairsList >= 2 then
        local p1, p2 = pairsList[1], pairsList[2]
        local k = 0
        for _, c in ipairs(hand) do if c.r ~= p1 and c.r ~= p2 then k = c.r break end end
        return { 3, p1, p2, k }
    end

    -- Pair
    if #pairsList == 1 then
        local p = pairsList[1]
        local k = {}
        for _, c in ipairs(hand) do if c.r ~= p then table.insert(k, c.r) end end
        return { 2, p, k[1], k[2], k[3] }
    end

    -- High Card
    return { 1, hand[1].r, hand[2].r, hand[3].r, hand[4].r, hand[5].r }
end

local HAND_TYPE_NAMES = {
    "High Card", "Pair", "Two Pair", "Three of a Kind", "Straight", 
    "Flush", "Full House", "Four of a Kind", "Straight Flush"
}

-- Returns 1 if scoreA > scoreB, -1 if B > A, 0 if tie
local function compareScores(scoreA, scoreB)
    for i = 1, #scoreA do
        local a = scoreA[i] or 0
        local b = scoreB[i] or 0
        if a > b then return 1 end
        if b > a then return -1 end
    end
    return 0
end

-- =============================================================================
-- GAME LOGIC
-- =============================================================================

local showGameMenu -- Forward declaration

local function endGame(player)
    games[player:getID()] = nil
    SetServerVariable(TABLE_BUSY_VAR, 0)
end

local function playerFold(player)
    local game = games[player:getID()]
    if not game then return end
    
    player:printToPlayer("You folded. You lost your Ante of " .. game.ante .. " Gil.", xi.msg.channel.SYSTEM_3)
    endGame(player)
end

local function playerCall(player)
    local game = games[player:getID()]
    if not game then return end
    
    local callAmount = game.ante * 2
    if player:getGil() < callAmount then
        player:printToPlayer("You don't have enough Gil to Call ("..callAmount..").", xi.msg.channel.SYSTEM_3)
        return
    end
    
    player:delGil(callAmount)
    player:printToPlayer("Call placed: " .. callAmount .. " Gil.", xi.msg.channel.SYSTEM_3)
    
    -- Deal Turn and River
    table.insert(game.community, table.remove(game.deck))
    table.insert(game.community, table.remove(game.deck))
    
    -- Combine hands
    local pFull = {}; for _,c in ipairs(game.playerHand) do table.insert(pFull, c) end
    for _,c in ipairs(game.community) do table.insert(pFull, c) end
    
    local dFull = {}; for _,c in ipairs(game.dealerHand) do table.insert(dFull, c) end
    for _,c in ipairs(game.community) do table.insert(dFull, c) end
    
    local pScore = evaluateHand(pFull)
    local dScore = evaluateHand(dFull)
    
    -- Display Results
    player:printToPlayer("---------------------------------", xi.msg.channel.SYSTEM_3)
    player:printToPlayer("Community: " .. getHandString(game.community), xi.msg.channel.SYSTEM_3)
    player:printToPlayer("Dealer has: " .. getHandString(game.dealerHand) .. " (" .. HAND_TYPE_NAMES[dScore[1]] .. ")", xi.msg.channel.SYSTEM_3)
    player:printToPlayer("You have: " .. getHandString(game.playerHand) .. " (" .. HAND_TYPE_NAMES[pScore[1]] .. ")", xi.msg.channel.SYSTEM_3)
    
    -- Check Dealer Qualification (Pair of 4s or better)
    -- Score type > 2 (Two Pair+) OR (Type == 2 AND PairRank >= 4)
    local dealerQualifies = false
    if dScore[1] > 2 then dealerQualifies = true
    elseif dScore[1] == 2 and dScore[2] >= 4 then dealerQualifies = true
    end
    
    if not dealerQualifies then
        player:printToPlayer("Dealer does not qualify (Needs Pair of 4s).", xi.msg.channel.SYSTEM_3)
        player:printToPlayer("Ante pays 1:1. Call bet pushes.", xi.msg.channel.SYSTEM_3)
        player:addGil(game.ante * 2) -- Return Ante + Win
        player:addGil(callAmount)    -- Return Call
    else
        local result = compareScores(pScore, dScore)
        if result == 1 then -- Player Wins
            player:printToPlayer("You Win!", xi.msg.channel.SYSTEM_3)
            player:addGil(game.ante * 2) -- Return Ante + Win
            player:addGil(callAmount * 2) -- Return Call + Win
        elseif result == -1 then -- Dealer Wins
            player:printToPlayer("Dealer Wins.", xi.msg.channel.SYSTEM_3)
        else -- Tie
            player:printToPlayer("Push.", xi.msg.channel.SYSTEM_3)
            player:addGil(game.ante)
            player:addGil(callAmount)
        end
    end
    player:printToPlayer("---------------------------------", xi.msg.channel.SYSTEM_3)
    
    endGame(player)
end

local function startGame(player, ante, npc)
    if player:getGil() < ante then
        player:printToPlayer("Not enough Gil.", xi.msg.channel.SYSTEM_3)
        return
    end
    
    -- Lock table
    SetServerVariable(TABLE_BUSY_VAR, player:getID())
    
    player:delGil(ante)
    player:printToPlayer("Ante placed: " .. ante .. " Gil.", xi.msg.channel.SYSTEM_3)
    
    -- Deck
    local deck = {}
    for i=1,52 do table.insert(deck, i) end
    for i=#deck, 2, -1 do
        local j = math.random(i)
        deck[i], deck[j] = deck[j], deck[i]
    end
    
    local game = {
        deck = deck,
        ante = ante,
        playerHand = { table.remove(deck), table.remove(deck) },
        dealerHand = { table.remove(deck), table.remove(deck) },
        community = { table.remove(deck), table.remove(deck), table.remove(deck) } -- Flop
    }
    
    games[player:getID()] = game
    
    showGameMenu(player, npc)
end

showGameMenu = function(player, npc)
    local busyID = GetServerVariable(TABLE_BUSY_VAR) or 0
    if busyID ~= 0 and busyID ~= player:getID() then
        player:printToPlayer("The table is busy.", xi.msg.channel.SYSTEM_3)
        return
    end

    local game = games[player:getID()]
    
    if game then
        -- In-game menu (Flop dealt)
        player:printToPlayer("---------------------------------", xi.msg.channel.SYSTEM_3)
        player:printToPlayer("Community: " .. getHandString(game.community), xi.msg.channel.SYSTEM_3)
        player:printToPlayer("Your Hand: " .. getHandString(game.playerHand), xi.msg.channel.SYSTEM_3)
        player:printToPlayer("---------------------------------", xi.msg.channel.SYSTEM_3)
        
        local menu = {
            title = "Flop Dealt. Call (2x Ante) or Fold?",
            options = {
                { "Call ("..(game.ante*2).." Gil)", function(p) playerCall(p) end },
                { "Fold", function(p) playerFold(p) end }
            }
        }
        player:timer(50, function(p) p:customMenu(menu) end)
    else
        -- New Game Menu
        player:printToPlayer("---------------------------------", xi.msg.channel.SYSTEM_3)
        player:printToPlayer("Dealer: Welcome to the Hold'em table, kupo!", xi.msg.channel.SYSTEM_3)
        player:printToPlayer("Dealer: I'll only play if I have a pair of 4s or better!", xi.msg.channel.SYSTEM_3)
        local menu = {
            title = "Texas Hold'em (Heads Up)",
            options = {}
        }
        for _, opt in ipairs(BET_OPTIONS) do
            table.insert(menu.options, {
                "Ante " .. opt.label,
                function(p) startGame(p, opt.value, npc) end
            })
        end
        table.insert(menu.options, { "Exit", function(p) end })
        
        player:timer(50, function(p) p:customMenu(menu) end)
    end
end

-- =============================================================================
-- NPC DEFINITION
-- =============================================================================

m:addOverride('xi.zones.Mog_Garden.Zone.onInitialize', function(zone)
    pcall(function() super(zone) end)
    
    SetServerVariable(TABLE_BUSY_VAR, 0)

    zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = NPC_NAME,
        look = NPC_LOOK,
        x = NPC_POS.x, y = NPC_POS.y, z = NPC_POS.z, rotation = NPC_POS.rot,
        widescan = 1,
        onTrigger = function(player, npc)
            showGameMenu(player, npc)
            return true
        end,
    })
end)

return m