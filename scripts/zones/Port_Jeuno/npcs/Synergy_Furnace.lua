-----------------------------------
-- Area: Port Jeuno (and others)
--  NPC: Synergy Furnace
-----------------------------------
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

local ambuscadeItems = {
    [xi.item.AMBUSCADE_VOUCHER_HEAD] = 2,
    [xi.item.AMBUSCADE_VOUCHER_BODY] = 5,
    [xi.item.AMBUSCADE_VOUCHER_HANDS] = 1,
    [xi.item.AMBUSCADE_VOUCHER_LEGS] = 3,
    [xi.item.AMBUSCADE_VOUCHER_FEET] = 1,
    [xi.item.AMBUSCADE_VOUCHER_BACK] = 3,
    [xi.item.AMBUSCADE_VOUCHER_HEAD_P1] = 7,
    [xi.item.AMBUSCADE_VOUCHER_BODY_P1] = 17,
    [xi.item.AMBUSCADE_VOUCHER_HANDS_P1] = 4,
    [xi.item.AMBUSCADE_VOUCHER_LEGS_P1] = 11,
    [xi.item.AMBUSCADE_VOUCHER_FEET_P1] = 2,
    [xi.item.AMBUSCADE_VOUCHER_FINGERS] = 10,
    [xi.item.AMBUSCADE_VOUCHER_WEAPON] = 19,
    [xi.item.AMBUSCADE_CHIT_HEADGEAR] = 2,
    [xi.item.AMBUSCADE_CHIT_BODYGEAR] = 5,
    [xi.item.AMBUSCADE_CHIT_HANDGEAR] = 1,
    [xi.item.AMBUSCADE_CHIT_LEGGEAR] = 3,
    [xi.item.AMBUSCADE_CHIT_FOOTGEAR] = 1,
    [xi.item.AMBUSCADE_CHIT_HEADGEAR_P1] = 7,
    [xi.item.AMBUSCADE_CHIT_BODYGEAR_P1] = 17,
    [xi.item.AMBUSCADE_CHIT_HANDGEAR_P1] = 4,
    [xi.item.AMBUSCADE_CHIT_LEGGEAR_P1] = 10,
    [xi.item.AMBUSCADE_CHIT_FOOTGEAR_P1] = 2,
    [xi.item.AMBUSCADE_CHIT_RING] = 9,
}

local synergyRecipes = {
    {
        name = "Combatant's Torque",
        ingredients = {
            { id = xi.item.CARNAL_TORQUE, qty = 1 },
            { id = xi.item.DECIMUS_TORQUE, qty = 1 },
            { id = xi.item.BILIOUS_TORQUE, qty = 1 },
            { id = xi.item.AGELAST_TORQUE, qty = 1 },
            { id = xi.item.MASKIROVA_TORQUE, qty = 1 },
            { id = xi.item.YARAK_TORQUE, qty = 1 },
            { id = xi.item.ACANTHA_TORQUE, qty = 1 },
        },
        result = xi.item.COMBATANTS_TORQUE,
        successRate = 90, -- 90% chance to succeed
    },
    {
        name = "Incanter's Torque",
        ingredients = {
            { id = xi.item.MELIC_TORQUE, qty = 1 },
            { id = xi.item.HENIC_TORQUE, qty = 1 },
            { id = xi.item.DECEIVERS_TORQUE, qty = 1 },
        },
        result = xi.item.INCANTERS_TORQUE,
        successRate = 90,
    },
    {
        name = "Beast Collar",
        ingredients = {
            { id = xi.item.CARVERS_TORQUE, qty = 1 },
            { id = xi.item.SMITHYS_TORQUE, qty = 1 },
            { id = xi.item.GOLDSMITHS_TORQUE, qty = 1 },
            { id = xi.item.WEAVERS_TORQUE, qty = 1 },
            { id = xi.item.TANNERS_TORQUE, qty = 1 },
            { id = xi.item.BONEWORKERS_TORQUE, qty = 1 },
            { id = xi.item.ALCHEMISTS_TORQUE, qty = 1 },
            { id = xi.item.CULINARIANS_TORQUE, qty = 1 },
        },
        result = xi.item.BEAST_COLLAR,
        successRate = 90,
        onSuccess = function(player)
            player:addItem({id=13121, signature="CraftMaster"})
        end,
    },
}

