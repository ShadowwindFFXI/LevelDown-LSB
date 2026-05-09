-----------------------------------
-- Domain Invasion (custom module)
-- Coded with love by Carver, Xaver, Graves, Demetrie
-- 2022, CatsEyeXI (http://catseyexi.com) / --server server.catseyexi.com
-----------------------------------
require("modules/module_utils")
-----------------------------------
local m = Module:new("domain_invasion_core")

local battleID =
{
    COLKHAB  = 1,
    TCHAKKA  = 2,
    ACHUKA   = 3,
    YUMCAX   = 4,
    HURKAN   = 5,
    KUMHAU   = 6,
}

local naakual =
{
    mods =
    {
        [xi.mod.BLINDRES       ] =  100,
        [xi.mod.BINDRES        ] =  100,
        [xi.mod.GRAVITYRES     ] =  100,
        [xi.mod.SLEEPRES       ] =  100,
        [xi.mod.LULLABYRES     ] =  100,
        [xi.mod.MDEF           ] = 1400,
        [xi.mod.MAIN_DMG_RATING] =  150,
        [xi.mod.MATT           ] =  150,
        [xi.mod.MACC           ] =  450,
        [xi.mod.DEF            ] = 1100,
        [xi.mod.MEVA           ] =  500,
        [xi.mod.ATT            ] =  500,
        [xi.mod.EVA            ] =  750,
        [xi.mod.STR            ] =  200,
        [xi.mod.VIT            ] =  300,
        [xi.mod.INT            ] =  150,
        [xi.mod.MND            ] =  150,
        [xi.mod.CHR            ] =  120,
        [xi.mod.AGI            ] =  120,
        [xi.mod.DEX            ] =  140,
        [xi.mod.ACC            ] = 1000,
    },

    effects =
    {
        [xi.effect.REGAIN] = { 2, 3, 0 }, 
    },
}

local basicMob =
{
    mods =
    {
        [xi.mod.STUNRES    ] = 100,
        [xi.mod.BLINDRES   ] = 100,
        [xi.mod.BINDRES    ] = 100,
        [xi.mod.GRAVITYRES ] = 100,
        [xi.mod.SLEEPRES   ] = 100,
        [xi.mod.POISONRES  ] = 100,
        [xi.mod.PARALYZERES] = 100,
        [xi.mod.LULLABYRES ] = 100,
    },

    effects =
    {
        [xi.effect.REGAIN] = { 15, 3, 0 },
    },
}

-- One randomly selected temp item is distributed after all three mobs are defeated
local tempList =
{
    5433, -- Dusty Elixir
    5824, -- Lucid Potion I
    5825, -- Lucid Potion II
    5322, -- Healing Powder
    5827, -- Lucid Ether I
    5828, -- Lucid Ether II
    4255, -- Mana Powder
    4206, -- Catholicon
    4208, -- Catholicon +1
    5390, -- Braver's Drink
    5243, -- Carnal Incense
    5243, -- Spiritual Incense
    5834, -- Lucid Wings I
    4147, -- Body Boost
    4200, -- Mana Boost
}

local amchuchu =
{
    4206, -- Catholicon
    5433, -- Dusty Elixir
    4147, -- Body Boost
    4200, -- Mana Boost
}

local function giveTemp(player, itemID)
    if player:hasItem(itemID) then
        return
    end

    local ID = zones[player:getZoneID()]

    player:messageSpecial(ID.text.ITEM_OBTAINED + 9, itemID, 1)
    player:addTempItem(itemID, 1)
end

local mobs =
{
    -----------------------------------
    -- COLKHAB
    -----------------------------------
    {
        name        = "Colkhab",
        area        = "Ceizak_Battlegrounds",
        look        = "0x0000C40900000000000000000000000000000000",
        pos         = { -141.983, 0.429, 421.215, 30 }, -- !pos -141.983 0.429 421.215 261
        groupId     =  36,
        groupZoneId =  261,
        level       = { 145, 150 },
        shards      =  850,
        skillList   = 5028,
        spellList   =    0,
        auraShield  =
        {
            skillID      = 3005, -- droning_whirlwind
            shieldAmount = 400,
            damageType   = xi.damageType.ICE,
            effects      =
            {
                [xi.effect.PERFECT_DODGE] = { 1, 0, 0 },
            },
        },

        pets        =
        {
            {
                name        = "Waggling Wasp",
                groupId     = 28,
                groupZoneId = 261,
                template    = basicMob,
            },
            {
                name        = "Leaping Chapuli",
                groupId     = 33,
                groupZoneId = 261,
                template    = basicMob,
            },
            {
                name        = "Rapier Hornet",
                look        = 272,
                groupId     = 28,
                groupZoneId = 261,
                template    = basicMob,
            },
        },

        --         str, vit, int, mnd, agi, dex, chr, ACC, DEFP, RATTP, EVA
        stats    = { 200,  100,  300,  100,  100,  200,  100, 1000,   150,   750,  900 },
        template = naakual,
        mods     =
        {
            [xi.mod.CRIT_DEF_BONUS] =  100,
            [xi.mod.EVA           ] =  300,
            [xi.mod.SLASH_SDT     ] = 1000,
            [xi.mod.PIERCE_SDT    ] = 1250,
            [xi.mod.IMPACT_SDT    ] =  750,
            [xi.mod.HTH_SDT       ] =  750,
			[xi.mod.DMGMAGIC]  = -400, -- Matches your lib (163)
            [xi.mod.MDEF]      = 0,    -- Matches your lib (29)
            [xi.mod.FIRE_SDT]  = 700,
            [xi.mod.WIND_SDT]  = 150,
            [xi.mod.THUNDER_SDT] = 500, -- CORRECTED: was LTNG_SDT
            [xi.mod.LIGHT_SDT] = 300,
            [xi.mod.ICE_SDT]   = 700,
            [xi.mod.EARTH_SDT] = 150,
            [xi.mod.WATER_SDT] = 500,
            [xi.mod.DARK_SDT]  = 500,
        },

        additionalEffect = xi.mob.ae.ENAERO,
    },

    -----------------------------------
    -- TCHAKKA
    -----------------------------------
    {

        name        = "Tchakka",
        area        = "Foret_de_Hennetiel",
        look        = "0x0000C90900000000000000000000000000000000",
        pos         = { -148.203, 0.500, -457.182, 185 },
        groupId     =  32,
        groupZoneId =  262,
        level       = { 145, 150 },
        shards      =  850,
        skillList   = 5029,
        spellList   =    0,
        rangedSkill = 3016, -- Marine Mayhem (Will use at 20')
        auraShield  =
        {
            skillID      = 3014, -- carcharian_verve
            shieldAmount = 400,
            damageType   = xi.damageType.THUNDER,
            mods         =
            {
                [xi.mod.ATT          ] = 250,
                [xi.mod.DEF          ] = 450,
                [xi.mod.DOUBLE_ATTACK] =  25,
            },
            effects      =
            {
                [xi.effect.REGEN] = { 100, 3, 0 },
            },
        },

        pets        =
        {
            {
                name        = "Primrose Jagil",
                look        = 350, -- jagil
                groupId     = 30,
                groupZoneId = 262,
                template    = basicMob,
            },
            {
                name             = "Cracklaw",
                groupId          = 26,
                groupZoneId      = 262,
                template         = basicMob,
                additionalEffect = xi.mob.ae.STUN,
            },
            {
                name        = "Wetlands Orobon",
                groupId     = 29,
                groupZoneId = 262,
                template    = basicMob,
            },
        },

        mods        =
        {
            [xi.mod.CRITHITRATE      ] =   15,
            [xi.mod.CRIT_DMG_INCREASE] =    5,
            [xi.mod.SLASH_SDT        ] =  750,
            [xi.mod.PIERCE_SDT       ] = 1000,
            [xi.mod.IMPACT_SDT       ] = 1250,
            [xi.mod.HTH_SDT          ] = 1250,
			[xi.mod.DMGMAGIC]  = 3500, -- +35% Magic Damage taken
            [xi.mod.FIRE_SDT]  = 150,
            [xi.mod.WIND_SDT]  = 500,
            [xi.mod.THUNDER_SDT] = 700, -- CORRECTED: was LTNG_SDT
            [xi.mod.LIGHT_SDT] = 500,
            [xi.mod.ICE_SDT]   = 500,
            [xi.mod.EARTH_SDT] = 700,
            [xi.mod.WATER_SDT] = 150,
            [xi.mod.DARK_SDT]  = 300,
        },

        effects     =
        {
            [xi.effect.PHALANX] = { 30, 0, 0 },
        },

                         -- str, vit, int, mnd, agi, dex, chr, ACC, DEFP, RATTP, EVA
        stats            = { 200,  100,  250,  100,  100,  200,  100, 1000,   250,   750,  900 },
        template         = naakual,
        additionalEffect = xi.mob.ae.ENWATER,
    },

    -----------------------------------
    -- ACHUKA
    -----------------------------------
    {
        name        = "Achuka",
        area        = "Morimar_Basalt_Fields",
        look        = "0x0000D30900000000000000000000000000000000",
        pos         = { -464.543, -62.870, 501.823, 27 },
        groupId     =  33,
        groupZoneId =  265,
        level       = { 145, 150 },
        shards      =  850,
        skillList   = 5030,
        spellList   =    0,
        auraShield  =
        {
            skillID      = 3020, -- blistering_roar
            shieldAmount = 400,
            damageType   = xi.damageType.WATER,
            effects      =
            {
                [xi.effect.BLAZE_SPIKES] = { math.random(6, 12), 0, 0 },
                [xi.effect.HASTE       ] = { 1500, 0, 0 },
                [xi.effect.STONESKIN   ] = { 2500, 0, 0 },
            },
            mods         =
            {
                [xi.mod.ATT ] = 50, -- Can adjust for balance here
                [xi.mod.MATT] = 50, -- Can adjust for balance here
            },
        },

        pets        =
        {
            {
                name        = "Matamata",
                groupId     = 26,
                groupZoneId = 265,
                template    = basicMob,
            },
            {
                name        = "Outlands Peiste",
                groupId     = 30,
                groupZoneId = 265,
                template    = basicMob,
            },
            {
                name        = "Jagtooth Raptor",
                groupId     = 31,
                groupZoneId = 265,
                template    = basicMob,
            },
        },

        mods        =
        {
            [xi.mod.SLASH_SDT ] = 1250,
            [xi.mod.PIERCE_SDT] =  750,
            [xi.mod.IMPACT_SDT] = 1000,
            [xi.mod.HTH_SDT   ] = 1000,
			[xi.mod.DMG]       = 3500, -- Takes +35% total damage
            [xi.mod.FIRE_SDT]  = 150,
            [xi.mod.WIND_SDT]  = 500,
            [xi.mod.THUNDER_SDT] = 700, -- CORRECTED: was LTNG_SDT
            [xi.mod.LIGHT_SDT] = 300,
            [xi.mod.ICE_SDT]   = 150,
            [xi.mod.EARTH_SDT] = 500,
            [xi.mod.WATER_SDT] = 700,
            [xi.mod.DARK_SDT]  = 500,
        },

                         -- str, vit, int, mnd, agi, dex, chr, ACC, DEFP, RATTP, EVA
        stats            = { 200,  100,  250,  100,  100,  200,  100, 1000,   500,   350,  900 },
        template         = naakual,
        additionalEffect = xi.mob.ae.ENFIRE,
    },

    -----------------------------------
    -- YUMCAX
    -----------------------------------
    {
        name        = "Yumcax",
        area        = "Yorcia_Weald",
        look        = "0x0000CE0900000000000000000000000000000000",
        pos         = { -498.613, 0.909, -55.695, 24 },
        groupId     =  37,
        groupZoneId = 263,

        level       = { 145, 150 },
        shards      =  850,
        skillList   = 5031,
        spellList   =    0,
        auraShield  =
        {
            skillID      = 3059, -- uproot
            shieldAmount = 400,
            damageType   = xi.damageType.WIND,
            effects      =
            {
                [xi.effect.REGEN] = { 200, 3, 0 },
            },
        },

        pets        =
        {
            {
                name        = "Yumcax's Panopt",
                groupId     = 24,
                groupZoneId = 263,
                template    = basicMob,
            },
            {
                name        = "Yumcax's Maw",
                groupId     = 3,
                groupZoneId = 263,
                template    = basicMob,
            },
            {
                name        = "Yumcax's Panopt",
                groupId     = 24,
                groupZoneId = 263,
                template    = basicMob,
            },
        },

        mods        =
        {
            [xi.mod.SLASH_SDT ] = 1250,
            [xi.mod.PIERCE_SDT] =  750,
            [xi.mod.IMPACT_SDT] = 1000,
            [xi.mod.HTH_SDT   ] = 1000,
			[xi.mod.DMG]       = -100, -- -10% DT
            [xi.mod.FIRE_SDT]  = 1000,
            [xi.mod.WIND_SDT]  = 700,
            [xi.mod.THUNDER_SDT] = 50, -- CORRECTED: was LTNG_SDT
            [xi.mod.LIGHT_SDT] = 500,
            [xi.mod.ICE_SDT]   = 300,
            [xi.mod.EARTH_SDT] = 50,
            [xi.mod.WATER_SDT] = 100,
            [xi.mod.DARK_SDT]  = 300,
        },

        --             str, vit, int, mnd, agi, dex, chr, ACC, DEFP, RATTP, EVA
        stats       = { 200,  100,  250,  100,  100,  200,  100, 1000,   500,   350,  900 },
        template    = naakual,

        additionalEffect = xi.mob.ae.ENSTONE,
    },

    -----------------------------------
    -- HURKAN
    -----------------------------------
    {
        name        = "Hurkan",
        area        = "Marjami_Ravine",
        look        = "0x0000140A00000000000000000000000000000000",
        pos         = { 61.119, -55.964, 180.383, 119 },
        groupId     =  34,
        groupZoneId =  266,
        level       = { 145, 150 },
        shards      =  850,
        skillList   = 5032,
        spellList   =    0,
        auraShield  =
        {
            skillID      = 3072, -- crashing thunder
            shieldAmount = 400,
            damageType   = xi.damageType.EARTH,
            effects      =
            {
                [xi.effect.SHOCK_SPIKES] = { math.random(6, 12), 0, 0 },
                [xi.effect.PHALANX     ] = { 40, 0, 0 },
            },
        },

        pets        =
        {
            {
                name        = "Clawed Tulfaire",
                groupId     = 24,
                groupZoneId = 266,
                template    = basicMob,
            },
            {
                name        = "Breeze Vulture",
                groupId     = 25,
                groupZoneId = 266,
                template    = basicMob,
            },
            {
                name        = "Stonefaced Roc",
                groupId     = 32,
                groupZoneId = 266,
                template    = basicMob,
            },
        },

        mods =
        {
            [xi.mod.SLASH_SDT ] = 1000,
            [xi.mod.PIERCE_SDT] = 1250,
            [xi.mod.IMPACT_SDT] =  750,
            [xi.mod.HTH_SDT   ] =  750,
			[xi.mod.DMGMAGIC]  = 3500,
            [xi.mod.FIRE_SDT]  = 500,
            [xi.mod.WIND_SDT]  = 150,
            [xi.mod.THUNDER_SDT] = 150, -- CORRECTED: was LTNG_SDT
            [xi.mod.LIGHT_SDT] = 500,
            [xi.mod.ICE_SDT]   = 700,
            [xi.mod.EARTH_SDT] = 700,
            [xi.mod.WATER_SDT] = 500,
            [xi.mod.DARK_SDT]  = 300,
        },

                         -- str, vit, int, mnd, agi, dex, chr, ACC, DEFP, RATTP, EVA
        stats            = { 200,  100,  205,  200,  100,  200,  100, 1000,   500,   350,  900 },
        template         = naakual,
        additionalEffect = xi.mob.ae.ENTHUNDER,
    },

    -----------------------------------
    -- KUMHAU
    -----------------------------------
    {
        name        = "Kumhau",
        area        = "Kamihr_Drifts",
        look        = "0x0000190A00000000000000000000000000000000",
        pos         = { 368.406, 20.650, 254.179, 164 },
        groupId     =  31,
        groupZoneId =  267,
        level       = { 145, 150 },
        shards      =  850,
        skillList   = 5033,
        spellList   =    0,
        auraShield  =
        {
            skillID      = 3137, -- polar_roar
            shieldAmount = 400,
            damageType   = xi.damageType.FIRE,
            effects      =
            {
                [xi.effect.ICE_SPIKES] = { math.random(6, 12), 0, 0 },
            },
        },

        pets        =
        {
            {
                name        = "Kumhau's Claw",
                groupId     = 21,
                groupZoneId = 267,
                template    = basicMob,
            },
            {
                name        = "Kumhau's Tusk",
                groupId     = 19,
                groupZoneId = 267,
                template    = basicMob,
            },
            {
                name        = "Kumhau's Hoof",
                groupId     = 20,
                groupZoneId = 267,
                template    = basicMob,
            },
        },

                         -- str, vit, int, mnd, agi, dex, chr, ACC, DEFP, RATTP, EVA
        stats            = { 200,  100,  250,  200,  100,  200,  100, 1000,   500,   350,  900 },
        template         = naakual,
		mods =
        {
            [xi.mod.DMG]       = 2000, -- +20% damage taken
            [xi.mod.MDEF]      = 14,
            [xi.mod.FIRE_SDT]  = 1300,
            [xi.mod.WIND_SDT]  = 50,
            [xi.mod.THUNDER_SDT] = 150, -- CORRECTED: was LTNG_SDT
            [xi.mod.LIGHT_SDT] = 300,
            [xi.mod.ICE_SDT]   = 50,
            [xi.mod.EARTH_SDT] = 100,
            [xi.mod.WATER_SDT] = 700,
            [xi.mod.DARK_SDT]  = 500,
        },
        additionalEffect = xi.mob.ae.ENBLIZZARD,
    },
}

----------------------------------------------------------------------
-- Handlers and listeners
----------------------------------------------------------------------
local lookupID =
{
    Colkhab = 0,
    Tchakka = 1,
    Yumcax  = 2,
    Hurkan  = 3,
    Achuka  = 4,
    Kumhau  = 5,
}

local function getBonus(player)
    local domainsCompleted = math.floor(player:getCharVar("[Domain]Completed") / 5)
    local dailiesCompleted = player:getCharVar("[DQ]Completed")

    return utils.clamp(domainsCompleted + dailiesCompleted, 0, 5)
end

local function handlePlayerReward(player, baseReward, mobName)
    -- Calculate shards random bonus.
    local baseShards = baseReward + math.random(0, 75) + math.random(0, 75)

    -- Calculate player amount facor. Effect caps at 50 players, granting double participation.
    local playersInZone     = player:getZone():getPlayers()
    local playerCountFactor = 1 + utils.clamp(#playersInZone * 2 / 100, 0, 1)

    -- Calculate base participation multiplier.
    local actionPoints   = utils.clamp(player:getLocalVar("[Domain]BasePoints") * playerCountFactor, 0, 10000)
    local trustPoints    = utils.clamp(player:getLocalVar("[Domain]TrustPoints"), 0, 2000)
    local pointReduction = utils.clamp(player:getLocalVar("[Domain]MaxPointsReduction"), 0, 5000)
    local baseMultiplier = utils.clamp(actionPoints + trustPoints, 0, 10000 - pointReduction) / 10000

    -- Calculate daily quest multiplier.
    local rotationMultiplier = getBonus(player)
    rotationMultiplier       = 1 + utils.clamp(rotationMultiplier, 0, 5) / 10

    -- Calculate seasonal event multiplier.
    local eventMultiplier = 0.1

    -- Calculate final result.
    local maxShardsRewarded  = 0
    maxShardsRewarded        = math.floor(baseShards        * baseMultiplier)
    maxShardsRewarded        = math.floor(maxShardsRewarded * rotationMultiplier)
    maxShardsRewarded        = math.floor(maxShardsRewarded * eventMultiplier)

    -- Delete elvorseal.
    if player:hasStatusEffect(xi.effect.ELVORSEAL) then
        player:delStatusEffect(xi.effect.ELVORSEAL)
    end

    -- Give shards according to their participation and their daily quest bonus.
    if baseMultiplier > 0 then
        player:addCurrency('domain_points', maxShardsRewarded)
        player:sys("{} gains {} domain points.", player:getName(), maxShardsRewarded)
    else
        player:sys("You haven't contributed enough to aquire any domain points.")
    end

    -- Remove player listeners.
    player:removeListener("DI_DEATH")
    player:removeListener("DI_TICK")
    player:removeListener("DI_PLAYER_MAGIC")
    player:removeListener("DI_PLAYER_ABILITY")

    -- Zero player temporal variables.
    player:setLocalVar("[Domain]BasePoints",   0)
    player:setLocalVar("[Domain]TrustPoints",  0)
    player:setLocalVar("[Domain]DeathCounter", 0)
    player:setLocalVar("[Domain]MaxPointsReduction", 0)

    -- Increment player kill counter.
    player:incrementCharVar(string.format("[DI]%s_kills", mobName), 1)

    -- Determine if player is eligible to lot on items.
    if baseMultiplier < 0.5 then
        player:sys("You haven't contributed enough to cast lots on treasure. You will be warped back shortly.")

        -- Allow GMs to remain in area to fix issues
        if player:getGMLevel() == 0 then
            player:timer(1200, function(participant)
                participant:warp()
            end)
        else
            player:sys("You are a GM, so you may remain in the zone.\n== REMEMBER to PASS the items in pool ==")
        end
    else
        local prog  = player:getCharVar("[Domain]Progress")
        local mobID = lookupID[mobName]
        local count = utils.mask.countBits(prog)

        -- Increment 1/6 objective
        if not utils.mask.getBit(prog, mobID) then
            prog = utils.mask.setBit(prog, mobID, true)
            player:setCharVar("[Domain]Progress", prog, JstMidnight())

            count = utils.mask.countBits(prog)
            player:fmt("You have completed a domain invasion objective. (Progress: {}/6)", count)
        end

        local completed = player:getCharVar("[Domain]Completed")
        player:setCharVar("[Domain]Completed", completed + 1, JstMidnight())

        -- Complete 6/6 objectives
        if count == 6 then
            local cycles = player:getCharVar("[Domain]Cycles")
            player:setCharVar("[Domain]Cycles", cycles + 1, JstMidnight())
            player:setCharVar("[Domain]Progress", 0)

            if cycles  > 1 then
                player:fmt("You have successfully completed a domain invasion rotation! (Total: {})", cycles)
            else
                player:fmt("You have successfully completed a domain invasion rotation!")
            end

            local itemID = xi.item.DOMAIN_COFFER

            -- 15% chance for Domain Coffer +1
            if math.random(0, 100) > 85 then
                itemID = xi.item.DOMAIN_COFFER_P1
            end

            if not npcUtil.giveItem(player, itemID) then
                player:incrementCharVar(fmt("[Domain]Missed_{}", itemID), 1)
            end
        end
    end
end

local function onMobSpawnListenerSetup(mob)
    -- Set mob listeners
    mob:addListener("TAKE_DAMAGE", "DI_MOB_DAMAGE_TAKEN", function(mob, damage, attacker, attackType, damageType)
        if attacker then
            -- Determine correct participant.
            local participant = false

            if attacker:isPC() then
                participant = attacker
            else
                participant = attacker:getMaster()
            end

            -- Give participation points for damage done.
            if participant and participant:hasStatusEffect(xi.effect.ELVORSEAL) then
                local participation = participant:getLocalVar("[Domain]BasePoints") + utils.clamp(math.floor(damage * 1.5), 1, 2500)
                participant:setLocalVar("[Domain]BasePoints", participation)
            end
        end
    end)

    mob:addListener("WEAPONSKILL_TAKE", "DI_MOB_WS_TAKEN", function(mob, attacker, skillId, tp, action)
        if attacker then
            -- Determine correct participant.
            local participant = false

            if attacker:isPC() then
                participant = attacker
            else
                participant = attacker:getMaster()
            end

            -- Give participation points for Weaponskill usage.
            if participant and participant:hasStatusEffect(xi.effect.ELVORSEAL) then
                local participation = participant:getLocalVar("[Domain]BasePoints") + 1000
                participant:setLocalVar("[Domain]BasePoints", participation)
            end
        end
    end)
end

local function onMobFightHPPChecks(mob)
    local hppChecks = mob:getLocalVar("HPPChecks")
    local hppMob = mob:getHPP()

    -- give all players 1 extra "death count" to increase their contribution floor
    -- if present at particular boss hp percents (start of fight included)
    if
        (hppChecks < 4 and hppMob < 100 - 25 * 3) or
        (hppChecks < 3 and hppMob < 100 - 25 * 2) or
        (hppChecks < 2 and hppMob < 100 - 25 * 1) or
        (hppChecks < 1) -- will immediately give 1 point when fight starts
    then
        local reqPoints = 6000 * hppChecks / 4
        mob:setLocalVar("HPPChecks", hppChecks + 1)
        local players = mob:getZone():getPlayers()
        for _, participant in pairs(players) do
            -- only increase floor for active participants
            if participant:getLocalVar("[Domain]BasePoints") >= reqPoints then
                participant:setLocalVar("[Domain]DeathCounter", 1 + participant:getLocalVar("[Domain]DeathCounter"))
            elseif mob:getLocalVar("LastHPPCheck") + 30 < os.time() then -- only penalize players every 30s or more to avoid penalty on fast fights
                -- reduce their max shards by 20% per missing this window
                participant:setLocalVar("[Domain]MaxPointsReduction", participant:getLocalVar("[Domain]MaxPointsReduction") + 2000)
            end
        end
        mob:setLocalVar("LastHPPCheck", os.time())
    end
end

-- apply when mob engages and when using a weaponskill (to catch new players entering zone)
-- reminder that this only takes "mob" to get all players in zone, it can safely be run anytime and simply adds contribution listeners to all players in zone
local function onMobFightListenerSetup(mob)
    -- Set player listeners
    local players = mob:getZone():getPlayers()

    for _, participant in pairs(players) do
        participant:addListener("MAGIC_USE", "DI_PLAYER_MAGIC", function(player, target, spell, action)
            if player:hasStatusEffect(xi.effect.ELVORSEAL) then
                local spellID       = spell:getID()
                local spellType     = spell:getSkillType()
                local bonus         = 0
                local mpCost        = spell:getMPCost()
                local totalTargets  = spell:getTotalTargets()

                if spellType == xi.skill.NINJUTSU then
                    bonus = 400
                elseif spellType == xi.skill.SINGING then
                    bonus = 600
                elseif spellType == xi.skill.HEALING_MAGIC then
                    bonus = mpCost
                    if target then
                        -- give bonus based on difference between basepoints of caster and target (only if missing large amount of hp)
                        -- otherwise, small bonus based on mp cost (multiplied by number of targets below)
                        bonus = bonus +
                        utils.clamp(target:getMaxHP() - target:getHP() - 300, 0, 1000) / 300 * -- max extra bonus if target is missing more hp (ignore first 300 missing due to cure cheating)
                            math.max((target:getLocalVar("[Domain]BasePoints") - player:getLocalVar("[Domain]BasePoints")), 800)
                    end

                    -- additional scaling based on mp cost to make lower-tier cures less relevant
                    bonus = utils.clamp(mpCost, 0, 100) / 100 * (bonus * 2)
                elseif spellType == xi.skill.ENHANCING_MAGIC then
                    bonus = mpCost + 200
                else
                    if mpCost <= 40 then
                        bonus = math.floor(mpCost / 2)
                    elseif mpCost <= 95 then
                        bonus = mpCost + 100
                    elseif mpCost <= 140 then
                        bonus = mpCost * 2 + 200
                    else
                        bonus = mpCost * 4 + 300
                    end
                end

                bonus = math.floor(bonus)

                local participation = player:getLocalVar("[Domain]BasePoints")
                if totalTargets > 1 then
                    participation = participation + totalTargets * utils.clamp(bonus, 0, 1000)
                else
                    participation = participation + utils.clamp(bonus, 0, 2000)
                end

                -- print(fmt("{}-{}: {}-{}-{}-{}-{}", player:getName(), target:getName(), spellID, spellType, mpCost, bonus, participation))
                player:setLocalVar("[Domain]BasePoints", participation)
            end
        end)

        participant:addListener("ABILITY_USE", "DI_PLAYER_ABILITY", function(player, target, ability, action)
            if player:hasStatusEffect(xi.effect.ELVORSEAL) then
                local maxPoints = 1500
                local additionalPoints = maxPoints
                local recast = action and action:getRecast() or 0

                additionalPoints = math.floor(utils.clamp(additionalPoints * recast / 30, maxPoints / 4, maxPoints)) -- give less points for job abilities lower than 30s recast

                local participation = player:getLocalVar("[Domain]BasePoints") + additionalPoints
                player:setLocalVar("[Domain]BasePoints", participation)
            end
        end)

        participant:addListener("TICK", "DI_TICK", function(player)
            local participation = player:getLocalVar("[Domain]BasePoints")
            local safetyValue   = player:getLocalVar("[Domain]DeathCounter") * 1000 + 3000

            if participation > safetyValue then
                local decay = 25

                -- Calculate decay.
                if player:isAlive() then
                    decay = 20

                    if player:hasStatusEffect(xi.effect.ELVORSEAL) then
                        local playerAction = player:getCurrentAction()
                        decay = 10

                        if
                           player:hasStatusEffect(xi.effect.HEALING) and
                           (player:getHP() < player:getMaxHP() * .85 or player:getMP() < player:getMaxMP() * .85)
                        then
                            decay = 2
                        elseif
                            playerAction == xi.action.MAGIC_CASTING or
                            playerAction == xi.action.RANGED_START or
                            playerAction == xi.action.ITEM_USING or
                            playerAction == xi.action.SLEEP or
                            playerAction == xi.action.JOBABILITY_FINISH
                        then
                            decay = 2
                        end
                    end
                end

                -- Pity system: Half the margin between safetyValue and max (10000)
                -- safetyValue of  3000 -> pityValue of  6500 -> no deaths.
                -- safetyValue of  5000 -> pityValue of  7500 ->  1 deaths.
                -- safetyValue of  6000 -> pityValue of  8000 ->  2 deaths.
                -- safetyValue of  7000 -> pityValue of  8500 ->  3 deaths.
                -- safetyValue of  8000 -> pityValue of  9000 ->  4 deaths.
                -- safetyValue of  9000 -> pityValue of  9500 ->  5 deaths.
                -- safetyValue of 10000 -> pityValue of 10000 -> 6+ deaths.
                local pityValue = 10000 - (utils.clamp(10000 - safetyValue, 0, 7000) / 2)

                if participation <= pityValue then
                    decay = math.floor(decay / 2)
                end

                -- Apply decay, and cap past max
                participation = utils.clamp(participation - decay, safetyValue, 12000)

                player:setLocalVar("[Domain]BasePoints", participation)
            end
        end)

        participant:addListener("DEATH", "DI_DEATH", function(player)
            -- Handle safety system.
            local deathCount = player:getLocalVar("[Domain]DeathCounter")

            if deathCount == 0 then
                deathCount = 1
            end

            player:setLocalVar("[Domain]DeathCounter", deathCount + 1)

            -- Handle messages.
            player:printToPlayer("Your Elvorseal has shattered!", xi.msg.channel.SYSTEM_3)
            player:printToPlayer("The power released allows to raise!", xi.msg.channel.SYSTEM_3)
            player:printToPlayer("Restore elvorseal to free yourself from your weakness.", xi.msg.channel.SYSTEM_3)

            -- Handle Arise.
            player:timer(5000, function(playerArg)
                playerArg:sendRaise(4)
            end)
        end)
    end
end

-- Function for variable work when mob spawns.
local function onMobSpawnVariableControl(mob)
    SetServerVariable("[Domain]NMSpawned", 1)
    SetServerVariable("[Domain]Notification", 0)

    onMobSpawnListenerSetup(mob)
end

-- Function for variable work when mob dies.
local function onMobDeathVariableControl(nextNM)
    SetServerVariable("[Domain]NMToD", os.time() + math.random(120, 180)) -- 2-3 mins
    SetServerVariable("[Domain]NM", nextNM)
    SetServerVariable("[Domain]NMSpawned", 0)
    SetServerVariable("[Domain]Notification", 1)
end

local function setupMob(mob, mobInfo)
    mob:setSpawn(unpack(mobInfo.pos))

    -- Extra Large 
    mob:setMobFlags(15)

    -- Block CFH
    mob:setCallForHelpBlocked(true)

    if type(mobInfo.level) == "table" then
    mob:setMobLevel(math.random(mobInfo.level[1], mobInfo.level[2]))
    else
        mob:setMobLevel(mobInfo.level)
    end

    mob:setMobMod(xi.mobMod.SKILL_LIST, mobInfo.skillList)
    mob:setSpellList(mobInfo.spellList)

    mob:addMod(xi.mod.STR,   mobInfo.stats[ 1])
    mob:addMod(xi.mod.VIT,   mobInfo.stats[ 2])
    mob:addMod(xi.mod.INT,   mobInfo.stats[ 3])
    mob:addMod(xi.mod.MND,   mobInfo.stats[ 4])
    mob:addMod(xi.mod.AGI,   mobInfo.stats[ 5])
    mob:addMod(xi.mod.DEX,   mobInfo.stats[ 6])
    mob:addMod(xi.mod.CHR,   mobInfo.stats[ 7])
    mob:addMod(xi.mod.ACC,   mobInfo.stats[ 8])
    mob:addMod(xi.mod.DEFP,  mobInfo.stats[ 9])
    mob:addMod(xi.mod.RATTP, mobInfo.stats[10])
    mob:addMod(xi.mod.EVA,   mobInfo.stats[11])

    mob:setMod(xi.mod.SILENCERES,  100)
    mob:setMod(xi.mod.STUNRES,      50)
    mob:setMod(xi.mod.BINDRES,     100)
    mob:setMod(xi.mod.GRAVITYRES,  100)
    mob:setMod(xi.mod.SLEEPRES,    100)
    mob:setMod(xi.mod.POISONRES,   100)
    mob:setMod(xi.mod.PARALYZERES, 100)
    mob:setMod(xi.mod.LULLABYRES,  100)

    mob:setMod(xi.mod.MP, 25000)
	mob:setMod(xi.mod.HP, 450000)
    mob:updateHealth()
    mob:setMP(mob:getMaxMP())

    -- Prevent roaming
    mob:setRoamFlags(xi.roamFlag.SCRIPTED)
end

-- Server Crash Failsafe, could hook on any zone, really... but using one in the DI cluster ensures boss repops after DI crash
m:addOverride("xi.zones.Ceizak_Battlegrounds.Zone.onInitialize", function(zone)
    super(zone)

    -- cleanup variables
    if GetServerVariable("[Domain]NMToD") < 1 then
        SetServerVariable("[Domain]NMToD", 1)
    end

    if GetServerVariable("[Domain]NMSpawned") == 1 then
        SetServerVariable("[Domain]NMSpawned", 0)
    end

    if GetServerVariable("[Domain]Notification") == 1 then
        SetServerVariable("[Domain]Notification", 0)
    end

    -- Guarantee an NM is spawned on fresh server
    if GetServerVariable("[Domain]NM") == 0 then
        SetServerVariable("[Domain]NM", math.random(#mobs))
    end
end)

local function addAuraShield(mob, auraShield)
    mob:addListener("TAKE_DAMAGE", "auraBreak", function(mob, amount, attacker, attackType, damageType)
        if attackType == xi.attackType.MAGICAL and damageType == auraShield.damageType then
            if amount >= auraShield.shieldAmount and mob:getLocalVar("aura") > 0 then
                if auraShield.effects ~= nil then
                    for effectID, _ in pairs(auraShield.effects) do
                        mob:delStatusEffect(effectID)
                    end
                end

                if auraShield.mods ~= nil then
                    for modID, modValue in pairs(auraShield.mods) do
                        local total = mob:getMod(modID) - modValue

                        if total < 0 then
                            total = 0
                        end

                        mob:setMod(modID, total)
                    end
                end

                mob:weaknessTrigger(3)
                mob:setAnimationSub(0)
                mob:setLocalVar("aura", 0)

                if attacker then
                    -- give player (or pet) who broke shield max hp/mp and strong regen for 10s
                    mob:independentAnimation(attacker, 169, 2)

                    local amtMP = attacker:getMaxMP() - attacker:getMP()
                    attacker:restoreMP(amtMP)
                    local amtHP = attacker:getMaxHP() - attacker:getHP()
                    attacker:restoreHP(amtHP)

                    attacker:delStatusEffectSilent(xi.effect.REGEN)
                    attacker:addStatusEffect(xi.effect.REGEN, {power = 500, duration = 30, origin = attacker})

                    attacker:setTP(3000)

                    if attacker:isPC() then
                        attacker:timer(3000, function(playerArg)
                            playerArg:messageBasic(xi.msg.basic.RECOVERS_HP, 0, amtHP)
                            playerArg:messageBasic(xi.msg.basic.RECOVERS_MP, 0, amtMP)
                        end)
                    end
                end

            end
        end
    end)
end

local function useRangedSkill(mob, target, rangedSkill)
    local distance = mob:checkDistance(target)

    if
        distance > 20 and
        os.time() > mob:getLocalVar("rangedSkill")
    then
        mob:setLocalVar("rangedSkill", os.time() + math.random(15, 22))
        mob:useMobAbility(rangedSkill)
    end
end

local spawnAt =
{
    76,
    51,
    26,
}

local function spawnPets(mob, mobInfo)
    local wave = mob:getLocalVar("PET_WAVE") + 1
    local hpp  = mob:getHPP()

    for waveNum, threshold in pairs(spawnAt) do
        if
            wave == waveNum and
            hpp < threshold
        then
            for index, pet in pairs(mobInfo.spawned) do
                if not pet:isAlive() then
                    pet:setSpawn(mob:getXPos() - 16 + (index * 8), mob:getYPos(), mob:getZPos() - 8, mob:getRotPos())
                    pet:spawn()
                    pet:updateEnmity(mob:getTarget())
                end
            end

            mob:setLocalVar("PET_WAVE", wave)

            return
        end
    end
end

local function applyMobStandard(mobTable, mobInfo, agro)
    mobTable.onMobInitialize = function(mob)
        if agro ~= nil then
            mob:setMobMod(xi.mobMod.DETECTION, agro)
            mob:setMobMod(xi.mobMod.SIGHT_RANGE, 15)
            mob:setMobMod(xi.mobMod.SOUND_RANGE, 10)
            mob:setMobMod(xi.mobMod.CLAIM_TYPE, 1)
			mob:setDropID(0) -- No loot!
            mob:setMobMod(xi.mobMod.NO_DROPS, 1)
        else
            mob:setMobMod(xi.mobMod.DETECTION, 0x08)
            mob:setMobMod(xi.mobMod.CLAIM_TYPE, 1)
			mob:setDropID(0) -- No loot!
            mob:setMobMod(xi.mobMod.NO_DROPS, 1)
        end

            mob:setMobMod(xi.mobMod.CHECK_AS_NM,  1)
            mob:setMobMod(xi.mobMod.CHARMABLE,    0)
            mob:setMobMod(xi.mobMod.CLAIM_TYPE, 1)
			mob:setDropID(0) -- No loot!
            mob:setMobMod(xi.mobMod.NO_DROPS, 1)

        if mobInfo.additionalEffect ~= nil then
            mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
        end
    end

    if mobInfo.additionalEffect ~= nil then
        mobTable.onAdditionalEffect = function(mob, target, damage)
            return xi.mob.onAddEffect(mob, target, damage, mobInfo.additionalEffect, { power = math.random(16, 55) })
        end
    end
end

local function applyModsAndEffects(mob, mobInfo)
    if mobInfo.mods ~= nil then
        for modID, modValue in pairs(mobInfo.mods) do
            mob:setMod(modID, modValue)
        end
    end

    -- LSB UPDATE: Fixed logic error where `#mobInfo.effects` was used, evaluating to 0 since it's a dictionary
    if mobInfo.effects ~= nil then
        for effectID, effectTable in pairs(mobInfo.effects) do
            mob:addStatusEffect(effectID, {
                power    = effectTable[1] or 0,
                tick     = effectTable[2] or 0,
                duration = effectTable[3] or 0,
                origin   = mob
            })
        end
    end
end

local function applyTemplate(mob, template)
    if template.mods ~= nil then
        for modID, modValue in pairs(template.mods) do
            mob:setMod(modID, modValue)
        end
    end

    -- LSB UPDATE: Converted unpack to table arguments
    if template.effects ~= nil then
        for effectID, effectTable in pairs(template.effects) do
            mob:addStatusEffect(effectID, {
                power    = effectTable[1] or 0,
                tick     = effectTable[2] or 0,
                duration = effectTable[3] or 0,
                origin   = mob
            })
        end
    end
end

local function setupPets(mob, mobInfo)
    if mobInfo.spawned == nil then
        mobInfo.spawned = {}
    end

    for index, pet in pairs(mobInfo.pets) do
        local mobTable =
        {
            objtype     = xi.objType.MOB,
            name        = pet.name,
            look        = pet.look,
            x           = mobInfo.pos[1] - 4 + (index * 2),
            y           = mobInfo.pos[2],
            z           = mobInfo.pos[3] - 2,
            rotation    = mobInfo.pos[4],
            groupId     = pet.groupId,
            groupZoneId = pet.groupZoneId,
            minLevel    = mobInfo.level[1],
            maxLevel    = mobInfo.level[2],

            onMobSpawn = function(mob)
                mob:setDropID(0) -- No loot!
                mob:setMobMod(xi.mobMod.NO_DROPS, 1)
                mob:setMobMod(xi.mobMod.CLAIM_TYPE, 1)

                -- Count contributions from players
                onMobSpawnListenerSetup(mob)

                -- re-add player contribution listeners when pets spawn
                onMobFightListenerSetup(mob)

                mob:addMod(xi.mod.UDMGMAGIC,  -7500)
                mob:addMod(xi.mod.UDMGBREATH, -7500)

                if mobInfo.onMobSpawn ~= nil then
                    mobInfo.onMobSpawn(mob)
                end
            end,

            -- Despawn adds if parent is not alive
            onMobFight = function(mobArg, target)
                if not mob:isAlive() then
                    DespawnMob(mobArg:getID())
                end
            end,

            -- Cleanup adds in case of wipe/reset
            onMobRoam = function(mobArg)
                if not mob:isAlive() then
                    DespawnMob(mobArg:getID())
                end

                if mob:getTarget() ~= nil then
                    mobArg:updateEnmity(mob:getTarget())
                end
            end,

            onMobDeath = function(mob, player, optParams)
                if
                    player ~= nil and
                    player:isPC() and
                    optParams ~= nil and optParams.isKiller
                then
                    player:setHP(player:getMaxHP())
                    player:setMP(player:getMaxMP())
                    player:setTP(3000)

                    local party = player:getPartyWithTrusts()

                    for _, member in pairs(party) do
                        if member:getObjType() == xi.objType.TRUST then
                            member:setHP(member:getMaxHP())
                            member:setMP(member:getMaxMP())
                        end
                    end

                    local roll = math.random(30, 90)
                    player:addCurrency('domain_points', roll)
                    player:sys("{} gains {} domain points.", player:getName(), roll)
                end
            end,

            onMobDespawn = function(mob)
                -- Reward temp item sometimes (% each pet should average to one every 3)
                local rewardTemp = false

                if
                    mob:getLocalVar("NO_TEMP") == 0 and
                    math.random() < 0.40
                then
                    rewardTemp = true
                end

                local players = mob:getZone():getPlayers()

                for _, participant in pairs(players) do
                    if not participant:hasStatusEffect(xi.effect.REGAIN) then
                        -- LSB UPDATE: Changed 'origin = player' to 'origin = participant' to prevent nil crash
                        participant:addStatusEffect(xi.effect.REGAIN, {power = 5, duration = 15, origin = participant})
                    end

                    if rewardTemp then
                        giveTemp(participant, tempList[math.random(#tempList)])
                    end
                end
            end,
        }

        -- We want these to be dealt with, so make them agro
        applyMobStandard(mobTable, mobInfo, xi.detects.HEARING)

        local zone = mob:getZone()
        mobInfo.spawned[index] = zone:insertDynamicEntity(mobTable)

        if pet.template ~= nil then
            applyTemplate(mob, pet.template)
        end
    end
end

local function adjustMobHealthBasedOnPlayerCount(zone, mob)
    local players      = zone:getPlayers()
    local totalPlayers = mob:getLocalVar("playerCount")

    if
        #players > 0 and
        totalPlayers < #players and
        totalPlayers <= 25
    then
        local baseHealth             = mob:getLocalVar("baseHealth")
        local healthIncreaseAbsolute = 2 * #players * 8000
        local healthIncreasePercent  = math.ceil((healthIncreaseAbsolute / baseHealth) * 100)
        local newPlayers             = #players - totalPlayers
        local hpToAdd                = 2 * newPlayers * 8000

        mob:setMod(xi.mod.HPP, healthIncreasePercent)
        mob:updateHealth()

        -- Add HP based only on the number of new players to the zone since last trigger
        mob:addHP(hpToAdd)

        -- Store the new player count
        mob:setLocalVar("playerCount", #players)
    end
end

----------------------------------------------------------------------
-- Create all mobs
----------------------------------------------------------------------
for diID, mobInfo in pairs(mobs) do
    local zonePath = fmt("xi.zones.{}.Zone", mobInfo.area)

    m:addOverride(zonePath .. ".onInitialize", function(zone)
        super(zone)

    local mobTable =
        {
            objtype     = xi.objType.MOB,
            name        = mobInfo.name,
            look        = mobInfo.look,
            x           = mobInfo.pos[1],
            y           = mobInfo.pos[2],
            z           = mobInfo.pos[3],
            rotation    = mobInfo.pos[4],
            groupId     = mobInfo.groupId,
            groupZoneId = mobInfo.groupZoneId,
            -- Add these lines to satisfy C++ luautils::GenerateDynamicEntity:
            minLevel    = mobInfo.level[1],
            maxLevel    = mobInfo.level[2],

            onMobSpawn = function(mob)
                -- Set base health for HP increase
                mob:setLocalVar("baseHealth", mob:getHP())
                mob:setLocalVar("FAST_TREASURE", 1)
                mob:setMobMod(xi.mobMod.CLAIM_TYPE, 1)
                onMobSpawnVariableControl(mob)

                if mobInfo.onMobSpawn ~= nil then
                    mobInfo.onMobSpawn(mob)
                end
            end,

            onMobFight = function(mob, target)
                if mob:getLocalVar("EngageTriggered") == 0 then
                    -- run this stuff only once (onMobEngage doesn't appear to work)
                    mob:setLocalVar("EngageTriggered", 1)

                    onMobFightListenerSetup(mob)
                    local players = mob:getZone():getPlayers()

                    for _, participant in pairs(players) do
                        local effect = participant:getStatusEffect(xi.effect.ELVORSEAL)
                        if
                            effect and
                            effect:getPower() <= 6 -- since native power is capped at 6
                        then
                            participant:delStatusEffectSilent(xi.effect.ELVORSEAL)
                            participant:addStatusEffect(xi.effect.ELVORSEAL, {power = math.floor(effect:getPower() * 1.5), origin = participant})
                        end
                    end

                    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 600)
                    mob:setMobMod(xi.mobMod.CLAIM_TYPE, 1)
                end

                onMobFightHPPChecks(mob)

                if mobInfo.pets ~= nil then
                    spawnPets(mob, mobInfo)
                end

                if mobInfo.onMobFight ~= nil then
                    mobInfo.onMobFight(mob)
                end

                if mobInfo.auraShield ~= nil then
                    addAuraShield(mob, mobInfo.auraShield)
                end

                if
                    mobInfo.rangedSkill ~= nil and
                    target ~= nil
                then
                    useRangedSkill(mob, target, mobInfo.rangedSkill)
                end

                adjustMobHealthBasedOnPlayerCount(zone, mob)
            end,

            onMobDeath = function(mob, player, optParams)
                -- Cleanup localVar for HP increase
                mob:setLocalVar("baseHealth", 0)
                mob:setLocalVar("playerCount", 0)
                if mobInfo.onMobDeath ~= nil then
                    mobInfo.onMobDeath(mob, player, optParams)
                end

                if mobInfo.spawned ~= nil then
                    for _, spawned in pairs(mobInfo.spawned) do
                        spawned:setLocalVar("NO_TEMP", 1)
                        spawned:setHP(0)
                    end
                end
            end,

            onMobDespawn = function(mob)
                -- Reward domain points and move to next location
                local players = mob:getZone():getPlayers()
                local nextLocation = diID + 1
                local notificationSent = GetServerVariable("[Domain]Notification")

                if diID >= #mobs then
                    nextLocation = 1
                end

                for _, participant in pairs(players) do
                    handlePlayerReward(participant, mobInfo.shards, mobInfo.name)

                    -- Only do messages once.
                    if notificationSent == 0 then
                        -- Server-wide message
                        local areaName = string.gsub(mobs[nextLocation].area, "_", " ")
                        local mobName  = string.gsub(mobs[nextLocation].name, "_", " ")
                        local message  = string.format("Oh dear, one of our members-wembers in %s says that %s could appear anytime in the next 5 minutes.", areaName, mobName)

                        if
                            participant ~= nil and
                            participant:isPC()
                        then
                            notificationSent = 1
                            SetServerVariable("[Domain]Notification", 1)
                            participant:printToArea(message, xi.msg.channel.UNITY, xi.msg.area.SYSTEM, "Apururu")
                            participant:printToArea("Would you please go and see if she's alrightaru?", xi.msg.channel.UNITY, xi.msg.area.SYSTEM, "Apururu")
                        end
                    end
                end

                -- Variable control
                onMobDeathVariableControl(nextLocation) -- Doing this repeatedly seemingly ensures this gets done always.
            end,
        }

        applyMobStandard(mobTable, mobInfo, bit.bor(xi.detects.HEARING, xi.detects.SIGHT))

        if mobInfo.onMobRoam ~= nil then
            mobTable.onMobRoam = mobInfo.onMobRoam
        end

        local mob = zone:insertDynamicEntity(mobTable)

        if mobInfo.template ~= nil then
            applyTemplate(mob, mobInfo.template)
        end

        applyModsAndEffects(mob, mobInfo)

        if mobInfo.pets ~= nil then
            setupPets(mob, mobInfo)
        end

        setupMob(mob, mobInfo)
    end)

    m:addOverride(zonePath .. ".onZoneTick", function(zone)
        super(zone)

        local osTime = os.time()

        if
            zone:getLocalVar("[Domain]NextSpawnCheck") < osTime or
            GetServerVariable("[Domain]NMSpawned") == 1 or -- NM is spawned
            GetServerVariable("[Domain]NM") ~= diID or     -- Wrong NM
            osTime < GetServerVariable("[Domain]NMToD")    -- NM Cooldown
        then
            if
                zone:getLocalVar("[Domain]NextSpawnCheck") < osTime
            then
                zone:setLocalVar("[Domain]NextSpawnCheck", osTime + math.random(30, 60))
            end

            return
        end

        local mob = zone:queryEntitiesByName("DE_" .. mobInfo.name)

        if
            mob ~= nil and
            not mob[1]:isSpawned()
        then
            -- DEBUG
            print(fmt("[DOMAIN INVASION]: Spawned [{}] in {} at POS: {}, {}, {}", mobInfo.name, zone:getName(), mobInfo.pos[1], mobInfo.pos[2], mobInfo.pos[3]))

            mob[1]:spawn()
            mob[1]:setMobMod(xi.mobMod.SKILL_LIST, mobInfo.skillList)
        end
    end)
end

----------------------------------------------------------------------
-- Entrance and Exit Checks
-- Make sure we remove xi.effect.ELVORSEAL from players when they zone.

-- Why isnt this handled via effect flag? MowFord: because effect is given by spicy traveler just before zoning
----------------------------------------------------------------------
for _, mobInfo in pairs(mobs) do
    m:addOverride(string.format("xi.zones.%s.Zone.onZoneOut", mobInfo.area), function(player)
        super(player)

        player:delStatusEffect(xi.effect.ELVORSEAL) -- just in case effectFlag doesn't work?
    end)

    m:addOverride(string.format("xi.zones.%s.Zone.onZoneIn", mobInfo.area), function(player, prevZone)
        super(player, prevZone)

        player:addStatusEffect(xi.effect.ELVORSEAL, {power =1,origin = player}) -- relogging will reapply buff, but also strip all contribution points... so nbd

        if
            GetServerVariable("[Domain]NMSpawned") == 1 and
            GetServerVariable("[Domain]Notification") ~= 1
        then
            SetServerVariable("[Domain]Notification", 1)
            player:printToArea(
                "Looks like our forces-warses are gathering for domain invasion! Hurry-worry and join them!",
                xi.msg.channel.UNITY,
                xi.msg.area.SYSTEM,
                "Apururu"
            )
        end

        local completed = player:getCharVar("[Domain]Completed")
        if completed >= 75 then
            player:timer(3000, function()
                for _, itemID in pairs(amchuchu) do
                    player:addTempItem(itemID)
                end
            end)
        end
    end)
end

-- Do not use on zone in
local function isInDI(player)
    local retVal = false
    local playerZone = player:getZone()
    for _, mobInfo in pairs(mobs) do
        if playerZone and playerZone:getName() == mobInfo.area then
            retVal = true
        end
    end

    return retVal
end

m:addOverride("xi.effects.paralysis.onEffectGain", function(player, effect)
    if isInDI(player) and effect:getPower() <= 20 then
        effect:setPower(1)
        effect:setDuration(30 * 60 * 1000) -- Potion 3 minutes to 30min
    end

    super(player, effect)
end)

xi.module.ensureTable("xi.effects.elvorseal")

m:addOverride("xi.effects.elvorseal.onEffectGain", function(player, effect)
    -- ensure we don't persist elvorseal in other zones due to zone crashes, etc
    effect:addEffectFlag(xi.effectFlag.ON_ZONE)
    player:timer(100, function(playerArg)
        if not isInDI(player) then
            playerArg:delStatusEffect(xi.effect.ELVORSEAL)
        end
    end)

    -- Determine effect power to track dailies done.
    local dailyBonus = getBonus(player)

    if effect:getPower() <= 1 then -- since power starts at 1 and spicy trav gives it with power 1
        effect:setPower(1 + dailyBonus)
    end

    -- Remove weakness.
    if player:hasStatusEffect(xi.effect.WEAKNESS) then
        player:delStatusEffect(xi.effect.WEAKNESS)
    end

    local completed = player:getCharVar("[Domain]Completed")

    local bonusAcc  = 0
    local bonusAtt  = 0
    local bonusMatt = 0
    local bonusMacc = 0

    if completed >= 25 then
        effect:addMod(xi.mod.STR, 10)
        effect:addMod(xi.mod.DEX, 10)
        effect:addMod(xi.mod.VIT, 10)
        effect:addMod(xi.mod.AGI, 10)
        effect:addMod(xi.mod.INT, 10)
        effect:addMod(xi.mod.MND, 10)
        effect:addMod(xi.mod.CHR, 10)
    end

    if completed >= 50 then
        bonusAcc  = 20
        bonusMacc = 15
    end

    if completed >= 100 then
        bonusAtt  = 50
        bonusMatt = 25
    end

    if completed >= 125 then
        effect:addMod(xi.mod.DOUBLE_ATTACK, 5)
        effect:addMod(xi.mod.FASTCAST,      5)
    end

    -- Add modifiers to effect so they clear on buff loss. Power ranges from 1 to 6
    local power = effect:getPower()
    effect:addMod(xi.mod.WALTZ_POTENCY,   4 * power) -- caps at 20% bonus
    effect:addMod(xi.mod.CURE_POTENCY,    2 * power) -- caps at 10% per
    effect:addMod(xi.mod.CURE_POTENCY_II, 2 * power) --   since each has an obtainable cap
    effect:addMod(xi.mod.HPP,            15 * power)
    effect:addMod(xi.mod.MPP,            15 * power)
    effect:addMod(xi.mod.REGEN,           3 * power)
    effect:addMod(xi.mod.REFRESH,             power)
    effect:addMod(xi.mod.HPHEAL,          8 * power)
    effect:addMod(xi.mod.MPHEAL,          8 * power)
    effect:addMod(xi.mod.RACC,            7 * power)
    effect:addMod(xi.mod.ACC,            (7 * power) + bonusAcc)
    effect:addMod(xi.mod.MACC,           (7 * power) + bonusMacc)
    effect:addMod(xi.mod.RATT,            7 * power)
    effect:addMod(xi.mod.ATT,            (7 * power) + bonusAtt)
    effect:addMod(xi.mod.MATT,           (7 * power) + bonusMatt)
    effect:addMod(xi.mod.DMG,          -450 * power) -- 10000 = 100%, so this gives 4.5% DT reduction per DQ

    -- Upate HP/MP after effect resolves
    player:timer(100, function(playerArg)
        playerArg:updateHealth()
        playerArg:setHP(playerArg:getMaxHP())
        playerArg:setMP(playerArg:getMaxMP())
    end)
end)

return m