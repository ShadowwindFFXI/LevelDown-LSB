-- Hervor Galea (23738)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES 
(23738, 1, 113), (23738, 2, 54), (23738, 8, 19), (23738, 9, 19), (23738, 10, 19), (23738, 11, 19), (23738, 12, 19), (23738, 13, 19), (23738, 14, 19), (23738, 25, 25), (23738, 30, 15), (23738, 68, 49), (23738, 31, 75), (23738, 29, 3), (23738, 384, 800);

-- Hervor Haubert (23741)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES 
(23741, 1, 143), (23741, 2, 77), (23741, 8, 28), (23741, 9, 26), (23741, 10, 28), (23741, 11, 25), (23741, 12, 25), (23741, 13, 25), (23741, 14, 25), (23741, 25, 25), (23741, 30, 15), (23741, 68, 58), (23741, 31, 86), (23741, 29, 6), (23741, 384, 400);

-- Hervor Mouffles (23744)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES 
(23744, 1, 101), (23744, 2, 43), (23744, 8, 12), (23744, 9, 34), (23744, 10, 34), (23744, 11, 8), (23744, 12, 16), (23744, 13, 32), (23744, 14, 21), (23744, 25, 25), (23744, 30, 15), (23744, 68, 63), (23744, 31, 59), (23744, 29, 3), (23744, 384, 500);

-- Hervor Brayettes (23747)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES 
(23747, 1, 125), (23747, 2, 66), (23747, 8, 33), (23747, 10, 20), (23747, 11, 20), (23747, 12, 32), (23747, 13, 19), (23747, 14, 19), (23747, 25, 25), (23747, 30, 15), (23747, 68, 41), (23747, 31, 91), (23747, 29, 4), (23747, 384, 600);

-- Hervor Sollerets (23750)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES 
(23750, 1, 83), (23750, 2, 31), (23750, 8, 16), (23750, 9, 19), (23750, 10, 17), (23750, 11, 35), (23750, 13, 14), (23750, 14, 30), (23750, 25, 25), (23750, 30, 15), (23750, 68, 63), (23750, 31, 91), (23750, 29, 4), (23750, 384, 400);

-- Common Core Stats for all pieces (STR+30, DEX/VIT/AGI/INT/MND/CHR +20)
-- Mods: 8, 9, 10, 11, 12, 13, 14
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) 
SELECT itemid, 8, 30, 13, 603 FROM item_equipment WHERE itemid IN (23738, 23741, 23744, 23747, 23750);
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) 
SELECT itemid, m, 20, 13, 603 FROM item_equipment, (SELECT 9 AS m UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14) mods WHERE itemid IN (23738, 23741, 23744, 23747, 23750);

-- Unique Piece Latents
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) VALUES 
(23738, 170, 50, 13, 603),   -- Galea: Fast Cast +50% (Mod 170)
(23741, 160, -5000, 13, 603),-- Haubert: DT -50% (Mod 160)
(23744, 73, 50, 13, 603),    -- Mouffles: Store TP +50 (Mod 73)
(23747, 289, 50, 13, 603),   -- Brayettes: Subtle Blow II +50 (Mod 289)
(23750, 840, 50, 13, 603);   -- Sollerets: WS Damage +50% (Mod 840)

-- Heidrek Mask (23739)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES 
(23739, 1, 101), (23739, 2, 45), (23739, 5, 41), (23739, 8, 16), (23739, 9, 21), (23739, 10, 16), (23739, 11, 20), (23739, 12, 16), (23739, 13, 16), (23739, 14, 16), (23739, 25, 20), (23739, 26, 20), (23739, 30, 20), (23739, 68, 60), (23739, 31, 80), (23739, 29, 4), (23739, 384, 800);

-- Heidrek Harness (23742)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES 
(23742, 1, 131), (23742, 2, 68), (23742, 5, 61), (23742, 8, 26), (23742, 9, 33), (23742, 10, 26), (23742, 11, 30), (23742, 12, 25), (23742, 13, 25), (23742, 14, 25), (23742, 25, 20), (23742, 26, 20), (23742, 30, 20), (23742, 68, 69), (23742, 31, 91), (23742, 29, 7), (23742, 384, 400);

-- Heidrek Gloves (23745)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES 
(23745, 1, 89), (23745, 2, 34), (23745, 8, 14), (23745, 9, 38), (23745, 10, 34), (23745, 11, 8), (23745, 12, 15), (23745, 13, 33), (23745, 14, 21), (23745, 25, 20), (23745, 26, 20), (23745, 30, 20), (23745, 68, 74), (23745, 31, 64), (23745, 29, 4), (23745, 384, 500);

-- Heidrek Brais (23748)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES 
(23748, 1, 113), (23748, 2, 57), (23748, 8, 30), (23748, 10, 19), (23748, 11, 21), (23748, 12, 32), (23748, 13, 19), (23748, 14, 12), (23748, 25, 20), (23748, 26, 20), (23748, 30, 20), (23748, 68, 52), (23748, 31, 96), (23748, 29, 5), (23748, 384, 600);

-- Heidrek Boots (23751)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES 
(23751, 1, 71), (23751, 2, 22), (23751, 8, 14), (23751, 9, 25), (23751, 10, 14), (23751, 11, 38), (23751, 13, 14), (23751, 14, 32), (23751, 25, 20), (23751, 26, 20), (23751, 30, 20), (23751, 68, 74), (23751, 31, 96), (23751, 29, 5), (23751, 384, 400);

