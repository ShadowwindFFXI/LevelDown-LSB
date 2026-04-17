-----------------------------------
-- Chocobo Race Game Module
-- Places NPCs as visual markers and uses Trigger Areas for checkpoints.
-----------------------------------
require("modules/module_utils")
require("scripts/globals/npc_util")
-----------------------------------

local m = Module:new("chocoborace")

--[[
================================================================================
VARIABLE DEFINITIONS
================================================================================

-- LOCAL SCRIPT VARIABLES (Reset on script reload)
  - voteActive: (boolean) Tracks if a "cancel race" vote is in progress.
  - voteYes, voteTotal, voteProcessed: (number) Counters for the voting system.
  - bets: (table) Stores all active bets placed for the current race setup.

-- PLAYER-SPECIFIC VARIABLES (set with setLocalVar, reset on zone/logout)
  - RaceActive: (0/1) Flag indicating if the player is currently in a race.
  - RaceStarting: (0/1) Flag indicating the race is in the pre-start countdown.
  - RaceSetupActive: (0/1) Flag indicating the player is the organizer of a race being set up.
  - RaceFinished: (0/1) Flag indicating the player has crossed the finish line.
  - CurrentCheckpoint: (number) The ID of the next checkpoint the player must reach.
  - RaceStartTime: (number) The os.time() when the race began for the player.
  - RaceLaps: (number) The total number of laps for the current race.
  - CurrentLap: (number) The current lap the player is on.
  - RaceParticipants: (number) The number of players who started the race.
  - RaceMinSpeed: (number) The minimum speed for the player in this race.
  - RaceMaxSpeed: (number) The maximum speed for the player in this race.
  - RaceStunDuration: (number) The duration of stuns inflicted by this player.

-- PLAYER-PERSISTENT VARIABLES (set with setCharVar, saved to database)
  - ChocoboRaceOn: (0/1) Persistent flag used by external scripts (e.g., !chocostun) to verify the player is in a race.
  - chocostun: (number) The number of stun charges a player has available.
  - ChocoboRaceWins: (number) A counter for the player's total race victories.
  - ChocoboRacesParticipated: (number) A counter for the total number of races a player has participated in.
  - ChocoboRaceMonthlyWins: (number) Wins in the current month.
  - ChocoboRaceMonth: (number) The month index (1-12) of the last win, used to reset monthly wins.
  - ChocoboRaceClaimedMonth: (number) The month index for which a player has claimed their leaderboard reward.

-- SERVER-WIDE VARIABLES (set with SetServerVariable, persists until server reboot)
  - ChocoboRaceActive: (0/1) A global flag for the zone, indicating a race is in progress to prevent new ones from starting.
  - ChocoboRaceRank{1,2,3}_ID: (number) The player ID of the racer in that rank.
  - ChocoboRaceRank{1,2,3}_Wins: (number) The win count for the racer in that rank.
  - ChocoboRacePrevRank{1,2,3}_ID: (number) Stores the previous month's winner IDs for reward claims.
  - ChocoboRacePrevWinnersMonth: (number) The month index for which the previous winners are stored.
  - chocohousebets: (number) The total gil collected by the "house" from losing bets.

]]

-- Configuration
local RACE_START_DELAY = 15 -- seconds before the race begins
local RACE_MIN_SPEED = 100
local RACE_MAX_SPEED = 255
local CHECKPOINT_LOOK = 2410 -- Placeholder look (e.g., a flag or generic NPC) 
--Runic Seal - 2404
--2410 Transscendental Radiance
--1102    Memory Receptacle (green)
--1103    Memory Recepticle (yellow)
--1104    Memory Recepticle (blue)
--1105    Memory Recepticle (red)
local STUN_SPOT_LOOK = '00003b0500000000000000000000000000000000' -- Different look for stun spots (Crate)
local START_NPC_LOOK = '010000041810be20673067406750006000700000'  -- Placeholder look for the race starter
local BOOKIE_LOOK = 2359
local RACER_WIN_PERCENT = 0.10 -- 10% of pot goes to the winner
local HOUSE_CUT_PERCENT = 0.10 -- 10% of losing bets go to the house
local BET_AMOUNTS = {
    { label = "100k", value = 100000 },
    { label = "500k", value = 500000 },
    { label = "1M",   value = 1000000 },
    { label = "10M",  value = 10000000 },
}
local RACE_SETUP_TIMEOUT = 5 -- Minutes allowed for setup before timeout
local STUN_PICKUP_CHANCE = 50 -- Percentage chance to get a stun from a pickup
local SPEED_BOOST_LOOK = 1104
local SPEED_BOOST_STUN_CHANCE = 50 -- Percentage chance a boost pad will stun instead.
local SPEED_BOOST_DURATION = 5 -- Seconds the speed boost lasts.
local SPEED_BOOST_AMOUNT = 255 -- The speed value to apply.
local SPEED_BOOST_STUN_DURATION = 2 -- Seconds the stun lasts.
local REWARDS_PER_PAGE = 3

--look 2359
--66.0969, 0.0000, -58.7917, rot 64

-- Define your 4 checkpoints here (x, y, z, rotation)
-- UPDATE THESE COORDINATES with the actual positions you want.
local checkpoints = {
    [1] = { x = -60.9674, y = 0.0000, z = -79.8416, rot = 0 }, -- Checkpoint 1 -- Start Line
    [2] = { x = 239.7545, y = 0.0000, z = -0.5987, rot = 0 }, -- Checkpoint 2
    [3] = { x = -119.2987, y = 0.0000, z = 77.9136, rot = 0 }, -- Checkpoint 3
    [4] = { x = -222.8418, y = 0.0000, z = -51.1210, rot = 0 }, -- Checkpoint 4
}

local stunSpots = {
    [1] = { x = 128.2652, y = -1.0126, z = -113.5968, rot = 0 },
    [2] = { x = -41.7662, y = -0.8365, z = 111.3653, rot = 0 },
    [3] = { x = -268.5884, y = -0.8206, z = 48.2412, rot = 0 },
}

local speedBoostSpots = {
    [1] = { x = 232.3279, y = 0.0000, z = -0.1367, rot = 0 },
    [2] = { x = 246.2235, y = 0.0000, z = -0.3662, rot = 0 }, 
    [3] = { x = -120, y = 0.0000, z = 71.2824, rot = 0 },
    [4] = { x = -120, y = 0.0000, z = 84.5720, rot = 0 },
    [5] = { x = -216.9892, y = 0.0000, z = -44.8999, rot = 0 },
    [6] = { x = -228.9377, y = 0.0000, z = -55.6153, rot = 0 },
}

