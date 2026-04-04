-----------------------------------
-- Uplox Storage NPC
-----------------------------------
require('modules/module_utils')
require('scripts/globals/npc_util')
-----------------------------------
local m = Module:new('Uplox')

local itemsPerPage = 3

-- Define categories and items
local categories = {
    {
        name = "Shared Mats",
        items = {
            { name = "Phoenix Feather", id = xi.item.PHOENIX_FEATHER },
            { name = "Malboro Fiber", id = xi.item.SPOOL_OF_MALBORO_FIBER },
			{ name = "Beetle Blood", id = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD },
			{ name = "Damascene Cloth", id = xi.item.SQUARE_OF_DAMASCENE_CLOTH },
			{ name = "Oxblood", id = xi.item.PIECE_OF_OXBLOOD },
			{ name = "Maliyakaleya Coral", id = xi.item.PIECE_OF_MALIYAKALEYA_CORAL },
            { name = "Hepatizon Ingot", id = xi.item.HEPATIZON_INGOT },
			{ name = "Beryllium Ingot", id = xi.item.BERYLLIUM_INGOT },
			{ name = "Exalted Lumber", id = xi.item.PIECE_OF_EXALTED_LUMBER },
			{ name = "Sif's Macrame", id = xi.item.SPOOL_OF_SIFS_MACRAME },
			{ name = "Gabbrath Horn", id = xi.item.GABBRATH_HORN },
            { name = "Yggdreant Bole", id = xi.item.YGGDREANT_BOLE },
			{ name = "Bztavian Stinger", id = xi.item.BZTAVIAN_STINGER },
			{ name = "Wakzta Rostrum", id = xi.item.WAKTZA_ROSTRUM },
			{ name = "Rockfin Tooth", id = xi.item.ROCKFIN_TOOTH },
			{ name = "Defiant Scarf", id = xi.item.DEFIANT_SCARF },
            { name = "Defiant Sweat", id = xi.item.VIAL_OF_DEFIANT_SWEAT },
			{ name = "Hades' Claw", id = xi.item.HADES_CLAW },
			{ name = "Dark Matter", id = xi.item.CHUNK_OF_DARK_MATTER },
			{ name = "Macuil Plating", id = xi.item.MACUIL_PLATING },
			{ name = "Macuil Horn", id = xi.item.MACUIL_HORN },
			{ name = "Tartarian Soul", id = xi.item.TARTARIAN_SOUL },
			{ name = "Tartarian Chain", id = xi.item.TARTARIAN_CHAIN },
			{ name = "Plovid Flesh", id = xi.item.CHUNK_OF_PLOVID_FLESH },
			{ name = "Plovid Effluvium", id = xi.item.VIAL_OF_PLOVID_EFFLUVIUM },
			{ name = "Etched Memory", id = xi.item.ETCHED_MEMORY },			
        }
    },
    {
        name = "Misc Mats",
        items = {
            { name = "Behemoth Leather", id = xi.item.SQUARE_OF_BEHEMOTH_LEATHER },
			{ name = "Pl. Silk Thread", id = xi.item.SPOOL_OF_PLATINUM_SILK_THREAD },
			{ name = "Raxa", id = xi.item.SQUARE_OF_RAXA },
			{ name = "Twill Damask", id = xi.item.SQUARE_OF_TWILL_DAMASK },
			{ name = "Siren's Hair", id = xi.item.LOCK_OF_SIRENS_HAIR },
			{ name = "Ori. Sheet", id = xi.item.ORICHALCUM_SHEET },
			{ name = "Durium Sheet", id = xi.item.DURIUM_SHEET },
			{ name = "Damascus Ingot", id = xi.item.DAMASCUS_INGOT },
			{ name = "Kei's Scale", id = xi.item.KEIS_SCALE },
			{ name = "Kin's Scale", id = xi.item.KINS_SCALE },
			{ name = "Gin's Scale", id = xi.item.GINS_SCALE },
			{ name = "Fu's Scale", id = xi.item.FUS_SCALE },
			{ name = "Kyou's Scale", id = xi.item.KYOUS_SCALE },            
        }
    },
    {
        name = "Guild Mats",
        items = {
            { name = "S. Faulpie Leather", id = xi.item.SQUARE_OF_SYNTHETIC_FAULPIE_LEATHER },
			{ name = "Faulpie Leather", id = xi.item.SQUARE_OF_FAULPIE_LEATHER },
			{ name = "Cypress Log", id = xi.item.CYPRESS_LOG },
			{ name = "Cypress Lumber", id = xi.item.PIECE_OF_CYPRESS_LUMBER },
			{ name = "Khoma Thread", id = xi.item.SPOOL_OF_KHOMA_THREAD },
			{ name = "Khoma Cloth", id = xi.item.BOLT_OF_KHOMA_CLOTH },
			{ name = "Azure Leaf", id = xi.item.AZURE_LEAF },
			{ name = "Azure Cermet", id = xi.item.AZURE_CERMET },
			{ name = "Cyan Coral", id = xi.item.FRAGMENT_OF_CYAN_CORAL },
			{ name = "Cyan Orb", id = xi.item.CYAN_ORB },
			{ name = "Ruthenium Ore", id = xi.item.CHUNK_OF_RUTHENIUM_ORE },
			{ name = "Ruthenium Ingot", id = xi.item.RUTHENIUM_INGOT },
			{ name = "Niobium Ore", id = xi.item.NIOBIUM_INGOT },
			{ name = "Niobium Ingot", id = xi.item.NIOBIUM_ORE },
        }

    },
    {
        name = "Misc. Items",
        items = {
            { name = "Eschalixir", id = xi.item.ESCHALIXIR },
            { name = "Eschalixir +1", id = xi.item.ESCHALIXIR_P1 },
            { name = "Eschalixir +2", id = xi.item.ESCHALIXIR_P2 },
            { name = "Ashweed", id = xi.item.TUFT_OF_ASHWEED },
            { name = "Duskcrawler", id = xi.item.DUSKCRAWLER },
            { name = "Gravewood Log", id = xi.item.GRAVEWOOD_LOG },
            { name = "Akaso", id = xi.item.CLUMP_OF_AKASO },
            { name = "Ancestral Cloth", id = xi.item.SQUARE_OF_ANCESTRAL_CLOTH },
            { name = "Hepatizon Ore", id = xi.item.HEPATIZON_ORE },
            { name = "Beryllium Ore", id = xi.item.CHUNK_OF_BERYLLIUM_ORE },
            { name = "Ra'Kaznar Ore", id = xi.item.CHUNK_OF_RAKAZNAR_ORE },
            { name = "Vulcanite Ore", id = xi.item.CHUNK_OF_VULCANITE_ORE },
            { name = "Bismuth Ore", id = xi.item.CHUNK_OF_BISMUTH_ORE },
            { name = "Bismuth Ingot", id = xi.item.BISMUTH_INGOT },
            { name = "Scarletite Ingot", id = xi.item.SCARLETITE_INGOT },
            { name = "Midrium Ore", id = xi.item.CHUNK_OF_MIDRIUM_ORE },
            { name = "Midrium Ingot", id = xi.item.MIDRIUM_INGOT },
            { name = "Rhodium Ore", id = xi.item.CHUNK_OF_RHODIUM_ORE },
            { name = "Rhodium Ingot", id = xi.item.RHODIUM_INGOT },
            { name = "Exalted Log", id = xi.item.EXALTED_LOG },
            { name = "Urunday Log", id = xi.item.URUNDAY_LOG },
            { name = "Urunday Lumber", id = xi.item.PIECE_OF_URUNDAY_LUMBER },
            { name = "Guatambu Log", id = xi.item.GUATAMBU_LOG },
            { name = "Guatambu Lumber", id = xi.item.PIECE_OF_GUATAMBU_LUMBER },
            { name = "Raaz Hide", id = xi.item.RAAZ_HIDE },
            { name = "Raaz Leather", id = xi.item.SQUARE_OF_RAAZ_LEATHER },
            { name = "Maliya. Coral Orb", id = xi.item.MALIYAKALEYA_ORB },
			{ name = "Waktza Crest", id = xi.item.WAKTZA_CREST },
            { name = "Yggdreant Root", id = xi.item.YGGDREANT_ROOT },
            { name = "Gabbrath Meat", id = xi.item.SLICE_OF_GABBRATH_MEAT },
            { name = "Cehuetzi Ice", id = xi.item.CEHUETZI_ICE_SHARD },
            { name = "Cehuetzi Pelt", id = xi.item.CEHUETZI_PELT },
			{ name = "Cehuetzi Claw", id = xi.item.CEHUETZI_CLAW },
            { name = "Bztavian Wing", id = xi.item.BZTAVIAN_WING },
            { name = "Rockfin Fin", id = xi.item.ROCKFIN_FIN },
            { name = "Sif's Lock", id = xi.item.SIFS_LOCK },
        }
    },
    {
        name = "Job Cards",
        items = {
            { name = "P. WAR Card", id = xi.item.PARAGON_WARRIOR_CARD },
			{ name = "P. MNK Card", id = xi.item.PARAGON_MONK_CARD },
			{ name = "P. WHM Card", id = xi.item.PARAGON_WHITE_MAGE_CARD },
			{ name = "P. BLM Card", id = xi.item.PARAGON_BLACK_MAGE_CARD },
			{ name = "P. RDM Card", id = xi.item.PARAGON_RED_MAGE_CARD },
			{ name = "P. THF Card", id = xi.item.PARAGON_THIEF_CARD },
			{ name = "P. PLD Card", id = xi.item.PARAGON_PALADIN_CARD },
			{ name = "P. DRK Card", id = xi.item.PARAGON_DARK_KNIGHT_CARD },
			{ name = "P. BST Card", id = xi.item.PARAGON_BEASTMASTER_CARD },
			{ name = "P. BRD Card", id = xi.item.PARAGON_BARD_CARD },
			{ name = "P. RNG Card", id = xi.item.PARAGON_RANGER_CARD },
			{ name = "P. SAM Card", id = xi.item.PARAGON_SAMURAI_CARD },
			{ name = "P. NIN Card", id = xi.item.PARAGON_NINJA_CARD },
			{ name = "P. DRG Card", id = xi.item.PARAGON_DRAGOON_CARD },
			{ name = "P. SMN Card", id = xi.item.PARAGON_SUMMONER_CARD },
			{ name = "P. BLU Card", id = xi.item.PARAGON_BLUE_MAGE_CARD },
			{ name = "P. COR Card", id = xi.item.PARAGON_CORSAIR_CARD },
			{ name = "P. PUP Card", id = xi.item.PARAGON_PUPPETMASTER_CARD },
			{ name = "P. DNC Card", id = xi.item.PARAGON_DANCER_CARD },
			{ name = "P. SCH Card", id = xi.item.PARAGON_SCHOLAR_CARD },
			{ name = "P. GEO Card", id = xi.item.PARAGON_GEOMANCER_CARD },
			{ name = "P. RUN Card", id = xi.item.PARAGON_RUNE_FENCER_CARD },			
        }
    },
    {
        name = "Job Shards",
		groups = {
			{ name = "WAR", items = {
				{ name = "Headshard: WAR", id = xi.item.HEADSHARD_WAR },
				{ name = "Torsoshard: WAR", id = xi.item.TORSOSHARD_WAR },
				{ name = "Handshard: WAR", id = xi.item.HANDSHARD_WAR },
				{ name = "Legshard: WAR", id = xi.item.LEGSHARD_WAR },
				{ name = "Footshard: WAR", id = xi.item.FOOTSHARD_WAR },
			}},
			{ name = "MNK", items = {
				{ name = "Headshard: MNK", id = xi.item.HEADSHARD_MNK },
				{ name = "Torsoshard: MNK", id = xi.item.TORSOSHARD_MNK },
				{ name = "Handshard: MNK", id = xi.item.HANDSHARD_MNK },
				{ name = "Legshard: MNK", id = xi.item.LEGSHARD_MNK },
				{ name = "Footshard: MNK", id = xi.item.FOOTSHARD_MNK },
			}},
			{ name = "WHM", items = {
				{ name = "Headshard: WHM", id = xi.item.HEADSHARD_WHM },
				{ name = "Torsoshard: WHM", id = xi.item.TORSOSHARD_WHM },
				{ name = "Handshard: WHM", id = xi.item.HANDSHARD_WHM },
				{ name = "Legshard: WHM", id = xi.item.LEGSHARD_WHM },
				{ name = "Footshard: WHM", id = xi.item.FOOTSHARD_WHM },
			}},
			{ name = "BLM", items = {
				{ name = "Headshard: BLM", id = xi.item.HEADSHARD_BLM },
				{ name = "Torsoshard: BLM", id = xi.item.TORSOSHARD_BLM },
				{ name = "Handshard: BLM", id = xi.item.HANDSHARD_BLM },
				{ name = "Legshard: BLM", id = xi.item.LEGSHARD_BLM },
				{ name = "Footshard: BLM", id = xi.item.FOOTSHARD_BLM },
			}},
			{ name = "RDM", items = {
				{ name = "Headshard: RDM", id = xi.item.HEADSHARD_RDM },
				{ name = "Torsoshard: RDM", id = xi.item.TORSOSHARD_RDM },
				{ name = "Handshard: RDM", id = xi.item.HANDSHARD_RDM },
				{ name = "Legshard: RDM", id = xi.item.LEGSHARD_RDM },
				{ name = "Footshard: RDM", id = xi.item.FOOTSHARD_RDM },
			}},
			{ name = "THF", items = {
				{ name = "Headshard: THF", id = xi.item.HEADSHARD_THF },
				{ name = "Torsoshard: THF", id = xi.item.TORSOSHARD_THF },
				{ name = "Handshard: THF", id = xi.item.HANDSHARD_THF },
				{ name = "Legshard: THF", id = xi.item.LEGSHARD_THF },
				{ name = "Footshard: THF", id = xi.item.FOOTSHARD_THF },
			}},
			{ name = "PLD", items = {
				{ name = "Headshard: PLD", id = xi.item.HEADSHARD_PLD },
				{ name = "Torsoshard: PLD", id = xi.item.TORSOSHARD_PLD },
				{ name = "Handshard: PLD", id = xi.item.HANDSHARD_PLD },
				{ name = "Legshard: PLD", id = xi.item.LEGSHARD_PLD },
				{ name = "Footshard: PLD", id = xi.item.FOOTSHARD_PLD },
			}},
			{ name = "DRK", items = {
				{ name = "Headshard: DRK", id = xi.item.HEADSHARD_DRK },
				{ name = "Torsoshard: DRK", id = xi.item.TORSOSHARD_DRK },
				{ name = "Handshard: DRK", id = xi.item.HANDSHARD_DRK },
				{ name = "Legshard: DRK", id = xi.item.LEGSHARD_DRK },
				{ name = "Footshard: DRK", id = xi.item.FOOTSHARD_DRK },
			}},
			{ name = "BST", items = {
				{ name = "Headshard: BST", id = xi.item.HEADSHARD_BST },
				{ name = "Torsoshard: BST", id = xi.item.TORSOSHARD_BST },
				{ name = "Handshard: BST", id = xi.item.HANDSHARD_BST },
				{ name = "Legshard: BST", id = xi.item.LEGSHARD_BST },
				{ name = "Footshard: BST", id = xi.item.FOOTSHARD_BST },
			}},
			{ name = "BRD", items = {
				{ name = "Headshard: BRD", id = xi.item.HEADSHARD_BRD },
				{ name = "Torsoshard: BRD", id = xi.item.TORSOSHARD_BRD },
				{ name = "Handshard: BRD", id = xi.item.HANDSHARD_BRD },
				{ name = "Legshard: BRD", id = xi.item.LEGSHARD_BRD },
				{ name = "Footshard: BRD", id = xi.item.FOOTSHARD_BRD },
			}},
			{ name = "RNG", items = {
				{ name = "Headshard: RNG", id = xi.item.HEADSHARD_RNG },
				{ name = "Torsoshard: RNG", id = xi.item.TORSOSHARD_RNG },
				{ name = "Handshard: RNG", id = xi.item.HANDSHARD_RNG },
				{ name = "Legshard: RNG", id = xi.item.LEGSHARD_RNG },
				{ name = "Footshard: RNG", id = xi.item.FOOTSHARD_RNG },
			}},
			{ name = "SAM", items = {
				{ name = "Headshard: SAM", id = xi.item.HEADSHARD_SAM },
				{ name = "Torsoshard: SAM", id = xi.item.TORSOSHARD_SAM },
				{ name = "Handshard: SAM", id = xi.item.HANDSHARD_SAM },
				{ name = "Legshard: SAM", id = xi.item.LEGSHARD_SAM },
				{ name = "Footshard: SAM", id = xi.item.FOOTSHARD_SAM },
			}},
			{ name = "NIN", items = {
				{ name = "Headshard: NIN", id = xi.item.HEADSHARD_NIN },
				{ name = "Torsoshard: NIN", id = xi.item.TORSOSHARD_NIN },
				{ name = "Handshard: NIN", id = xi.item.HANDSHARD_NIN },
				{ name = "Legshard: NIN", id = xi.item.LEGSHARD_NIN },
				{ name = "Footshard: NIN", id = xi.item.FOOTSHARD_NIN },
			}},
			{ name = "DRG", items = {
				{ name = "Headshard: DRG", id = xi.item.HEADSHARD_DRG },
				{ name = "Torsoshard: DRG", id = xi.item.TORSOSHARD_DRG },
				{ name = "Handshard: DRG", id = xi.item.HANDSHARD_DRG },
				{ name = "Legshard: DRG", id = xi.item.LEGSHARD_DRG },
				{ name = "Footshard: DRG", id = xi.item.FOOTSHARD_DRG },
			}},
			{ name = "SMN", items = {
				{ name = "Headshard: SMN", id = xi.item.HEADSHARD_SMN },
				{ name = "Torsoshard: SMN", id = xi.item.TORSOSHARD_SMN },
				{ name = "Handshard: SMN", id = xi.item.HANDSHARD_SMN },
				{ name = "Legshard: SMN", id = xi.item.LEGSHARD_SMN },
				{ name = "Footshard: SMN", id = xi.item.FOOTSHARD_SMN },
			}},
			{ name = "BLU", items = {
				{ name = "Headshard: BLU", id = xi.item.HEADSHARD_BLU },
				{ name = "Torsoshard: BLU", id = xi.item.TORSOSHARD_BLU },
				{ name = "Handshard: BLU", id = xi.item.HANDSHARD_BLU },
				{ name = "Legshard: BLU", id = xi.item.LEGSHARD_BLU },
				{ name = "Footshard: BLU", id = xi.item.FOOTSHARD_BLU },
			}},
			{ name = "COR", items = {
				{ name = "Headshard: COR", id = xi.item.HEADSHARD_COR },
				{ name = "Torsoshard: COR", id = xi.item.TORSOSHARD_COR },
				{ name = "Handshard: COR", id = xi.item.HANDSHARD_COR },
				{ name = "Legshard: COR", id = xi.item.LEGSHARD_COR },
				{ name = "Footshard: COR", id = xi.item.FOOTSHARD_COR },
			}},
			{ name = "PUP", items = {
				{ name = "Headshard: PUP", id = xi.item.HEADSHARD_PUP },
				{ name = "Torsoshard: PUP", id = xi.item.TORSOSHARD_PUP },
				{ name = "Handshard: PUP", id = xi.item.HANDSHARD_PUP },
				{ name = "Legshard: PUP", id = xi.item.LEGSHARD_PUP },
				{ name = "Footshard: PUP", id = xi.item.FOOTSHARD_PUP },
			}},
			{ name = "DNC", items = {
				{ name = "Headshard: DNC", id = xi.item.HEADSHARD_DNC },
				{ name = "Torsoshard: DNC", id = xi.item.TORSOSHARD_DNC },
				{ name = "Handshard: DNC", id = xi.item.HANDSHARD_DNC },
				{ name = "Legshard: DNC", id = xi.item.LEGSHARD_DNC },
				{ name = "Footshard: DNC", id = xi.item.FOOTSHARD_DNC },
			}},
			{ name = "SCH", items = {
				{ name = "Headshard: SCH", id = xi.item.HEADSHARD_SCH },
				{ name = "Torsoshard: SCH", id = xi.item.TORSOSHARD_SCH },
				{ name = "Handshard: SCH", id = xi.item.HANDSHARD_SCH },
				{ name = "Legshard: SCH", id = xi.item.LEGSHARD_SCH },
				{ name = "Footshard: SCH", id = xi.item.FOOTSHARD_SCH },
			}},
			{ name = "GEO", items = {			
				{ name = "Headshard: GEO", id = xi.item.HEADSHARD_GEO },
				{ name = "Torsoshard: GEO", id = xi.item.TORSOSHARD_GEO },
				{ name = "Handshard: GEO", id = xi.item.HANDSHARD_GEO },
				{ name = "Legshard: GEO", id = xi.item.LEGSHARD_GEO },
				{ name = "Footshard: GEO", id = xi.item.FOOTSHARD_GEO },
			}},
			{ name = "RUN", items = {
				{ name = "Headshard: RUN", id = xi.item.HEADSHARD_RUN },
				{ name = "Torsoshard: RUN", id = xi.item.TORSOSHARD_RUN },
				{ name = "Handshard: RUN", id = xi.item.HANDSHARD_RUN },
				{ name = "Legshard: RUN", id = xi.item.LEGSHARD_RUN },
				{ name = "Footshard: RUN", id = xi.item.FOOTSHARD_RUN },
			}},
        }
    },
	{
        name = "Void Shards",
		groups = {
			{ name = "WAR", items = {
				{ name = "Voidhead: WAR", id = xi.item.VOIDHEAD_WAR },
				{ name = "Voidtorso: WAR", id = xi.item.VOIDTORSO_WAR },
				{ name = "Voidhand: WAR", id = xi.item.VOIDHAND_WAR },
				{ name = "Voidleg: WAR", id = xi.item.VOIDLEG_WAR },
				{ name = "Voidfoot: WAR", id = xi.item.VOIDFOOT_WAR },
			}},
			{ name = "MNK", items = {
				{ name = "Voidhead: MNK", id = xi.item.VOIDHEAD_MNK },
				{ name = "Voidtorso: MNK", id = xi.item.VOIDTORSO_MNK },
				{ name = "Voidhand: MNK", id = xi.item.VOIDHAND_MNK },
				{ name = "Voidleg: MNK", id = xi.item.VOIDLEG_MNK },
				{ name = "Voidfoot: MNK", id = xi.item.VOIDFOOT_MNK },
			}},
			{ name = "WHM", items = {
				{ name = "Voidhead: WHM", id = xi.item.VOIDHEAD_WHM },
				{ name = "Voidtorso: WHM", id = xi.item.VOIDTORSO_WHM },
				{ name = "Voidhand: WHM", id = xi.item.VOIDHAND_WHM },
				{ name = "Voidleg: WHM", id = xi.item.VOIDLEG_WHM },
				{ name = "Voidfoot: WHM", id = xi.item.VOIDFOOT_WHM },
			}},
			{ name = "BLM", items = {
				{ name = "Voidhead: BLM", id = xi.item.VOIDHEAD_BLM },
				{ name = "Voidtorso: BLM", id = xi.item.VOIDTORSO_BLM },
				{ name = "Voidhand: BLM", id = xi.item.VOIDHAND_BLM },
				{ name = "Voidleg: BLM", id = xi.item.VOIDLEG_BLM },
				{ name = "Voidfoot: BLM", id = xi.item.VOIDFOOT_BLM },
			}},
			{ name = "RDM", items = {
				{ name = "Voidhead: RDM", id = xi.item.VOIDHEAD_RDM },
				{ name = "Voidtorso: RDM", id = xi.item.VOIDTORSO_RDM },
				{ name = "Voidhand: RDM", id = xi.item.VOIDHAND_RDM },
				{ name = "Voidleg: RDM", id = xi.item.VOIDLEG_RDM },
				{ name = "Voidfoot: RDM", id = xi.item.VOIDFOOT_RDM },
			}},
			{ name = "THF", items = {
				{ name = "Voidhead: THF", id = xi.item.VOIDHEAD_THF },
				{ name = "Voidtorso: THF", id = xi.item.VOIDTORSO_THF },
				{ name = "Voidhand: THF", id = xi.item.VOIDHAND_THF },
				{ name = "Voidleg: THF", id = xi.item.VOIDLEG_THF },
				{ name = "Voidfoot: THF", id = xi.item.VOIDFOOT_THF },
			}},
			{ name = "PLD", items = {
				{ name = "Voidhead: PLD", id = xi.item.VOIDHEAD_PLD },
				{ name = "Voidtorso: PLD", id = xi.item.VOIDTORSO_PLD },
				{ name = "Voidhand: PLD", id = xi.item.VOIDHAND_PLD },
				{ name = "Voidleg: PLD", id = xi.item.VOIDLEG_PLD },
				{ name = "Voidfoot: PLD", id = xi.item.VOIDFOOT_PLD },
			}},
			{ name = "DRK", items = {
				{ name = "Voidhead: DRK", id = xi.item.VOIDHEAD_DRK },
				{ name = "Voidtorso: DRK", id = xi.item.VOIDTORSO_DRK },
				{ name = "Voidhand: DRK", id = xi.item.VOIDHAND_DRK },
				{ name = "Voidleg: DRK", id = xi.item.VOIDLEG_DRK },
				{ name = "Voidfoot: DRK", id = xi.item.VOIDFOOT_DRK },
			}},
			{ name = "BST", items = {
				{ name = "Voidhead: BST", id = xi.item.VOIDHEAD_BST },
				{ name = "Voidtorso: BST", id = xi.item.VOIDTORSO_BST },
				{ name = "Voidhand: BST", id = xi.item.VOIDHAND_BST },
				{ name = "Voidleg: BST", id = xi.item.VOIDLEG_BST },
				{ name = "Voidfoot: BST", id = xi.item.VOIDFOOT_BST },
			}},
			{ name = "BRD", items = {
				{ name = "Voidhead: BRD", id = xi.item.VOIDHEAD_BRD },
				{ name = "Voidtorso: BRD", id = xi.item.VOIDTORSO_BRD },
				{ name = "Voidhand: BRD", id = xi.item.VOIDHAND_BRD },
				{ name = "Voidleg: BRD", id = xi.item.VOIDLEG_BRD },
				{ name = "Voidfoot: BRD", id = xi.item.VOIDFOOT_BRD },
			}},
			{ name = "RNG", items = {
				{ name = "Voidhead: RNG", id = xi.item.VOIDHEAD_RNG },
				{ name = "Voidtorso: RNG", id = xi.item.VOIDTORSO_RNG },
				{ name = "Voidhand: RNG", id = xi.item.VOIDHAND_RNG },
				{ name = "Voidleg: RNG", id = xi.item.VOIDLEG_RNG },
				{ name = "Voidfoot: RNG", id = xi.item.VOIDFOOT_RNG },
			}},
			{ name = "SAM", items = {
				{ name = "Voidhead: SAM", id = xi.item.VOIDHEAD_SAM },
				{ name = "Voidtorso: SAM", id = xi.item.VOIDTORSO_SAM },
				{ name = "Voidhand: SAM", id = xi.item.VOIDHAND_SAM },
				{ name = "Voidleg: SAM", id = xi.item.VOIDLEG_SAM },
				{ name = "Voidfoot: SAM", id = xi.item.VOIDFOOT_SAM },
			}},
			{ name = "NIN", items = {
				{ name = "Voidhead: NIN", id = xi.item.VOIDHEAD_NIN },
				{ name = "Voidtorso: NIN", id = xi.item.VOIDTORSO_NIN },
				{ name = "Voidhand: NIN", id = xi.item.VOIDHAND_NIN },
				{ name = "Voidleg: NIN", id = xi.item.VOIDLEG_NIN },
				{ name = "Voidfoot: NIN", id = xi.item.VOIDFOOT_NIN },
			}},
			{ name = "DRG", items = {
				{ name = "Voidhead: DRG", id = xi.item.VOIDHEAD_DRG },
				{ name = "Voidtorso: DRG", id = xi.item.VOIDTORSO_DRG },
				{ name = "Voidhand: DRG", id = xi.item.VOIDHAND_DRG },
				{ name = "Voidleg: DRG", id = xi.item.VOIDLEG_DRG },
				{ name = "Voidfoot: DRG", id = xi.item.VOIDFOOT_DRG },
			}},
			{ name = "SMN", items = {
				{ name = "Voidhead: SMN", id = xi.item.VOIDHEAD_SMN },
				{ name = "Voidtorso: SMN", id = xi.item.VOIDTORSO_SMN },
				{ name = "Voidhand: SMN", id = xi.item.VOIDHAND_SMN },
				{ name = "Voidleg: SMN", id = xi.item.VOIDLEG_SMN },
				{ name = "Voidfoot: SMN", id = xi.item.VOIDFOOT_SMN },
			}},
			{ name = "BLU", items = {
				{ name = "Voidhead: BLU", id = xi.item.VOIDHEAD_BLU },
				{ name = "Voidtorso: BLU", id = xi.item.VOIDTORSO_BLU },
				{ name = "Voidhand: BLU", id = xi.item.VOIDHAND_BLU },
				{ name = "Voidleg: BLU", id = xi.item.VOIDLEG_BLU },
				{ name = "Voidfoot: BLU", id = xi.item.VOIDFOOT_BLU },
			}},
			{ name = "COR", items = {
				{ name = "Voidhead: COR", id = xi.item.VOIDHEAD_COR },
				{ name = "Voidtorso: COR", id = xi.item.VOIDTORSO_COR },
				{ name = "Voidhand: COR", id = xi.item.VOIDHAND_COR },
				{ name = "Voidleg: COR", id = xi.item.VOIDLEG_COR },
				{ name = "Voidfoot: COR", id = xi.item.VOIDFOOT_COR },
			}},
			{ name = "PUP", items = {
				{ name = "Voidhead: PUP", id = xi.item.VOIDHEAD_PUP },
				{ name = "Voidtorso: PUP", id = xi.item.VOIDTORSO_PUP },
				{ name = "Voidhand: PUP", id = xi.item.VOIDHAND_PUP },
				{ name = "Voidleg: PUP", id = xi.item.VOIDLEG_PUP },
				{ name = "Voidfoot: PUP", id = xi.item.VOIDFOOT_PUP },
			}},
			{ name = "DNC", items = {
				{ name = "Voidhead: DNC", id = xi.item.VOIDHEAD_DNC },
				{ name = "Voidtorso: DNC", id = xi.item.VOIDTORSO_DNC },
				{ name = "Voidhand: DNC", id = xi.item.VOIDHAND_DNC },
				{ name = "Voidleg: DNC", id = xi.item.VOIDLEG_DNC },
				{ name = "Voidfoot: DNC", id = xi.item.VOIDFOOT_DNC },
			}},
			{ name = "SCH", items = {
				{ name = "Voidhead: SCH", id = xi.item.VOIDHEAD_SCH },
				{ name = "Voidtorso: SCH", id = xi.item.VOIDTORSO_SCH },
				{ name = "Voidhand: SCH", id = xi.item.VOIDHAND_SCH },
				{ name = "Voidleg: SCH", id = xi.item.VOIDLEG_SCH },
				{ name = "Voidfoot: SCH", id = xi.item.VOIDFOOT_SCH },
			}},
			{ name = "GEO", items = {			
				{ name = "Voidhead: GEO", id = xi.item.VOIDHEAD_GEO },
				{ name = "Voidtorso: GEO", id = xi.item.VOIDTORSO_GEO },
				{ name = "Voidhand: GEO", id = xi.item.VOIDHAND_GEO },
				{ name = "Voidleg: GEO", id = xi.item.VOIDLEG_GEO },
				{ name = "Voidfoot: GEO", id = xi.item.VOIDFOOT_GEO },
			}},
			{ name = "RUN", items = {
				{ name = "Voidhead: RUN", id = xi.item.VOIDHEAD_RUN },
				{ name = "Voidtorso: RUN", id = xi.item.VOIDTORSO_RUN },
				{ name = "Voidhand: RUN", id = xi.item.VOIDHAND_RUN },
				{ name = "Voidleg: RUN", id = xi.item.VOIDLEG_RUN },
				{ name = "Voidfoot: RUN", id = xi.item.VOIDFOOT_RUN },
			}},
        }
    },
}

