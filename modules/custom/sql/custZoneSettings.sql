
UPDATE zone_settings SET misc = 2206 WHERE zoneid = 218;
UPDATE zone_settings SET misc = 2206 WHERE zoneid = 215;
UPDATE zone_settings SET misc = 2206 WHERE zoneid = 254;
UPDATE zone_settings SET misc = 2206 WHERE zoneid =  15;
UPDATE zone_settings SET misc = 2206 WHERE zoneid = 132;
UPDATE zone_settings SET misc = 2206 WHERE zoneid = 216;
UPDATE zone_settings SET misc = 2206 WHERE zoneid =  45;
UPDATE zone_settings SET misc = 2206 WHERE zoneid = 253;
UPDATE zone_settings SET misc = 2206 WHERE zoneid = 217;
UPDATE zone_settings SET misc = 5736 WHERE zoneid = 280;
UPDATE zone_settings SET misc = 2712 WHERE zoneid =  298;

--Allows Mounts in Escha zones
UPDATE `zone_settings` SET `misc`=2716 WHERE `zoneid`=288; -- Escha Zi'Tah
UPDATE `zone_settings` SET `misc`=2716 WHERE `zoneid`=289; -- Escha Ru'Aun
UPDATE `zone_settings` SET `misc`=2716 WHERE `zoneid`=291; -- Reisenjima

--Potential fix for Outer_RaKazner [U1] to show mobskills?
UPDATE `zone_settings` SET `misc`= 6809 WHERE `zoneid`= 275; -- misc was 2714 