local ambuscadeWeaponsList = {
    { name = "Karambit", id = xi.item.KARAMBIT },
    { name = "Tauret", id = xi.item.TAURET },
    { name = "Naegling", id = xi.item.NAEGLING },
    { name = "Nandaka", id = xi.item.NANDAKA },
    { name = "Dolichenus", id = xi.item.DOLICHENUS },
    { name = "Lycurgos", id = xi.item.LYCURGOS },
    { name = "Drepanum", id = xi.item.DREPANUM },
    { name = "Shining One", id = xi.item.SHINING_ONE },
    { name = "Gokotai", id = xi.item.GOKOTAI },
    { name = "Hachimonji", id = xi.item.HACHIMONJI },
    { name = "Maxentius", id = xi.item.MAXENTIUS },
    { name = "Xoanon", id = xi.item.XOANON },
    { name = "Ullr", id = xi.item.ULLR },
    { name = "Khonsu", id = xi.item.KHONSU },
}

local ambuscadeWeapons = {}
for _, v in ipairs(ambuscadeWeaponsList) do
    ambuscadeWeapons[v.id] = true
end

local adoulinRingsList = {
    { name = "Adoulin Ring +1", id = xi.item.ADOULIN_RING_P1 },
    { name = "Gorney Ring +1", id = xi.item.GORNEY_RING_P1 },
    { name = "Haverton Ring +1", id = xi.item.HAVERTON_RING_P1 },
    { name = "Janniston Ring +1", id = xi.item.JANNISTON_RING_P1 },
    { name = "Karieyh Ring +1", id = xi.item.KARIEYH_RING_P1 },
    { name = "Orvail Ring +1", id = xi.item.ORVAIL_RING_P1 },
    { name = "Renaye Ring +1", id = xi.item.RENAYE_RING_P1 },
    { name = "Shneddick Ring +1", id = xi.item.SHNEDDICK_RING_P1 },
    { name = "Thurandaut Ring +1", id = xi.item.THURANDAUT_RING_P1 },
    { name = "Vocane Ring +1", id = xi.item.VOCANE_RING_P1 },
    { name = "Weatherspoon Ring +1", id = xi.item.WEATHERSPOON_RING_P1 },
    { name = "Woltaris Ring +1", id = xi.item.WOLTARIS_RING_P1 },
}

local adoulinRings = {}
for _, v in ipairs(adoulinRingsList) do
    adoulinRings[v.id] = true
end

local showRingExchangeMenu
showRingExchangeMenu = function(player, page)
    local tradedItemId = player:getLocalVar("SynergyAdoulinRingTrade")

    local availableRings = {}
    for _, ring in ipairs(adoulinRingsList) do
        if ring.id ~= tradedItemId and not player:hasItem(ring.id) then
            table.insert(availableRings, ring)
        end
    end

    if #availableRings == 0 then
        player:printToPlayer("You already possess all available exchange rings.", xi.msg.channel.SYSTEM_3)
        if tradedItemId > 0 then
            npcUtil.giveItem(player, tradedItemId)
            player:setLocalVar("SynergyAdoulinRingTrade", 0)
        end
        return
    end

    page = page or 1
    local itemsPerPage = 3
    local totalItems = #availableRings
    local startIndex = (page - 1) * itemsPerPage + 1
    local endIndex = math.min(startIndex + itemsPerPage - 1, totalItems)

    local options = {}

    if page > 1 then
        table.insert(options, { 'Previous Page', function(pArg)
            pArg:timer(50, function(p) showRingExchangeMenu(p, page - 1) end)
        end })
    end

    for i = startIndex, endIndex do
        local ring = availableRings[i]
        table.insert(options, { ring.name, function(pArg)
            if npcUtil.giveItem(pArg, { { ring.id, 1 } }) then
                pArg:setLocalVar("SynergyAdoulinRingTrade", 0)
                pArg:setCharVar("AdoulinRingExchangeTally", NextConquestTally())
            else
                npcUtil.giveItem(pArg, pArg:getLocalVar("SynergyAdoulinRingTrade"))
                pArg:setLocalVar("SynergyAdoulinRingTrade", 0)
            end
        end })
    end

    if endIndex < totalItems then
        table.insert(options, { 'Next Page', function(pArg)
            pArg:timer(50, function(p) showRingExchangeMenu(p, page + 1) end)
        end })
    end

    table.insert(options, { 'Cancel', function(pArg)
        local returnedItem = pArg:getLocalVar("SynergyAdoulinRingTrade")
        if returnedItem > 0 then
            npcUtil.giveItem(pArg, returnedItem)
            pArg:setLocalVar("SynergyAdoulinRingTrade", 0)
        end
    end })

    player:customMenu({
        title = 'Select a ring to exchange for:',
        options = options,
        onCancelled = function(pArg)
            local returnedItem = pArg:getLocalVar("SynergyAdoulinRingTrade")
            if returnedItem > 0 then
                npcUtil.giveItem(pArg, returnedItem)
                pArg:setLocalVar("SynergyAdoulinRingTrade", 0)
            end
        end
    })
end

