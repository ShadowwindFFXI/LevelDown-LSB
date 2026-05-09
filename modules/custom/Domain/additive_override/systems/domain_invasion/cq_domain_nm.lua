-----------------------------------
-- Domain NM
-----------------------------------
-- !setvar [CQ]DOMAIN_NM 1
-----------------------------------
require("modules/module_utils")
require('scripts/utils/utils')
require('scripts/globals/player')
require('scripts/globals/npc_util')
local cq = require("modules/custom/domain/additive_override/utils/custom_quest")
-----------------------------------
local m = Module:new("cq_domain_nm")

local info =
{
    name   = "Domain NM",
    var    = "[CQ]DOMAIN_NM",
    points = "domain_points",
    msg    = "{} gains {} domain points.",
    miss   = "[Domain]Missed_{}",
}

local materials =
{
    { omixi.rate.COMMON, 3980 }, -- Bztavian Stinger
    { omixi.rate.COMMON, 3979 }, -- Rockfin Tooth
    { omixi.rate.COMMON, 3977 }, -- Gabbrath Horn
    { omixi.rate.COMMON, 4014 }, -- Yggdreant Bole
    { omixi.rate.COMMON, 4012 }, -- Waktza Rostrum
    { omixi.rate.COMMON, 8752 }, -- Cehuetzi Claw
    { omixi.rate.COMMON, 3981 }, -- Bztavian Wing
    { omixi.rate.COMMON, 3978 }, -- Rockfin Fin
    { omixi.rate.COMMON, 4015 }, -- Yggdreant Root
    { omixi.rate.COMMON, 4013 }, -- Waktza Crest
    { omixi.rate.COMMON, 8754 }, -- Cehuetzi Pelt
}

local materialsHQ =
{
    { omixi.rate.COMMON, 3981 }, -- Bztavian Wing
    { omixi.rate.COMMON, 3978 }, -- Rockfin Fin
    { omixi.rate.COMMON, 4015 }, -- Yggdreant Root
    { omixi.rate.COMMON, 4013 }, -- Waktza Crest
    { omixi.rate.COMMON, 8754 }, -- Cehuetzi Pelt
}

local rareMats =
{
    { omixi.rate.UNCOMMON,  722 }, -- Divine Log      (10%)
    { omixi.rate.UNCOMMON,  729 }, -- Bloodwood Log   (10%)
    { omixi.rate.UNCOMMON,  692 }, -- Beech Log       (10%)
    { omixi.rate.UNCOMMON, 1110 }, -- Beetle Blood    (10%)
    { omixi.rate.UNCOMMON,  655 }, -- Adaman Ingot    (10%)
    { omixi.rate.UNCOMMON,  747 }, -- Ocl. Ingot      (10%)
    { omixi.rate.UNCOMMON, 1311 }, -- Oxblood         (10%)
    { omixi.rate.UNCOMMON, 1312 }, -- Angel Skin      (10%)
    { omixi.rate.UNCOMMON, 1313 }, -- Siren's Hair    (10%)
    { omixi.rate.UNCOMMON, 2228 }, -- Luminium Ore    (10%)
    { omixi.rate.UNCOMMON,  741 }, -- P.Brass Ore     (10%)
    { omixi.rate.UNCOMMON,  740 }, -- Phrygian Ore    (10%)
    { omixi.rate.UNCOMMON,  734 }, -- Thokcha Ore     (10%)
    { omixi.rate.UNCOMMON, 1712 }, -- Cashmere Wool   (10%)
    { omixi.rate.UNCOMMON,  836 }, -- Damascene Cloth (10%)
    { omixi.rate.UNCOMMON,  901 }, -- Venomous Claw   (10%)
    { omixi.rate.UNCOMMON,  860 }, -- Behemoth Hide   (10%)
}

local ores =
{
    { omixi.rate.COMMON, 1255 }, -- Fire Ore
    { omixi.rate.COMMON, 1256 }, -- Ice Ore
    { omixi.rate.COMMON, 1257 }, -- Wind Ore
    { omixi.rate.COMMON, 1258 }, -- Earth Ore
    { omixi.rate.COMMON, 1259 }, -- Lightning Ore
    { omixi.rate.COMMON, 1260 }, -- Water Ore
    { omixi.rate.COMMON, 1261 }, -- Light Ore
    { omixi.rate.COMMON, 1262 }, -- Dark Ore
}