-- Heidrek Common Stat Bonuses: (DEX/AGI/CHR +30, STR/VIT/INT/MND +20)
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) 
SELECT itemid, m, 30, 13, 603 FROM item_equipment, (SELECT 9 AS m UNION SELECT 11 UNION SELECT 14) mods WHERE itemid IN (23739, 23742, 23745, 23748, 23751);
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) 
SELECT itemid, m, 20, 13, 603 FROM item_equipment, (SELECT 8 AS m UNION SELECT 10 UNION SELECT 12 UNION SELECT 13) mods WHERE itemid IN (23739, 23742, 23745, 23748, 23751);

-- Unique Piece Latents
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) VALUES 
(23739, 170, 50, 13, 603),   -- Mask: Fast Cast +50%
(23742, 160, -5000, 13, 603),-- Harness: DT -50%
(23745, 73, 50, 13, 603),    -- Gloves: Store TP +50
(23748, 289, 50, 13, 603),   -- Brais: Subtle Blow II +50
(23751, 840, 50, 13, 603);   -- Boots: WS Damage +50%

-- Angantyr Beret (23740)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES 
(23740, 1, 95), (23740, 2, 41), (23740, 5, 53), (23740, 8, 15), (23740, 9, 15), (23740, 10, 15), (23740, 11, 15), (23740, 12, 21), (23740, 13, 21), (23740, 14, 21), (23740, 25, 15), (23740, 30, 25), (23740, 68, 44), (23740, 31, 102), (23740, 29, 5), (23740, 384, 600);

-- Angantyr Robe (23743)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES 
(23743, 1, 125), (23743, 2, 59), (23743, 5, 79), (23743, 8, 24), (23743, 9, 24), (23743, 10, 24), (23743, 11, 24), (23743, 12, 32), (23743, 13, 32), (23743, 14, 32), (23743, 25, 15), (23743, 30, 25), (23743, 68, 52), (23743, 31, 107), (23743, 29, 8), (23743, 384, 300);

-- Angantyr Mittens (23746)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES 
(23746, 1, 83), (23746, 2, 27), (23746, 5, 35), (23746, 8, 7), (23746, 9, 29), (23746, 10, 26), (23746, 11, 6), (23746, 12, 20), (23746, 13, 35), (23746, 14, 20), (23746, 25, 15), (23746, 30, 25), (23746, 68, 58), (23746, 31, 59), (23746, 29, 5), (23746, 384, 300);

-- Angantyr Tights (23749)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES 
(23749, 1, 107), (23749, 2, 47), (23749, 5, 50), (23749, 8, 26), (23749, 10, 14), (23749, 11, 19), (23749, 12, 37), (23749, 13, 26), (23749, 14, 20), (23749, 25, 15), (23749, 30, 25), (23749, 68, 36), (23749, 31, 134), (23749, 29, 6), (23749, 384, 500);

-- Angantyr Boots (23752)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES 
(23752, 1, 65), (23752, 2, 18), (23752, 5, 32), (23752, 8, 11), (23752, 9, 12), (23752, 10, 11), (23752, 11, 35), (23752, 12, 19), (23752, 13, 20), (23752, 14, 37), (23752, 25, 15), (23752, 30, 25), (23752, 68, 58), (23752, 31, 134), (23752, 29, 6), (23752, 384, 300);

-- Angantyr Common Stat Bonuses: (INT/MND/CHR +30, STR/DEX/VIT/AGI +20)
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) 
SELECT itemid, m, 30, 13, 603 FROM item_equipment, (SELECT 12 AS m UNION SELECT 13 UNION SELECT 14) mods WHERE itemid IN (23740, 23743, 23746, 23749, 23752);
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) 
SELECT itemid, m, 20, 13, 603 FROM item_equipment, (SELECT 8 AS m UNION SELECT 9 UNION SELECT 10 UNION SELECT 11) mods WHERE itemid IN (23740, 23743, 23746, 23749, 23752);

-- Unique Piece Latents
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) VALUES 
(23740, 170, 50, 13, 603),   -- Beret: Fast Cast +50%
(23743, 160, -5000, 13, 603),-- Robe: DT -50%
(23746, 73, 50, 13, 603),    -- Mittens: Store TP +50
(23749, 289, 50, 13, 603),   -- Tights: Subtle Blow II +50
(23752, 28, 50, 13, 603);    -- Boots: Magic Atk. Bonus +50 (Mod 28)

-- WEAPONS VOLUSPA
-- Voluspa Knuckles (21510)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (21510, 25, 40), (21510, 30, 40);
-- Voluspa Knife (21566)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (21566, 25, 40), (21566, 30, 40);
-- Voluspa Sword (21622)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (21622, 25, 40), (21622, 30, 40);
-- Voluspa Blade (21665)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (21665, 25, 40), (21665, 30, 40);
-- Voluspa Axe (21712)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (21712, 25, 40), (21712, 30, 40);
-- Voluspa Chopper (21769)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (21769, 25, 40), (21769, 30, 40);
-- Voluspa Scythe (21822)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (21822, 25, 40), (21822, 30, 40);
-- Voluspa Lance (21864)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (21864, 25, 40), (21864, 30, 40);
-- Voluspa Katana (21912)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (21912, 25, 40), (21912, 30, 40);
-- Voluspa Tachi (21976)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (21976, 25, 40), (21976, 30, 40);
-- Voluspa Hammer (22006)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (22006, 25, 40), (22006, 30, 40);
-- Voluspa Pole (22088)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (22088, 25, 40), (22088, 30, 40);
-- Voluspa Bow & Gun (22133, 22144)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (22133, 25, 40), (22133, 26, 40), (22133, 30, 40);
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (22144, 25, 40), (22144, 26, 40), (22144, 30, 40);