local chocoboColors = {
    xi.chocobo.color.YELLOW,
    xi.chocobo.color.BLACK,
    xi.chocobo.color.BLUE,
    xi.chocobo.color.RED,
    xi.chocobo.color.GREEN,
}

-- Trigger Area IDs (Must not conflict with choc_race.lua which uses 1-10)
local TRIGGER_BASE_ID = 200
local TRIGGER_STUN_BASE_ID = 300
local TRIGGER_SPEED_BOOST_BASE_ID = 400

local voteActive = false
local voteYes = 0
local voteTotal = 0
local voteProcessed = 0
local bets = {} -- Stores active bets: bets[bettorID] = { targetID = id, amount = val }

local function delaySendMenu(player, menu)
    player:timer(50, function(p)
        p:customMenu(menu)
    end)
end

local function offerTeleportToStart(p)
    local startPos = checkpoints[1]
    local menu = {
        title = "Race Cancelled. Teleport to Start?",
        options = {
            { "Yes", function(player)
                player:setPos(startPos.x, startPos.y, startPos.z, startPos.rot)
            end },
            { "No", function(player) end }
        }
    }
    delaySendMenu(p, menu)
end

local function printToZone(zone, message, channel)
    if not zone then return end
    local players = zone:getPlayers()
    for _, p in pairs(players) do
        p:printToPlayer(message, channel)
    end
end

local function endRace(zone)
    SetServerVariable("ChocoboRaceActive", 0)
    bets = {} -- Clear bets on cancellation
    local players = zone:getPlayers()
    for _, p in pairs(players) do
        if p:getLocalVar("RaceActive") == 1 then
            p:printToPlayer("The race has been cancelled by vote.", xi.msg.channel.SYSTEM_3)
            -- Reset vars
            p:setLocalVar("RaceActive", 0)
            p:setLocalVar("RaceFinished", 0)
            p:setLocalVar("CurrentCheckpoint", 0)
            p:setLocalVar("RaceStarting", 0)
            p:setLocalVar("RaceStartTime", 0)
            p:setLocalVar("RaceLaps", 0)
            p:setLocalVar("CurrentLap", 0)
            p:setLocalVar("RaceParticipants", 0)
            p:setCharVar("ChocoboRaceOn", 0)
            p:setCharVar("chocostun", 0)
            p:setMod(xi.mod.MOVE_SPEED_OVERRIDE, 0)
            p:setMod(xi.mod.MOUNT_MOVE, 0)
            p:recalculateStats()
            
            offerTeleportToStart(p)
        end
    end
end

local function processVote(zone, isYes)
    voteProcessed = voteProcessed + 1
    if isYes then voteYes = voteYes + 1 end
    
    if voteActive then
        if voteYes > (voteTotal / 2) then
            voteActive = false
            printToZone(zone, "Vote passed! Cancelling race...", xi.msg.channel.SYSTEM_3)
            endRace(zone)
        elseif voteProcessed >= voteTotal then
            voteActive = false
            printToZone(zone, "Vote failed. Race continues.", xi.msg.channel.SYSTEM_3)
        end
    end
end

local function processPayouts(zone, winner)
    local totalPot = 0
    local winnersPot = 0
    local validBets = {} -- List of bets where money was successfully collected
    
    -- Map players for easy lookup
    local zonePlayers = {}
    for _, p in pairs(zone:getPlayers()) do
        zonePlayers[p:getID()] = p
    end
    
    -- Determine Cap (Highest winning bet)
    local maxWinningBet = 0
    local hasWinners = false
    for bettorID, bet in pairs(bets) do
        if bet.targetID == winner:getID() then
            hasWinners = true
            if bet.amount > maxWinningBet then
                maxWinningBet = bet.amount
            end
        end
    end

    -- 1. Collect Gil from bettors
    for bettorID, bet in pairs(bets) do
        local bettor = zonePlayers[bettorID]
        if bettor then
            local amountToTake = bet.amount

            -- Cap loss if there are winners and this bet lost
            if hasWinners and bet.targetID ~= winner:getID() then
                if amountToTake > maxWinningBet then
                    amountToTake = maxWinningBet
                    bettor:printToPlayer(string.format("Bet loss capped at %d gil (highest winning bet).", maxWinningBet), xi.msg.channel.SYSTEM_3)
                end
            end

            if bettor:getGil() >= amountToTake then
                bettor:delGil(amountToTake)
                bettor:printToPlayer(string.format("Bet processed: -%d gil.", amountToTake), xi.msg.channel.SYSTEM_3)
                totalPot = totalPot + amountToTake
                
                if bet.targetID == winner:getID() then
                    winnersPot = winnersPot + amountToTake
                    table.insert(validBets, { bettor = bettor, amount = amountToTake })
                end
            else
                bettor:printToPlayer("Insufficient funds to cover your bet! Bet voided.", xi.msg.channel.SYSTEM_3)
            end
        end
    end
    
    if totalPot == 0 then 
        bets = {}
        return 
    end
    
    -- 2. Distribute Winnings
    local losingPot = totalPot - winnersPot
    local racerShare = 0
    local distributableProfit = 0
    local houseShare = 0

    if losingPot > 0 then
        -- House takes its cut from the losing pot first
        houseShare = math.floor(losingPot * HOUSE_CUT_PERCENT)
        local currentHousePot = GetServerVariable("chocohousebets") or 0
        SetServerVariable("chocohousebets", currentHousePot + houseShare)
        
        local remainingLosingPot = losingPot - houseShare
        racerShare = math.floor(remainingLosingPot * RACER_WIN_PERCENT)
        distributableProfit = remainingLosingPot - racerShare
    end
    
    winner:addGil(racerShare)
    winner:printToPlayer(string.format("You won the race! You receive %d gil from the betting pot (%d%% of losing bets).", racerShare, RACER_WIN_PERCENT * 100), xi.msg.channel.SYSTEM_3)
    
    if winnersPot > 0 then
        for _, winBet in ipairs(validBets) do
            local profitShare = math.floor((winBet.amount / winnersPot) * distributableProfit)
            local totalPayout = winBet.amount + profitShare
            winBet.bettor:addGil(totalPayout)
            winBet.bettor:printToPlayer(string.format("You won the bet! Payout: %d gil (Bet: %d + Profit: %d).", totalPayout, winBet.amount, profitShare), xi.msg.channel.SYSTEM_3)
        end
    elseif distributableProfit > 0 then
        winner:addGil(distributableProfit)
        winner:printToPlayer(string.format("No one bet on you! You take the rest of the pot: %d gil.", distributableProfit), xi.msg.channel.SYSTEM_3)
    end
    
    bets = {} -- Clear bets after payout
end