local trustHQ =
{
    { 950,            0     }, -- Nothing
    { omixi.rate.RARE, 10174 }, -- Cipher: Ingrid II  ( 5%)
}

local ringHQ =
{

    { omixi.rate.GUARANTEED, 26225 }, -- Medada's Ring (100%)
	{ omixi.rate.GUARANTEED, 26226 }, -- Gurebu's Ring (100%)
	{ omixi.rate.GUARANTEED, 26227 }, -- Cornelia's Ring (100%)
	{ omixi.rate.GUARANTEED, 26228 }, -- Ragelise's Ring (100%)
	{ omixi.rate.GUARANTEED, 26229 }, -- Lehko's Ring (100%)
	{ omixi.rate.GUARANTEED, 26230 }, -- Fickblix's Ring (100%)
	{ omixi.rate.GUARANTEED, 26231 }, -- Ephramad's Ring (100%)

}

local locations =
{
    -----------------------------------
    -- Amphisbaena / Tamandua
    -----------------------------------
    {
        name = "Amphisbaena",
        base = { 132, 43 }, -- Hadhayosh
        level       = { 145, 150 },
        hp    = 800000,
        area = "La_Theine_Plateau",
        pos  = { -194.054, 24.308, -474.497, 239 }, -- !pos -194.054 24.308 -474.497 102
        mods =
        {
            [xi.mod.REGAIN]     = 15,
            [xi.mod.ATT]        = 600,
			[xi.mod.ACC]        = 3200,
            [xi.mod.UDMGPHYS]   = -2500,
            [xi.mod.UDMGRANGE]  = -2500,
            [xi.mod.UDMGMAGIC]  = -2500,
            [xi.mod.UDMGBREATH] = -2500,
            [xi.mod.MATT]       = 400,
        },
        pool =
        {
            {
                { 550,                    0                        }, -- Nothing           (55%)
                { omixi.rate.VERY_COMMON, xi.item.AMPHISBAENA_HIDE }, -- Amphisbaena Hide  (24%)
                { omixi.rate.UNCOMMON,    860                      }, -- Behemoth Hide     (10%)
                { omixi.rate.UNCOMMON,    883                      }, -- Behemoth Horn     (10%)
                { omixi.rate.VERY_RARE,   10174                    }, -- Cipher: Ingrid II ( 1%)
            },
            {
                { 720,                    0                        }, -- Nothing           (72%)
                { omixi.rate.VERY_COMMON, xi.item.AMPHISBAENA_HIDE }, -- Amphisbaena Hide  (24%)
                { omixi.rate.VERY_RARE,   xi.item.MEDIUMS_SABOTS   }, -- Medium's Sabots   ( 1%)
                { omixi.rate.VERY_RARE,   xi.item.SAMNUHA_TIGHTS   }, -- Samnuha Tights    ( 1%)
                { omixi.rate.VERY_RARE,   xi.item.SAMNUHA_COAT     }, -- Samnuha's Coat    ( 1%)
                { omixi.rate.VERY_RARE,   xi.item.PURGATION        }, -- Purgation         ( 1%)
            },
            {
			    { 1000,                   26365                    }, -- Cornelia's Belt   (100%)
				{ 1000,                   26366                    }, -- Plat. Mog. Belt   (100%)
                { omixi.rate.COMMON,      xi.item.MEDIUMS_SABOTS   }, -- Medium's Sabots   (15%)
                { omixi.rate.COMMON,      xi.item.SAMNUHA_TIGHTS   }, -- Samnuha Tights    (15%)
                { omixi.rate.COMMON,      xi.item.SAMNUHA_COAT     }, -- Samnuha's Coat    (15%)
                { omixi.rate.COMMON,      xi.item.PURGATION        }, -- Purgation         (15%)
            },
            rareMats,
            materials,
            ores,
            ores,
        },
        hq  =
        {
            name = "Tamandua",
            look = 2866, -- Urmahlullu
            level = { 160, 165 },
            hp   = 1500000,
            mods =
            {
                [xi.mod.REGAIN]     = 25,
                [xi.mod.ATT]        = 1800,
				[xi.mod.ACC]        = 3200,
                [xi.mod.UDMGPHYS]   = -3000,
                [xi.mod.UDMGRANGE]  = -3000, 
                [xi.mod.UDMGMAGIC]  = -3000,
                [xi.mod.UDMGBREATH] = -3000,
                [xi.mod.MATT]       = 500,
            },
            pool =
            {
                trustHQ,
                {
                    { omixi.rate.GUARANTEED, xi.item.AMPHISBAENA_HIDE },
                },
                {
                    { 750,                    0                        }, -- Nothing          (75%)
                    { omixi.rate.VERY_COMMON, xi.item.AMPHISBAENA_HIDE }, -- Amphisbaena Hide (24%)
                    { omixi.rate.RARE,        xi.item.MEDIUMS_SABOTS   }, -- Medium's Sabots  ( 5%)
                    { omixi.rate.RARE,        xi.item.SAMNUHA_TIGHTS   }, -- Samnuha Tights   ( 5%)
                    { omixi.rate.RARE,        xi.item.SAMNUHA_COAT     }, -- Samnuha's Coat   ( 5%)
                    { omixi.rate.RARE,        xi.item.PURGATION        }, -- Purgation        ( 5%)
                    { omixi.rate.RARE,        xi.item.OCHU             }, -- Ochu             ( 5%)
                },
                {
                    { omixi.rate.COMMON,      xi.item.MEDIUMS_SABOTS   }, -- Medium's Sabots  (15%)
                    { omixi.rate.COMMON,      xi.item.SAMNUHA_TIGHTS   }, -- Samnuha Tights   (15%)
                    { omixi.rate.COMMON,      xi.item.SAMNUHA_COAT     }, -- Samnuha's Coat   (15%)
                    { omixi.rate.COMMON,      xi.item.PURGATION        }, -- Purgation        (15%)
                    { omixi.rate.UNCOMMON,    xi.item.OCHU             }, -- Ochu             (10%)
                },
                rareMats,
                rareMats,
                materialsHQ,
                ores,
				ringHQ,
            },
        },

        onMobSpawn = function(mob)
            mob:addImmunity(xi.immunity.DARK_SLEEP)
            mob:addImmunity(xi.immunity.GRAVITY)
            mob:addImmunity(xi.immunity.LIGHT_SLEEP)
            mob:addImmunity(xi.immunity.PETRIFY)
            mob:addImmunity(xi.immunity.SILENCE)
            mob:addImmunity(xi.immunity.TERROR)
            omixi.mob_util.wsPenalty(mob)
        end,

        onMobFight = function(mob, target)
            omixi.mob_util.ignorePet(mob, target)
        end,
    },

    -----------------------------------
    -- Battosai / Gensai
    -----------------------------------
    {
        name = "Battosai",
        base = { 51, 38 }, -- Hydra
        level       = { 145, 150 },
        hp   = 800000,
        area = "Konschtat_Highlands",
        pos  = { 244.922, 39.812, 636.224, 36 }, -- !pos 244.922 39.812 636.224 108
        mods =
        {
            [xi.mod.DOUBLE_ATTACK] = 15,
            [xi.mod.ATT]           = 800,
			[xi.mod.ACC]           = 3200,
            [xi.mod.UDMGPHYS]      = -2500,
            [xi.mod.UDMGRANGE]     = -2500,
            [xi.mod.UDMGMAGIC]     = -2500,
            [xi.mod.UDMGBREATH]    = -2500,
        },
        pool =
        {
            {
                { 550,                   0                        }, -- Nothing           (55%)
                { omixi.rate.VERY_COMMON, xi.item.BATTOSAI_FANG    }, -- Battosai Fang     (24%)
                { omixi.rate.UNCOMMON,    2158                     }, -- Hydra Fang        (10%)
                { omixi.rate.UNCOMMON,    2172                     }, -- Hydra Scale       (10%)
                { omixi.rate.VERY_RARE,   10174                    }, -- Cipher: Ingrid II ( 1%)
            },
            {
                { 720,                   0                        }, -- Nothing           (72%)
                { omixi.rate.VERY_COMMON, xi.item.BATTOSAI_FANG    }, -- Battosai Fang     (24%)
                { omixi.rate.VERY_RARE,   xi.item.UKUXKAJ_CAP      }, -- Uk'uxkaj Cap      ( 1%)
                { omixi.rate.VERY_RARE,   xi.item.UKUXKAJ_BOOTS    }, -- Uk'uxkaj Boots    ( 1%)
                { omixi.rate.VERY_RARE,   xi.item.FLORAL_GAUNTLETS }, -- Floral Gauntlets  ( 1%)
                { omixi.rate.VERY_RARE,   xi.item.VAMPIRISM        }, -- Vampirism         ( 1%)
            },
            {
			    { 1000,                   26365                    }, -- Cornelia's Belt   (100%)
				{ 1000,                   26366                    }, -- Plat. Mog. Belt   (100%)
                { omixi.rate.COMMON,      xi.item.UKUXKAJ_BOOTS    }, -- Uk'uxkaj Boots    (15%)
                { omixi.rate.COMMON,      xi.item.FLORAL_GAUNTLETS }, -- Floral Gauntlets  (15%)
                { omixi.rate.COMMON,      xi.item.VAMPIRISM        }, -- Vampirism         (15%)
            },
            rareMats,
            materials,
            ores,
            ores,
        },
        hq  =
        {
            name = "Gensai",
            look = 1797, -- Alfard
            level       = { 160, 165 },
            hp   = 1500000,
            mods =
            {
                [xi.mod.DOUBLE_ATTACK] = 25,
                [xi.mod.ATT]           = 900,
				[xi.mod.ACC]           = 3200,
                [xi.mod.UDMGPHYS]      = -3000,
                [xi.mod.UDMGRANGE]     = -3000,
                [xi.mod.UDMGMAGIC]     = -3000,
                [xi.mod.UDMGBREATH]    = -3000,
            },
            pool =
            {
                trustHQ,
                {
                    { omixi.rate.GUARANTEED, xi.item.BATTOSAI_FANG },
                },
                {
                    { 510,                   0                        }, -- Nothing          (51%)
                    { omixi.rate.VERY_COMMON, xi.item.BATTOSAI_FANG    }, -- Battosai Fang    (24%)
                    { omixi.rate.RARE,        xi.item.UKUXKAJ_CAP      }, -- Uk'uxkaj Cap     ( 5%)
                    { omixi.rate.RARE,        xi.item.UKUXKAJ_BOOTS    }, -- Uk'uxkaj Boots   ( 5%)
                    { omixi.rate.RARE,        xi.item.FLORAL_GAUNTLETS }, -- Floral Gauntlets ( 5%)
                    { omixi.rate.RARE,        xi.item.VAMPIRISM        }, -- Vampirism        ( 5%)
                    { omixi.rate.RARE,        xi.item.TAMING_SARI      }, -- Taming Sari      ( 5%)
                },
                {
                    { omixi.rate.COMMON,      xi.item.UKUXKAJ_CAP      }, -- Uk'uxkaj Cap     (15%)
                    { omixi.rate.COMMON,      xi.item.UKUXKAJ_BOOTS    }, -- Uk'uxkaj Boots   (15%)
                    { omixi.rate.COMMON,      xi.item.FLORAL_GAUNTLETS }, -- Floral Gauntlets (15%)
                    { omixi.rate.COMMON,      xi.item.VAMPIRISM        }, -- Vampirism        (15%)
                    { omixi.rate.UNCOMMON,    xi.item.TAMING_SARI      }, -- Taming Sari      (10%)
                },
                rareMats,
                rareMats,
                materialsHQ,
                ores,
				ringHQ,
            },
        },

        onMobSpawn = function(mob)
            mob:addImmunity(xi.immunity.DARK_SLEEP)
            mob:addImmunity(xi.immunity.GRAVITY)
            mob:addImmunity(xi.immunity.LIGHT_SLEEP)
            mob:addImmunity(xi.immunity.PETRIFY)
            mob:addImmunity(xi.immunity.SILENCE)
            mob:addImmunity(xi.immunity.TERROR)
            omixi.mob_util.wsPenalty(mob)
        end,

        onMobFight = function(mob, target)
            omixi.mob_util.ignorePet(mob, target)
        end,
    },

    -----------------------------------
    -- Tortuga / Cryptodira
    -----------------------------------
    {
        name = "Tortuga",
        base = { 289, 79 }, -- Genbu-Escha
        look = 2376,
        level       = { 145, 150 },
        hp   = 800000,
        area = "Tahrongi_Canyon",
        pos  = { -461.275, -39.983, -140.451, 45 }, -- !pos -461.275 -39.983 -140.451 117
        mods =
        {
            [xi.mod.FASTCAST]   = 20,
            [xi.mod.ATT]        = 600,
            [xi.mod.MATT]       = 300,
			[xi.mod.ACC]        = 3200,
            [xi.mod.UDMGPHYS]   = -2500,
            [xi.mod.UDMGRANGE]  = -2500,
            [xi.mod.UDMGMAGIC]  = -2500,
            [xi.mod.UDMGBREATH] = -2500,
        },
        pool =
        {
            {
                { 550,                   0                     }, -- Nothing           (55%)
                { omixi.rate.VERY_COMMON, xi.item.TORTUGA_SHELL }, -- Tortuga Shell     (24%)
                { omixi.rate.UNCOMMON,    908                   }, -- Adamantoise Shell (10%)
                { omixi.rate.UNCOMMON,    646                   }, -- Adaman Ore        (10%)
                { omixi.rate.VERY_RARE,   10174                 }, -- Cipher: Ingrid II ( 1%)
            },
            {
                { 720,                   0                     }, -- Nothing       (72%)
                { omixi.rate.VERY_COMMON, xi.item.TORTUGA_SHELL }, -- Tortuga Shell (24%)
                { omixi.rate.VERY_RARE,   xi.item.JUMALIK_HELM  }, -- Jumalik Helm  ( 1%)
                { omixi.rate.VERY_RARE,   xi.item.JUMALIK_MAIL  }, -- Jumalik Mail  ( 1%)
                { omixi.rate.VERY_RARE,   xi.item.DAMPENING_TAM }, -- Dampening Tam ( 1%)
                { omixi.rate.VERY_RARE,   xi.item.DIVINITY      }, -- Divinity      ( 1%)
            },
            {
			    { 1000,                   26365                    }, -- Cornelia's Belt   (100%)
				{ 1000,                   26366                    }, -- Plat. Mog. Belt   (100%)
                { omixi.rate.COMMON, xi.item.JUMALIK_HELM  }, -- Jumalik Helm  (15%)
                { omixi.rate.COMMON, xi.item.JUMALIK_MAIL  }, -- Jumalik Mail  (15%)
                { omixi.rate.COMMON, xi.item.DAMPENING_TAM }, -- Dampening Tam (15%)
                { omixi.rate.COMMON, xi.item.DIVINITY      }, -- Divinity      (15%)
            },
            rareMats,
            materials,
            ores,
            ores,
        },
        hq  =
        {
            name = "Cryptodira",
            look = 407, -- Genbu
            level       = { 160, 165 },
            hp   = 1500000,
            mods =
            {
                [xi.mod.FASTCAST]   = 40,
                [xi.mod.ATT]        = 900,
				[xi.mod.ACC]        = 3200,
                [xi.mod.MATT]       = 500,
                [xi.mod.UDMGPHYS]   = -3000,
                [xi.mod.UDMGRANGE]  = -3000,
                [xi.mod.UDMGMAGIC]  = -3000,
                [xi.mod.UDMGBREATH] = -3000,
            },
            pool =
            {
                trustHQ,
                {
                    { omixi.rate.GUARANTEED, xi.item.TORTUGA_SHELL },
                },
                {
                    { 510,                   0                     }, -- Nothing       (51%)
                    { omixi.rate.VERY_COMMON, xi.item.TORTUGA_SHELL }, -- Tortuga Shell (24%)
                    { omixi.rate.RARE,        xi.item.JUMALIK_HELM  }, -- Jumalik Helm  ( 5%)
                    { omixi.rate.RARE,        xi.item.JUMALIK_MAIL  }, -- Jumalik Mail  ( 5%)
                    { omixi.rate.RARE,        xi.item.DAMPENING_TAM }, -- Dampening Tam ( 5%)
                    { omixi.rate.RARE,        xi.item.DIVINITY      }, -- Divinity      ( 5%)
                    { omixi.rate.RARE,        xi.item.MALEVOLENCE   }, -- Malevolence   ( 5%)
                },
                {
                    { omixi.rate.COMMON,      xi.item.JUMALIK_HELM  }, -- Jumalik Helm  (15%)
                    { omixi.rate.COMMON,      xi.item.JUMALIK_MAIL  }, -- Jumalik Mail  (15%)
                    { omixi.rate.COMMON,      xi.item.DAMPENING_TAM }, -- Dampening Tam (15%)
                    { omixi.rate.COMMON,      xi.item.DIVINITY      }, -- Divinity      (15%)
                    { omixi.rate.UNCOMMON,    xi.item.MALEVOLENCE   }, -- Malevolence   (10%)
                },
                rareMats,
                rareMats,
                materialsHQ,
                ores,
				ringHQ,
            },
        },

        onMobSpawn = function(mob)
            mob:addImmunity(xi.immunity.DARK_SLEEP)
            mob:addImmunity(xi.immunity.GRAVITY)
            mob:addImmunity(xi.immunity.LIGHT_SLEEP)
            mob:addImmunity(xi.immunity.PETRIFY)
            mob:addImmunity(xi.immunity.SILENCE)
            mob:addImmunity(xi.immunity.TERROR)
            omixi.mob_util.wsPenalty(mob)
        end,

        onMobFight = function(mob, target)
            omixi.mob_util.ignorePet(mob, target)
        end,
    },
}