-- Target IDs for Voluspa Melee Weapons (21510 - 22088)
-- Knuckles: DMG+86, Acc/Atk/MAcc+120, DA+30%
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) VALUES (21510, 287, 86, 13, 603), (21510, 25, 120, 13, 603), (21510, 23, 120, 13, 603), (21510, 30, 120, 13, 603), (21510, 288, 30, 13, 603);

-- Knife: DMG+48, Acc/Atk/MAcc+80, Crit+30%
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) VALUES (21566, 287, 48, 13, 603), (21566, 25, 80, 13, 603), (21566, 23, 80, 13, 603), (21566, 30, 80, 13, 603), (21566, 165, 30, 13, 603);

-- Sword: DMG+58, Acc/Atk/MAcc+80, Store TP+30
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) VALUES (21622, 287, 58, 13, 603), (21622, 25, 80, 13, 603), (21622, 23, 80, 13, 603), (21622, 30, 80, 13, 603), (21622, 73, 30, 13, 603);

-- Blade (G.Sword): DMG+120, Acc/Atk/MAcc+80, PDT II-30% (Mod 161)
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) VALUES (21665, 287, 120, 13, 603), (21665, 25, 80, 13, 603), (21665, 23, 80, 13, 603), (21665, 30, 80, 13, 603), (21665, 161, -30, 13, 603);

-- Axe / Lance: DMG bonus, Acc/Atk/MAcc+80, Double Attack+30%
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) VALUES (21712, 287, 78, 13, 603), (21864, 287, 123, 13, 603);
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) SELECT itemid, m, 80, 13, 603 FROM item_equipment, (SELECT 25 AS m UNION SELECT 23 UNION SELECT 30) mods WHERE itemid IN (21712, 21864);
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) SELECT itemid, 288, 30, 13, 603 FROM item_equipment WHERE itemid IN (21712, 21864);

-- Katana: DMG+57, Acc/Atk/RAcc/MAcc+80, Triple Attack+30%
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) VALUES (21912, 287, 57, 13, 603), (21912, 25, 80, 13, 603), (21912, 23, 80, 13, 603), (21912, 26, 80, 13, 603), (21912, 30, 80, 13, 603), (21912, 302, 30, 13, 603);

-- Chopper / Tachi: DMG bonus, Acc/Atk/MAcc+80, WSD+30%
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) VALUES (21769, 287, 126, 13, 603), (21976, 287, 113, 13, 603);
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) SELECT itemid, m, 80, 13, 603 FROM item_equipment, (SELECT 25 AS m UNION SELECT 23 UNION SELECT 30) mods WHERE itemid IN (21769, 21976);
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) SELECT itemid, 840, 30, 13, 603 FROM item_equipment WHERE itemid IN (21769, 21976);

-- Hammer (Club): DMG+85, Acc/MAcc+80, MAB+80, PDT II-30%
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) VALUES (22006, 287, 85, 13, 603), (22006, 25, 80, 13, 603), (22006, 30, 80, 13, 603), (22006, 28, 80, 13, 603), (22006, 161, -30, 13, 603);

-- Pole (Staff): DMG+101, Acc/MAcc+80, MAB+80, Pet: Acc/RAcc/Atk/RAtk +120
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) VALUES (22088, 287, 101, 13, 603), (22088, 25, 80, 13, 603), (22088, 30, 80, 13, 603), (22088, 28, 80, 13, 603);
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) SELECT 22088, m, 120, 13, 603 FROM (SELECT 25 AS m UNION SELECT 26 UNION SELECT 23 UNION SELECT 24) mods; -- Pet portion assuming isPet check is handled in core or these are direct mods.

-- Ranged (Bow/Gun): DMG bonus, RAcc/RAtk +100, WSD or Store TP
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) VALUES (22133, 376, 94, 13, 603), (22133, 26, 100, 13, 603), (22133, 24, 100, 13, 603), (22133, 840, 30, 13, 603);
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) VALUES (22144, 376, 53, 13, 603), (22144, 26, 100, 13, 603), (22144, 24, 100, 13, 603), (22144, 73, 30, 13, 603);

-- Voluspa Grip (22219): Acc/Atk/MAcc+80, MAB+50, Store TP+30
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) VALUES (22219, 25, 80, 13, 603), (22219, 23, 80, 13, 603), (22219, 30, 80, 13, 603), (22219, 28, 50, 13, 603), (22219, 73, 30, 13, 603);

-- Voluspa Shield (Assuming ID 22218 or similar based on your range)
-- Permanent DEF 40, Shield Skill +112
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (22218, 1, 40);
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (22218, 109, 112);

-- Shield Latents: Block+30, WSD+30%, MDT II-40% (Effect 603)
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) VALUES (22218, 518, 30, 13, 603);
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) VALUES (22218, 840, 30, 13, 603);
REPLACE INTO `item_latents` (`itemid`, `modid`, `value`, `latentid`, `latentparam`) VALUES (22218, 163, -40, 13, 603);

-- Date Shuriken Pouch (ID 22296)
-- DEX+5, AGI+5, Acc+5, RAcc+5, Eva+5, Enmity+3
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (22296, 9, 5);
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (22296, 11, 5);
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (22296, 25, 5);
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (22296, 26, 5);
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (22296, 68, 5);
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (22296, 27, 3);

