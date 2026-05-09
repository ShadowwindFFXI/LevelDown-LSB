-----------------------------------
-- Player Settings
-----------------------------------
local m = Module:new("enum_setting")

omixi         = omixi or {}
omixi.setting =
{
    -- Reserve 0-3 for future settings eg. language
    EMILIA_SIGNET   = 4,
    SKIP_FURNACE_RP = 5,
    SKIP_VENTURE_RP = 6,
}

omixi.settingVar = "[CHAR]CONFIG"

omixi.hasSetting = function(player, setting)
    local current = player:getCharVar(omixi.settingVar)
    return utils.mask.getBit(current, setting)
end

return m
