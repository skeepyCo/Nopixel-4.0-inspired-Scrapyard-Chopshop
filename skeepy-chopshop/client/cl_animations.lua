RegisterNetEvent('skeepy-chopshop:wheelanimation')
AddEventHandler('skeepy-chopshop:wheelanimation', function()
	local ped = PlayerPedId()
	QBCore.Functions.Progressbar("wheel", Config.Locale["Wheel"], 6500, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
		anim = "machinic_loop_mechandplayer",
	}, {}, {}, function()
		ClearPedTasks(ped)
	end, function()
		ClearPedTasks(ped)
		QBCore.Functions.Notify("Canceled", "error")
	end)
end)

RegisterNetEvent('skeepy-chopshop:dooranimation')
AddEventHandler('skeepy-chopshop:dooranimation', function()
	local ped = PlayerPedId()
	QBCore.Functions.Progressbar("Door", Config.Locale["Door"], (4000), false, true, {
	    disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "amb@world_human_welding@male@base",
		anim = "base",
	}, {
		model = "prop_weld_torch",
		bone = 28422,
		coords = {
			x = 0.0,
			y = 0.0,
			z = 0.0
		},
		rotation = {
			x = 0.0,
			y = 0.0,
			z = 0.0
		}
	}, {}, function()
		ClearPedTasks(ped)
	end, function()
		ClearPedTasks(ped)
		QBCore.Functions.Notify("Canceled", "error")
	end)
end)

RegisterNetEvent('skeepy-chopshop:trunkanimation')
AddEventHandler('skeepy-chopshop:trunkanimation', function()
	local ped = PlayerPedId()
	QBCore.Functions.Progressbar("Trunk1", Config.Locale["searching"], (4000), false, true, {
	    disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "mini@repair",
		anim = "fixing_a_ped",
	}, {}, {}, function()
	end)
	Citizen.Wait(4500)
	QBCore.Functions.Progressbar("Trunk2", Config.Locale["trunk"], (5500), false, true, {
	    disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "amb@world_human_welding@male@base",
		anim = "base",
	}, {
		model = "prop_weld_torch",
		bone = 28422,
		coords = {
			x = 0.0,
			y = 0.0,
			z = 0.0
		},
		rotation = {
			x = 0.0,
			y = 0.0,
			z = 0.0
		}
	}, {}, function()
		ClearPedTasks(ped)
	end, function()
		ClearPedTasks(ped)
		QBCore.Functions.Notify("Canceled", "error")
	end)
end)

RegisterNetEvent('skeepy-chopshop:hoodanimation')
AddEventHandler('skeepy-chopshop:hoodanimation', function()
	local ped = PlayerPedId()
	QBCore.Functions.Progressbar("Hood1", Config.Locale["hood"], (4000), false, true, {
	    disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
	}, {}, {}, function()
		ClearPedTasks(ped)
	end, function()
		ClearPedTasks(ped)
		QBCore.Functions.Notify("Canceled", "error")
	end)
end)

RegisterNetEvent('skeepy-chopshop:wheelchopanim')
AddEventHandler('skeepy-chopshop:wheelchopanim', function()
	local ped = PlayerPedId()
	QBCore.Functions.Progressbar("wheel", Config.Locale["chopwheel"], 13000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	end)
	RequestAnimDict("anim@heists@box_carry@")
	Citizen.Wait(100)
    wheelprop = CreateObject(GetHashKey("imp_prop_impexp_tyre_01b"), 0, 0, 0, true, true, true)        
	AttachEntityToEntity(wheelprop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), -0.05, 0.2, 0.35, -145.0, 100.0, 0.0, true, true, false, true, 1, true)
	SetEntityCoords(ped, 472.3670, -1311.3860, 28.2159)
    SetEntityHeading(ped, 124.7478)
	TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 2.0, 2.0, 1500, 51, 0, false, false, false)
	Citizen.Wait(1500)
	DeleteEntity(wheelprop)
	DeleteEntity(wheelprop)
	DeleteObject(wheelprop)
	wheeleobj = CreateObject(GetHashKey("imp_prop_impexp_tyre_01b"), 471.8941, -1311.6477, 29.2602, true, true, true)
	PlaceObjectOnGroundProperly(wheeleobj)
    SetEntityHeading(wheeleobj, 290.6089)
	exports["skeepy_emotes"]:EmoteCommandStart("weld")
	Citizen.Wait(12000)
	ClearPedTasks(ped)
	DeleteEntity(wheeleobj)
	DeleteEntity(wheeleobj)
	DeleteObject(wheeleobj)
end)