-- Voluspa Arrow (22289)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (22289, 26, 20);
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (22289, 24, 20);

-- Voluspa Bolt (22290)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (22290, 26, 20);
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (22290, 24, 20);

-- Voluspa Bullet (22291)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (22291, 26, 20);
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (22291, 24, 20);

-- Hammerfists (20519) - MNK
-- Stats: HP+150, Accuracy+10, Attack+10, Martial Arts+5, Counter+3
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (20519, 2, 150), (20519, 25, 10), (20519, 23, 10), (20519, 173, 5), (20519, 291, 3);

-- Instigator (20845) - WAR
-- Stats: Attack+15, Store TP+6
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (20845, 23, 15), (20845, 73, 6);

-- Queller Rod (21084) - WHM
-- Stats: INT+6, MND+6, Magic Accuracy+15, Magic Atk. Bonus+16, Enmity-10, Refresh+1
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (21084, 12, 6), (21084, 13, 6), (21084, 30, 15), (21084, 28, 16), (21084, 27, -10), (21084, 369, 1);

-- Lathi (21151) - BLM
-- Stats: INT+12, MND+12, Magic Atk. Bonus+48, Enmity-10, Refresh+1
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (21151, 12, 12), (21151, 13, 12), (21151, 28, 48), (21151, 27, -10), (21151, 369, 1);

-- Emissary (20702) - RDM
-- Stats: Accuracy+15, Magic Atk. Bonus+14, Fast Cast+10, PDT-3%
-- Note: PDT -3% is -300 if your server uses a 100x multiplier.
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (20702, 25, 15), (20702, 28, 14), (20702, 170, 10), (20702, 161, -300);

-- Shijo (20598) - THF
-- Stats: Accuracy+10, Attack+10, Evasion+22, Critical Hit Rate+4%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (20598, 25, 10), (20598, 23, 10), (20598, 68, 22), (20598, 165, 4);

-- Nixxer (20700) - PLD
-- Stats: Accuracy+10, Attack+10, PDT-6%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (20700, 25, 10), (20700, 23, 10), (20700, 161, -600);

-- Deathbane (20892) - DRK
-- Stats: Attack+20, Double Attack+4%, Store TP+3, WS Damage+5%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (20892, 23, 20), (20892, 288, 4), (20892, 73, 3), (20892, 840, 5);

-- Kali (20599) - BRD
-- Stats: Accuracy+10, Magic Accuracy+10, Magic Atk. Bonus+14, Singing Skill+10, Fast Cast+7%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (20599, 25, 10), (20599, 30, 10), (20599, 28, 14), (20599, 119, 10), (20599, 170, 7);

-- Ichigohitofuri (21027) - SAM
-- Stats: Accuracy+15, Store TP+10
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (21027, 25, 15), (21027, 73, 10);

-- Aizushintogo (20979) - NIN
-- Stats: Accuracy+15, Evasion+22, Dual Wield+5
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (20979, 25, 15), (20979, 68, 22), (20979, 259, 5);

-- Espiritus (21149) - SMN
-- Player Stats: MP+88
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (21149, 5, 88);

-- Iris (20701) - BLU
-- Stats: Accuracy+10, Attack+10, Magic Atk. Bonus+14, Blue Magic Skill+15
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (20701, 25, 10), (20701, 23, 10), (20701, 28, 14), (20701, 122, 15);

-- Espiritus Pet Mods
-- Avatar: MAcc+15, MAB+120, BP Dmg+3
REPLACE INTO `item_mods_pet` (`itemid`, `modid`, `value`) VALUES (21149, 30, 15), (21149, 28, 120), (21149, 126, 3);

-- 1. Hretha Earring (itemId: 26092) - Guarding Skill +10
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26092, 1, 20), (26092, 108, 10);
-- 2. Ran Earring (itemId: 26089) - Evasion Skill +10
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26089, 1, 20), (26089, 107, 10);
-- 3. Foresti Earring (itemId: 26091) - Shield Skill +10
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26091, 1, 20), (26091, 109, 10);
-- 4. Hermodr Earring (itemId: 26090) - Parrying Skill +10
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26090, 1, 20), (26090, 110, 10);

-- 5. Saxnot Earring (itemId: 26093) - Divine Magic Skill +10
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26093, 1, 20), (26093, 111, 10);
-- 6. Meili Earring (itemId: 26098) - Healing Magic Skill +10
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26098, 1, 20), (26098, 112, 10);
-- 7. Mimir Earring (itemId: 26095) - Enhancing Magic Skill +10
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26095, 1, 20), (26095, 113, 10);
-- 8. Vor Earring (itemId: 26096) - Enfeebling Magic Skill +10
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26096, 1, 20), (26096, 114, 10);
-- 9. Ilmr Earring (itemId: 26097) - Elemental Magic Skill +10
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26097, 1, 20), (26097, 115, 10);
-- 10. Mani Earring (itemId: 26094) - Dark Magic Skill +10
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26094, 1, 20), (26094, 116, 10);

