Config = {}

-- EITHER "new" or "old"    If new Remove shared_scripts from the fxmanifest.lua

Config.Version = "new" -- If you use a newer version of QBCores "qb-core" (around 1 month old) then set to new otherwise set it to old

Config.Target = "qb"   -- use either "qb", "berkie" or "bt" depending on which target you use (qb-target, berkie-target or bt-target)

Config.CallCops = "true"   -- True or False, do you want police to be notified when a vehicle is being chopped.

Config.CoolDown = 15       -- How long people must wait before starting another job (in minutes)

Config.Email = false -- The sent number plate comes to your phone as an e-mail. If you are going to use Skeepy UI, make it false.

Config.Fuel = 'LegacyFuel'

Config.StartLoc = vector4(-552.0936, -1792.5475, 22.3643, 67.7999)  -- Starting Location with target and PED

Config.WheelItems = {      -- Items you get when chopping a wheel
    [1] = {
        ["item"] = "aluminum",
        ["amount"] = math.random(1, 4)
    },
    [2] = {
        ["item"] = "plastic",
        ["amount"] = math.random(1, 4)
    },
    [3] = {
        ["item"] = "rubber",
        ["amount"] = math.random(1, 4)
    },
}

Config.DoorItems = {    -- Items you get when chopping a door (also includes the trunk and hood)
    [1] = {
        ["item"] = "steel",
        ["amount"] = math.random(2, 5)
    },
    [2] = {
        ["item"] = "plastic",
        ["amount"] = math.random(2, 5)
    },
    [3] = {
        ["item"] = "metalscrap",
        ["amount"] = math.random(2, 5)
    },
    [4] = {
        ["item"] = "iron",
        ["amount"] = math.random(2, 5)
    },
    [5] = {
        ["item"] = "aluminum",
        ["amount"] = math.random(2, 5)
    },
}

Config.TrunkItems = {      -- Items that players can find in the trunk of the vehicle
    [1] = {
        ["item"] = "lockpick",
        ["amount"] = math.random(1, 2)
    },
    [2] = {
        ["item"] = "joint",
        ["amount"] = math.random(1, 4)
    },
    [3] = {
        ["item"] = "weapon_bat",
        ["amount"] = 1,
    },
}

-- ***If you add or remove any of these please also change line 112 in cl_main.lua***
Config.DeliveryCoords = {  -- Locations for the scrapyards **Chosen from random every time you start a new job**
    -- [1] = {
    --     coords = vector4(206.41, -2004.35, 18.2, 49.47), -TESTING
    -- },
    [1] = {
        coords = vector4(2055.7080, 3179.8103, 45.1689, 91.500389),
    },
    [2] = {
        coords = vector4( 2351.7979, 3132.7310, 47.6015, 91.500389),
    },
    [3] = {
        coords = vector4(1565.4553, -2158.8508, 76.9222, 91.500389),
    },
    [4] = {
        coords = vector4(-458.0591, -1712.9053, 18.0516, 91.500389),
    },
}

