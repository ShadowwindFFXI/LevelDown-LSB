-----------------------------------
-- Area: Port Jeuno (and others)
--  NPC: Synergy Furnace
-----------------------------------
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

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
}

entity.onTrade = function(player, npc, trade)
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
            npcUtil.giveItem(player, recipeMatched.result)
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
