local zname =
{ -- zone name / mob name / coffer id / difficuly level / tier / time to kill
{'Alzadaal_Undersea_Ruins', 'Vidmapire',               6389, 128, 3,  900},
{'Attohwa_Chasm',           'Muut',                    6358, 125, 3,  900},
{'Aydeewa_Subterrane',      'Tumult_Curator',          6479, 145, 5,  900},
{'Batallia_Downs',          'Lumber_Jill',             6323, 125, 3,  900},
{'Beaucedine_Glacier',      'Largantua',               6328, 125, 3,  900},
{'Behemoths_Dominion',      'Sovereign_Behemoth',      6405, 135, 4,  900},
{'Bibiki_Bay',              'Intuila',                 6320, 119, 2,  900},
{'Bostaunieux_Oubliette',   'Garbage_Gel',             6382, 122, 3,  900},
{'Buburimu_Peninsula',      'Abyssdiver',              6319, 119, 2,  900},
{'Caedarva_Mire',           'Shedu',                   6482, 135, 4, 1800},
{'Cape_Teriggan',           'Vedrfolnir',              6354, 128, 3,  900},
{'Carpenters_Landing',      'Orcfeltrap',              6322, 119, 2,  900},
{'Den_of_Rancor',           'Azrael',                  6365, 128, 3,  900},
{'East_Ronfaure',           'Hugemaw_Harold',          6312,  75, 1,  900},
{'East_Sarutabaruta',       'Prickly_Pitriv',          6314,  75, 1,  900},
{'Eastern_Altepa_Desert',   'Cactrot_Veloz',           6331, 122, 3,  900},
{'FeiYin',                  'Borealis_Shadow',         6366, 128, 3,  900},
{'Garlaige_Citadel',        'Mephitas',                6361, 125, 3,  900},
{'Gustav_Tunnel',           'Wyvernhunter_Bambrox',    6485, 128, 3,  900},
{'Ifrits_Cauldron',         'Coca',                    6362, 125, 3,  900},
{'Jugner_Forest',           'Emperor_Arthro',          6321, 125, 3,  900},
{'Konschtat_Highlands',     'Sleepy_Mabel',            6316,  99, 1,  900},
{'Kuftal_Tunnel',           'Specter_Worm',            6364, 125, 3,  900},
{'La_Theine_Plateau',       'Ironhorn_Baldurno',       6315,  99, 1,  900},
{'Labyrinth_of_Onzozo',     'Voso',                    6360, 122, 3,  900},
{'Lufaise_Meadows',         'Immanibugard',            6357, 119, 2,  900},
{'Meriphataud_Mountains',   'Warblade_Beak',           6326, 122, 3,  900},
{'Misareaux_Coast',         'Tiyanak',                 6356, 122, 3,  900},
{'Mount_Zhayolm',           'Grand_Grenade',           6388, 128, 3,  900},
{'Pashhow_Marshlands',      'Joyous_Green',            6324, 122, 3,  900},
{'Qufim_Island',            'Jester_Malatrix',         6330, 119, 2,  900},
{'Quicksand_Caves',         'Centurio_XX-I',           6390, 125, 3,  900},
{'RoMaeve',                 'Douma_Weapon',            6352, 125, 3,  900},
{'Rolanberry_Fields',       'Strix',                   6325, 125, 3,  900},
{'Sauromugue_Champaign',    'Arke',                    6327, 125, 3,  900},
{'Sea_Serpent_Grotto',      'Bakunawa',                6383, 125, 3,  900},
{'South_Gustaberg',         'Bounding_Belinda',        6313,  75, 1,  900},
{'Tahrongi_Canyon',         'Serpopard_Ninlil',        6318,  99, 1,  900},
{'Temple_of_Uggalepih',     'Azure-toothed_Clawberry', 6384, 125, 3,  900},
{'The_Boyahda_Tree',        'Ayapec',                  6363, 125, 3,  900},
{'The_Sanctuary_of_ZiTah',  'Keeper_of_Heiligtum',     6351, 122, 3,  900},
{'Uleguerand_Range',        'Camahueto',               6359, 128, 3,  900},
{'Valkurm_Dunes',           'Valkurm_Imperator',       6317, 119, 2,  900},
{'Valley_of_Sorrows',       'Tolba',                   6403, 135, 4, 1800},
{'Wajaom_Woodlands',        'Kubool_Jas_Mhuufya',      6387, 125, 3,  900},
{'Western_Altepa_Desert',   'King_Uropygid',           6353, 125, 3,  900},
{'Xarcabard',               'Beist',                   6329, 125, 3,  900},
{'Yhoator_Jungle',          'Woodland_Mender',         6332, 122, 3,  900},
{'Yuhtunga_Jungle',         'Sybaritic_Samantha',      6350, 119, 2,  900},
{'Lufaise_Meadows',         'Vermillion_Fishfly',      6385, 125, 3,  900},
{'FeiYin',                  'Carousing_Celine',        6484, 128, 3,  900},
{'Misareaux_Coast',         'Volatile_Cluster',        6386, 128, 3,  900},
{'Cape_Teriggan',           'Glazemane',               6483, 128, 3,  900},
{'The_Boyahda_Tree',        'Hidhaegg',                6404, 135, 4, 1800},
{'Wajaom_Woodlands',        'Thuban',                  6480, 135, 4, 1800},
{'Mount_Zhayolm',           'Sarama',                  6481, 135, 4, 1800},
}