-- ***If you add or remove any of these please also change line 110 in cl_main.lua***
Config.VehicleList =  {       -- All the different types of vehicles that can spawn. **Chosen from random every time you start a new job**
    [1]  = {vehicle = "Asterope"},
    [2]  = {vehicle = "Premier"},
    [3]  = {vehicle = "Primo2"},
    [4]  = {vehicle = "sultanrs"},
    [5]  = {vehicle = "Stanier"},
    [6]  = {vehicle = "Stratum"},
    [7]  = {vehicle = "Surge"},
    [8]  = {vehicle = "Tailgater"},
    [9]  = {vehicle = "Warrener"},
    [10] = {vehicle = "Washington"},
    [11] = {vehicle = "Asea"},
    [12] = {vehicle = "sultan2"},
    [13] = {vehicle = "Cog55"},
    [14] = {vehicle = "Cognoscenti"},
    [15] = {vehicle = "Emperor"},
    [16] = {vehicle = "Emperor2"},
    [17] = {vehicle = "Fugitive"},
    [18] = {vehicle = "Glendale"},
    [19] = {vehicle = "Ingot"},
    [20] = {vehicle = "Intruder"},
    [21] = {vehicle = "Buffalo"},
    [22] = {vehicle = "Kuruma"},
    [23] = {vehicle = "Schafter2"},
    [24] = {vehicle = "Schwarzer"},
    [25] = {vehicle = "Pigalle"},
    [26] = {vehicle = "Superd"},
    [27] = {vehicle = "Buffalo2"},
    [28] = {vehicle = "Felon"},
    [29] = {vehicle = "Jackal"},
    [30] = {vehicle = "Oracle"},
    [31] = {vehicle = "Sentinel"},
    [32] = {vehicle = "Dilettante"},
    [33] = {vehicle = "Blista"},
    [34] = {vehicle = "Blista2"},
    [35] = {vehicle = "Zion"},
    [36] = {vehicle = "Zion2"},
    [37] = {vehicle = "Feltzer2"},
    [38] = {vehicle = "Ninef"},
    [39] = {vehicle = "Fusilade"},
    [40] = {vehicle = "Jester"},
    [41] = {vehicle = "Carbonizzare"},
    [42] = {vehicle = "Sultan"},
    [43] = {vehicle = "Peyote"},
    [44] = {vehicle = "Buccaneer2"},
    [45] = {vehicle = "Picador"},
    [46] = {vehicle = "Virgo2"},
    [47] = {vehicle = "Brawler"},
}

-- ***If you add or remove any of these please also change line 111 in cl_main.lua***
Config.VehicleCoords = {        -- Locations of where the vehicle can spawn **Chosen from random every time you start a new job**,
    -- [1] = { coords = vector4(222.24, -2017.48, 18.17, 135.5) , radarCoords = vector3(212.38, -2025.43, 18.26) }, -TESTING
    [1] = {coords = vector4(-1074.953, -1160.545, 1.661577, 119.0), radarCoords = vector3(-1093.75, -1131.36, 2.16) },
    [2] = {coords = vector4(-1023.625, -890.4014, 5.202, 216.0399), radarCoords = vector3(-1022.15, -903.87, 2.13)  },
    [3] = {coords = vector4(-1609.647, -382.792, 42.70383, 52.535), radarCoords = vector3(-1636.34, -374.05, 43.78) },
    [4] = {coords = vector4(97.57888, -1946.472, 20.27978, 215.933),radarCoords = vector3(102.8, -1982.58, 20.79)   },
    [5] = {coords = vector4(437.5428, -1925.465, 24.004, 28.82286), radarCoords = vector3(436.09, -1875.0, 27.23)   },
    [6] = {coords = vector4(438.4482, -1838.672, 27.47369, 42.8129),radarCoords = vector3(436.36, -1820.41, 27.98)  },
}

