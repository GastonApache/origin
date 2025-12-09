Config = {}
Config.Locale = GetConvar('esx:locale', 'fr')

Config.Accounts = {
	bank = {
		label = TranslateCap('account_bank'),
		round = true
	},
	black_money = {
		label = TranslateCap('account_black_money'),
		round = true
	},
	money = {
		label = TranslateCap('account_money'),
		round = true
	}
}

Config.BackpackWeight = {
    [40] = 16, 
    [41] = 20, 
    [44] = 25, 
    [45] = 23
}

Config.DoubleJob = { -- default name is faction, but you have example for job2
	enable = true, -- if you want doublejob
	label = "Faction",
	table = "Factions", -- Jobs2
	getTable = "GetFactions", -- GetJobs2
	name = 'faction', -- job2
	event = 'esx:setFaction', -- esx:setJob2
	set = "setFaction", -- setJob2
	get = "getFaction", -- getJob2
	all = "GetFactions", -- GetJobs2
	does = "DoesFactionExist", -- DoesJob2Exist
	refresh = "RefreshFactions", -- RefreshJob2
	database = {
		list = 'factions', -- jobs2
		list_grade = 'faction_grades', -- job2_grades
		list_grade_name = 'faction_name', -- job2_name
		users_dj_name = 'faction', -- job2
		users_dj_grade = 'faction_grade' -- job2_grade
	},
	default = {
		list = {
			name = "nofaction", -- unemployed
			label = "Faction", -- Unemployed
		},
		list_grade = {
			name = "nofaction",
			label = "Sans faction",
			grade = 0
		}
	},
	command =  {
		name = 'setfaction',
		group = 'admin',
		translate = {
			'Commande setfactopn invalide',
			'Assignez une faction au joueur',
			'Nom de la faction',
			'Numéro du grade'
		}
	},
	translate = {
		'Vous avez joué un event sans autorisation (tricheur)'
	}
}

Config.StartingAccountMoney 	= {bank = 50000}
Config.StartingItems 			= {money = 500, water = 2, burger = 2}

Config.DefaultSpawn 			= { x = -769.02502441, y = 323.08599854, z = 195.87930298 -1, heading = 106.61 }


Config.EnablePaycheck			= true -- enable paycheck
Config.EnableSocietyPayouts 	= false -- pay from the society account that the player is employed at? Requirement: esx_society
Config.MaxWeight            	= 24   -- the max inventory weight without backpack
Config.PaycheckInterval         = 7 * 60000 -- how often to recieve pay checks in milliseconds
Config.EnableDebug              = false -- Use Debug options?
Config.EnableDefaultInventory   = true -- Display the default Inventory ( F2 )
Config.EnableWantedLevel    	= false -- Use Normal GTA wanted Level?
Config.EnablePVP                = true -- Allow Player to player combat

Config.Multichar                = GetResourceState("esx_multicharacter") ~= "missing"
Config.Identity                 = false -- Select a characters identity data before they have loaded in (this happens by default with multichar)
Config.DistanceGive 			= 4.0 -- Max distance when giving items, weapons etc.

Config.DisableHealthRegeneration  = false -- Player will no longer regenerate health
Config.DisableVehicleRewards      = false -- Disables Player Recieving weapons from vehicles
Config.DisableNPCDrops            = false -- stops NPCs from dropping weapons on death
Config.DisableDispatchServices	  = false -- Disable Dispatch services
Config.DisableScenarios			  = false -- Disable Scenarios
Config.DisableWeaponWheel         = false -- Disables default weapon wheel
Config.DisableAimAssist           = false -- disables AIM assist (mainly on controllers)
Config.DisableVehicleSeatShuff	  = false -- Disables vehicle seat shuff
Config.RemoveHudCommonents = {
	[1] = false, --WANTED_STARS,
	[2] = false, --WEAPON_ICON
	[3] = false, --CASH
	[4] = false,  --MP_CASH
	[5] = false, --MP_MESSAGE
	[6] = false, --VEHICLE_NAME
	[7] = false,-- AREA_NAME
	[8] = false,-- VEHICLE_CLASS
	[9] = false, --STREET_NAME
	[10] = false, --HELP_TEXT
	[11] = false, --FLOATING_HELP_TEXT_1
	[12] = false, --FLOATING_HELP_TEXT_2
	[13] = false, --CASH_CHANGE
	[14] = false, --RETICLE
	[15] = false, --SUBTITLE_TEXT
	[16] = false, --RADIO_STATIONS
	[17] = false, --SAVING_GAME,
	[18] = false, --GAME_STREAM
	[19] = false, --WEAPON_WHEEL
	[20] = false, --WEAPON_WHEEL_STATS
	[21] = false, --HUD_COMPONENTS
	[22] = false, --HUD_WEAPONS
}

