-----------------------------------
-- AF Reward
-----------------------------------
require('modules/module_utils')
require('scripts/globals/mobs')
require('scripts/globals/player')
require('scripts/globals/npc_util')
require("scripts/enum/job")
-----------------------------------
local m = Module:new('af_level_reward')

local jobAFTable =
{

            [ 1] = -- War
            {
               [52] = { xi.item.FIGHTERS_CALLIGAE},  -- 
               [54] = { xi.item.FIGHTERS_MUFFLERS},  -- 
               [56] = { xi.item.FIGHTERS_MASK},  -- 
               [58] = { xi.item.FIGHTERS_CUISSES},  -- 
               [60] = { xi.item.FIGHTERS_LORICA},  -- 
            },
            [ 2] = -- Mnk
            {
               [52] = { xi.item.TEMPLE_GAITERS},  -- 
               [54] = { xi.item.TEMPLE_GLOVES},  -- 
               [56] = { xi.item.TEMPLE_CROWN},  -- 
               [58] = { xi.item.TEMPLE_CYCLAS},  -- 
               [60] = { xi.item.TEMPLE_HOSE},  -- 
            },
            [ 3] = -- Whm
            {
               [52] = { xi.item.HEALERS_DUCKBILLS},  -- 
               [54] = { xi.item.HEALERS_CAP},  -- 
               [56] = { xi.item.HEALERS_PANTALOONS},  -- 
               [58] = { xi.item.HEALERS_BLIAUT},  -- 
               [60] = { xi.item.HEALERS_MITTS},  -- 
            },
            [ 4] = -- Blm
            {
               [52] = { xi.item.WIZARDS_SABOTS},  -- 
               [54] = { xi.item.WIZARDS_GLOVES},  -- 
               [56] = { xi.item.WIZARDS_TONBAN},  -- 
               [58] = { xi.item.WIZARDS_COAT},  -- 
               [60] = { xi.item.WIZARDS_PETASOS},  -- 
            },
            [ 5] = -- Rdm
            {
               [52] = { xi.item.WARLOCKS_BOOTS},  -- 
               [54] = { xi.item.WARLOCKS_GLOVES},  -- 
               [56] = { xi.item.WARLOCKS_TIGHTS},  -- 
               [58] = { xi.item.WARLOCKS_TABARD},  -- 
               [60] = { xi.item.WARLOCKS_CHAPEAU},  -- 
            },
            [ 6] = -- Thf
            {
               [52] = { xi.item.ROGUES_ARMLETS},  -- 
               [54] = { xi.item.ROGUES_BONNET},  -- 
               [56] = { xi.item.ROGUES_CULOTTES},  -- 
               [58] = { xi.item.ROGUES_VEST},  -- 
               [60] = { xi.item.ROGUES_POULAINES},  -- 
            },
            [ 7] = -- Pld
            {
               [52] = { xi.item.GALLANT_LEGGINGS},  -- 
               [54] = { xi.item.GALLANT_GAUNTLETS},  -- 
               [56] = { xi.item.GALLANT_CORONET},  -- 
               [58] = { xi.item.GALLANT_BREECHES},  -- 
               [60] = { xi.item.GALLANT_SURCOAT},  -- 
            },
            [ 8] = -- Drk
            {
               [52] = { xi.item.CHAOS_SOLLERETS},  -- 
               [54] = { xi.item.CHAOS_GAUNTLETS},  -- 
               [56] = { xi.item.CHAOS_FLANCHARD},  -- 
               [58] = { xi.item.CHAOS_CUIRASS},  -- 
               [60] = { xi.item.CHAOS_BURGEONET},  -- 
            },
            [ 9] = -- Bst
            {
               [52] = { xi.item.BEAST_GAITERS},  -- 
               [54] = { xi.item.BEAST_GLOVES},  -- 
               [56] = { xi.item.BEAST_HELM},  -- 
               [58] = { xi.item.BEAST_JACKCOAT},  -- 
               [60] = { xi.item.BEAST_TROUSERS},  -- 
            },
            [10] = -- Brd
            {
               [52] = { xi.item.CHORAL_SLIPPERS},  -- 
               [54] = { xi.item.CHORAL_ROUNDLET},  -- 
               [56] = { xi.item.CHORAL_CANNIONS},  -- 
               [58] = { xi.item.CHORAL_JUSTAUCORPS},  -- 
               [60] = { xi.item.CHORAL_CUFFS},  -- 
            },
            [11] = -- Rng
            {
               [52] = { xi.item.HUNTERS_BRACERS},  -- 
               [54] = { xi.item.HUNTERS_BERET},  -- 
               [56] = { xi.item.HUNTERS_BRACCAE},  -- 
               [58] = { xi.item.HUNTERS_JERKIN},  -- 
               [60] = { xi.item.HUNTERS_SOCKS},  -- 
            },
            [12] = -- Sam
            {
               [52] = { xi.item.MYOCHIN_SUNE_ATE},  -- 
               [54] = { xi.item.MYOCHIN_HAIDATE},  -- 
               [56] = { xi.item.MYOCHIN_KOTE},  -- 
               [58] = { xi.item.MYOCHIN_DOMARU},  -- 
               [60] = { xi.item.MYOCHIN_KABUTO},  -- 
            },
            [13] = -- Nin
            {
               [52] = { xi.item.NINJA_HAKAMA},  -- 
               [54] = { xi.item.NINJA_KYAHAN},  -- 
               [56] = { xi.item.NINJA_HATSUBURI},  -- 
               [58] = { xi.item.NINJA_CHAINMAIL},  -- 
               [60] = { xi.item.NINJA_TEKKO},  -- 
            },
            [14] = -- Drg
            {
               [52] = { xi.item.DRACHEN_BRAIS},  -- 
               [54] = { xi.item.DRACHEN_GREAVES},  -- 
               [56] = { xi.item.DRACHEN_FINGER_GAUNTLETS},  -- 
               [58] = { xi.item.DRACHEN_MAIL},  -- 
               [60] = { xi.item.DRACHEN_ARMET},  -- 
            },
            [15] = -- Smn
            {
               [52] = { xi.item.EVOKERS_SPATS},  -- 
               [54] = { xi.item.EVOKERS_BRACERS},  -- 
               [56] = { xi.item.EVOKERS_PIGACHES},  -- 
               [58] = { xi.item.EVOKERS_DOUBLET},  -- 
               [60] = { xi.item.EVOKERS_HORN},  -- 
            },
            [16] = -- Blu
            {
               [52] = { xi.item.MAGUS_CHARUQS},  -- 
               [54] = { xi.item.MAGUS_SHALWAR},  -- 
               [56] = { xi.item.MAGUS_BAZUBANDS},  -- 
               [58] = { xi.item.MAGUS_JUBBAH},  -- 
               [60] = { xi.item.MAGUS_KEFFIYEH},  -- 
            },
            [17] = -- Cor
            {
               [52] = { xi.item.CORSAIRS_CULOTTES},  -- 
               [54] = { xi.item.CORSAIRS_GANTS},  -- 
               [56] = { xi.item.CORSAIRS_BOTTES},  -- 
               [58] = { xi.item.CORSAIRS_FRAC},  -- 
               [60] = { xi.item.CORSAIRS_TRICORNE},  -- 
            },
            [18] = -- Pup
            {
               [52] = { xi.item.PUPPETRY_CHURIDARS},  -- 
               [54] = { xi.item.PUPPETRY_BABOUCHES},  -- 
               [56] = { xi.item.PUPPETRY_DASTANAS},  -- 
               [58] = { xi.item.PUPPETRY_TOBE},  -- 
               [60] = { xi.item.PUPPETRY_TAJ},  -- 
            },
            [19] = -- Dnc
            {
               [52] = { xi.item.DANCERS_BANGLES_M},  -- xi.item.DANCERS_BANGLES_F
               [54] = { xi.item.DANCERS_TIARA_M},  -- xi.item.DANCERS_TIARA_F
               [56] = { xi.item.DANCERS_TOE_SHOES_M},  -- xi.item.DANCERS_TOE_SHOES_F
               [58] = { xi.item.DANCERS_TIGHTS_M},  -- xi.item.DANCERS_TIGHTS_F
               [60] = { xi.item.DANCERS_CASAQUE_M},  -- xi.item.DANCERS_CASAQUE_F
            },
            [20] = -- Sch
            {
               [52] = { xi.item.SCHOLARS_BRACERS},  -- 
               [54] = { xi.item.SCHOLARS_LOAFERS},  -- 
               [56] = { xi.item.SCHOLARS_PANTS},  -- 
               [58] = { xi.item.SCHOLARS_GOWN},  -- 
               [60] = { xi.item.SCHOLARS_MORTARBOARD},  -- 
            },
            [21] = -- Geo
            {
               [52] = { xi.item.COBRA_UNIT_HAT},  --
               [54] = { xi.item.COBRA_UNIT_COAT},  --
               [56] = { xi.item.COBRA_UNIT_CUFFS},  --
               [58] = { xi.item.COBRA_UNIT_SLOPS},  --
               [60] = { xi.item.COBRA_UNIT_PIGACHES},  --
            },
            [22] = -- Run
            {
               [52] = { xi.item.COBRA_UNIT_HAT},  --
               [54] = { xi.item.COBRA_UNIT_COAT},  --
               [56] = { xi.item.COBRA_UNIT_CUFFS},  --
               [58] = { xi.item.COBRA_UNIT_SLOPS},  --
               [60] = { xi.item.COBRA_UNIT_PIGACHES},  --
            },
}