-- Helper to store string in Server Variables (ASCII encoding)
local function SetServerVariableString(varName, str)
    if not str then return end
    SetServerVariable(varName .. "_Len", #str)
    for i = 1, #str do
        SetServerVariable(varName .. "_C" .. i, string.byte(str, i))
    end
end

-- Helper to retrieve string from Server Variables
local function GetServerVariableString(varName)
    local len = GetServerVariable(varName .. "_Len")
    if len == 0 then return "" end
    local str = ""
    for i = 1, len do
        local char = GetServerVariable(varName .. "_C" .. i)
        if char > 0 then str = str .. string.char(char) end
    end
    return str
end

local function checkMonthlyReset()
    local currentMonth = tonumber(os.date("%m"))
    local lastResetMonth = GetServerVariable("ChocoboRaceLastResetMonth") or 0

    if currentMonth ~= lastResetMonth then
        -- It's a new month, time to reset.

        -- Reset current leaderboard
        SetServerVariable("ChocoboRaceRank1_ID", 0)
        SetServerVariable("ChocoboRaceRank1_Wins", 0)
        SetServerVariable("ChocoboRaceRank1_Name_Len", 0) -- Clear name
        SetServerVariable("ChocoboRaceRank2_ID", 0)
        SetServerVariable("ChocoboRaceRank2_Wins", 0)
        SetServerVariable("ChocoboRaceRank2_Name_Len", 0) -- Clear name
        SetServerVariable("ChocoboRaceRank3_ID", 0)
        SetServerVariable("ChocoboRaceRank3_Wins", 0)
        SetServerVariable("ChocoboRaceRank3_Name_Len", 0) -- Clear name
        
        -- Update the last reset month to the current month
        SetServerVariable("ChocoboRaceLastResetMonth", currentMonth)
    end
end

local function updateLeaderboard(player)
    -- Check for character monthly reset
    local currentMonth = tonumber(os.date("%m"))
    local charMonth = player:getCharVar("ChocoboRaceMonth")
    if charMonth ~= currentMonth then
        player:setCharVar("ChocoboRaceMonthlyWins", 0)
        player:setCharVar("ChocoboRaceMonth", currentMonth)
    end

    local charId = player:getID()
    local charName = player:getName()
    local monthlyWins = player:getCharVar("ChocoboRaceMonthlyWins") + 1
    player:setCharVar("ChocoboRaceMonthlyWins", monthlyWins)
    
    -- Store as requested: playername30 (Name as key, Wins as value)
    SetServerVariable(charName .. "_MWins", monthlyWins)
    
    -- Update Top 3
    local rank1Id = GetServerVariable("ChocoboRaceRank1_ID")
    local rank1Wins = GetServerVariable("ChocoboRaceRank1_Wins")
    local rank2Id = GetServerVariable("ChocoboRaceRank2_ID")
    local rank2Wins = GetServerVariable("ChocoboRaceRank2_Wins")
    local rank3Id = GetServerVariable("ChocoboRaceRank3_ID")
    local rank3Wins = GetServerVariable("ChocoboRaceRank3_Wins")
    
    if charId == rank1Id then
        SetServerVariable("ChocoboRaceRank1_Wins", monthlyWins)
        SetServerVariableString("ChocoboRaceRank1_Name", charName) -- Update name in case of change
    elseif charId == rank2Id then
        SetServerVariable("ChocoboRaceRank2_Wins", monthlyWins)
        SetServerVariableString("ChocoboRaceRank2_Name", charName)
        if monthlyWins > rank1Wins then
            -- Swap 1 and 2
            local name1 = GetServerVariableString("ChocoboRaceRank1_Name")
            
            SetServerVariable("ChocoboRaceRank1_ID", charId)
            SetServerVariable("ChocoboRaceRank1_Wins", monthlyWins)
            SetServerVariableString("ChocoboRaceRank1_Name", charName)
            
            SetServerVariable("ChocoboRaceRank2_ID", rank1Id)
            SetServerVariable("ChocoboRaceRank2_Wins", rank1Wins)
            SetServerVariableString("ChocoboRaceRank2_Name", name1)
        end
    elseif charId == rank3Id then
        SetServerVariable("ChocoboRaceRank3_Wins", monthlyWins)
        SetServerVariableString("ChocoboRaceRank3_Name", charName)
        if monthlyWins > rank2Wins then
            -- Swap 2 and 3
            local name2 = GetServerVariableString("ChocoboRaceRank2_Name")
            
            SetServerVariable("ChocoboRaceRank2_ID", charId)
            SetServerVariable("ChocoboRaceRank2_Wins", monthlyWins)
            SetServerVariableString("ChocoboRaceRank2_Name", charName)
            
            SetServerVariable("ChocoboRaceRank3_ID", rank2Id)
            SetServerVariable("ChocoboRaceRank3_Wins", rank2Wins)
            SetServerVariableString("ChocoboRaceRank3_Name", name2)
            
            -- Re-check rank 1
            rank1Wins = GetServerVariable("ChocoboRaceRank1_Wins")
            if monthlyWins > rank1Wins then
                local old1Id = GetServerVariable("ChocoboRaceRank1_ID")
                local old1Wins = GetServerVariable("ChocoboRaceRank1_Wins")
                local old1Name = GetServerVariableString("ChocoboRaceRank1_Name")
                
                SetServerVariable("ChocoboRaceRank1_ID", charId)
                SetServerVariable("ChocoboRaceRank1_Wins", monthlyWins)
                SetServerVariableString("ChocoboRaceRank1_Name", charName)
                
                SetServerVariable("ChocoboRaceRank2_ID", old1Id)
                SetServerVariable("ChocoboRaceRank2_Wins", old1Wins)
                SetServerVariableString("ChocoboRaceRank2_Name", old1Name)
            end
        end
    else
        -- Player is not in top 3, check if they should enter
        if monthlyWins > rank1Wins then
            -- Shift 1->2, 2->3
            local name1 = GetServerVariableString("ChocoboRaceRank1_Name")
            local name2 = GetServerVariableString("ChocoboRaceRank2_Name")
            
            SetServerVariable("ChocoboRaceRank3_ID", rank2Id)
            SetServerVariable("ChocoboRaceRank3_Wins", rank2Wins)
            SetServerVariableString("ChocoboRaceRank3_Name", name2)
            
            SetServerVariable("ChocoboRaceRank2_ID", rank1Id)
            SetServerVariable("ChocoboRaceRank2_Wins", rank1Wins)
            SetServerVariableString("ChocoboRaceRank2_Name", name1)
            
            SetServerVariable("ChocoboRaceRank1_ID", charId)
            SetServerVariable("ChocoboRaceRank1_Wins", monthlyWins)
            SetServerVariableString("ChocoboRaceRank1_Name", charName)
        elseif monthlyWins > rank2Wins then
            -- Shift 2->3
            local name2 = GetServerVariableString("ChocoboRaceRank2_Name")
            
            SetServerVariable("ChocoboRaceRank3_ID", rank2Id)
            SetServerVariable("ChocoboRaceRank3_Wins", rank2Wins)
            SetServerVariableString("ChocoboRaceRank3_Name", name2)
            
            SetServerVariable("ChocoboRaceRank2_ID", charId)
            SetServerVariable("ChocoboRaceRank2_Wins", monthlyWins)
            SetServerVariableString("ChocoboRaceRank2_Name", charName)
        elseif monthlyWins > rank3Wins then
            SetServerVariable("ChocoboRaceRank3_ID", charId)
            SetServerVariable("ChocoboRaceRank3_Wins", monthlyWins)
            SetServerVariableString("ChocoboRaceRank3_Name", charName)
        end
    end
end

local function invitePartyToRace(player)
    local party = player:getParty()
    local destZone = player:getZoneID()

    local teleportMenu = {
        title = 'Race Setup: Teleport to Start?',
        options = {
            {
                'Yes',
                function(p)
                    p:setPos(-74.0570, 0.0000, -62.4020, 27, destZone)
                end,
            },
            {
                'No',
                function(p) end,
            },
        }
    }

    for _, member in ipairs(party) do
        if member:getID() ~= player:getID() then
            member:printToPlayer(string.format("%s is setting up a race! Teleport offered.", player:getName()), xi.msg.channel.SYSTEM_3)
            delaySendMenu(member, teleportMenu)
        end
    end
end

local function startSetupTimer(p)
    p:timer(RACE_SETUP_TIMEOUT * 60 * 1000, function(player)
        if player and player:getLocalVar("RaceSetupActive") == 1 then
            player:setLocalVar("RaceSetupActive", 0)
            player:printToPlayer("Race setup timed out. Betting closed.", xi.msg.channel.SYSTEM_3)
            bets = {}
        end
    end)
end

local updatePlayerRaceSpeed -- Forward declaration
local startRaceForParty -- Forward declaration

local function checkPartyReady(player, laps)
    if player:getLocalVar("RaceSetupActive") ~= 1 then return end

    if GetServerVariable("ChocoboRaceActive") == 1 then
        player:setLocalVar("RaceSetupActive", 0)
        player:printToPlayer("Another race has started! Setup cancelled.", xi.msg.channel.SYSTEM_3)
        return
    end

    local party = player:getParty()
    local allReady = true
    local notReadyList = {}
    local startPos = checkpoints[1]

    for _, member in ipairs(party) do
        if member:getZoneID() == player:getZoneID() then
            local mx, my, mz = member:getXPos(), member:getYPos(), member:getZPos()
            local dist = math.sqrt(math.pow(startPos.x - mx, 2) + math.pow(startPos.y - my, 2) + math.pow(startPos.z - mz, 2))

            if dist > 5 then
                allReady = false
                table.insert(notReadyList, string.format("%s (Too Far)", member:getName()))
            end

            -- Check for Chocobo Shirt and signature
            local bodyItem = member:getEquippedItem(xi.slot.BODY)
            if bodyItem and bodyItem:getID() == 13810 then
                local signature = bodyItem:getSignature()
                if signature and signature ~= "" then
                    member:printToPlayer(string.format("Your Chocobo Shirt signature is: %s", signature), xi.msg.channel.SYSTEM_3)
                else
                    member:printToPlayer("Your Chocobo Shirt has no signature.", xi.msg.channel.SYSTEM_3)
                end
            end
        end
    end

    if allReady then
        startRaceForParty(player, laps)
    else
        local msg = "Waiting for: " .. table.concat(notReadyList, ", ")
        for _, member in ipairs(party) do
            if member:getZoneID() == player:getZoneID() then
                member:printToPlayer(msg, xi.msg.channel.SYSTEM_3)
                member:printToPlayer("Please gather at the Start Line.", xi.msg.channel.SYSTEM_3)
            end
        end

        player:timer(15000, function(p)
            if p then checkPartyReady(p, laps) end
        end)
    end
end

startRaceForParty = function(player, laps)
    local party = player:getParty()
    local participants = 0
    for _, member in ipairs(party) do
        if member:getZoneID() == player:getZoneID() then
            participants = participants + 1
        end
    end

    local rankedMsg = " (Unranked)"
    if participants >= 3 then rankedMsg = " (Ranked)" end
    
    -- Announce the start and set 'starting' flag
    for _, member in ipairs(party) do
        if member:getZoneID() == player:getZoneID() then
            member:setLocalVar("RaceSetupActive", 0) -- Stop checking
            member:setLocalVar("RaceStarting", 1)
            member:printToPlayer(string.format("All riders ready!%s Race (%d laps) starting in %d seconds! Stay within range of the starting line to receive your mount!", rankedMsg, laps, RACE_START_DELAY), xi.msg.channel.SYSTEM_3)
        end
    end

    -- Single timer on the party leader
    player:timer(RACE_START_DELAY * 1000, function(p_leader)
        if not p_leader or not p_leader:isPC() then return end

        local currentParty = p_leader:getParty()
        local allStillReady = true
        local notReadyList = {}
        local startPos = checkpoints[1]

        -- Final readiness check
        for _, member in ipairs(currentParty) do
            if member:getZoneID() == p_leader:getZoneID() then
                local mx, my, mz = member:getXPos(), member:getYPos(), member:getZPos()
                local dist = math.sqrt(math.pow(startPos.x - mx, 2) + math.pow(startPos.y - my, 2) + math.pow(startPos.z - mz, 2))

                if dist > 5 then
                    allStillReady = false
                    table.insert(notReadyList, string.format("%s (Moved away)", member:getName()))
                end
            end
        end

        if allStillReady then
            -- Announce total betting pot
            local totalPot = 0
            for _, bet in pairs(bets) do
                totalPot = totalPot + bet.amount
            end
            if totalPot > 0 then
                printToZone(p_leader:getZone(), string.format("Betting is closed! A total of %d gil is on the line!", totalPot), xi.msg.channel.SYSTEM_3)
            end

            -- Everyone is still ready, start the race for real
            SetServerVariable("ChocoboRaceActive", 1)
            local participants = 0
            for _, member in ipairs(currentParty) do
                if member:getZoneID() == p_leader:getZoneID() then
                    participants = participants + 1
                end
            end

            for _, member in ipairs(currentParty) do
                if member:getZoneID() == p_leader:getZoneID() then
                    -- Set race stats
                    local minSpeed = RACE_MIN_SPEED
                    local maxSpeed = RACE_MAX_SPEED
                    local stunAmount = 1
                    local stunDuration = 1

                    member:setLocalVar("RaceMinSpeed", minSpeed)
                    member:setLocalVar("RaceMaxSpeed", maxSpeed)
                    member:setLocalVar("RaceStunDuration", stunDuration)

                    -- Set race flags
                    member:setLocalVar("RaceParticipants", participants)
                    member:setLocalVar("RaceFinished", 0)
                    member:setCharVar("ChocoboRaceOn", 1)
                    member:setCharVar("chocostun", laps + stunAmount)

                    -- Reset Stun Spot vars
                    for i = 1, #stunSpots do
                        member:setLocalVar("StunSpot_" .. i .. "_Lap", 0)
                    end

                    -- Reset Speed Boost Spot vars
                    for i = 1, #speedBoostSpots do
                        member:setLocalVar("SpeedBoostSpot_" .. i .. "_Lap", 0)
                    end

                    -- Random Mount Logic
                    local randColor = chocoboColors[math.random(#chocoboColors)]
                    local randTraits = {
                        largeBeak   = (math.random(0, 1) == 1),
                        fullTail    = (math.random(0, 1) == 1),
                        largeTalons = (math.random(0, 1) == 1),
                    }
                    member:registerChocobo(randColor, randTraits)
                    member:delStatusEffect(xi.effect.MOUNTED)
                    member:addStatusEffect(xi.effect.MOUNTED, { power = xi.mount.CHOCOBO, duration = 0, origin = member, subPower = 64, silent = true })
                    member:addStatusEffect(xi.effect.BIND, { power = 1, duration = 10, origin = member }) -- Freeze players during countdown
                    --member:printToPlayer("You are riding a customized Chocobo!", xi.msg.channel.SYSTEM_3)

                    -- Countdown animation (Delayed slightly to ensure client is ready)
                    member:timer(500, function(p)
                        if p then p:injectActionPacket(p:getID(), 5, 242, 0, 0, 0, 10, p:getID()) end
                    end)

                    -- Final race start
                    member:timer(3500, function(p)
                        if p and p:getLocalVar("RaceStarting") == 1 then
                            p:delStatusEffect(xi.effect.BIND)
                            p:setLocalVar("RaceStarting", 0)
                            p:setLocalVar("RaceActive", 1)
                            p:setLocalVar("CurrentCheckpoint", 2)
                            p:setLocalVar("RaceStartTime", os.time())
                            p:setLocalVar("RaceLaps", laps)
                            p:setLocalVar("CurrentLap", 1)
                            p:printToPlayer("GO! Race started! Head to Checkpoint 2!", xi.msg.channel.SYSTEM_3)
                            updatePlayerRaceSpeed(p)
                        end
                    end)
                end
            end
        else
            -- Someone moved, abort the start
            local msg = "Race start aborted! Waiting for: " .. table.concat(notReadyList, ", ")
            for _, member in ipairs(currentParty) do
                if member:getZoneID() == p_leader:getZoneID() then
                    member:setLocalVar("RaceStarting", 0) -- Reset this flag
                    member:printToPlayer(msg, xi.msg.channel.SYSTEM_3)
                end
            end
            -- Re-enable the setup flag for the leader so the check can resume
            p_leader:setLocalVar("RaceSetupActive", 1)
            -- Go back to the ready check loop. This will re-check every 15 seconds.
            checkPartyReady(p_leader, laps) -- This call is now safe because checkPartyReady is defined before this function.
        end
    end)
end

-- This function will be called every 5 seconds during the race to change the player's speed.
updatePlayerRaceSpeed = function(player)
    -- If race is no longer active, stop the speed changes and reset speed to normal.
    if player:getLocalVar("RaceActive") ~= 1 then
        player:setMod(xi.mod.MOVE_SPEED_OVERRIDE, 0)
        player:setMod(xi.mod.MOUNT_MOVE, 0)
        player:recalculateStats()
        player:printToPlayer("Your speed returns to normal.", xi.msg.channel.SYSTEM_3)
        return
    end

    -- Check for active speed boost
    local boostEndTime = player:getLocalVar("SpeedBoostEndTime") or 0
    if boostEndTime > os.time() then
        player:setMod(xi.mod.MOVE_SPEED_OVERRIDE, SPEED_BOOST_AMOUNT)
        player:setMod(xi.mod.MOUNT_MOVE, SPEED_BOOST_AMOUNT)
        player:recalculateStats()
        -- Schedule the next check
        player:timer(5000, function()
            updatePlayerRaceSpeed(player)
        end)
        return -- Skip random speed logic
    elseif boostEndTime > 0 then
        player:setLocalVar("SpeedBoostEndTime", 0)
    end

    -- Generate a random speed. A normal chocobo is around 18-20.
    local minSpeed = player:getLocalVar("RaceMinSpeed")
    local maxSpeed = player:getLocalVar("RaceMaxSpeed")
    if minSpeed == 0 then minSpeed = RACE_MIN_SPEED end
    if maxSpeed == 0 then maxSpeed = RACE_MAX_SPEED end

    local newSpeed = math.random(minSpeed, maxSpeed)
    player:setMod(xi.mod.MOVE_SPEED_OVERRIDE, newSpeed)
    player:setMod(xi.mod.MOUNT_MOVE, newSpeed)
    player:recalculateStats()
    --player:printToPlayer(string.format("Your chocobo's speed changes! (New Speed: %d)", newSpeed), xi.msg.channel.SYSTEM_3)

    -- Schedule the next speed change in 5 seconds
    player:timer(5000, function()
        updatePlayerRaceSpeed(player)
    end)
end

-- Override Zone Initialization to spawn NPCs and register Trigger Areas
m:addOverride('xi.zones.Chocobo_Circuit.Zone.onInitialize', function(zone)
    -- Safely call the original onInitialize function to ensure other modules' spawns are not broken.
    local ok, err = pcall(function() super(zone) end)
    if not ok then
        print('ERROR: super(zone) failed in Chocobo_Circuit: ' .. tostring(err))
    end

    -- Reset race state on zone load
    SetServerVariable("ChocoboRaceActive", 0)
    voteActive = false
    bets = {}

    -- Spawn Race Official NPC (Start Point)
    local raceOfficial = zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = "Race Official",
        look = START_NPC_LOOK,
        x = -62.3462, y = 0.0000, z = -67.1669, rotation = 101,
        widescan = 1,
        onTrigger = function(player, npc)
            checkMonthlyReset()
            -- Self-healing: Check if anyone is actually racing
            local zone = player:getZone()
            local players = zone:getPlayers()
            local activeRacers = 0
            for _, p in pairs(players) do
                if p:getLocalVar("RaceActive") == 1 then
                    activeRacers = activeRacers + 1
                end
            end

            -- Sync server variable
            if activeRacers > 0 and GetServerVariable("ChocoboRaceActive") == 0 then
                SetServerVariable("ChocoboRaceActive", 1)
            elseif activeRacers == 0 and GetServerVariable("ChocoboRaceActive") == 1 then
                SetServerVariable("ChocoboRaceActive", 0)
                voteActive = false
            end

            if GetServerVariable("ChocoboRaceActive") == 1 then
                -- If player is IN the race, give them specific options
                if player:getLocalVar("RaceActive") == 1 then
                    local menu = {
                        title = "Race Options",
                        options = {
                            { "Resign (Quit Race)", function(p)
                                p:setLocalVar("RaceActive", 0)
                                p:setLocalVar("RaceFinished", 0)
                                p:setLocalVar("CurrentCheckpoint", 0)
                                p:setLocalVar("RaceStarting", 0)
                                p:setLocalVar("RaceStartTime", 0)
                                p:setLocalVar("RaceLaps", 0)
                                p:setLocalVar("CurrentLap", 0)
                                p:setLocalVar("RaceParticipants", 0)
                                p:setCharVar("ChocoboRaceOn", 0)
                                p:setCharVar("chocostun", 0)
                                p:setMod(xi.mod.MOVE_SPEED_OVERRIDE, 0)
                                p:setMod(xi.mod.MOUNT_MOVE, 0)
                                p:recalculateStats()
                                p:printToPlayer("You have resigned.", xi.msg.channel.SYSTEM_3)
                                
                                -- Check if race should end
                                local stillActive = false
                                for _, mem in pairs(zone:getPlayers()) do
                                    if mem:getID() ~= p:getID() and mem:getLocalVar("RaceActive") == 1 then
                                        stillActive = true
                                        break
                                    end
                                end
                                if not stillActive then
                                    SetServerVariable("ChocoboRaceActive", 0)
                                    voteActive = false
                                end
                            end },
                            { "Initiate Vote to Cancel", function(p)
                                if voteActive then
                                    p:printToPlayer("Vote already in progress.", xi.msg.channel.SYSTEM_3)
                                    return
                                end
                                voteActive = true
                                voteYes = 0
                                voteProcessed = 0
                                local voters = {}
                                table.insert(voters, p)
                                for _, member in pairs(zone:getPlayers()) do
                                    if member:getID() ~= p:getID() and member:getLocalVar("RaceActive") == 1 then
                                        table.insert(voters, member)
                                    end
                                end
                                voteTotal = #voters
                            printToZone(zone, string.format("[System] %s has initiated a vote to cancel the race.", p:getName()), xi.msg.channel.SYSTEM_3)
                                for _, voter in ipairs(voters) do
                                    local voteMenu = {
                                        title = "Vote to End Race?",
                                        options = {
                                            { "Yes", function(vp) processVote(zone, true) end },
                                            { "No", function(vp) processVote(zone, false) end }
                                        }
                                    }
                                    delaySendMenu(voter, voteMenu)
                                end
                            end },
                            { "Close", function(p) end }
                        }
                    }
                    delaySendMenu(player, menu)
                    return true
                end

                if voteActive then
                    player:printToPlayer("A cancellation vote is already in progress.", xi.msg.channel.SYSTEM_3)
                    return true
                end

                local menu = {
                    title = "Race in Progress. Cancel?",
                    options = {
                        { "Initiate Vote", function(p)
                            voteActive = true
                            voteYes = 0
                            voteProcessed = 0
                            
                            local voters = {}
                            table.insert(voters, p)
                            
                            -- Include active racers in vote
                            for _, member in pairs(zone:getPlayers()) do
                                if member:getID() ~= p:getID() and member:getLocalVar("RaceActive") == 1 then
                                    table.insert(voters, member)
                                end
                            end
                            
                            voteTotal = #voters
                            printToZone(zone, string.format("[System] %s has initiated a vote to cancel the current race.", p:getName()), xi.msg.channel.SYSTEM_3)
                            
                            for _, voter in ipairs(voters) do
                                local voteMenu = {
                                    title = "Vote to End Race?",
                                    options = {
                                        { "Yes", function(vp) processVote(zone, true) end },
                                        { "No", function(vp) processVote(zone, false) end }
                                    }
                                }
                                delaySendMenu(voter, voteMenu)
                            end
                        end },
                        { "No", function(p) end }
                    }
                }
                delaySendMenu(player, menu)
                return true
            end

            if player:getLocalVar("RaceActive") == 1 or player:getLocalVar("RaceStarting") == 1 or player:getLocalVar("RaceSetupActive") == 1 then
                player:printToPlayer("You are already in a race or setting one up!", xi.msg.channel.SYSTEM_3)
            else
                local menu = {
                    title = "Chocobo Race - Select Laps",
                    options = {
                        { "1 Lap", function(p)
                            p:setLocalVar("RaceSetupActive", 1)
                            startSetupTimer(p)
                            invitePartyToRace(p)
                            checkPartyReady(p, 1)
                        end },
                        { "2 Laps", function(p)
                            p:setLocalVar("RaceSetupActive", 1)
                            startSetupTimer(p)
                            invitePartyToRace(p)
                            checkPartyReady(p, 2)
                        end },
                        { "3 Laps", function(p)
                            p:setLocalVar("RaceSetupActive", 1)
                            startSetupTimer(p)
                            invitePartyToRace(p)
                            checkPartyReady(p, 3)
                        end },
                        { "Cancel", function(p) end }
                    }
                }
                delaySendMenu(player, menu)
            end
            return true
        end,
    })

    -- Spawn Bookie NPC
    local bookie = zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = "Bookie",
        look = BOOKIE_LOOK,
        x = -66.0969, y = 0.0000, z = -58.7917, rotation = 64,
        onTrigger = function(player, npc)
            -- Extra check: Ensure no one is currently racing (handles desync)
            local zone = player:getZone()
            for _, p in pairs(zone:getPlayers()) do
                if p:getLocalVar("RaceActive") == 1 or p:getLocalVar("RaceStarting") == 1 then
                    player:printToPlayer("Betting is closed while a race is in progress.", xi.msg.channel.SYSTEM_3)
                    return true
                end
            end

            if GetServerVariable("ChocoboRaceActive") == 1 then
                player:printToPlayer("Betting is closed while a race is in progress.", xi.msg.channel.SYSTEM_3)
                return true
            end

            local organizer = nil
            for _, p in pairs(player:getZone():getPlayers()) do
                if p:getLocalVar("RaceSetupActive") == 1 then
                    organizer = p
                    break
                end
            end

            if not organizer then
                player:printToPlayer("No race is currently being organized. Betting is closed.", xi.msg.channel.SYSTEM_3)
                return true
            end

            -- Get the list of racers
            local players = {}
            if organizer then
                for _, member in ipairs(organizer:getParty()) do
                    if member:getZoneID() == organizer:getZoneID() then
                        table.insert(players, member)
                    end
                end
            end

            -- Function to show the bet amount menu after a racer is selected
            local function showBetAmountMenu(p, target)
                local betMenu = {
                    title = string.format("Bet on %s", target:getName()),
                    options = {}
                }

                for _, betData in ipairs(BET_AMOUNTS) do
                    table.insert(betMenu.options, {
                        string.format("Bet %s Gil", betData.label),
                        function(bp)
                            bets[bp:getID()] = { targetID = target:getID(), amount = betData.value }
                            bp:printToPlayer(string.format("Bet placed: %d gil on %s. (Gil taken upon win)", betData.value, target:getName()), xi.msg.channel.SYSTEM_3)
                        end
                    })
                end
                table.insert(betMenu.options, { "Cancel", function(bp) end })
                delaySendMenu(p, betMenu)
            end

            -- Function to show the paginated racer selection menu
            local function showRacerPage(page)
                local pageMenu = { title = string.format("Select Racer (Page %d)", page), options = {} }
                local startIndex = (page - 1) * 3 + 1
                local endIndex = startIndex + 2
                
                for i = startIndex, math.min(endIndex, #players) do
                    local target = players[i]
                    local wins = target:getCharVar("ChocoboRaceWins") or 0
                    local participated = target:getCharVar("ChocoboRacesParticipated") or 0
                    local displayName = string.format("%s (%d/%d)", target:getName(), wins, participated)
                    table.insert(pageMenu.options, {
                        displayName,
                        function(p)
                            showBetAmountMenu(p, target)
                        end
                    })
                end
                
                if endIndex < #players then
                    table.insert(pageMenu.options, { "Next Page", function(p) showRacerPage(page + 1) end })
                end
                
                table.insert(pageMenu.options, { "Cancel", function(p) end })
                delaySendMenu(player, pageMenu)
            end
            
            -- Start by showing the first page of racers
            showRacerPage(1)
            
            return true
        end,
    })

    -- Spawn Race Leaderboard NPC
    local leaderboardNpc = zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = "Score Keeper",
        look = 2290,
        x = -64.6509, y = 0.0000, z = -58.7887, rotation = 207,
        onTrigger = function(player, npc)
            checkMonthlyReset()
            
            local menu = {
                title = "Monthly Chocobo Race Leaderboard",
                options = {}
            }

            local rank1Id = GetServerVariable("ChocoboRaceRank1_ID")
            local rank1Wins = GetServerVariable("ChocoboRaceRank1_Wins")
            local rank1Name = GetServerVariableString("ChocoboRaceRank1_Name")
            local rank2Id = GetServerVariable("ChocoboRaceRank2_ID")
            local rank2Wins = GetServerVariable("ChocoboRaceRank2_Wins")
            local rank2Name = GetServerVariableString("ChocoboRaceRank2_Name")
            local rank3Id = GetServerVariable("ChocoboRaceRank3_ID")
            local rank3Wins = GetServerVariable("ChocoboRaceRank3_Wins")
            local rank3Name = GetServerVariableString("ChocoboRaceRank3_Name")

            local function getName(name)
                if name == "" then return "None" end
                return name
            end

            table.insert(menu.options, { "--- Current Standings ---", function() end })
            table.insert(menu.options, { string.format("1. %s - %d", getName(rank1Name), rank1Wins), function() end })
            table.insert(menu.options, { string.format("2. %s - %d", getName(rank2Name), rank2Wins), function() end })
            table.insert(menu.options, { string.format("3. %s - %d", getName(rank3Name), rank3Wins), function() end })
            table.insert(menu.options, { "Close", function() end })

            delaySendMenu(player, menu)
            return true
        end,
    })

    -- Setup Checkpoints (Visual NPCs + Trigger Areas)
    for i, pos in ipairs(checkpoints) do
        -- 1. Visual NPC (from laddernpcs.lua style)
        zone:insertDynamicEntity({
            objtype = xi.objType.NPC,
            name = "Checkpoint " .. i,
            look = CHECKPOINT_LOOK,
            x = pos.x, y = pos.y, z = pos.z, rotation = pos.rot,
            widescan = 1,
            onTrigger = function(player, npc)
                -- Optional: Interaction with the checkpoint NPC
                if player:getLocalVar("RaceActive") == 1 and player:getLocalVar("CurrentCheckpoint") == i then
                     player:printToPlayer("Run through the checkpoint to proceed!", xi.msg.channel.SYSTEM_3)
                else
                     player:printToPlayer("This is Checkpoint " .. i, xi.msg.channel.SYSTEM_3)
                end
                return true
            end,
        })

        -- 2. Trigger Area (from choc_race.lua style)
        -- Using a radius of 6 to make it easy to hit while riding
        zone:registerCylindricalTriggerArea(TRIGGER_BASE_ID + i, pos.x, pos.z, 12)
    end

    -- Setup Stun Spots
    for i, pos in ipairs(stunSpots) do
        zone:insertDynamicEntity({
            objtype = xi.objType.NPC,
            name = "Stun Pickup",
            look = STUN_SPOT_LOOK,
            x = pos.x, y = pos.y, z = pos.z, rotation = pos.rot,
        })
        zone:registerCylindricalTriggerArea(TRIGGER_STUN_BASE_ID + i, pos.x, pos.z, 6)
    end

    -- Setup Speed Boost Spots
    for i, pos in ipairs(speedBoostSpots) do
        zone:insertDynamicEntity({
            objtype = xi.objType.NPC,
            name = "Boost Pad",
            look = SPEED_BOOST_LOOK,
            x = pos.x, y = pos.y, z = pos.z, rotation = pos.rot,
        })
        zone:registerCylindricalTriggerArea(TRIGGER_SPEED_BOOST_BASE_ID + i, pos.x, pos.z, 6)
    end