-- Flatten list for storage scanning
local allItems = {}
local isInitialized = false

local function initializeData()
    if isInitialized then return end
    for _, cat in ipairs(categories) do
        if cat.items then
            for _, item in ipairs(cat.items) do
                if item.id then
                    item.var = "Uplox_" .. item.id
                    table.insert(allItems, item)
                end
            end
        elseif cat.groups then
            for _, group in ipairs(cat.groups) do
                for _, item in ipairs(group.items) do
                    if item.id then
                        item.var = "Uplox_" .. item.id
                        table.insert(allItems, item)
                    end
                end
            end
        end
    end
    isInitialized = true
end

local function delaySendMenu(player, menuToSend)
    player:timer(50, function(playerArg)
        playerArg:customMenu(menuToSend)
    end)
end

local function storeItems(player, trade)
    local storedSomething = false

    for _, item in ipairs(allItems) do
        local count = trade:getItemQty(item.id)
        if count > 0 then
            trade:confirmItem(item.id, count)
            local currentBalance = player:getCharVar(item.var)
            player:setCharVar(item.var, currentBalance + count)
            storedSomething = true
            player:printToPlayer(string.format('Stored %d %s. New balance: %d.', count, item.name, currentBalance + count), 0, 'Uplox')
        end
    end

    if storedSomething then
        player:confirmTrade()
    else
        player:printToPlayer('No valid items found in the trade.', 0, 'Uplox')
    end
