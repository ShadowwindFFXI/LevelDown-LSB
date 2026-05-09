-----------------------------------
-- Rates
-----------------------------------
local m = Module:new("enum_rate")

omixi      = omixi or {}
omixi.rate =
{
    GUARANTEED  = 1000, -- 100%
    VERY_COMMON =  240, --  24%
    COMMON      =  150, --  15%
    UNCOMMON    =  100, --  10%
    RARE        =   50, --   5%
    VERY_RARE   =   10, --   1%
    SUPER_RARE  =    5, -- 0.5%
    ULTRA_RARE  =    1, -- 0.1%
}

return m
