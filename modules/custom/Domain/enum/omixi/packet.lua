-----------------------------------
-- Animation packet names
-----------------------------------
local m = Module:new("enum_packet")

omixi        = omixi or {}
omixi.packet =
{
    -- PHYSICAL
    ATTACK_1                    = "ati0",
    ATTACK_2                    = "ati1",
    ATTACK_3                    = "ati2",
    CRIT_HIT                    = "chit",
    RANGED_BOW_START            = "lc06",
    RANGED_BOW_STOP             = "ls06",
    RANGED_GUN_START            = "lc03",
    RANGED_GUN_STOP             = "ls03",
    RANGED_BOOMERANG_START      = "lc04",
    RANGED_BOOMERANG_STOP       = "ls04",
    -- MAGIC
    CAST_BLACK_MAGIC_START      = "cabk",
    CAST_BLACK_MAGIC_STOP       = "shbk",
    CAST_WHITE_MAGIC_START      = "cawh",
    CAST_WHITE_MAGIC_STOP       = "shwh",
    CAST_NINJA_START            = "canj",
    CAST_NINJA_STOP             = "shnj",
    CAST_SUMMONER_START         = "casm",
    CAST_SUMMONER_STOP          = "shsm",
    CAST_BLUE_MAGIC_START       = "cabl",
    CAST_BLUE_MAGIC_STOP        = "shbl",
    CAST_SONG_START             = "caso",
    CAST_SONG_STOP              = "shso",
    CAST_SINGING_START          = "lc00",
    CAST_SINGING_STOP           = "ls00",
    CAST_WIND_INSTR_START       = "lc01",
    CAST_WIND_INSTR_STOP        = "ls01",
    CAST_STRING_INSTR_START     = "lc02",
    CAST_STRING_INSTR_STOP      = "ls02",
    -- ACTIONS
    JUMP1                       = "jmp0",
    JUMP2                       = "jmp1",
    RESTING_START               = "res0",
    RESTING_STOP                = "res2",
    SIT_START                   = "sit0",
    SIT_STOP                    = "sit2",
    USE_ITEM_START              = "cait",
    USE_ITEM_STOP               = "shit",
    -- EFFECTS
    EFFECT_DEATH                = "dead",
    EFFECT_RAISE                = "stnd",
    EFFECT_SILENCE              = "sils",
    EFFECT_SWEATING             = "hitl",
    -- STATUS
    VISIBLE                     = "deru",
    DISAPPEAR                   = "kesu",
    OPEN_CRATE                  = "open",
    OPEN_DOOR                   = "smin",
}

return m