-- 11. Lodurr Earring (itemId: 26099) - Summoning Magic Skill +10
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26099, 1, 20), (26099, 117, 10);
-- 12. Njordr Earring (itemId: 26104) - Blue Magic Skill +10
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26104, 1, 20), (26104, 122, 10);
-- 13. Bragi Earring (itemId: 26101) - Singing Skill +10
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26101, 1, 20), (26101, 119, 10);
-- 14. Dellingr Earring (itemId: 26103) - Wind Instrument Skill +10
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26103, 1, 20), (26103, 121, 10);
-- 15. Gersemi Earring (itemId: 26102) - String Instrument Skill +10
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26102, 1, 20), (26102, 120, 10);
-- 16. Hnoss Earring (itemId: 26100) - Ninjutsu Skill +10
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26100, 1, 20), (26100, 118, 10);
-- 17. Gna Earring (itemId: 26105) - Geomancy Skill +10
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26105, 1, 20), (26105, 123, 10);
-- 18. Fulla Earring (itemId: 26106) - Handbell Skill +10
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26106, 1, 20), (26106, 124, 10);

-- Condemners (20505): MNK/PUP
-- Accuracy+20, Double Attack+3%, Store TP+5
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (20505, 25, 20), (20505, 288, 3), (20505, 73, 5);

-- Skinflayer (20579): THF/BRD/DNC
-- Acc+15, Atk+10, RAcc+15, RAtk+10, Evasion+22, Triple Attack+2%, Subtle Blow+8
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (20579, 25, 15), (20579, 23, 10), (20579, 26, 15), (20579, 24, 10), (20579, 68, 22), (20579, 302, 2), (20579, 289, 8);

-- Colada (20677): RDM/PLD/BLU
-- Acc+20, Magic Acc+15, MAB+14, Magic Damage+123, Fast Cast+4%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (20677, 25, 20), (20677, 30, 15), (20677, 28, 14), (20677, 311, 123), (20677, 170, 4);

-- Zulfiqar (21686): WAR/DRK/RUN
-- Accuracy+15, Attack+15, Double Attack+2%, Weapon skill damage+2%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (21686, 25, 15), (21686, 23, 15), (21686, 288, 2), (21686, 840, 2);

-- Digirbalag (21746): WAR/BST
-- STR+10, VIT+10, CHR+10, Acc+20, Double Attack+3%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (21746, 8, 10), (21746, 10, 10), (21746, 14, 10), (21746, 25, 20), (21746, 288, 3);
-- Pet Stat (Acc+20)
REPLACE INTO `item_mods_pet` (`itemid`, `modid`, `value`) VALUES (21746, 25, 20);

-- Aganoshe (21754): WAR
-- Accuracy+25, Attack+5, Store TP+5, PDT-3% (Value -300)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (21754, 25, 25), (21754, 23, 5), (21754, 73, 5), (21754, 161, -300);

-- Reienkyo (21854): DRG
-- STR+20, Accuracy+20, Attack+10, Critical hit rate+3%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (21854, 8, 20), (21854, 25, 20), (21854, 23, 10), (21854, 165, 3);

-- Obschine (21804): DRK
-- STR+22, Accuracy+10, Attack+20, Weapon skill damage+3%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (21804, 8, 22), (21804, 25, 10), (21804, 23, 20), (21804, 840, 3);

-- Kanaria (21904): NIN
-- Acc+15, Atk+10, RAcc+15, RAtk+10, Evasion+22, Store TP+5, Fast Cast+5%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (21904, 25, 15), (21904, 23, 10), (21904, 26, 15), (21904, 24, 10), (21904, 68, 22), (21904, 73, 5), (21904, 170, 5);

-- Umaru (21021): SAM
-- Accuracy+20, Attack+10, Store TP+5, Zanshin+5
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (21021, 25, 20), (21021, 23, 10), (21021, 73, 5), (21021, 306, 5);

-- Gada (21072): WHM/BLM/SMN/SCH/GEO
-- INT+6, MND+6, Magic Acc+20, MAB+16, Magic Damage+124, Cure potency+18%
-- Magic Skills +18 (Divine 111, Healing 112, Enhancing 113, Enfeebling 114)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (21072, 12, 6), (21072, 13, 6), (21072, 30, 20), (21072, 28, 16), (21072, 311, 124), (21072, 374, 18);
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (21072, 111, 18), (21072, 112, 18), (21072, 113, 18), (21072, 114, 18);

-- Grioavolr (22054): WHM/BLM/RDM/BRD/SMN/SCH/GEO
-- INT+19, MND+19, Magic Acc+14, MAB+30, Magic Damage+217, Conserve MP+5, Fast Cast+4%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (22054, 12, 19), (22054, 13, 19), (22054, 30, 14), (22054, 28, 30), (22054, 311, 217), (22054, 296, 5), (22054, 170, 4);
-- Avatar: Magic Acc+35, MAB+115
REPLACE INTO `item_mods_pet` (`itemid`, `modid`, `value`) VALUES (22054, 30, 35), (22054, 28, 115);

-- Teller (22113): RNG (Archery)
-- DEX+15, AGI+15, Ranged Accuracy+15, Enmity-5
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (22113, 9, 15), (22113, 11, 15), (22113, 26, 15), (22113, 27, -5);

-- Holliday (22134): RNG/COR (Marksmanship)
-- STR+15, AGI+15, RAcc+10, RAtk+15, Store TP+5
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (22134, 8, 15), (22134, 11, 15), (22134, 26, 10), (22134, 24, 15), (22134, 73, 5);

-- Helm (25640): Acc/Atk+8, PDT-2%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (25640, 1, 120), (25640, 2, 112), (25640, 5, 89), (25640, 8, 29), (25640, 9, 15), (25640, 10, 35), (25640, 11, 18), (25640, 12, 17), (25640, 13, 17), (25640, 14, 17), (25640, 25, 8), (25640, 23, 8), (25640, 68, 33), (25640, 31, 53), (25640, 29, 2), (25640, 384, 700), (25640, 161, -200);

