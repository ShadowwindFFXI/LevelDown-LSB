-----------------------------------
-- Curseulox Storage NPC
-----------------------------------
require('modules/module_utils')
require('scripts/globals/npc_util')
-----------------------------------
local m = Module:new('Curseulox')

local itemsPerPage = 3

-- Define categories and items
local categories = {
    {
        name = "Zilartian Abjurations",
        groups = {
            { name = "Dryadic Set", items = {
                { name = "D. Head", id = xi.item.DRYADIC_ABJURATION_HEAD },
                { name = "D. Body", id = xi.item.DRYADIC_ABJURATION_BODY },
                { name = "D. Hands", id = xi.item.DRYADIC_ABJURATION_HANDS },
                { name = "D. Legs", id = xi.item.DRYADIC_ABJURATION_LEGS },
                { name = "D. Feet", id = xi.item.DRYADIC_ABJURATION_FEET },
            }},
            { name = "Earthen Set", items = {
                { name = "E. Head", id = xi.item.EARTHEN_ABJURATION_HEAD },
                { name = "E. Body", id = xi.item.EARTHEN_ABJURATION_BODY },
                { name = "E. Hands", id = xi.item.EARTHEN_ABJURATION_HANDS },
                { name = "E. Legs", id = xi.item.EARTHEN_ABJURATION_LEGS },
                { name = "E. Feet", id = xi.item.EARTHEN_ABJURATION_FEET },
            }},
            { name = "Aquarian Set", items = {
                { name = "A. Head", id = xi.item.AQUARIAN_ABJURATION_HEAD },
                { name = "A. Body", id = xi.item.AQUARIAN_ABJURATION_BODY },
                { name = "A. Hands", id = xi.item.AQUARIAN_ABJURATION_HANDS },
                { name = "A. Legs", id = xi.item.AQUARIAN_ABJURATION_LEGS },
                { name = "A. Feet", id = xi.item.AQUARIAN_ABJURATION_FEET },
            }},
            { name = "Martial Set", items = {
                { name = "M. Head", id = xi.item.MARTIAL_ABJURATION_HEAD },
                { name = "M. Body", id = xi.item.MARTIAL_ABJURATION_BODY },
                { name = "M. Hands", id = xi.item.MARTIAL_ABJURATION_HANDS },
                { name = "M. Legs", id = xi.item.MARTIAL_ABJURATION_LEGS },
                { name = "M. Feet", id = xi.item.MARTIAL_ABJURATION_FEET },
            }},
            { name = "Wyrmal Set", items = {
                { name = "W. Head", id = xi.item.WYRMAL_ABJURATION_HEAD },
                { name = "W. Body", id = xi.item.WYRMAL_ABJURATION_BODY },
                { name = "W. Hands", id = xi.item.WYRMAL_ABJURATION_HANDS },
                { name = "W. Legs", id = xi.item.WYRMAL_ABJURATION_LEGS },
                { name = "W. Feet", id = xi.item.WYRMAL_ABJURATION_FEET },
            }},
            { name = "Neptunal Set", items = {
                { name = "N. Head", id = xi.item.NEPTUNAL_ABJURATION_HEAD },
                { name = "N. Body", id = xi.item.NEPTUNAL_ABJURATION_BODY },
                { name = "N. Hands", id = xi.item.NEPTUNAL_ABJURATION_HANDS },
                { name = "N. Legs", id = xi.item.NEPTUNAL_ABJURATION_LEGS },
                { name = "N. Feet", id = xi.item.NEPTUNAL_ABJURATION_FEET },
            }},
            { name = "Consumables", items = {
                { name = "Libation", id = xi.item.LIBATION_ABJURATION },
                { name = "Oblation", id = xi.item.OBLATION_ABJURATION },                
            }},            
        }
    },
    
	{
        name = "Einherjar Abjurations",
        groups = {
            { name = "Hadean Set", items = {
                { name = "H. Head", id = xi.item.HADEAN_ABJURATION_HEAD },
                { name = "H. Body", id = xi.item.HADEAN_ABJURATION_BODY },
                { name = "H. Hands", id = xi.item.HADEAN_ABJURATION_HANDS },
                { name = "H. Legs", id = xi.item.HADEAN_ABJURATION_LEGS },
                { name = "H. Feet", id = xi.item.HADEAN_ABJURATION_FEET },
            }},
            { name = "Phantasmal Set", items = {
                { name = "P. Head", id = xi.item.PHANTASMAL_ABJURATION_HEAD },
                { name = "P. Body", id = xi.item.PHANTASMAL_ABJURATION_BODY },
                { name = "P. Hands", id = xi.item.PHANTASMAL_ABJURATION_HANDS },
                { name = "P. Legs", id = xi.item.PHANTASMAL_ABJURATION_LEGS },
                { name = "P. Feet", id = xi.item.PHANTASMAL_ABJURATION_FEET },
            }},            
        }
    },
	
	{
        name = "Legion Abjurations",
        groups = {
            { name = "Corvine Set", items = {
                { name = "Cor. Head", id = xi.item.CORVINE_ABJURATION_HEAD },
                { name = "Cor. Body", id = xi.item.CORVINE_ABJURATION_BODY },
                { name = "Cor. Hands", id = xi.item.CORVINE_ABJURATION_HANDS },
                { name = "Cor. Legs", id = xi.item.CORVINE_ABJURATION_LEGS },
                { name = "Cor. Feet", id = xi.item.CORVINE_ABJURATION_FEET },
            }},
            { name = "Supernal Set", items = {
                { name = "Sup. Head", id = xi.item.SUPERNAL_ABJURATION_HEAD },
                { name = "Sup. Body", id = xi.item.SUPERNAL_ABJURATION_BODY },
                { name = "Sup. Hands", id = xi.item.SUPERNAL_ABJURATION_HANDS },
                { name = "Sup. Legs", id = xi.item.SUPERNAL_ABJURATION_LEGS },
                { name = "Sup. Feet", id = xi.item.SUPERNAL_ABJURATION_FEET },
            }},
            { name = "Transitory Set", items = {
                { name = "Tra. Head", id = xi.item.TRANSITORY_ABJURATION_HEAD },
                { name = "Tra. Body", id = xi.item.TRANSITORY_ABJURATION_BODY },
                { name = "Tra. Hands", id = xi.item.TRANSITORY_ABJURATION_HANDS },
                { name = "Tra. Legs", id = xi.item.TRANSITORY_ABJURATION_LEGS },
                { name = "Tra. Feet", id = xi.item.TRANSITORY_ABJURATION_FEET },
            }},
            { name = "Foreboding Set", items = {
                { name = "For. Head", id = xi.item.FOREBODING_ABJURATION_HEAD },
                { name = "For. Body", id = xi.item.FOREBODING_ABJURATION_BODY },
                { name = "For. Hands", id = xi.item.FOREBODING_ABJURATION_HANDS },
                { name = "For. Legs", id = xi.item.FOREBODING_ABJURATION_LEGS },
                { name = "For. Feet", id = xi.item.FOREBODING_ABJURATION_FEET },
            }},
            { name = "Lenitive Set", items = {
                { name = "Len. Head", id = xi.item.LENITIVE_ABJURATION_HEAD },
                { name = "Len. Body", id = xi.item.LENITIVE_ABJURATION_BODY },
                { name = "Len. Hands", id = xi.item.LENITIVE_ABJURATION_HANDS },
                { name = "Len. Legs", id = xi.item.LENITIVE_ABJURATION_LEGS },
                { name = "Len. Feet", id = xi.item.LENITIVE_ABJURATION_FEET },
            }},            
        }
    },
	
	{
        name = "E. Ru'Aun Abjurations",
        groups = {
            { name = "Bushin Set", items = {
                { name = "Bus. Head", id = xi.item.BUSHIN_ABJURATION_HEAD },
                { name = "Bus. Body", id = xi.item.BUSHIN_ABJURATION_BODY },
                { name = "Bus. Hands", id = xi.item.BUSHIN_ABJURATION_HANDS },
                { name = "Bus. Legs", id = xi.item.BUSHIN_ABJURATION_LEGS },
                { name = "Bus. Feet", id = xi.item.BUSHIN_ABJURATION_FEET },
            }},
            { name = "Vale Set", items = {
                { name = "Val. Head", id = xi.item.VALE_ABJURATION_HEAD },
                { name = "Val. Body", id = xi.item.VALE_ABJURATION_BODY },
                { name = "Val. Hands", id = xi.item.VALE_ABJURATION_HANDS },
                { name = "Val. Legs", id = xi.item.VALE_ABJURATION_LEGS },
                { name = "Val. Feet", id = xi.item.VALE_ABJURATION_FEET },
            }},
            { name = "Grove Set", items = {
                { name = "Gro. Head", id = xi.item.GROVE_ABJURATION_HEAD },
                { name = "Gro. Body", id = xi.item.GROVE_ABJURATION_BODY },
                { name = "Gro. Hands", id = xi.item.GROVE_ABJURATION_HANDS },
                { name = "Gro. Legs", id = xi.item.GROVE_ABJURATION_LEGS },
                { name = "Gro. Feet", id = xi.item.GROVE_ABJURATION_FEET },
            }},
            { name = "Triton Set", items = {
                { name = "Tri. Head", id = xi.item.TRITON_ABJURATION_HEAD },
                { name = "Tri. Body", id = xi.item.TRITON_ABJURATION_BODY },
                { name = "Tri. Hands", id = xi.item.TRITON_ABJURATION_HANDS },
                { name = "Tri. Legs", id = xi.item.TRITON_ABJURATION_LEGS },
                { name = "Tri. Feet", id = xi.item.TRITON_ABJURATION_FEET },
            }},
            { name = "Shinryu Set", items = {
                { name = "Shi. Head", id = xi.item.SHINRYU_ABJURATION_HEAD },
                { name = "Shi. Body", id = xi.item.SHINRYU_ABJURATION_BODY },
                { name = "Shi. Hands", id = xi.item.SHINRYU_ABJURATION_HANDS },
                { name = "Shi. Legs", id = xi.item.SHINRYU_ABJURATION_LEGS },
                { name = "Shi. Feet", id = xi.item.SHINRYU_ABJURATION_FEET },
            }},
            { name = "Abyssal Set", items = {
                { name = "Aby. Head", id = xi.item.ABYSSAL_ABJURATION_HEAD },
                { name = "Aby. Body", id = xi.item.ABYSSAL_ABJURATION_BODY },
                { name = "Aby. Hands", id = xi.item.ABYSSAL_ABJURATION_HANDS },
                { name = "Aby. Legs", id = xi.item.ABYSSAL_ABJURATION_LEGS },
                { name = "Aby. Feet", id = xi.item.ABYSSAL_ABJURATION_FEET },
            }},
            { name = "Cronian Set", items = {
                { name = "Cro. Head", id = xi.item.CRONIAN_ABJURATION_HEAD },
                { name = "Cro. Body", id = xi.item.CRONIAN_ABJURATION_BODY },
                { name = "Cro. Hands", id = xi.item.CRONIAN_ABJURATION_HANDS },
                { name = "Cro. Legs", id = xi.item.CRONIAN_ABJURATION_LEGS },
                { name = "Cro. Feet", id = xi.item.CRONIAN_ABJURATION_FEET },
            }},
			{ name = "Arean Set", items = {
                { name = "Are. Head", id = xi.item.AREAN_ABJURATION_HEAD },
                { name = "Are. Body", id = xi.item.AREAN_ABJURATION_BODY },
                { name = "Are. Hands", id = xi.item.AREAN_ABJURATION_HANDS },
                { name = "Are. Legs", id = xi.item.AREAN_ABJURATION_LEGS },
                { name = "Are. Feet", id = xi.item.AREAN_ABJURATION_FEET },
            }},
			{ name = "Jovian Set", items = {
                { name = "Jov. Head", id = xi.item.JOVIAN_ABJURATION_HEAD },
                { name = "Jov. Body", id = xi.item.JOVIAN_ABJURATION_BODY },
                { name = "Jov. Hands", id = xi.item.JOVIAN_ABJURATION_HANDS },
                { name = "Jov. Legs", id = xi.item.JOVIAN_ABJURATION_LEGS },
                { name = "Jov. Feet", id = xi.item.JOVIAN_ABJURATION_FEET },
            }},
			{ name = "Venerian Set", items = {
                { name = "Ven. Head", id = xi.item.VENERIAN_ABJURATION_HEAD },
                { name = "Ven. Body", id = xi.item.VENERIAN_ABJURATION_BODY },
                { name = "Ven. Hands", id = xi.item.VENERIAN_ABJURATION_HANDS },
                { name = "Ven. Legs", id = xi.item.VENERIAN_ABJURATION_LEGS },
                { name = "Ven. Feet", id = xi.item.VENERIAN_ABJURATION_FEET },
            }},
			{ name = "Cyllenian Set", items = {
                { name = "Cyl. Head", id = xi.item.CYLLENIAN_ABJURATION_HEAD },
                { name = "Cyl. Body", id = xi.item.CYLLENIAN_ABJURATION_BODY },
                { name = "Cyl. Hands", id = xi.item.CYLLENIAN_ABJURATION_HANDS },
                { name = "Cyl. Legs", id = xi.item.CYLLENIAN_ABJURATION_LEGS },
                { name = "Cyl. Feet", id = xi.item.CYLLENIAN_ABJURATION_FEET },
            }},
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
                    item.var = "Curseulox_" .. item.id
                    table.insert(allItems, item)
                end
            end
        elseif cat.groups then
            for _, group in ipairs(cat.groups) do
                for _, item in ipairs(group.items) do
                    if item.id then
                        item.var = "Curseulox_" .. item.id
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
            local currentBalance = player:getCharVar(item.var)
            player:setCharVar(item.var, currentBalance + count)
            storedSomething = true
            player:printToPlayer(string.format('Stored %d %s. New balance: %d.', count, item.name, currentBalance + count), 0, 'Curseulox')
        end
    end

    if storedSomething then
        player:tradeComplete()
    else
        player:printToPlayer('No valid items found in the trade.', 0, 'Curseulox')
    end
end

local function retrieveItemWithGil(player, trade, selectedItem)
    local gilAmount = trade:getGil()
    local totalItemsToWithdraw = math.min(gilAmount, 99) -- 1 gil = 1 item fee

    local quantity = player:getCharVar(selectedItem.var)
    if quantity > 0 and totalItemsToWithdraw > 0 then
        local itemsToWithdraw = math.min(totalItemsToWithdraw, quantity)
        if player:getFreeSlotsCount() < math.ceil(itemsToWithdraw / 99) then -- Assuming stack size 99 for simplicity, or 12
            player:printToPlayer('You cannot withdraw that amount. Please check your inventory and try again.', 0, 'Curseulox')
            return
        end

        player:addItem(selectedItem.id, itemsToWithdraw)
        player:setCharVar(selectedItem.var, quantity - itemsToWithdraw)
        player:printToPlayer(string.format('You have withdrawn %d %s.', itemsToWithdraw, selectedItem.name), 0, 'Curseulox')
        player:printToPlayer(string.format('Your remaining %s balance is %d.', selectedItem.name, player:getCharVar(selectedItem.var)), 0, 'Curseulox')
        player:tradeComplete()
    else
        player:printToPlayer('You cannot withdraw that amount. Please check your balance and try again.', 0, 'Curseulox')
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
                    playerArg:printToPlayer("This item is unavailable.", 0, 'Curseulox')
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

m:addOverride('xi.zones.Mog_Garden.Zone.onInitialize', function(zone)
    super(zone)

    local Curseulox = zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = 'Curseulox',
        look = 85,
        x = 320.5554, y = -2.8292, z = -546.2506, 
        rotation = 50,
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
            player:printToPlayer('Review your current Abjuration Stock. To withdraw, trade me gil (1 gil per item). Or trade me the Abjurations you want stored.', 0, 'Curseulox')
        end,
    })
    utils.unused(Curseulox)
end)

return m