-- All Text used in the script (you can change any of the text you want)
Config.Locale = {
    -- Notifications
    ["Reminder"] 			= "Remove parts from the vehicle then get back into it to to crush it!",
	["FarAway"] 			= "You are to far away from the vehicle. It has been sent to the crusher!",
    ["CoolDown"]            = "There is currently no new jobs, please come back later!",
    ["JobActive"]           = "You have not yet completed the active job!",
    ["Email"]               = "I will send information to your email.",
    ["Ui"]                  = "I'll find you a customer.",
    ["WrongVeh"]            = "This Is not the correct Vehicle",
    ["FoundVeh"]            = "Nice, You found the right car!",
    ["ScrapBlip"]           = "Sending scrapyard location to your GPS...",


    -- Draw Text
    ["chop"] 			    = "~g~E~w~ - Start Chopping",
	["remove"] 				= "~g~E~w~ - Remove the ",
	["destroy"] 			= "~g~E~w~ - Destroy car ",
    ["reqjob"] 			    = "~g~E~w~ - Request Vehicle Information.",
	["Trunk"]				= "Trunk",				
	["Hood"]				= "Hood",				
	["Frontleftdoor"]		= "front left door",	
	["Backleftdoor"]		= "back left door",		
	["Frontrightdoor"]		= "front right door",	
	["Backrightdoor"]		= "back right door",	
	["Frontleftwheel"]		= "front left wheel",	
	["Backleftwheel"]		= "back left wheel",	
	["Rightfrontwheel"]		= "front right wheel",	
	["Rightbackwheel"]		= "back right wheel",	

    -- Progress Bars
    ["Wheel"] 				= "Remove Wheel",
	["Door"] 		        = "Remove Door",
    ["trunk"]               = "Remove Trunk",
    ["hood"]                = "Remove Radiator",
	["crushing"] 			= "Sending car for crushing",
    ["searching"]           = "Looting Trunk",

    ["chopwheel"]           = "Cutting Down the wheel..",
    ["chopdoor"]            = "Cutting Down the door..",
    ["choptrunk"]           = "Cutting Down the trunk..",
    ["chophood"]            = "Cutting Down the hood..",

    --Skeepy UI
    ["title"] 				= "Chopping",

    ["chop1"]               = "I'm looking for some clients for you.",
    ["chop2"]               = "The customer requests this vehicle.<br>Plate: ",
    ["chop3"]               = "Head to chop location",
    ["chop4"]               = "Strip down vehicle of parts",

    --RADAR 

    ["RadarSuccess"]        = "You have successfully unlocked the car.",
    ["RadarError"]          = "You couldn't unlock the car.",


}

Config.CarTable = {
    {name = Config.Locale["Trunk"],			    coords = 0,	    vehBone = "boot", 		        distance = 1.5,		chopped = false,	anim = "trunk",	    	destroy = 5,	getin = 5},
	{name = Config.Locale["Hood"],			    coords = 0,	    vehBone = "overheat",		    distance = 0.8,		chopped = false,	anim = "hood",	    	destroy = 4,	getin = 4},
	{name = Config.Locale["Frontleftdoor"],	    coords = 0,	    vehBone = "door_dside_f",       distance = 0.8,	 	chopped = false,	anim = "door",	    	destroy = 0, 	getin = 0},
	{name = Config.Locale["Backleftdoor"],	    coords = 0,	    vehBone = "door_dside_r",	    distance = 0.8,		chopped = false,	anim = "door",	    	destroy = 2, 	getin = 2},
	{name = Config.Locale["Frontrightdoor"],	coords = 0,	    vehBone = "door_pside_f",	    distance = 0.8,		chopped = false,	anim = "door",	    	destroy = 1, 	getin = -1},
	{name = Config.Locale["Backrightdoor"],	    coords = 0,	    vehBone = "door_pside_r",	    distance = 0.8,		chopped = false,	anim = "door",	   	 	destroy = 3, 	getin = 1},
	{name = Config.Locale["Frontleftwheel"],	coords = 0,	    vehBone = "wheel_lf", 	        distance = 1.3,	 	chopped = "cando",	anim = "wheel1",	    destroy = 0,	getin = 0},
	{name = Config.Locale["Backleftwheel"],	    coords = 0,	    vehBone = "wheel_lr",		    distance = 1.3,		chopped = "cando",	anim = "wheel2",	    destroy = 4,	getin = 0},
	{name = Config.Locale["Rightfrontwheel"],	coords = 0,	    vehBone = "wheel_rf",		    distance = 1.3,		chopped = "cando",	anim = "wheel3",	    destroy = 1,	getin = 0},
	{name = Config.Locale["Rightbackwheel"],	coords = 0,	    vehBone = "wheel_rr",		    distance = 1.3,		chopped = "cando",	anim = "wheel4",	    destroy = 5,	getin = 0},
}