local ensureTable = function(str)
    local parts = utils.splitStr(str, '.')
    local table = _G;
    for _, part in ipairs(parts) do
        table[part] = table[part] or {}
        table = table[part]
    end
end
for _, entry in pairs(zname) do
    ensureTable(string.format('xi.zones.%s.npcs.Ethereal_Junction', entry[1]))
end
for _, entry in pairs(zname) do
    ensureTable(string.format('xi.zones.%s.mobs.%s', entry[1], entry[2]))
end

-----------------------------------
require("modules/module_utils")
require("scripts/globals/npc_util")
require("scripts/globals/unitywanted")
-----------------------------------

local m = Module:new("unitybattle")

for _, entry in pairs(zname) do
    m:addOverride(string.format("xi.zones.%s.npcs.Ethereal_Junction.onTrigger",entry[1]), function(player, npc)
        xi.unitywanted.qmOnTrigger(player, npc)
    end)
end

for _, entry in pairs(zname) do
    m:addOverride(string.format("xi.zones.%s.npcs.Ethereal_Junction.onEventUpdate",entry[1]), function(player, csid, option, npc)
        local zonez = player:getZoneID()

        if zonez == 113 or 204 or 24 or 25 or 61 or 153 or 51 then
            xi.unitywanted.qmOnEventUpdate(player, csid, option, npc)
        end

    end)
end

for _, entry in pairs(zname) do
    m:addOverride(string.format("xi.zones.%s.npcs.Ethereal_Junction.onEventFinish", entry[1]), function(player, csid, option, npc, trade)
        xi.unitywanted.qmOnEventFinish(player, npc, option)
    end)
end

for _, entry in pairs(zname) do
    m:addOverride(string.format("xi.zones.%s.mobs.%s.onMobInitialize", entry[1], entry[2]), function(mob)
end)

m:addOverride(string.format("xi.zones.%s.mobs.%s.onMobSpawn", entry[1], entry[2]), function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 15)
    mob:setLocalVar('Unity_Time', os.time() + entry[6])
    if mob:getMainLvl() > 121 and mob:getMainLvl() <= 125 then
            mob:addMod(xi.mod.ATT, 1000)
            mob:addMod(xi.mod.DEF, 150)
            mob:addMod(xi.mod.ACC, 500)
            mob:addMod(xi.mod.EVA, 150)
            mob:addMod(xi.mod.MATT, 50)
            mob:addMod(xi.mod.MDEF, 150)
            mob:addMod(xi.mod.MACC, 500)
            mob:addMod(xi.mod.MEVA, 150)
            mob:addMod(xi.mod.HASTE_MAGIC, 10)
    elseif mob:getMainLvl() > 126 and mob:getMainLvl() <= 130 then
            mob:addMod(xi.mod.ATT, 1400)
            mob:addMod(xi.mod.DEF, 250)
            mob:addMod(xi.mod.ACC, 700)
            mob:addMod(xi.mod.EVA, 200)
            mob:addMod(xi.mod.MATT, 100)
            mob:addMod(xi.mod.MDEF, 250)
            mob:addMod(xi.mod.MACC, 700)
            mob:addMod(xi.mod.MEVA, 200)
            mob:addMod(xi.mod.HASTE_MAGIC, 15)
            mob:addMod(xi.mod.REGEN, 20)
            mob:addMod(xi.mod.REFRESH, 20)
    elseif mob:getMainLvl() > 131 and mob:getMainLvl() <= 135 then
            mob:addMod(xi.mod.ATT, 1800)
            mob:addMod(xi.mod.DEF, 350)
            mob:addMod(xi.mod.ACC, 900)
            mob:addMod(xi.mod.EVA, 250)
            mob:addMod(xi.mod.MATT, 150)
            mob:addMod(xi.mod.MDEF, 350)
            mob:addMod(xi.mod.MACC, 900)
            mob:addMod(xi.mod.MEVA, 250)
            mob:addMod(xi.mod.HASTE_MAGIC, 20)
            mob:addMod(xi.mod.REGEN, 30)
            mob:addMod(xi.mod.REFRESH, 30)
            mob:addMod(xi.mod.REGAIN, 20)
    end
end)

m:addOverride(string.format("xi.zones.%s.mobs.%s.onMobDeath", entry[1], entry[2]), function(mob, player, params, npc)
    local party = player:getParty()
    for _, partyMemeber in pairs(party) do
        player:delStatusEffect(xi.effect.BATTLEFIELD)
        player:countdown()
    end
        npcUtil.giveItem(player, {{entry[3], 1}})

end)

m:addOverride(string.format("xi.zones.%s.mobs.%s.onMobDespawn", entry[1], entry[2]), function(mob, player, params, npc)

end)

m:addOverride(string.format("xi.zones.%s.mobs.%s.onMobFight", entry[1], entry[2]), function(mob, player, params, npc)
    local timeLeft = mob:getLocalVar('Unity_Time') - os.time()
    local party = player:getParty()
    --[[
    if timeLeft <= 0 or
       not player:hasStatusEffect(xi.effect.BATTLEFIELD) then
                 for _, partyMemeber in pairs(party) do
       player:delStatusEffect(xi.effect.BATTLEFIELD)
       player:countdown()
       end
       DespawnMob(mob:getID())
    end
    ]]--
    if timeLeft <= 0 then
        for _, partyMemeber in pairs(party) do
            player:countdown()
        end

        DespawnMob(mob:getID())
    end


end)
end

return m