-- Chestplate (25716): Atk+14, FC+5%, Store TP+5, Enmity+6
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (25716, 1, 152), (25716, 2, 66), (25716, 5, 59), (25716, 8, 30), (25716, 9, 17), (25716, 10, 30), (25716, 11, 19), (25716, 12, 19), (25716, 13, 19), (25716, 14, 19), (25716, 23, 14), (25716, 68, 41), (25716, 31, 69), (25716, 29, 4), (25716, 384, 300), (25716, 170, 5), (25716, 73, 5), (25716, 27, 6);

-- Gauntlets (25791): Acc+10, WSD+2%, MDT-2%, Skillchain+5
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (25791, 1, 108), (25791, 2, 31), (25791, 5, 14), (25791, 8, 12), (25791, 9, 28), (25791, 10, 34), (25791, 12, 8), (25791, 13, 24), (25791, 14, 19), (25791, 25, 10), (25791, 68, 22), (25791, 31, 48), (25791, 29, 1), (25791, 384, 400), (25791, 840, 2), (25791, 163, -200), (25791, 175, 5);

-- Cuisses (25840): Acc+15, Store TP+5, DA+2%, Enmity+4
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (25840, 1, 132), (25840, 2, 54), (25840, 5, 41), (25840, 8, 37), (25840, 10, 23), (25840, 11, 16), (25840, 12, 26), (25840, 13, 12), (25840, 14, 10), (25840, 25, 15), (25840, 68, 22), (25840, 31, 86), (25840, 29, 4), (25840, 384, 500), (25840, 73, 5), (25840, 288, 2), (25840, 27, 4);

-- Greaves (25916): Acc/MAcc+10, FC+5%, Cure Pot+7%, SIRD 20%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (25916, 1, 93), (25916, 2, 20), (25916, 5, 14), (25916, 8, 19), (25916, 9, 12), (25916, 10, 19), (25916, 11, 29), (25916, 13, 10), (25916, 14, 24), (25916, 25, 10), (25916, 30, 10), (25916, 68, 49), (25916, 31, 86), (25916, 29, 2), (25916, 384, 300), (25916, 170, 5), (25916, 374, 7), (25916, 168, -20);
-- Mask (25641): Acc+13, Regain+3, Crit Rate+2%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (25641, 1, 116), (25641, 2, 38), (25641, 8, 28), (25641, 9, 24), (25641, 10, 23), (25641, 11, 18), (25641, 12, 14), (25641, 13, 14), (25641, 14, 14), (25641, 25, 13), (25641, 68, 36), (25641, 31, 48), (25641, 29, 2), (25641, 384, 700), (25641, 165, 2);

-- Mail (25717): Acc+20, Store TP+3, DA+2%, PDT-2%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (25717, 1, 146), (25717, 2, 61), (25717, 8, 29), (25717, 9, 25), (25717, 10, 29), (25717, 11, 20), (25717, 12, 20), (25717, 13, 20), (25717, 14, 20), (25717, 25, 20), (25717, 68, 44), (25717, 31, 59), (25717, 29, 4), (25717, 384, 300), (25717, 73, 3), (25717, 288, 2), (25717, 161, -200);

-- Mitts (25792): Acc/Atk+10, Zanshin+10, Skillchain+5
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (25792, 1, 102), (25792, 2, 22), (25792, 8, 13), (25792, 9, 33), (25792, 10, 33), (25792, 11, 8), (25792, 12, 7), (25792, 13, 24), (25792, 14, 17), (25792, 25, 10), (25792, 23, 10), (25792, 68, 24), (25792, 31, 32), (25792, 29, 1), (25792, 384, 400), (25792, 306, 10), (25792, 175, 5);

-- Hose (25841): Atk+15, DA+3%, PDT-2%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (25841, 1, 127), (25841, 2, 95), (25841, 8, 39), (25841, 10, 26), (25841, 11, 16), (25841, 12, 24), (25841, 13, 14), (25841, 14, 11), (25841, 23, 15), (25841, 68, 24), (25841, 31, 80), (25841, 29, 3), (25841, 384, 500), (25841, 288, 3), (25841, 161, -200);

-- Greaves (25917): Acc/Atk+12, Store TP+5, Crit Dmg+4%, MDT-2%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (25917, 1, 84), (25917, 2, 11), (25917, 8, 17), (25917, 9, 20), (25917, 10, 17), (25917, 11, 26), (25917, 13, 6), (25917, 14, 20), (25917, 25, 12), (25917, 23, 12), (25917, 68, 55), (25917, 31, 80), (25917, 29, 2), (25917, 384, 300), (25917, 73, 5), (25917, 421, 4), (25917, 163, -200);
-- Helm (25642): Atk/RAtk+15, MAB+10, FC+7%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (25642, 1, 108), (25642, 2, 38), (25642, 8, 22), (25642, 9, 28), (25642, 10, 18), (25642, 11, 25), (25642, 12, 20), (25642, 13, 16), (25642, 14, 17), (25642, 23, 15), (25642, 24, 15), (25642, 28, 10), (25642, 68, 55), (25642, 31, 59), (25642, 29, 3), (25642, 384, 800), (25642, 170, 7);

-- Vest (25718): Acc/RAcc+15, Store TP+3, Crit Rate+3%, Enmity-4
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (25718, 1, 133), (25718, 2, 61), (25718, 8, 28), (25718, 9, 34), (25718, 10, 24), (25718, 11, 30), (25718, 12, 21), (25718, 13, 20), (25718, 14, 21), (25718, 25, 15), (25718, 26, 15), (25718, 68, 60), (25718, 31, 69), (25718, 29, 6), (25718, 384, 400), (25718, 73, 3), (25718, 165, 3), (25718, 27, -4);

