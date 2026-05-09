-----------------------------------
-- Update Zalsuhn to require scaling ws points based on nyzul climb (pre 2014)
-- Also update the required WS points for all Vigil weapons latent ability
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('unlocking_a_myth')

xi = xi or {}
xi.equipment = xi.equipment or {}

-- encodes the order for offset calculations in the Unlocking the Myth quests
xi.equipment.baseNyzulWeaponsFull =
{
    [xi.job.WAR] =
    {
        itemId = xi.item.STURDY_AXE, -- (WAR) Sturdy Axe
        wsUnlockId = xi.wsUnlock.KINGS_JUSTICE,
        wsId = xi.weaponskill.KINGS_JUSTICE,
    },
    [xi.job.MNK] =
    {
        itemId = xi.item.BURNING_FISTS, -- (MNK) Burning Fists
        wsUnlockId = xi.wsUnlock.ASCETICS_FURY,
        wsId = xi.weaponskill.ASCETICS_FURY,
    },
    [xi.job.WHM] =
    {
        itemId = xi.item.WEREBUSTER, -- (WHM) Werebuster
        wsUnlockId = xi.wsUnlock.MYSTIC_BOON,
        wsId = xi.weaponskill.MYSTIC_BOON,
    },
    [xi.job.BLM] =
    {
        itemId = xi.item.MAGES_STAFF, -- (BLM) Mage's Staff
        wsUnlockId = xi.wsUnlock.VIDOHUNIR,
        wsId = xi.weaponskill.VIDOHUNIR,
    },
    [xi.job.RDM] =
    {
        itemId = xi.item.VORPAL_SWORD, -- (RDM) Vorpal Sword
        wsUnlockId = xi.wsUnlock.DEATH_BLOSSOM,
        wsId = xi.weaponskill.DEATH_BLOSSOM,
    },
    [xi.job.THF] =
    {
        itemId = xi.item.SWORDBREAKER, -- (THF) Swordbreaker
        wsUnlockId = xi.wsUnlock.MANDALIC_STAB,
        wsId = xi.weaponskill.MANDALIC_STAB,
    },
    [xi.job.PLD] =
    {
        itemId = xi.item.BRAVE_BLADE, -- (PLD) Brave Blade
        wsUnlockId = xi.wsUnlock.ATONEMENT,
        wsId = xi.weaponskill.ATONEMENT,
    },
    [xi.job.DRK] =
    {
        itemId = xi.item.DEATH_SICKLE, -- (DRK) Death Sickle
        wsUnlockId = xi.wsUnlock.INSURGENCY,
        wsId = xi.weaponskill.INSURGENCY,
    },
    [xi.job.BST] =
    {
        itemId = xi.item.DOUBLE_AXE, -- (BST) Double Axe
        wsUnlockId = xi.wsUnlock.PRIMAL_REND,
        wsId = xi.weaponskill.PRIMAL_REND,
    },
    [xi.job.BRD] =
    {
        itemId = xi.item.DANCING_DAGGER, -- (BRD) Dancing Dagger
        wsUnlockId = xi.wsUnlock.MORDANT_RIME,
        wsId = xi.weaponskill.MORDANT_RIME,
    },
    [xi.job.RNG] =
    {
        itemId = xi.item.KILLER_BOW, -- (RNG) Killer Bow
        wsUnlockId = xi.wsUnlock.TRUEFLIGHT,
        wsId = xi.weaponskill.TRUEFLIGHT,
    },
    [xi.job.SAM] =
    {
        itemId = xi.item.WINDSLICER, -- (SAM) Windslicer
        wsUnlockId = xi.wsUnlock.TACHI_RANA,
        wsId = xi.weaponskill.TACHI_RANA,
    },
    [xi.job.NIN] =
    {
        itemId = xi.item.SASUKE_KATANA, -- (NIN) Sasuke Katana
        wsUnlockId = xi.wsUnlock.BLADE_KAMU,
        wsId = xi.weaponskill.BLADE_KAMU,
    },
    [xi.job.DRG] =
    {
        itemId = xi.item.RADIANT_LANCE, -- (DRG) Radiant Lance
        wsUnlockId = xi.wsUnlock.DRAKESBANE,
        wsId = xi.weaponskill.DRAKESBANE,
    },
    [xi.job.SMN] =
    {
        itemId = xi.item.SCEPTER_STAFF, -- (SMN) Scepter Staff
        wsUnlockId = xi.wsUnlock.GARLAND_OF_BLISS,
        wsId = xi.weaponskill.GARLAND_OF_BLISS,
    },
    [xi.job.BLU] =
    {
        itemId = xi.item.WIGHTSLAYER, -- (BLU) Wightslayer
        wsUnlockId = xi.wsUnlock.EXPIACION,
        wsId = xi.weaponskill.EXPIACION,
    },
    [xi.job.COR] =
    {
        itemId = xi.item.QUICKSILVER, -- (COR) Quicksilver
        wsUnlockId = xi.wsUnlock.LEADEN_SALUTE,
        wsId = xi.weaponskill.LEADEN_SALUTE,
    },
    [xi.job.PUP] =
    {
        itemId = xi.item.INFERNO_CLAWS, -- (PUP) Inferno Claws
        wsUnlockId = xi.wsUnlock.STRINGING_PUMMEL,
        wsId = xi.weaponskill.STRINGING_PUMMEL,
    },
    [xi.job.DNC] =
    {
        itemId = xi.item.MAIN_GAUCHE, -- (DNC) Main Gauche
        wsUnlockId = xi.wsUnlock.PYRRHIC_KLEOS,
        wsId = xi.weaponskill.PYRRHIC_KLEOS,
    },
    [xi.job.SCH] =
    {
        itemId = xi.item.ELDER_STAFF,
        wsUnlockId = xi.wsUnlock.OMNISCIENCE,
        wsId = xi.weaponskill.OMNISCIENCE,
    },
}

