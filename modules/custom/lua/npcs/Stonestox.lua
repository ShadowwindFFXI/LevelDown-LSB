-----------------------------------
-- Stonestox Storage NPC
-----------------------------------
require('modules/module_utils')
require('scripts/globals/npc_util')
-----------------------------------
local m = Module:new('Stonestox')

local itemsPerPage = 3

-- Define categories and items
local categories = {
    {
        name = "Snow Stones",
        items = {
            { name = "Snowslit Stone", id = xi.item.SNOWSLIT_STONE },
			{ name = "Snowslit Stone +1", id = xi.item.SNOWSLIT_STONE_P1 },
			{ name = "Snowslit Stone +2", id = xi.item.SNOWSLIT_STONE_P2 },
			{ name = "Snowtip Stone", id = xi.item.SNOWTIP_STONE },
			{ name = "Snowtip Stone +1", id = xi.item.SNOWTIP_STONE_P1 },
			{ name = "Snowtip Stone +2", id = xi.item.SNOWTIP_STONE_P2 },
			{ name = "Snowdim Stone", id = xi.item.SNOWDIM_STONE },
			{ name = "Snowdim Stone +1", id = xi.item.SNOWDIM_STONE_P1 },
			{ name = "Snowdim Stone +2", id = xi.item.SNOWDIM_STONE_P2 },
			{ name = "Snoworb Stone", id = xi.item.SNOWORB_STONE },
			{ name = "Snoworb Stone +1", id = xi.item.SNOWORB_STONE_P1 },
			{ name = "Snoworb Stone +2", id = xi.item.SNOWORB_STONE_P2 },
        }
    },
    {
        name = "Leaf Stones",
        items = {
            { name = "Leafslit Stone", id = xi.item.LEAFSLIT_STONE },
			{ name = "Leafslit Stone +1", id = xi.item.LEAFSLIT_STONE_P1 },
			{ name = "Leafslit Stone +2", id = xi.item.LEAFSLIT_STONE_P2 },
			{ name = "Leaftip Stone", id = xi.item.LEAFTIP_STONE },
			{ name = "Leaftip Stone +1", id = xi.item.LEAFTIP_STONE_P1 },
			{ name = "Leaftip Stone +2", id = xi.item.LEAFTIP_STONE_P2 },
			{ name = "Leafdim Stone", id = xi.item.LEAFDIM_STONE },
			{ name = "Leafdim Stone +1", id = xi.item.LEAFDIM_STONE_P1 },
			{ name = "Leafdim Stone +2", id = xi.item.LEAFDIM_STONE_P2 },
			{ name = "Leaforb Stone", id = xi.item.LEAFORB_STONE },
			{ name = "Leaforb Stone +1", id = xi.item.LEAFORB_STONE_P1 },
			{ name = "Leaforb Stone +2", id = xi.item.LEAFORB_STONE_P2 },
        }
    },
    {
        name = "Dusk Stones",
        items = {
            { name = "Duskslit Stone", id = xi.item.DUSKSLIT_STONE },
			{ name = "Duskslit Stone +1", id = xi.item.DUSKSLIT_STONE_P1 },
			{ name = "Duskslit Stone +2", id = xi.item.DUSKSLIT_STONE_P2 },
			{ name = "Dusktip Stone", id = xi.item.DUSKTIP_STONE },
			{ name = "Dusktip Stone +1", id = xi.item.DUSKTIP_STONE_P1 },
			{ name = "Dusktip Stone +2", id = xi.item.DUSKTIP_STONE_P2 },
			{ name = "Duskdim Stone", id = xi.item.DUSKDIM_STONE },
			{ name = "Duskdim Stone +1", id = xi.item.DUSKDIM_STONE_P1 },
			{ name = "Duskdim Stone +2", id = xi.item.DUSKDIM_STONE_P2 },
			{ name = "Duskorb Stone", id = xi.item.DUSKORB_STONE },
			{ name = "Duskorb Stone +1", id = xi.item.DUSKORB_STONE_P1 },
			{ name = "Duskorb Stone +2", id = xi.item.DUSKORB_STONE_P2 },
        }

    },
    {
        name = "Other Stones",
        items = {
            { name = "Ghastly Stone", id = xi.item.GHASTLY_STONE },
			{ name = "Ghastly Stone +1", id = xi.item.GHASTLY_STONE_P1 },
			{ name = "Ghastly Stone +2", id = xi.item.GHASTLY_STONE_P2 },
			{ name = "Verdigris Stone", id = xi.item.VERDIGRIS_STONE },
			{ name = "Verdigris Stone +1", id = xi.item.VERDIGRIS_STONE_P1 },
			{ name = "Verdigris Stone +2", id = xi.item.VERDIGRIS_STONE_P2 },
			{ name = "Wailing Stone", id = xi.item.WAILING_STONE },
			{ name = "Wailing Stone +1", id = xi.item.WAILING_STONE_P1 },
			{ name = "Wailing Stone +2", id = xi.item.WAILING_STONE_P2 },
        }
    },    
}