local showWeaponExchangeMenu
showWeaponExchangeMenu = function(player, page)
    local tradedItemId = player:getLocalVar("SynergyAmbuscadeWeaponTrade")

    local availableWeapons = {}
    for _, weapon in ipairs(ambuscadeWeaponsList) do
        if weapon.id ~= tradedItemId and not player:hasItem(weapon.id) then
            table.insert(availableWeapons, weapon)
        end
    end

    if #availableWeapons == 0 then
        player:printToPlayer("You already possess all available exchange weapons.", xi.msg.channel.SYSTEM_3)
        if tradedItemId > 0 then
            npcUtil.giveItem(player, tradedItemId)
            player:setLocalVar("SynergyAmbuscadeWeaponTrade", 0)
        end
        return
    end

    page = page or 1
    local itemsPerPage = 3
    local totalItems = #availableWeapons
    local startIndex = (page - 1) * itemsPerPage + 1
    local endIndex = math.min(startIndex + itemsPerPage - 1, totalItems)

    local options = {}

    if page > 1 then
        table.insert(options, { 'Previous Page', function(pArg)
            pArg:timer(50, function(p) showWeaponExchangeMenu(p, page - 1) end)
        end })
    end

    for i = startIndex, endIndex do
        local weapon = availableWeapons[i]
        table.insert(options, { weapon.name, function(pArg)
            if npcUtil.giveItem(pArg, { { weapon.id, 1 } }) then
                pArg:setLocalVar("SynergyAmbuscadeWeaponTrade", 0)
            else
                npcUtil.giveItem(pArg, pArg:getLocalVar("SynergyAmbuscadeWeaponTrade"))
                pArg:setLocalVar("SynergyAmbuscadeWeaponTrade", 0)
            end
        end })
    end

    if endIndex < totalItems then
        table.insert(options, { 'Next Page', function(pArg)
            pArg:timer(50, function(p) showWeaponExchangeMenu(p, page + 1) end)
        end })
    end

    table.insert(options, { 'Cancel', function(pArg)
        local returnedItem = pArg:getLocalVar("SynergyAmbuscadeWeaponTrade")
        if returnedItem > 0 then
            npcUtil.giveItem(pArg, returnedItem)
            pArg:setLocalVar("SynergyAmbuscadeWeaponTrade", 0)
        end
    end })

    player:customMenu({
        title = 'Select a weapon to exchange for:',
        options = options,
        onCancelled = function(pArg)
            local returnedItem = pArg:getLocalVar("SynergyAmbuscadeWeaponTrade")
            if returnedItem > 0 then
                npcUtil.giveItem(pArg, returnedItem)
                pArg:setLocalVar("SynergyAmbuscadeWeaponTrade", 0)
            end
        end
    })
end