m:addOverride('xi.equipment.baseNyzulWeaponRequiredWsPoints', function(player)
    local nyzulFloorProgress = player:getCharVar('NyzulFloorProgress')
    if nyzulFloorProgress == 100 then
        return 250
    elseif nyzulFloorProgress >= 80 then
        return 500 + 20 * (99 - nyzulFloorProgress)
    elseif nyzulFloorProgress >= 60 then
        return 1000 + 40 * (79 - nyzulFloorProgress)
    elseif nyzulFloorProgress >= 40 then
        return 2000 + 80 * (59 - nyzulFloorProgress)
    elseif nyzulFloorProgress >= 20 then
        return 4000 + 160 * (39 - nyzulFloorProgress)
    elseif nyzulFloorProgress > 0 then
        return 8000 + 320 * (19 - nyzulFloorProgress)
    else
        return 16000
    end
end)

xi.equipment.baseNyzulTemporarilyUnlockWS = function(player)
    for _, weapon in pairs({ player:getEquippedItem(xi.slot.MAIN), player:getEquippedItem(xi.slot.RANGED) }) do
        local weaponData = xi.equipment.baseNyzulWeaponsFull[player:getMainJob()]
        if
            weaponData and
            weaponData.itemId == weapon:getID() and
            weapon:getMod(xi.mod.ADDS_WEAPONSKILL) ~= weaponData.wsId and
            weapon:getWeaponskillPoints() >= xi.equipment.baseNyzulWeaponRequiredWsPoints(player)
        then
            weapon:addMod(xi.mod.ADDS_WEAPONSKILL, weaponData.wsId)
            player:reloadWeaponskillList()
        end
    end
end

xi.equipment.isBaseNyzulWeapon = function(itemId)
    for _, weaponData in pairs(xi.equipment.baseNyzulWeaponsFull) do
        if itemId == weaponData.itemId then
            return true
        end
    end

    return false
end

return m