end)

-- Handle Trigger Area Entry
m:addOverride('xi.zones.Chocobo_Circuit.Zone.onTriggerAreaEnter', function(player, triggerArea)
    local areaID = triggerArea:getTriggerAreaID()
    
    -- Check if it's one of our checkpoint IDs
    if areaID >= TRIGGER_BASE_ID + 1 and areaID <= TRIGGER_BASE_ID + #checkpoints then
        local checkpointIndex = areaID - TRIGGER_BASE_ID
        
        if player:getLocalVar("RaceActive") == 1 then
            local currentTarget = player:getLocalVar("CurrentCheckpoint")
            
            if checkpointIndex == currentTarget then
                -- Correct checkpoint reached
                if checkpointIndex == 1 then
                    local currentLap = player:getLocalVar("CurrentLap")
                    local totalLaps = player:getLocalVar("RaceLaps")

                    if currentLap < totalLaps then
                        player:setLocalVar("CurrentLap", currentLap + 1)
                        player:setLocalVar("CurrentCheckpoint", 2)
                        player:printToPlayer(string.format("Lap %d/%d completed! Go to Checkpoint 2!", currentLap, totalLaps), xi.msg.channel.SYSTEM_3)
                    else
                        -- Finished!
                        local startTime = player:getLocalVar("RaceStartTime")
                        local duration = os.time() - startTime
                        
                        local party = player:getParty()
                        local winnerName = player:getName()
                        local msg = string.format("%s has won the race! Time: %d seconds.", winnerName, duration)

                        if player:getLocalVar("RaceParticipants") >= 3 then
                            local wins = player:getCharVar("ChocoboRaceWins")
                            player:setCharVar("ChocoboRaceWins", wins + 1)
                            player:printToPlayer(string.format("Congratulations! You earned a win! Total Wins: %d", wins + 1), xi.msg.channel.SYSTEM_3)
                            updateLeaderboard(player)
                        end

                        processPayouts(player:getZone(), player)

                        SetServerVariable("ChocoboRaceActive", 0)

                        for _, member in ipairs(party) do
                            if member:getZoneID() == player:getZoneID() and member:getLocalVar("RaceActive") == 1 then
                                member:printToPlayer(msg, xi.msg.channel.SYSTEM_3)

                                -- Increment total races participated
                                local races = member:getCharVar("ChocoboRacesParticipated") or 0
                                member:setCharVar("ChocoboRacesParticipated", races + 1)
                                
                                -- Reset race variables
                                member:setLocalVar("RaceActive", 0)
                                member:setLocalVar("RaceFinished", 0)
                                member:setLocalVar("CurrentCheckpoint", 0)
                                member:setLocalVar("RaceStartTime", 0)
                                member:setLocalVar("RaceLaps", 0)
                                member:setLocalVar("CurrentLap", 0)
                                member:setLocalVar("RaceParticipants", 0)
                                member:setCharVar("ChocoboRaceOn", 0)
                                member:setCharVar("chocostun", 0)
                                
                                -- Force speed reset immediately
                                member:setMod(xi.mod.MOVE_SPEED_OVERRIDE, 0)
                                member:setMod(xi.mod.MOUNT_MOVE, 0)
                                member:recalculateStats()
                            end
                        end
                    end
                elseif checkpointIndex == #checkpoints then
                    -- Loop back to start
                    player:setLocalVar("CurrentCheckpoint", 1)
                    player:printToPlayer("Checkpoint " .. checkpointIndex .. " cleared! Next: Checkpoint 1 (Finish Line!)", xi.msg.channel.SYSTEM_3)
                else
                    -- Advance to next
                    player:setLocalVar("CurrentCheckpoint", currentTarget + 1)
                    player:printToPlayer("Checkpoint " .. checkpointIndex .. " cleared! Next: Checkpoint " .. (currentTarget + 1), xi.msg.channel.SYSTEM_3)
                end
            else
                -- Wrong checkpoint or already passed
                if checkpointIndex > currentTarget and currentTarget ~= 1 then
                    player:printToPlayer("You missed a checkpoint! Go to Checkpoint " .. currentTarget, xi.msg.channel.SYSTEM_3)
                end
            end
        end
    elseif areaID >= TRIGGER_STUN_BASE_ID + 1 and areaID <= TRIGGER_STUN_BASE_ID + #stunSpots then
        local spotIndex = areaID - TRIGGER_STUN_BASE_ID
        if player:getLocalVar("RaceActive") == 1 then
            local currentLap = player:getLocalVar("CurrentLap")
            local lastLapTaken = player:getLocalVar("StunSpot_" .. spotIndex .. "_Lap")
            
            if lastLapTaken < currentLap then
                player:setLocalVar("StunSpot_" .. spotIndex .. "_Lap", currentLap)
                if math.random(1, 100) <= STUN_PICKUP_CHANCE then
                    local stuns = player:getCharVar("chocostun")
                    player:setCharVar("chocostun", stuns + 1)
                    player:printToPlayer(string.format("You found a stun charge! (Stuns: %d)", stuns + 1), xi.msg.channel.SYSTEM_3)
                else
                    player:printToPlayer("The crate was empty!", xi.msg.channel.SYSTEM_3)
                end
            end
        end
    elseif areaID >= TRIGGER_SPEED_BOOST_BASE_ID + 1 and areaID <= TRIGGER_SPEED_BOOST_BASE_ID + #speedBoostSpots then
        local spotIndex = areaID - TRIGGER_SPEED_BOOST_BASE_ID
        if player:getLocalVar("RaceActive") == 1 then
            local currentLap = player:getLocalVar("CurrentLap")
            local lastLapTaken = player:getLocalVar("SpeedBoostSpot_" .. spotIndex .. "_Lap")

            if lastLapTaken < currentLap then
                player:setLocalVar("SpeedBoostSpot_" .. spotIndex .. "_Lap", currentLap)

                if math.random(1, 100) <= SPEED_BOOST_STUN_CHANCE then
                    -- Stun the player
                    player:addStatusEffect(xi.effect.STUN, { power = 1, duration = SPEED_BOOST_STUN_DURATION, origin = player })
                    player:injectActionPacket(player:getID(), 5, 226, 0, 0, 0, 10, player:getID())
                    player:printToPlayer("The boost pad malfunctioned! You are stunned!", xi.msg.channel.SYSTEM_3)
                else
                    -- Give speed boost
                    player:setLocalVar("SpeedBoostEndTime", os.time() + SPEED_BOOST_DURATION)
                    player:printToPlayer("Speed Boost!", xi.msg.channel.SYSTEM_3)
                end
            end
        end
    end
end)

-- Override Mog_Garden Zone Initialization to spawn Race Concierge
m:addOverride('xi.zones.Mog_Garden.Zone.onInitialize', function(zone)
    -- Safely call the original onInitialize function
    local ok, err = pcall(function() super(zone) end)
    if not ok then
        print('ERROR: super(zone) failed in Mog_Garden: ' .. tostring(err))
    end

    -- Spawn Race Concierge NPC
    zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = "Race Concierge",
        look = START_NPC_LOOK,
        x = 329.2843, y = -3.1686, z = -546.2296, rotation = 23,
        onTrigger = function(player, npc)
            local menu = {
                title = "Travel to Race Track?",
                options = {
                    { "Yes", function(p) p:setPos(-74.0570, 0.0000, -62.4020, 27, 70) end },
                    { "No", function(p) end }
                }
            }
            delaySendMenu(player, menu)
            return true
        end,
    })
end)

return m