m:addOverride('xi.player.onPlayerLevelUp', function(player, option, id)
    local levelMilestones = player:getJobLevel(player:getMainJob()) -- player:getMainLvl()
    local gender = player:getGender()                        -- Female: 0, Male: 1
    local job = player:getMainJob()
    local mlvl = player:getJobLevel(job)
    local sbjob = player:getSubJob()
    local slvl = player:getJobLevel(sbjob)
      --    player:capAllSkills()

            local jobNameByNum = {}
                for k, v in pairs(xi.job) do
                    jobNameByNum[v] = k
                end
  if player:getCharVar('[ParagonQuest]'..jobNameByNum[player:getSubJob()]) == 0 then
    if slvl < 50 then
        if slvl < mlvl then
            if slvl >= mlvl - 5 then
               player:setsLevel(slvl + 1)
               player:printToPlayer(string.format('%s attains sublevel %s', player:getName() , slvl +1),xi.msg.channel.SYSTEM_3)
            end
        end
    end
  end

            if mlvl == 52 or mlvl == 54 or mlvl == 56 or mlvl == 58 or mlvl == 60 then
                local itemData = jobAFTable[job][mlvl]
                local itemId = itemData[1]

               if job == 19 and gender == 0 then
                          if player:getFreeSlotsCount() < 1 then
                             player:printToPlayer('Your inventory is full and the armor has been sent to your delivery box!',xi.msg.channel.SYSTEM_3)
                             SendItemToDeliveryBox(player:getName(), itemId, 1,'LevelDown')
                          else
                             player:printToPlayer(string.format('%s has obtained Artifact Armor as a reward for achieving Level %s.',player:getName(),levelMilestones),xi.msg.channel.SYSTEM_3)
                             npcUtil.giveItem(player, { { itemId +1, 1 } })
                          end
               else
                          if player:getFreeSlotsCount() < 1 then
                             player:printToPlayer('Your inventory is full and the armor has been sent to your delivery box!',xi.msg.channel.SYSTEM_3)
                             SendItemToDeliveryBox(player:getName(), itemId, 1,'LevelDown')
                          else
                             player:printToPlayer(string.format('%s has obtained Artifact Armor as a reward for achieving Level %s.',player:getName(),levelMilestones),xi.msg.channel.SYSTEM_3)
                             npcUtil.giveItem(player, { { itemId, 1 } })
                          end
               end
            end

local buffOff = function(player)
    player:setCharVar('Buff', 0)
    player:setCharVar('BuffLvl', 0)
    player:setCharVar('BuffJob', 0)
local power        = 50
local regainPower  = 25
local refreshPower = 10
local regenPower   = 10
            local jobNameByNum = {}
                for k, v in pairs(xi.job) do
                    jobNameByNum[v] = k
                end
   if player:getCharVar('[ParagonQuest]'..jobNameByNum[player:getMainJob()]) == 10 then
      power        = 35
      regainPower  = 25
      refreshPower = 10
      regenPower   = 10
   elseif player:getCharVar('[ParagonQuest]'..jobNameByNum[player:getMainJob()]) == 20 then
      power        = 25
      regainPower  = 15
      refreshPower = 7
      regenPower   = 7
   elseif player:getCharVar('[ParagonQuest]'..jobNameByNum[player:getMainJob()]) == 30 then
      power        = 15
      regainPower  = 7
      refreshPower = 3
      regenPower   = 3
   end

    player:setCharVar('Buff', 0)
    player:setCharVar('BuffLvl', 0)
    player:setCharVar('BuffJob', 0)
    -- Remove bonus effects..
    player:delStatusEffect(xi.effect.REGAIN)
    player:delStatusEffect(xi.effect.DEDICATION)
    player:delStatusEffect(xi.effect.REFRESH)
    player:delStatusEffect(xi.effect.REGEN)
    -- Remove bonus mods..
    player:delMod(xi.mod.ATT, power)
    player:delMod(xi.mod.RACC, power)
    player:delMod(xi.mod.RATT, power)
    player:delMod(xi.mod.ACC, power)
    player:delMod(xi.mod.MATT, power)
    player:delMod(xi.mod.MACC, power)
    player:delMod(xi.mod.RDEF, power)
    player:delMod(xi.mod.DEF, power)
    player:delMod(xi.mod.MDEF, power)
end

local buffOffCap = function(player)
    player:setCharVar('Buff', 0)
    player:setCharVar('BuffLvl', 0)
    player:setCharVar('BuffJob', 0)
    player:delStatusEffect(xi.effect.COMMITMENT)
end
                      if player:getCharVar('BuffLvl') < player:getMainLvl() and
                         player:getCharVar('Buff') == 1 then
                         player:setCharVar('BuffLvl', player:getMainLvl())
                      end
                      if player:getCharVar('BuffLvl') == 99 and
                         player:getCharVar('Buff') == 1 then
                                player:printToPlayer('Buff disabled.')
                                buffOff(player)
                      end
                      if player:getCharVar('BuffJob') ~= player:getMainJob() and
                         player:getCharVar('Buff') == 1 then
                                player:printToPlayer('Buff disabled.')
                                buffOff(player)
                      end
                      if player:getCharVar('BuffJob') ~= player:getMainJob() and
                         player:getCharVar('Buff') == 2 then
                                player:printToPlayer('Buff disabled.')
                                buffOffCap(player)
                      end



    super(player)
end)
return m