RegisterNetEvent('skeepy-chopshop:doorchopanim')
AddEventHandler('skeepy-chopshop:doorchopanim', function()
	local ped = PlayerPedId()    
	QBCore.Functions.Progressbar("door", Config.Locale["chopdoor"], 13000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	end)
	RequestAnimDict("anim@heists@box_carry@")
	Citizen.Wait(100)
	doorprop = CreateObject(GetHashKey("imp_prop_impexp_car_door_04a"), 0, 0, 0, true, true, true)  
    AttachEntityToEntity(doorprop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.08, 0.28, 0.90, -115.0, 180.0, 0.0, true, true, false, true, 1, true)
    SetEntityCoords(ped, 472.5670, -1311.3860, 28.2159)
    SetEntityHeading(ped, 124.747)
	TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 2.0, 2.0, 1500, 51, 0, false, false, false)
	Citizen.Wait(1500)
	DetachEntity(doorprop, 1, true)
	DeleteEntity(doorprop)
	DeleteObject(doorprop)
	doorobj = CreateObject(GetHashKey("imp_prop_impexp_car_door_04a"), 471.5941, -1311.3477, 29.2602, true, true, true)
	PlaceObjectOnGroundProperly(doorobj)
    SetEntityHeading(doorobj, 37.1947)
	exports["skeepy_emotes"]:EmoteCommandStart("weld")
	Citizen.Wait(12000)
	ClearPedTasks(ped)
	DeleteEntity(doorobj)
	DeleteEntity(doorobj)
	DeleteObject(doorobj)
end)

RegisterNetEvent('skeepy-chopshop:hoodchopanim')
AddEventHandler('skeepy-chopshop:hoodchopanim', function()
	local ped = PlayerPedId()    
	QBCore.Functions.Progressbar("hood", Config.Locale["chophood"], 12500, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	end)
	RequestAnimDict("anim@heists@box_carry@")
	Citizen.Wait(100)
	hoodprop = CreateObject(GetHashKey("imp_prop_impexp_bonnet_02a"), 0, 0, 0, true, true, true)  
    AttachEntityToEntity(hoodprop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.15, -0.05, 0.24, -200.0, 110.0, 0.0, true, true, false, true, 1, true)
	SetEntityCoords(ped, 472.8181, -1311.4249, 28.2183)
    SetEntityHeading(ped, 124.3253)
	TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 2.0, 2.0, 1000, 51, 0, false, false, false)
	Citizen.Wait(1000)
	DetachEntity(hoodprop, 1, true)
	DeleteEntity(hoodprop)
	DeleteObject(hoodprop)
	hoodobj = CreateObject(GetHashKey("imp_prop_impexp_bonnet_02a"), 471.8663, -1311.6914, 29.86, true, true, true)
    SetEntityHeading(hoodobj, 118.1908)
	SetEntityRotation(hoodobj, 0.0, 80.0)
	exports["skeepy_emotes"]:EmoteCommandStart("weld")
	Citizen.Wait(12000)
	ClearPedTasks(ped)
	DeleteEntity(hoodobj)
	DeleteEntity(hoodobj)
	DeleteObject(hoodobj)
end)

RegisterNetEvent('skeepy-chopshop:trunkchopanim')
AddEventHandler('skeepy-chopshop:trunkchopanim', function()
	local ped = PlayerPedId()
	QBCore.Functions.Progressbar("trunk", Config.Locale["choptrunk"], 12500, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	end)
	RequestAnimDict("anim@heists@box_carry@")
	Citizen.Wait(100)
	trunkprop = CreateObject(GetHashKey("imp_prop_impexp_bonnet_02a"), 0, 0, 0, true, true, true)  
    AttachEntityToEntity(trunkprop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.15, -0.05, 0.24, -200.0, 110.0, 0.0, true, true, false, true, 1, true)
	SetEntityCoords(ped, 472.5044, -1311.2794, 28.2171)
    SetEntityHeading(ped, 122.8519)
	TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 2.0, 2.0, 1000, 51, 0, false, false, false)
	Citizen.Wait(1000)
	DetachEntity(trunkprop, 1, true)
	DeleteEntity(trunkprop)
	DeleteObject(trunkprop)
	trunkobj = CreateObject(GetHashKey("imp_prop_impexp_bonnet_02a"),471.7178, -1311.6902, 29.82, true, true, true)
    SetEntityHeading(trunkobj, 118.1908)   
	SetEntityRotation(trunkobj, 0.0, 250.0)
	exports["skeepy_emotes"]:EmoteCommandStart("weld")
	Citizen.Wait(12000)
	ClearPedTasks(ped)
	DeleteEntity(trunkobj)
	DeleteEntity(trunkobj)
	DeleteObject(trunkobj)
end)