-- Gloves (25793): Acc/RAcc+12, TA+2%, Subtle Blow+5, PDT-2%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (25793, 1, 97), (25793, 2, 20), (25793, 8, 16), (25793, 9, 39), (25793, 10, 30), (25793, 11, 8), (25793, 12, 14), (25793, 13, 26), (25793, 14, 19), (25793, 25, 12), (25793, 26, 12), (25793, 68, 41), (25793, 31, 43), (25793, 29, 2), (25793, 384, 500), (25793, 302, 2), (25793, 289, 5), (25793, 161, -200);

-- Trousers (25842): Atk/RAtk+15, Store TP+4, PDT-2%, Enmity-4
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (25842, 1, 114), (25842, 2, 38), (25842, 8, 33), (25842, 10, 16), (25842, 11, 32), (25842, 12, 29), (25842, 13, 15), (25842, 14, 10), (25842, 23, 15), (25842, 24, 15), (25842, 68, 62), (25842, 31, 75), (25842, 29, 5), (25842, 384, 600), (25842, 73, 4), (25842, 161, -200), (25842, 27, -4);

-- Boots (25918): Acc/Atk/RAcc/RAtk/MAcc+10, MAB+10, TA+2, Subtle Blow+6, PDT-2%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (25918, 1, 79), (25918, 2, 9), (25918, 8, 16), (25918, 9, 24), (25918, 10, 10), (25918, 11, 43), (25918, 13, 11), (25918, 14, 26), (25918, 25, 10), (25918, 23, 10), (25918, 26, 10), (25918, 24, 10), (25918, 30, 10), (25918, 28, 10), (25918, 68, 80), (25918, 31, 75), (25918, 29, 5), (25918, 384, 400), (25918, 302, 2), (25918, 289, 6), (25918, 161, -200);
-- Hat (25644): Acc/MAcc+15, MDT-2%, Aquaveil+1
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (25644, 1, 98), (25644, 2, 25), (25644, 5, 59), (25644, 8, 14), (25644, 9, 14), (25644, 10, 14), (25644, 11, 5), (25644, 12, 29), (25644, 13, 29), (25644, 14, 24), (25644, 25, 15), (25644, 30, 15), (25644, 68, 33), (25644, 31, 86), (25644, 29, 6), (25644, 384, 600), (25644, 163, -200);

-- Doublet (25720): MAcc+20, MAB+15, Cure Pot+13%, Conserve MP+5
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (25720, 1, 129), (25720, 2, 43), (25720, 5, 70), (25720, 8, 16), (25720, 9, 19), (25720, 10, 16), (25720, 11, 16), (25720, 12, 39), (25720, 13, 34), (25720, 14, 30), (25720, 68, 38), (25720, 31, 91), (25720, 30, 20), (25720, 28, 15), (25720, 29, 7), (25720, 384, 300), (25720, 296, 5), (25720, 374, 13);

-- Gloves (25795): Acc/MAcc+15, MAB+15, Enhancing Skill+15, Enmity-4, SIRD 20%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (25795, 1, 87), (25795, 2, 11), (25795, 5, 23), (25795, 8, 3), (25795, 9, 23), (25795, 10, 20), (25795, 11, 2), (25795, 12, 25), (25795, 13, 38), (25795, 14, 20), (25795, 25, 15), (25795, 30, 15), (25795, 68, 19), (25795, 31, 48), (25795, 28, 15), (25795, 29, 3), (25795, 113, 15), (25795, 384, 300), (25795, 27, -4), (25795, 168, -20);

-- Hose (25844): MAcc+20, Enfeebling Skill+13, Cure Pot+8%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (25844, 1, 109), (25844, 2, 31), (25844, 5, 47), (25844, 8, 19), (25844, 10, 6), (25844, 11, 14), (25844, 12, 42), (25844, 13, 29), (25844, 14, 20), (25844, 30, 20), (25844, 68, 24), (25844, 31, 118), (25844, 29, 6), (25844, 114, 13), (25844, 384, 500), (25844, 374, 8);

-- Slippers (25920): Atk+20, MAB+20, Divine Skill+15, Enmity-5, PDT-2%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (25920, 1, 70), (25920, 2, 4), (25920, 5, 23), (25920, 8, 6), (25920, 9, 6), (25920, 10, 6), (25920, 11, 26), (25920, 12, 23), (25920, 13, 24), (25920, 14, 34), (25920, 23, 20), (25920, 68, 60), (25920, 31, 118), (25920, 28, 20), (25920, 29, 6), (25920, 111, 15), (25920, 384, 300), (25920, 27, -5), (25920, 161, -200);
-- Hood (25643): MAcc+15, MAB+10, FC+8%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (25643, 1, 95), (25643, 2, 22), (25643, 5, 56), (25643, 8, 15), (25643, 9, 15), (25643, 10, 15), (25643, 11, 6), (25643, 12, 29), (25643, 13, 28), (25643, 14, 26), (25643, 68, 33), (25643, 31, 86), (25643, 30, 15), (25643, 28, 10), (25643, 29, 6), (25643, 384, 600), (25643, 170, 8);