-- Flatten list for storage scanning
local allItems = {}
local isInitialized = false

local function initializeData()
    if isInitialized then return end
    for _, cat in ipairs(categories) do
        if cat.items then
            for _, item in ipairs(cat.items) do
                if item.id then
                    item.var = "Stonestox_" .. item.id
                    table.insert(allItems, item)
                end
            end
        elseif cat.groups then
            for _, group in ipairs(cat.groups) do
                for _, item in ipairs(group.items) do
                    if item.id then
                        item.var = "Stonestox_" .. item.id
                        table.insert(allItems, item)
                    end
                end
            end
        end
    end
    isInitialized = true
end

local function delaySendMenu(player, menuToSend)
    player:timer(50, function(playerArg)
        playerArg:customMenu(menuToSend)
    end)
end

local function storeItems(player, trade)
    local storedSomething = false

    for _, item in ipairs(allItems) do
        local count = trade:getItemQty(item.id)
        if count > 0 then
            trade:confirmItem(item.id, count)
            local currentBalance = player:getCharVar(item.var)
            player:setCharVar(item.var, currentBalance + count)
            storedSomething = true
            player:printToPlayer(string.format('Stored %d %s. New balance: %d.', count, item.name, currentBalance + count), 0, 'Stonestox')
        end
    end

    if storedSomething then
        player:confirmTrade()
    else
        player:printToPlayer('No valid items found in the trade.', 0, 'Stonestox')
    end
end

local function retrieveItemWithGil(player, trade, selectedItem)
    local gilAmount = trade:getGil()
    local totalItemsToWithdraw = math.min(gilAmount, 99) -- 1 gil = 1 item fee

    local quantity = player:getCharVar(selectedItem.var)
    if quantity > 0 and totalItemsToWithdraw > 0 then
        local itemsToWithdraw = math.min(totalItemsToWithdraw, quantity)
        if player:getFreeSlotsCount() < math.ceil(itemsToWithdraw / 99) then -- Assuming stack size 99 for simplicity, or 12
            player:printToPlayer('You cannot withdraw that amount. Please check your inventory and try again.', 0, 'Stonestox')
            return
        end

        player:addItem(selectedItem.id, itemsToWithdraw)
        player:setCharVar(selectedItem.var, quantity - itemsToWithdraw)
        player:printToPlayer(string.format('You have withdrawn %d %s.', itemsToWithdraw, selectedItem.name), 0, 'Stonestox')
        player:printToPlayer(string.format('Your remaining %s balance is %d.', selectedItem.name, player:getCharVar(selectedItem.var)), 0, 'Stonestox')
        trade:confirmItem(xi.item.GIL, itemsToWithdraw)
        player:confirmTrade()
    else
        player:printToPlayer('You cannot withdraw that amount. Please check your balance and try again.', 0, 'Stonestox')
    end
end

local createCategoryMenu -- Forward declaration
local createGroupMenu -- Forward declaration
local createItemMenu -- Forward declaration