end

local function retrieveItemWithGil(player, trade, selectedItem)
    local gilAmount = trade:getGil()
    local totalItemsToWithdraw = math.min(gilAmount, 99) -- 1 gil = 1 item fee

    local quantity = player:getCharVar(selectedItem.var)
    if quantity > 0 and totalItemsToWithdraw > 0 then
        local itemsToWithdraw = math.min(totalItemsToWithdraw, quantity)
        if player:getFreeSlotsCount() < math.ceil(itemsToWithdraw / 99) then -- Assuming stack size 99 for simplicity, or 12
            player:printToPlayer('You cannot withdraw that amount. Please check your inventory and try again.', 0, 'Uplox')
            return
        end

        player:addItem(selectedItem.id, itemsToWithdraw)
        player:setCharVar(selectedItem.var, quantity - itemsToWithdraw)
        player:printToPlayer(string.format('You have withdrawn %d %s.', itemsToWithdraw, selectedItem.name), 0, 'Uplox')
        player:printToPlayer(string.format('Your remaining %s balance is %d.', selectedItem.name, player:getCharVar(selectedItem.var)), 0, 'Uplox')
        trade:confirmItem(xi.item.GIL, itemsToWithdraw)
        player:confirmTrade()
    else
        player:printToPlayer('You cannot withdraw that amount. Please check your balance and try again.', 0, 'Uplox')
    end