-- Jubbah (25719): MAcc+20, MAB+20, FC+6%, Enmity-5, PDT-2%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (25719, 1, 124), (25719, 2, 41), (25719, 5, 67), (25719, 8, 16), (25719, 9, 19), (25719, 10, 16), (25719, 11, 16), (25719, 12, 40), (25719, 13, 33), (25719, 14, 32), (25719, 68, 38), (25719, 31, 91), (25719, 30, 20), (25719, 28, 20), (25719, 29, 7), (25719, 384, 300), (25719, 27, -5), (25719, 170, 6), (25719, 161, -200);

-- Dastanas (25794): Pet Atk+20, Pet MAB+20, Pet BP Dmg+5, Enmity+5
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (25794, 1, 84), (25794, 2, 9), (25794, 5, 20), (25794, 8, 3), (25794, 9, 23), (25794, 10, 20), (25794, 11, 2), (25794, 12, 26), (25794, 13, 37), (25794, 14, 21), (25794, 68, 19), (25794, 31, 48), (25794, 29, 3), (25794, 384, 300), (25794, 27, 5);
-- Pet Mods
REPLACE INTO `item_mods_pet` (`itemid`, `modid`, `value`) VALUES (25794, 23, 20), (25794, 28, 20), (25794, 126, 5);

-- Shalwar (25843): MAcc+20, MAB+15, Magic Damage+13, Enmity-5
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (25843, 1, 106), (25843, 2, 29), (25843, 5, 44), (25843, 8, 19), (25843, 10, 6), (25843, 11, 14), (25843, 12, 43), (25843, 13, 28), (25843, 14, 21), (25843, 30, 20), (25843, 311, 13), (25843, 24, 24), (25843, 31, 118), (25843, 28, 15), (25843, 29, 6), (25843, 384, 500), (25843, 27, -5);

-- Crackows (25919): MAB+15, FC+5%, Conserve MP+4, Drain/Aspir Pot+7
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (25919, 1, 67), (25919, 2, 4), (25919, 5, 20), (25919, 8, 6), (25919, 9, 6), (25919, 10, 6), (25919, 11, 26), (25919, 12, 24), (25919, 13, 23), (25919, 14, 35), (25919, 68, 60), (25919, 31, 118), (25919, 28, 15), (25919, 29, 6), (25919, 384, 300), (25919, 170, 5), (25919, 296, 4), (25919, 315, 7);
-- Hauksbok Arrow (22292)
-- STR+10, Ranged Accuracy+30, WSD+20%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (22292, 8, 10), (22292, 26, 30), (22292, 840, 20);

-- Hauksbok Bolt (22293)
-- AGI+10, Magic Accuracy+30, MAB+30
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (22293, 11, 10), (22293, 30, 30), (22293, 28, 30);

-- Hauksbok Bullet (22294)
-- AGI+10, MAB+40
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (22294, 11, 10), (22294, 28, 40);

-- Voluspa Tathlum (22296)
-- STR+5, DEX+5, CHR+5, Accuracy+10, Attack+10
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (22296, 8, 5), (22296, 9, 5), (22296, 14, 5), (22296, 25, 10), (22296, 23, 10);
-- Pet Stats: Acc/RAcc/MAcc +15
REPLACE INTO `item_mods_pet` (`itemid`, `modid`, `value`) VALUES (22296, 25, 15), (22296, 26, 15), (22296, 30, 15);

-- Yngvi Choker (25078)
-- DEF:17, Enmity-5, Regen+2
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (25078, 1, 17), (25078, 27, -5), (25078, 370, 2);

-- Thrud Earring (26159)
-- STR+10, VIT+10, WSD+3%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26159, 8, 10), (26159, 10, 10), (26159, 840, 3);

-- Odr Earring (26160)
-- DEX+10, Accuracy+10, Critical Hit Rate+5%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26160, 9, 10), (26160, 25, 10), (26160, 165, 5);

-- Snotra Earring (26162)
-- MND+8, Magic Accuracy+10, Enfeebling Duration +10% (Mod 495)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26162, 13, 8), (26162, 30, 10), (26162, 495, 10);

-- Sjofn Earring (26163)
-- Waltz Potency +10% (Mod 491)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26163, 491, 10);

-- Beyla Earring (26164)
-- Ranged Accuracy+15, Subtle Blow+5, Enmity-8
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26164, 26, 15), (26164, 289, 5), (26164, 27, -8);

-- Tuisto Earring (26165)
-- DEF:20, VIT+10, MP to HP +150 (Mod 1717)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26165, 1, 20), (26165, 10, 10), (26165, 1717, 150);

-- Nehalennia Earring (26166)
-- Magic Accuracy+5, HP to MP +60 (Mod 1718)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26166, 30, 5), (26166, 1718, 60);

-- Dreki Ring (26207)
-- Accuracy+8, Attack+8, Store TP+5
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26207, 25, 8), (26207, 23, 8), (26207, 73, 5);

-- Ask Sash (26307)
-- Boost: Regain +200, WSD+5%
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26307, 840, 5);

-- Embla Sash (26308)
-- Fast Cast+5%, Enhancing Duration +10% (Mod 890)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26308, 170, 5), (26308, 890, 10);

-- Audumbla Sash (26309)
-- DEF:18, SIRD 10%, PDT-4% (Value -400)
REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES (26309, 1, 18), (26309, 168, -10), (26309, 161, -400);

REPLACE INTO `item_weapon` (`itemId`, `name`, `skill`, `subskill`, `ilvl_skill`, `ilvl_parry`, `ilvl_macc`, `dmgType`, `hit`, `delay`, `dmg`, `unlock_points`) VALUES (22043, 'apkallu_scepter', 1, 0, 0, 0, 0, 1, 8, 300, 11, 0);