m:addOverride("xi.actions.mobskills.thunderbolt.onMobWeaponSkill", function(target, mob, skill)
    local mobName = mob:getPacketName()

    if
        mobName == "Amphisbaena" or
        mobName == "Tamandua"
    then
        target:addStatusEffect(xi.effect.SHOCK, 50, 0, 60)
    end

    return super(target, mob, skill)
end)

m:addOverride("xi.actions.mobskills.aqua_breath.onMobWeaponSkill", function(target, mob, skill)
    local mobName = mob:getPacketName()

    if
        mobName == "Tortuga" or
        mobName == "Cryptodira"
    then
        target:addStatusEffect(xi.effect.DROWN, 80, 0, 40)
    end

    return super(target, mob, skill)
end)

m:addOverride("xi.actions.mobskills.trembling.onMobWeaponSkill", function(target, mob, skill)
    local mobName = mob:getPacketName()

    if
        mobName == "Battosai" or
        mobName == "Gensai"
    then
        target:addStatusEffect(xi.effect.PARALYSIS, 50, 0, 30)
        target:addStatusEffect(xi.effect.POISON,    20, 0, 30)
    end

    return super(target, mob, skill)
end)

-- Create placeholder steps
local step = {}
step[1] = {}
step[2] = {}

local function nameToID(str)
    return string.upper(string.gsub(str, " ", "_"))