createItemMenu = function(player, categoryIndex, groupIndex, page, trade)
    page = page or 1
    local category = categories[categoryIndex]
    local sourceItems
    local title
    
    if groupIndex then
        sourceItems = category.groups[groupIndex].items
        title = category.groups[groupIndex].name
    else
        sourceItems = category.items
        title = category.name
    end

    local items = {}
    for _, item in ipairs(sourceItems) do
        table.insert(items, item)
    end

    table.sort(items, function(a, b)
        local balA = a.var and player:getCharVar(a.var) or 0
        local balB = b.var and player:getCharVar(b.var) or 0
        if balA == balB then return a.name < b.name end
        return balA > balB
    end)

    local startIndex = (page - 1) * itemsPerPage + 1
    local endIndex = math.min(startIndex + itemsPerPage - 1, #items)
    local options = {}

    for i = startIndex, endIndex do
        local item = items[i]
        local balance = 0
        if item.var then
            balance = player:getCharVar(item.var)
        end
        local text = string.format('%s (%d)', item.name, balance)
        if not item.var then
            text = string.format('%s (Unavailable)', item.name)
        end
        table.insert(options, {
            text,
            function(playerArg)
                if not item.var then
                    playerArg:printToPlayer("This item is unavailable.", 0, 'Stonestox')
                    return
                end
                if trade then
                    retrieveItemWithGil(playerArg, trade, item)
                end
            end
        })
    end

    if page > 1 then
        table.insert(options, { 'Prev', function(p) createItemMenu(p, categoryIndex, groupIndex, page - 1, trade) end })
    end
    if endIndex < #items then
        table.insert(options, { 'Next', function(p) createItemMenu(p, categoryIndex, groupIndex, page + 1, trade) end })
    end
    
    table.insert(options, { 'Back', function(p) 
        if groupIndex then
            createGroupMenu(p, categoryIndex, 1, trade)
        else
            createCategoryMenu(p, trade) 
        end
    end })

    delaySendMenu(player, { title = title, options = options })
end

createGroupMenu = function(player, categoryIndex, page, trade)
    page = page or 1
    local category = categories[categoryIndex]
    local groups = category.groups
    local startIndex = (page - 1) * itemsPerPage + 1
    local endIndex = math.min(startIndex + itemsPerPage - 1, #groups)
    local options = {}

    for i = startIndex, endIndex do
        local group = groups[i]
        table.insert(options, {
            group.name,
            function(playerArg)
                createItemMenu(playerArg, categoryIndex, i, 1, trade)
            end
        })
    end

    if page > 1 then
        table.insert(options, { 'Prev', function(p) createGroupMenu(p, categoryIndex, page - 1, trade) end })
    end
    if endIndex < #groups then
        table.insert(options, { 'Next', function(p) createGroupMenu(p, categoryIndex, page + 1, trade) end })
    end
    
    table.insert(options, { 'Back', function(p) createCategoryMenu(p, trade) end })

    delaySendMenu(player, { title = category.name, options = options })
end

createCategoryMenu = function(player, trade)
    local options = {}
    for i, cat in ipairs(categories) do
        table.insert(options, {
            cat.name,
            function(playerArg)
                if cat.groups then
                    createGroupMenu(playerArg, i, 1, trade)
                else
                    createItemMenu(playerArg, i, nil, 1, trade)
                end
            end
        })
    end
    
    delaySendMenu(player, { title = 'Select Category', options = options })
end

m:addOverride('xi.zones.Western_Adoulin.Zone.onInitialize', function(zone)
    super(zone)

    local Stonestox = zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = 'Stonestox',
        look = 85,
        x = 106.2028, y = -0.6500, z = -69.8621, 
        rotation = 90,
        widescan = 1,
        onTrade = function(player, npc, trade)
            initializeData()
            if npcUtil.tradeHas(trade, xi.item.GIL) then
                createCategoryMenu(player, trade)
            else
                storeItems(player, trade)
            end
        end,
        onTrigger = function(player, npc)
            initializeData()
            createCategoryMenu(player, nil) -- View only mode
            player:printToPlayer('Review your current Stones Balance. To withdraw, trade me gil (1 gil per item). Or trade me the Parts you want stored.', 0, 'Stonestox')
        end,
    })
    utils.unused(Stonestox)
end)

return m