Config.SpawnVehMaxUpgrades = true -- admin vehicles spawn with max vehcle settings
Config.CustomAIPlates = 'ESX.A111' -- Custom plates for AI vehicles 
-- Pattern string format
--1 will lead to a random number from 0-9.
--A will lead to a random letter from A-Z.
-- . will lead to a random letter or number, with 50% probability of being either.
--^1 will lead to a literal 1 being emitted.
--^A will lead to a literal A being emitted.
--Any other character will lead to said character being emitted.
-- A string shorter than 8 characters will be padded on the right.

Config.Components = {{
    label = TranslateCap('sex'),
    name = 'sex',
    value = 0,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('mom'),
    name = 'mom',
    value = 21,
    min = 21,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('dad'),
    name = 'dad',
    value = 0,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('resemblance'),
    name = 'face_md_weight',
    value = 50,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('skin_tone'),
    name = 'skin_md_weight',
    value = 50,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('nose_1'),
    name = 'nose_1',
    value = 0,
    min = -10,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('nose_2'),
    name = 'nose_2',
    value = 0,
    min = -10,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('nose_3'),
    name = 'nose_3',
    value = 0,
    min = -10,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('nose_4'),
    name = 'nose_4',
    value = 0,
    min = -10,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('nose_5'),
    name = 'nose_5',
    value = 0,
    min = -10,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('nose_6'),
    name = 'nose_6',
    value = 0,
    min = -10,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('cheeks_1'),
    name = 'cheeks_1',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('cheeks_2'),
    name = 'cheeks_2',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('cheeks_3'),
    name = 'cheeks_3',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('lip_fullness'),
    name = 'lip_thickness',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('jaw_bone_width'),
    name = 'jaw_1',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('jaw_bone_length'),
    name = 'jaw_2',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('chin_height'),
    name = 'chin_1',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('chin_length'),
    name = 'chin_2',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('chin_width'),
    name = 'chin_3',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('chin_hole'),
    name = 'chin_4',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('neck_thickness'),
    name = 'neck_thickness',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('hair_1'),
    name = 'hair_1',
    value = 0,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('hair_2'),
    name = 'hair_2',
    value = 0,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('hair_color_1'),
    name = 'hair_color_1',
    value = 0,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('hair_color_2'),
    name = 'hair_color_2',
    value = 0,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('tshirt_1'),
    name = 'tshirt_1',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15,
    componentId = 8
}, {
    label = TranslateCap('tshirt_2'),
    name = 'tshirt_2',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15,
    textureof = 'tshirt_1'
}, {
    label = TranslateCap('torso_1'),
    name = 'torso_1',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15,
    componentId = 11
}, {
    label = TranslateCap('torso_2'),
    name = 'torso_2',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15,
    textureof = 'torso_1'
}, {
    label = TranslateCap('decals_1'),
    name = 'decals_1',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15,
    componentId = 10
}, {
    label = TranslateCap('decals_2'),
    name = 'decals_2',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15,
    textureof = 'decals_1'
}, {
    label = TranslateCap('arms'),
    name = 'arms',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15
}, {
    label = TranslateCap('arms_2'),
    name = 'arms_2',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15
}, {
    label = TranslateCap('pants_1'),
    name = 'pants_1',
    value = 0,
    min = 0,
    zoomOffset = 0.8,
    camOffset = -0.5,
    componentId = 4
}, {
    label = TranslateCap('pants_2'),
    name = 'pants_2',
    value = 0,
    min = 0,
    zoomOffset = 0.8,
    camOffset = -0.5,
    textureof = 'pants_1'
}, {
    label = TranslateCap('shoes_1'),
    name = 'shoes_1',
    value = 0,
    min = 0,
    zoomOffset = 0.8,
    camOffset = -0.8,
    componentId = 6
}, {
    label = TranslateCap('shoes_2'),
    name = 'shoes_2',
    value = 0,
    min = 0,
    zoomOffset = 0.8,
    camOffset = -0.8,
    textureof = 'shoes_1'
}, {
    label = TranslateCap('mask_1'),
    name = 'mask_1',
    value = 0,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65,
    componentId = 1
}, {
    label = TranslateCap('mask_2'),
    name = 'mask_2',
    value = 0,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65,
    textureof = 'mask_1'
}, {
    label = TranslateCap('bproof_1'),
    name = 'bproof_1',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15,
    componentId = 9
}, {
    label = TranslateCap('bproof_2'),
    name = 'bproof_2',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15,
    textureof = 'bproof_1'
}, {
    label = TranslateCap('chain_1'),
    name = 'chain_1',
    value = 0,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65,
    componentId = 7
}, {
    label = TranslateCap('chain_2'),
    name = 'chain_2',
    value = 0,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65,
    textureof = 'chain_1'
}, {
    label = TranslateCap('helmet_1'),
    name = 'helmet_1',
    value = -1,
    min = -1,
    zoomOffset = 0.6,
    camOffset = 0.65,
    componentId = 0
}, {
    label = TranslateCap('helmet_2'),
    name = 'helmet_2',
    value = 0,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65,
    textureof = 'helmet_1'
}, {
    label = TranslateCap('glasses_1'),
    name = 'glasses_1',
    value = 0,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65,
    componentId = 1
}, {
    label = TranslateCap('glasses_2'),
    name = 'glasses_2',
    value = 0,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65,
    textureof = 'glasses_1'
}, {
    label = TranslateCap('watches_1'),
    name = 'watches_1',
    value = -1,
    min = -1,
    zoomOffset = 0.75,
    camOffset = 0.15,
    componentId = 6
}, {
    label = TranslateCap('watches_2'),
    name = 'watches_2',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15,
    textureof = 'watches_1'
}, {
    label = TranslateCap('bracelets_1'),
    name = 'bracelets_1',
    value = -1,
    min = -1,
    zoomOffset = 0.75,
    camOffset = 0.15,
    componentId = 7
}, {
    label = TranslateCap('bracelets_2'),
    name = 'bracelets_2',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15,
    textureof = 'bracelets_1'
}, {
    label = TranslateCap('bag'),
    name = 'bags_1',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15,
    componentId = 5
}, {
    label = TranslateCap('bag_color'),
    name = 'bags_2',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15,
    textureof = 'bags_1'
}, {
    label = TranslateCap('eye_color'),
    name = 'eye_color',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('eye_squint'),
    name = 'eye_squint',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('eyebrow_size'),
    name = 'eyebrows_2',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('eyebrow_type'),
    name = 'eyebrows_1',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('eyebrow_color_1'),
    name = 'eyebrows_3',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('eyebrow_color_2'),
    name = 'eyebrows_4',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('eyebrow_height'),
    name = 'eyebrows_5',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('eyebrow_depth'),
    name = 'eyebrows_6',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('makeup_type'),
    name = 'makeup_1',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('makeup_thickness'),
    name = 'makeup_2',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('makeup_color_1'),
    name = 'makeup_3',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('makeup_color_2'),
    name = 'makeup_4',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('lipstick_type'),
    name = 'lipstick_1',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('lipstick_thickness'),
    name = 'lipstick_2',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('lipstick_color_1'),
    name = 'lipstick_3',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('lipstick_color_2'),
    name = 'lipstick_4',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('ear_accessories'),
    name = 'ears_1',
    value = -1,
    min = -1,
    zoomOffset = 0.4,
    camOffset = 0.65,
    componentId = 2
}, {
    label = TranslateCap('ear_accessories_color'),
    name = 'ears_2',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65,
    textureof = 'ears_1'
}, {
    label = TranslateCap('chest_hair'),
    name = 'chest_1',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15
}, {
    label = TranslateCap('chest_hair_1'),
    name = 'chest_2',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15
}, {
    label = TranslateCap('chest_color'),
    name = 'chest_3',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15
}, {
    label = TranslateCap('bodyb'),
    name = 'bodyb_1',
    value = -1,
    min = -1,
    zoomOffset = 0.75,
    camOffset = 0.15
}, {
    label = TranslateCap('bodyb_size'),
    name = 'bodyb_2',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15
}, {
    label = TranslateCap('bodyb_extra'),
    name = 'bodyb_3',
    value = -1,
    min = -1,
    zoomOffset = 0.4,
    camOffset = 0.15
}, {
    label = TranslateCap('bodyb_extra_thickness'),
    name = 'bodyb_4',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.15
}, {
    label = TranslateCap('wrinkles'),
    name = 'age_1',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('wrinkle_thickness'),
    name = 'age_2',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('blemishes'),
    name = 'blemishes_1',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('blemishes_size'),
    name = 'blemishes_2',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('blush'),
    name = 'blush_1',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('blush_1'),
    name = 'blush_2',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('blush_color'),
    name = 'blush_3',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('complexion'),
    name = 'complexion_1',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('complexion_1'),
    name = 'complexion_2',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('sun'),
    name = 'sun_1',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('sun_1'),
    name = 'sun_2',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('freckles'),
    name = 'moles_1',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('freckles_1'),
    name = 'moles_2',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('beard_type'),
    name = 'beard_1',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('beard_size'),
    name = 'beard_2',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('beard_color_1'),
    name = 'beard_3',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('beard_color_2'),
    name = 'beard_4',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}}