end

local entity = {}

for index, battle in pairs(locations) do
    local mobNQ = nameToID(battle.name)
    local mobHQ = nameToID(battle.hq.name)
    local popID = fmt("DOMAIN_SEAL_{}", index)

    table.insert(entity, {
        id     = popID,
        name   = "Domain Seal",
        marker = cq.MAIN_QUEST,
        area   = battle.area,
        pos    = battle.pos,
        dialog =
        {
            DEFAULT = cq.NOTHING,
        },
    })

    -- NQ Mob
    table.insert(entity, {
        id          = mobNQ,
        name        = battle.name,
        type        = xi.objType.MOB,
        groupId     = battle.base[2],
        groupZoneId = battle.base[1],
        look        = battle.look,
		level       = battle.level,
        flags       = battle.flags or 603,
        area        = battle.area,
        pos         = battle.pos,
        hp          = battle.hp,
        pool        = battle.pool,
        mods        = battle.mods,
        onMobSpawn  = battle.onMobSpawn,
        onMobFight  = battle.onMobFight,
        points      =
        {
            var     = info.points,
            message = info.msg,
            amount  = { 1000, 1500 },
            exp     = 9000,
            item    = xi.item.DOMAIN_COFFER,
            missed  = info.miss,
        },
    })

    -- HQ Mob
    table.insert(entity, {
        id          = mobHQ,
        name        = battle.hq.name,
        type        = xi.objType.MOB,
        groupId     = battle.base[2],
        groupZoneId = battle.base[1],
        look        = battle.hq.look,
		level       = battle.hq.level,
        flags       = battle.flags or 603,
        area        = battle.area,
        pos         = battle.pos,
        hp          = battle.hq.hp,
        pool        = battle.hq.pool,
        mods        = battle.hq.mods,
        onMobSpawn  = battle.onMobSpawn,
        onMobFight  = battle.onMobFight,
        points      =
        {
            var     = info.points,
            message = info.msg,
            amount  = { 1500, 3000 },
            exp     = 18000,
            item    = xi.item.DOMAIN_COFFER_P1,
            missed  = info.miss,
        },
    })

    step[2][popID] = cq.menu({
        spawn    =
        {
            nq   = mobNQ,
            hq   = mobHQ,
            rate = 15,
        },
        title    = "Ready to battle?",
        setVar   = { { info.var, 0 } },
        options  =
        {
            { "Not yet" },
            { "I'm ready", true },
        },
    })
end

cq.add(m, {
    info   = info,
    entity = entity,
    step   = step,
})

return m
