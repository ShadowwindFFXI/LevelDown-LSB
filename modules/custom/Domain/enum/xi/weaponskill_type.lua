-----------------------------------
-- Lookup for weaponskill type
-----------------------------------
local m = Module:new("enum_item")

xi                  = xi or {}
xi.weaponskillTypes =
{
    xi.skill.HAND_TO_HAND,
    xi.skill.DAGGER,
    xi.skill.SWORD,
    xi.skill.GREAT_SWORD,
    xi.skill.AXE,
    xi.skill.GREAT_AXE,
    xi.skill.SCYTHE,
    xi.skill.POLEARM,
    xi.skill.KATANA,
    xi.skill.GREAT_KATANA,
    xi.skill.CLUB,
    xi.skill.STAFF,
    xi.skill.ARCHERY,
    xi.skill.MARKSMANSHIP,
}

xi.weaponskillType  =
{
        -----------------------------------
    -- H2H
    -----------------------------------
    [xi.weaponskill.COMBO]               = xi.skill.HAND_TO_HAND,
    [xi.weaponskill.SHOULDER_TACKLE]     = xi.skill.HAND_TO_HAND,
    [xi.weaponskill.ONE_INCH_PUNCH]      = xi.skill.HAND_TO_HAND,
    [xi.weaponskill.BACKHAND_BLOW]       = xi.skill.HAND_TO_HAND,
    [xi.weaponskill.RAGING_FISTS]        = xi.skill.HAND_TO_HAND,
    [xi.weaponskill.SPINNING_ATTACK]     = xi.skill.HAND_TO_HAND,
    [xi.weaponskill.HOWLING_FIST]        = xi.skill.HAND_TO_HAND,
    [xi.weaponskill.DRAGON_KICK]         = xi.skill.HAND_TO_HAND,
    [xi.weaponskill.ASURAN_FISTS]        = xi.skill.HAND_TO_HAND,
    [xi.weaponskill.FINAL_HEAVEN]        = xi.skill.HAND_TO_HAND,
    [xi.weaponskill.ASCETICS_FURY]       = xi.skill.HAND_TO_HAND,
    [xi.weaponskill.STRINGING_PUMMEL]    = xi.skill.HAND_TO_HAND,
    [xi.weaponskill.TORNADO_KICK]        = xi.skill.HAND_TO_HAND,
    [xi.weaponskill.VICTORY_SMITE]       = xi.skill.HAND_TO_HAND,
    [xi.weaponskill.SHIJIN_SPIRAL]       = xi.skill.HAND_TO_HAND,
    [xi.weaponskill.DRAGON_BLOW]         = xi.skill.HAND_TO_HAND,
    [xi.weaponskill.MARU_KALA]           = xi.skill.HAND_TO_HAND,

    -----------------------------------
    -- DAGGER
    -----------------------------------
    [xi.weaponskill.WASP_STING]          = xi.skill.DAGGER,
    [xi.weaponskill.VIPER_BITE]          = xi.skill.DAGGER,
    [xi.weaponskill.SHADOWSTITCH]        = xi.skill.DAGGER,
    [xi.weaponskill.GUST_SLASH]          = xi.skill.DAGGER,
    [xi.weaponskill.CYCLONE]             = xi.skill.DAGGER,
    [xi.weaponskill.ENERGY_STEAL]        = xi.skill.DAGGER,
    [xi.weaponskill.ENERGY_DRAIN]        = xi.skill.DAGGER,
    [xi.weaponskill.DANCING_EDGE]        = xi.skill.DAGGER,
    [xi.weaponskill.SHARK_BITE]          = xi.skill.DAGGER,
    [xi.weaponskill.EVISCERATION]        = xi.skill.DAGGER,
    [xi.weaponskill.MERCY_STROKE]        = xi.skill.DAGGER,
    [xi.weaponskill.MANDALIC_STAB]       = xi.skill.DAGGER,
    [xi.weaponskill.MORDANT_RIME]        = xi.skill.DAGGER,
    [xi.weaponskill.PYRRHIC_KLEOS]       = xi.skill.DAGGER,
    [xi.weaponskill.AEOLIAN_EDGE]        = xi.skill.DAGGER,
    [xi.weaponskill.RUDRAS_STORM]        = xi.skill.DAGGER,
    [xi.weaponskill.EXENTERATOR]         = xi.skill.DAGGER,
    [xi.weaponskill.MERCILESS_STRIKE]    = xi.skill.DAGGER,

    -----------------------------------
    -- SWORD
    -----------------------------------
    [xi.weaponskill.FAST_BLADE]          = xi.skill.SWORD,
    [xi.weaponskill.BURNING_BLADE]       = xi.skill.SWORD,
    [xi.weaponskill.RED_LOTUS_BLADE]     = xi.skill.SWORD,
    [xi.weaponskill.FLAT_BLADE]          = xi.skill.SWORD,
    [xi.weaponskill.SHINING_BLADE]       = xi.skill.SWORD,
    [xi.weaponskill.SERAPH_BLADE]        = xi.skill.SWORD,
    [xi.weaponskill.CIRCLE_BLADE]        = xi.skill.SWORD,
    [xi.weaponskill.SPIRITS_WITHIN]      = xi.skill.SWORD,
    [xi.weaponskill.VORPAL_BLADE]        = xi.skill.SWORD,
    [xi.weaponskill.SWIFT_BLADE]         = xi.skill.SWORD,
    [xi.weaponskill.SAVAGE_BLADE]        = xi.skill.SWORD,
    [xi.weaponskill.KNIGHTS_OF_ROUND]    = xi.skill.SWORD,
    [xi.weaponskill.DEATH_BLOSSOM]       = xi.skill.SWORD,
    [xi.weaponskill.ATONEMENT]           = xi.skill.SWORD,
    [xi.weaponskill.EXPIACION]           = xi.skill.SWORD,
    [xi.weaponskill.SANGUINE_BLADE]      = xi.skill.SWORD,
    [xi.weaponskill.CHANT_DU_CYGNE]      = xi.skill.SWORD,
    [xi.weaponskill.REQUIESCAT]          = xi.skill.SWORD,
    [xi.weaponskill.KNIGHTS_OF_ROTUND]   = xi.skill.SWORD,
    [xi.weaponskill.FINAL_PARADISE]      = xi.skill.SWORD,
    [xi.weaponskill.FAST_BLADE_II]       = xi.skill.SWORD,
    [xi.weaponskill.IMPERATOR]           = xi.skill.SWORD,
    [xi.weaponskill.URIEL_BLADE]         = xi.skill.SWORD,
    [xi.weaponskill.GLORY_SLASH]         = xi.skill.SWORD,

    -----------------------------------
    -- GREAT SWORD
    -----------------------------------
    [xi.weaponskill.HARD_SLASH]          = xi.skill.GREAT_SWORD,
    [xi.weaponskill.POWER_SLASH]         = xi.skill.GREAT_SWORD,
    [xi.weaponskill.FROSTBITE]           = xi.skill.GREAT_SWORD,
    [xi.weaponskill.FREEZEBITE]          = xi.skill.GREAT_SWORD,
    [xi.weaponskill.SHOCKWAVE]           = xi.skill.GREAT_SWORD,
    [xi.weaponskill.CRESCENT_MOON]       = xi.skill.GREAT_SWORD,
    [xi.weaponskill.SICKLE_MOON]         = xi.skill.GREAT_SWORD,
    [xi.weaponskill.SPINNING_SLASH]      = xi.skill.GREAT_SWORD,
    [xi.weaponskill.GROUND_STRIKE]       = xi.skill.GREAT_SWORD,
    [xi.weaponskill.SCOURGE]             = xi.skill.GREAT_SWORD,
    [xi.weaponskill.HERCULEAN_SLASH]     = xi.skill.GREAT_SWORD,
    [xi.weaponskill.TORCLEAVER]          = xi.skill.GREAT_SWORD,
    [xi.weaponskill.RESOLUTION]          = xi.skill.GREAT_SWORD,
    [xi.weaponskill.DIMIDIATION]         = xi.skill.GREAT_SWORD,
    [xi.weaponskill.FIMBULVETR]          = xi.skill.GREAT_SWORD,

    -----------------------------------
    -- AXE
    -----------------------------------
    [xi.weaponskill.RAGING_AXE]          = xi.skill.AXE,
    [xi.weaponskill.SMASH_AXE]           = xi.skill.AXE,
    [xi.weaponskill.GALE_AXE]            = xi.skill.AXE,
    [xi.weaponskill.AVALANCHE_AXE]       = xi.skill.AXE,
    [xi.weaponskill.SPINNING_AXE]        = xi.skill.AXE,
    [xi.weaponskill.RAMPAGE]             = xi.skill.AXE,
    [xi.weaponskill.CALAMITY]            = xi.skill.AXE,
    [xi.weaponskill.MISTRAL_AXE]         = xi.skill.AXE,
    [xi.weaponskill.DECIMATION]          = xi.skill.AXE,
    [xi.weaponskill.ONSLAUGHT]           = xi.skill.AXE,
    [xi.weaponskill.PRIMAL_REND]         = xi.skill.AXE,
    [xi.weaponskill.BORA_AXE]            = xi.skill.AXE,
    [xi.weaponskill.CLOUDSPLITTER]       = xi.skill.AXE,
    [xi.weaponskill.RUINATOR]            = xi.skill.AXE,
    [xi.weaponskill.BLITZ]               = xi.skill.AXE,

    -----------------------------------
    -- GREAT AXE
    -----------------------------------
    [xi.weaponskill.SHIELD_BREAK]        = xi.skill.GREAT_AXE,
    [xi.weaponskill.IRON_TEMPEST]        = xi.skill.GREAT_AXE,
    [xi.weaponskill.STURMWIND]           = xi.skill.GREAT_AXE,
    [xi.weaponskill.ARMOR_BREAK]         = xi.skill.GREAT_AXE,
    [xi.weaponskill.KEEN_EDGE]           = xi.skill.GREAT_AXE,
    [xi.weaponskill.WEAPON_BREAK]        = xi.skill.GREAT_AXE,
    [xi.weaponskill.RAGING_RUSH]         = xi.skill.GREAT_AXE,
    [xi.weaponskill.FULL_BREAK]          = xi.skill.GREAT_AXE,
    [xi.weaponskill.STEEL_CYCLONE]       = xi.skill.GREAT_AXE,
    [xi.weaponskill.METATRON_TORMENT]    = xi.skill.GREAT_AXE,
    [xi.weaponskill.KINGS_JUSTICE]       = xi.skill.GREAT_AXE,
    [xi.weaponskill.FELL_CLEAVE]         = xi.skill.GREAT_AXE,
    [xi.weaponskill.UKKOS_FURY]          = xi.skill.GREAT_AXE,
    [xi.weaponskill.UPHEAVAL]            = xi.skill.GREAT_AXE,
    [xi.weaponskill.DISASTER]            = xi.skill.GREAT_AXE,

    -----------------------------------
    -- SCYTHE
    -----------------------------------
    [xi.weaponskill.SLICE]               = xi.skill.SCYTHE,
    [xi.weaponskill.DARK_HARVEST]        = xi.skill.SCYTHE,
    [xi.weaponskill.SHADOW_OF_DEATH]     = xi.skill.SCYTHE,
    [xi.weaponskill.NIGHTMARE_SCYTHE]    = xi.skill.SCYTHE,
    [xi.weaponskill.SPINNING_SCYTHE]     = xi.skill.SCYTHE,
    [xi.weaponskill.VORPAL_SCYTHE]       = xi.skill.SCYTHE,
    [xi.weaponskill.GUILLOTINE]          = xi.skill.SCYTHE,
    [xi.weaponskill.CROSS_REAPER]        = xi.skill.SCYTHE,
    [xi.weaponskill.SPIRAL_HELL]         = xi.skill.SCYTHE,
    [xi.weaponskill.CATASTROPHE]         = xi.skill.SCYTHE,
    [xi.weaponskill.INSURGENCY]          = xi.skill.SCYTHE,
    [xi.weaponskill.INFERNAL_SCYTHE]     = xi.skill.SCYTHE,
    [xi.weaponskill.QUIETUS]             = xi.skill.SCYTHE,
    [xi.weaponskill.ENTROPY]             = xi.skill.SCYTHE,
    [xi.weaponskill.ORIGIN]              = xi.skill.SCYTHE,

    -----------------------------------
    -- POLEARM
    -----------------------------------
    [xi.weaponskill.DOUBLE_THRUST]       = xi.skill.POLEARM,
    [xi.weaponskill.THUNDER_THRUST]      = xi.skill.POLEARM,
    [xi.weaponskill.RAIDEN_THRUST]       = xi.skill.POLEARM,
    [xi.weaponskill.LEG_SWEEP]           = xi.skill.POLEARM,
    [xi.weaponskill.PENTA_THRUST]        = xi.skill.POLEARM,
    [xi.weaponskill.VORPAL_THRUST]       = xi.skill.POLEARM,
    [xi.weaponskill.SKEWER]              = xi.skill.POLEARM,
    [xi.weaponskill.WHEELING_THRUST]     = xi.skill.POLEARM,
    [xi.weaponskill.IMPULSE_DRIVE]       = xi.skill.POLEARM,
    [xi.weaponskill.GEIRSKOGUL]          = xi.skill.POLEARM,
    [xi.weaponskill.DRAKESBANE]          = xi.skill.POLEARM,
    [xi.weaponskill.SONIC_THRUST]        = xi.skill.POLEARM,
    [xi.weaponskill.CAMLANNS_TORMENT]    = xi.skill.POLEARM,
    [xi.weaponskill.STARDIVER]           = xi.skill.POLEARM,
    [xi.weaponskill.DIARMUID]            = xi.skill.POLEARM,

    -----------------------------------
    -- KATANA
    -----------------------------------
    [xi.weaponskill.BLADE_RIN]           = xi.skill.KATANA,
    [xi.weaponskill.BLADE_RETSU]         = xi.skill.KATANA,
    [xi.weaponskill.BLADE_TEKI]          = xi.skill.KATANA,
    [xi.weaponskill.BLADE_TO]            = xi.skill.KATANA,
    [xi.weaponskill.BLADE_CHI]           = xi.skill.KATANA,
    [xi.weaponskill.BLADE_EI]            = xi.skill.KATANA,
    [xi.weaponskill.BLADE_JIN]           = xi.skill.KATANA,
    [xi.weaponskill.BLADE_TEN]           = xi.skill.KATANA,
    [xi.weaponskill.BLADE_KU]            = xi.skill.KATANA,
    [xi.weaponskill.BLADE_METSU]         = xi.skill.KATANA,
    [xi.weaponskill.BLADE_KAMU]          = xi.skill.KATANA,
    [xi.weaponskill.BLADE_YU]            = xi.skill.KATANA,
    [xi.weaponskill.BLADE_HI]            = xi.skill.KATANA,
    [xi.weaponskill.BLADE_SHUN]          = xi.skill.KATANA,
    [xi.weaponskill.JIJIN_KAIMETSU]      = xi.skill.KATANA,

    -----------------------------------
    -- GREAT KATANA
    -----------------------------------
    [xi.weaponskill.TACHI_ENPI]          = xi.skill.GREAT_KATANA,
    [xi.weaponskill.TACHI_HOBAKU]        = xi.skill.GREAT_KATANA,
    [xi.weaponskill.TACHI_GOTEN]         = xi.skill.GREAT_KATANA,
    [xi.weaponskill.TACHI_KAGERO]        = xi.skill.GREAT_KATANA,
    [xi.weaponskill.TACHI_JINPU]         = xi.skill.GREAT_KATANA,
    [xi.weaponskill.TACHI_KOKI]          = xi.skill.GREAT_KATANA,
    [xi.weaponskill.TACHI_YUKIKAZE]      = xi.skill.GREAT_KATANA,
    [xi.weaponskill.TACHI_GEKKO]         = xi.skill.GREAT_KATANA,
    [xi.weaponskill.TACHI_KASHA]         = xi.skill.GREAT_KATANA,
    [xi.weaponskill.TACHI_KAITEN]        = xi.skill.GREAT_KATANA,
    [xi.weaponskill.TACHI_RANA]          = xi.skill.GREAT_KATANA,
    [xi.weaponskill.TACHI_AGEHA]         = xi.skill.GREAT_KATANA,
    [xi.weaponskill.TACHI_FUDO]          = xi.skill.GREAT_KATANA,
    [xi.weaponskill.TACHI_SHOHA]         = xi.skill.GREAT_KATANA,
    [xi.weaponskill.TACHI_SUIKAWARI]     = xi.skill.GREAT_KATANA,
    [xi.weaponskill.TACHI_MUMEI]         = xi.skill.GREAT_KATANA,

    -----------------------------------
    -- CLUB
    -----------------------------------
    [xi.weaponskill.SHINING_STRIKE]      = xi.skill.CLUB,
    [xi.weaponskill.SERAPH_STRIKE]       = xi.skill.CLUB,
    [xi.weaponskill.BRAINSHAKER]         = xi.skill.CLUB,
    [xi.weaponskill.STARLIGHT]           = xi.skill.CLUB,
    [xi.weaponskill.MOONLIGHT]           = xi.skill.CLUB,
    [xi.weaponskill.SKULLBREAKER]        = xi.skill.CLUB,
    [xi.weaponskill.TRUE_STRIKE]         = xi.skill.CLUB,
    [xi.weaponskill.JUDGMENT]            = xi.skill.CLUB,
    [xi.weaponskill.HEXA_STRIKE]         = xi.skill.CLUB,
    [xi.weaponskill.BLACK_HALO]          = xi.skill.CLUB,
    [xi.weaponskill.RANDGRITH]           = xi.skill.CLUB,
    [xi.weaponskill.MYSTIC_BOON]         = xi.skill.CLUB,
    [xi.weaponskill.FLASH_NOVA]          = xi.skill.CLUB,
    [xi.weaponskill.DAGAN]               = xi.skill.CLUB,
    [xi.weaponskill.REALMRAZER]          = xi.skill.CLUB,
    [xi.weaponskill.EXUDATION]           = xi.skill.CLUB,
    [xi.weaponskill.DAGDA]               = xi.skill.CLUB,

    -----------------------------------
    -- STAFF
    -----------------------------------
    [xi.weaponskill.HEAVY_SWING]         = xi.skill.STAFF,
    [xi.weaponskill.ROCK_CRUSHER]        = xi.skill.STAFF,
    [xi.weaponskill.EARTH_CRUSHER]       = xi.skill.STAFF,
    [xi.weaponskill.STARBURST]           = xi.skill.STAFF,
    [xi.weaponskill.SUNBURST]            = xi.skill.STAFF,
    [xi.weaponskill.SHELL_CRUSHER]       = xi.skill.STAFF,
    [xi.weaponskill.FULL_SWING]          = xi.skill.STAFF,
    [xi.weaponskill.SPIRIT_TAKER]        = xi.skill.STAFF,
    [xi.weaponskill.RETRIBUTION]         = xi.skill.STAFF,
    [xi.weaponskill.GATE_OF_TARTARUS]    = xi.skill.STAFF,
    [xi.weaponskill.VIDOHUNIR]           = xi.skill.STAFF,
    [xi.weaponskill.GARLAND_OF_BLISS]    = xi.skill.STAFF,
    [xi.weaponskill.OMNISCIENCE]         = xi.skill.STAFF,
    [xi.weaponskill.CATACLYSM]           = xi.skill.STAFF,
    [xi.weaponskill.MYRKR]               = xi.skill.STAFF,
    [xi.weaponskill.SHATTERSOUL]         = xi.skill.STAFF,
    [xi.weaponskill.OSHALA]              = xi.skill.STAFF,
    [xi.weaponskill.TARTARUS_TORPOR]     = xi.skill.STAFF,

    -----------------------------------
    -- ARCHERY
    -----------------------------------
    [xi.weaponskill.FLAMING_ARROW]       = xi.skill.ARCHERY,
    [xi.weaponskill.PIERCING_ARROW]      = xi.skill.ARCHERY,
    [xi.weaponskill.DULLING_ARROW]       = xi.skill.ARCHERY,
    [xi.weaponskill.SIDEWINDER]          = xi.skill.ARCHERY,
    [xi.weaponskill.BLAST_ARROW]         = xi.skill.ARCHERY,
    [xi.weaponskill.ARCHING_ARROW]       = xi.skill.ARCHERY,
    [xi.weaponskill.EMPYREAL_ARROW]      = xi.skill.ARCHERY,
    [xi.weaponskill.NAMAS_ARROW]         = xi.skill.ARCHERY,
    [xi.weaponskill.REFULGENT_ARROW]     = xi.skill.ARCHERY,
    [xi.weaponskill.JISHNUS_RADIANCE]    = xi.skill.ARCHERY,
    [xi.weaponskill.APEX_ARROW]          = xi.skill.ARCHERY,
    [xi.weaponskill.SARV]                = xi.skill.ARCHERY,

    -----------------------------------
    -- MARKSMANSHIP
    -----------------------------------
    [xi.weaponskill.HOT_SHOT]            = xi.skill.MARKSMANSHIP,
    [xi.weaponskill.SPLIT_SHOT]          = xi.skill.MARKSMANSHIP,
    [xi.weaponskill.SNIPER_SHOT]         = xi.skill.MARKSMANSHIP,
    [xi.weaponskill.SLUG_SHOT]           = xi.skill.MARKSMANSHIP,
    [xi.weaponskill.BLAST_SHOT]          = xi.skill.MARKSMANSHIP,
    [xi.weaponskill.HEAVY_SHOT]          = xi.skill.MARKSMANSHIP,
    [xi.weaponskill.DETONATOR]           = xi.skill.MARKSMANSHIP,
    [xi.weaponskill.CORONACH]            = xi.skill.MARKSMANSHIP,
    [xi.weaponskill.TRUEFLIGHT]          = xi.skill.MARKSMANSHIP,
    [xi.weaponskill.LEADEN_SALUTE]       = xi.skill.MARKSMANSHIP,
    [xi.weaponskill.NUMBING_SHOT]        = xi.skill.MARKSMANSHIP,
    [xi.weaponskill.WILDFIRE]            = xi.skill.MARKSMANSHIP,
    [xi.weaponskill.LAST_STAND]          = xi.skill.MARKSMANSHIP,
    [xi.weaponskill.TERMINUS]            = xi.skill.MARKSMANSHIP,
}

return m