end

local createCategoryMenu -- Forward declaration
local createGroupMenu -- Forward declaration
local createItemMenu -- Forward declaration

createItemMenu = function(player, categoryIndex, groupIndex, page, trade)
    page = page or 1
    local category = categories[categoryIndex]
    local sourceItems
    local title
    
    if groupIndex then
        sourceItems = category.groups[groupIndex].items
        title = category.groups[groupIndex].name
    else
        sourceItems = category.items
        title = category.name
    end

    local items = {}
    for _, item in ipairs(sourceItems) do
        table.insert(items, item)
    end

    table.sort(items, function(a, b)
        local balA = a.var and player:getCharVar(a.var) or 0
        local balB = b.var and player:getCharVar(b.var) or 0
        if balA == balB then return a.name < b.name end
        return balA > balB
    end)

    local startIndex = (page - 1) * itemsPerPage + 1
    local endIndex = math.min(startIndex + itemsPerPage - 1, #items)
    local options = {}

    for i = startIndex, endIndex do
        local item = items[i]
        local balance = 0
        if item.var then
            balance = player:getCharVar(item.var)
        end
        local text = string.format('%s (%d)', item.name, balance)
        if not item.var then
            text = string.format('%s (Unavailable)', item.name)
        end
        table.insert(options, {
            text,
            function(playerArg)
                if not item.var then
                    playerArg:printToPlayer("This item is unavailable.", 0, 'Uplox')
                    return
                end
                if trade then
                    retrieveItemWithGil(playerArg, trade, item)
                end
            end
        })
    end

    if page > 1 then
        table.insert(options, { 'Prev', function(p) createItemMenu(p, categoryIndex, groupIndex, page - 1, trade) end })
    end
    if endIndex < #items then
        table.insert(options, { 'Next', function(p) createItemMenu(p, categoryIndex, groupIndex, page + 1, trade) end })
    end
    
    table.insert(options, { 'Back', function(p) 
        if groupIndex then
            createGroupMenu(p, categoryIndex, 1, trade)
        else
            createCategoryMenu(p, trade) 
        end
    end })

    delaySendMenu(player, { title = title, options = options })
end

createGroupMenu = function(player, categoryIndex, page, trade)
    page = page or 1
    local category = categories[categoryIndex]
    local groups = category.groups
    local startIndex = (page - 1) * itemsPerPage + 1
    local endIndex = math.min(startIndex + itemsPerPage - 1, #groups)
    local options = {}

    for i = startIndex, endIndex do
        local group = groups[i]
        table.insert(options, {
            group.name,
            function(playerArg)
                createItemMenu(playerArg, categoryIndex, i, 1, trade)
            end
        })
    end

    if page > 1 then
        table.insert(options, { 'Prev', function(p) createGroupMenu(p, categoryIndex, page - 1, trade) end })
    end
    if endIndex < #groups then
        table.insert(options, { 'Next', function(p) createGroupMenu(p, categoryIndex, page + 1, trade) end })
    end
    
    table.insert(options, { 'Back', function(p) createCategoryMenu(p, trade) end })

    delaySendMenu(player, { title = category.name, options = options })
end

createCategoryMenu = function(player, trade)
    local options = {}
    for i, cat in ipairs(categories) do
        table.insert(options, {
            cat.name,
            function(playerArg)
                if cat.groups then
                    createGroupMenu(playerArg, i, 1, trade)
                else
                    createItemMenu(playerArg, i, nil, 1, trade)
                end
            end
        })
    end
    
    delaySendMenu(player, { title = 'Select Category', options = options })
end

m:addOverride('xi.zones.Port_Jeuno.Zone.onInitialize', function(zone)
    super(zone)

    local Uplox = zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = 'Uplox',
        look = 85,
        x = 1.2721, y = 0.0010, z = -9.9873, 
        rotation = 168,
        widescan = 1,
        onTrade = function(player, npc, trade)
            initializeData()
            if npcUtil.tradeHas(trade, xi.item.GIL) then
                createCategoryMenu(player, trade)
            else
                storeItems(player, trade)
            end
        end,
        onTrigger = function(player, npc)
            initializeData()
            createCategoryMenu(player, nil) -- View only mode
            player:printToPlayer('Review your current Parts Balance. To withdraw, trade me gil (1 gil per item). Or trade me the Parts you want stored.', 0, 'Uplox')
        end,
    })
    utils.unused(Uplox)
end)

return m