entity.onTrade = function(player, npc, trade)
    -- Special menu intercept for Ambuscade Vouchers/Chits/Weapons
    if trade:getItemCount() == 1 then
        local tradedItemId = trade:getItemId(0)

        if adoulinRings[tradedItemId] then
            local nextTally = player:getCharVar("AdoulinRingExchangeTally")
            if nextTally > os.time() then
                player:printToPlayer("You can only exchange an Adoulin ring once per conquest tally.", xi.msg.channel.SYSTEM_3)
                return
            end

            player:setLocalVar("SynergyAdoulinRingTrade", tradedItemId)
            player:tradeComplete()
            
            player:timer(100, function(p)
                showRingExchangeMenu(p, 1)
            end)
            return
        end
        
        if ambuscadeWeapons[tradedItemId] then
            player:setLocalVar("SynergyAmbuscadeWeaponTrade", tradedItemId)
            player:tradeComplete()
            
            player:timer(100, function(p)
                showWeaponExchangeMenu(p, 1)
            end)
            return
        end
        
        if ambuscadeItems[tradedItemId] then
            local rewardQty = ambuscadeItems[tradedItemId]
            player:setLocalVar("SynergyAmbuscadeTrade", tradedItemId)
            player:tradeComplete()
            
            player:timer(100, function(p)
                p:customMenu({
                    title = 'Select a reward for your Ambuscade item:',
                    options = {
                        { string.format('%dx Abdhaljs Metal', rewardQty), function(pArg)
                            if npcUtil.giveItem(pArg, { { xi.item.VIAL_OF_ABDHALJS_METAL, rewardQty } }) then
                                local hallmarkReward = rewardQty * 100
                                pArg:addCurrency('current_hallmarks', hallmarkReward)
                                pArg:printToPlayer(string.format("You receive %d hallmarks.", hallmarkReward), xi.msg.channel.SYSTEM_3)
                                pArg:setLocalVar("SynergyAmbuscadeTrade", 0)
                            else
                                npcUtil.giveItem(pArg, pArg:getLocalVar("SynergyAmbuscadeTrade"))
                                pArg:setLocalVar("SynergyAmbuscadeTrade", 0)
                            end
                        end },
                        { string.format('%dx Abdhaljs Fiber', rewardQty), function(pArg)
                            if npcUtil.giveItem(pArg, { { xi.item.LOOP_OF_ABDHALJS_FIBER, rewardQty } }) then
                                local hallmarkReward = rewardQty * 100
                                pArg:addCurrency('current_hallmarks', hallmarkReward)
                                pArg:printToPlayer(string.format("You receive %d hallmarks.", hallmarkReward), xi.msg.channel.SYSTEM_3)
                                pArg:setLocalVar("SynergyAmbuscadeTrade", 0)
                            else
                                npcUtil.giveItem(pArg, pArg:getLocalVar("SynergyAmbuscadeTrade"))
                                pArg:setLocalVar("SynergyAmbuscadeTrade", 0)
                            end
                        end },
                        { 'Cancel', function(pArg)
                            local returnedItem = pArg:getLocalVar("SynergyAmbuscadeTrade")
                            if returnedItem > 0 then
                                npcUtil.giveItem(pArg, returnedItem)
                                pArg:setLocalVar("SynergyAmbuscadeTrade", 0)
                            end
                        end },
                    },
                    onCancelled = function(pArg)
                        local returnedItem = pArg:getLocalVar("SynergyAmbuscadeTrade")
                        if returnedItem > 0 then
                            npcUtil.giveItem(pArg, returnedItem)
                            pArg:setLocalVar("SynergyAmbuscadeTrade", 0)
                        end
                    end
                })
            end)
            return
        end
    end

    local recipeMatched = nil
    
    -- Identify if trade matches any recipe exactly
    for _, recipe in ipairs(synergyRecipes) do
        local matched = true
        local totalReqQty = 0
        
        for _, req in ipairs(recipe.ingredients) do
            if not trade:hasItemQty(req.id, req.qty) then
                matched = false
                break
            end
            totalReqQty = totalReqQty + req.qty
        end
        
        -- Ensure the player isn't trading extra junk alongside the required items
        if matched and trade:getItemCount() == totalReqQty then
            recipeMatched = recipe
            break
        end
    end

    if recipeMatched then
        if player:hasItem(recipeMatched.result) then
            player:printToPlayer("You already possess the result of this synergy.", xi.msg.channel.SYSTEM_3)
            return
        end

        local roll = math.random(1, 100)
        
        if roll <= recipeMatched.successRate then
            -- Success! Consume all traded items and give the result
            player:tradeComplete()
            
            if recipeMatched.onSuccess then
                recipeMatched.onSuccess(player)
            else
                npcUtil.giveItem(player, recipeMatched.result)
            end
            
            player:printToPlayer(string.format("Synergy was successful! You obtained a %s!", recipeMatched.name), xi.msg.channel.SYSTEM_3)
        else
            -- Failure! Determine how many items are lost
            local numItems = #recipeMatched.ingredients
            
            -- Weighted random roll (Higher chance to lose fewer items)
            local totalWeight = (numItems * (numItems + 1)) / 2
            local lossRoll = math.random(1, totalWeight)
            local numLost = 1
            local currentWeight = 0
            
            for i = 1, numItems do
                local weightForThisItem = (numItems - i) + 1
                currentWeight = currentWeight + weightForThisItem
                if lossRoll <= currentWeight then
                    numLost = i
                    break
                end
            end
            
            -- Shuffle the ingredients to randomly pick which ones break
            local shuffledIngredients = {}
            for _, req in ipairs(recipeMatched.ingredients) do
                table.insert(shuffledIngredients, req)
            end
            
            for i = #shuffledIngredients, 2, -1 do
                local j = math.random(i)
                shuffledIngredients[i], shuffledIngredients[j] = shuffledIngredients[j], shuffledIngredients[i]
            end
            
            -- Confirm only the lost items to consume them; the rest are safely returned to the player
            for i = 1, numLost do
                trade:confirmItem(shuffledIngredients[i].id, shuffledIngredients[i].qty)
            end
            
            player:confirmTrade()
            player:printToPlayer(string.format("Synergy failed... You lost %d material(s) in the furnace.", numLost), xi.msg.channel.SYSTEM_3)
        end
    else
        player:printToPlayer("The furnace rejects your items. They do not match any known synergy recipe.", xi.msg.channel.SYSTEM_3)
    end
end

entity.onTrigger = function(player, npc)
    player:printToPlayer("The furnace hums with energy. Trade specific items to it to attempt Synergy.", xi.msg.channel.SYSTEM_3)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
