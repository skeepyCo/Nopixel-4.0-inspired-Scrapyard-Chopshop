if Config.Version == "new" then
    QBCore = exports['qb-core']:GetCoreObject()
end

RegisterNetEvent("skeepy-chopshop:syncchopcars")
AddEventHandler("skeepy-chopshop:syncchopcars", SyncCars)

function GiveReward(data)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if data == "wheel1" or data == "wheel2" or data == "wheel3" or data == "wheel4" then
    		Player.Functions.AddItem("car_wheel", 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['car_wheel'], "add")

	elseif data == "door" then
    	Player.Functions.AddItem("car_door", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['car_door'], "add")
		
	elseif data == "hood" then
    	Player.Functions.AddItem("radiator", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['radiator'], "add")

	elseif data == "trunk" then 
		local randomitem = math.random(1, 3)
		local item = Config.TrunkItems[randomitem]["item"]
		local amount = Config.TrunkItems[randomitem]["amount"]
		Player.Functions.AddItem(item, amount, false, info)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
		TriggerClientEvent('QBCore:Notify', src, "You found "..amount.." "..item.." in the trunk", 'success')
		Citizen.Wait(8500)
		Player.Functions.AddItem("trunk", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['trunk'], "add")
	end
end

RegisterServerEvent('skeepy-chopshop:server:callCops')
AddEventHandler('skeepy-chopshop:server:callCops', function(type, bank, streetLabel, coords)
    local msg = ""
    msg = "Possible Vehicle Robbery"
    local alertData = {
        title = "Chopshop",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = msg,
    }
    TriggerClientEvent("skeepy-chopshop:client:robberyCall", -1, type, bank, streetLabel, coords)
    TriggerClientEvent("qb-phone:client:addPoliceAlert", -1, alertData)
end)

RegisterNetEvent("skeepy-chopshop:server:rewardplayer")
AddEventHandler("skeepy-chopshop:server:rewardplayer", GiveReward)

function SyncCars(list) 
	TriggerClientEvent('skeepy-chopshop:carlist', -1,list) 
end

RegisterNetEvent("skeepy-chopshop:server:chopdoor")
AddEventHandler("skeepy-chopshop:server:chopdoor", function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local door = "car_door"
	
	if Player.Functions.GetItemByName(door) ~= nil then
		local randomitem = math.random(1, 5)
		local item = Config.DoorItems[randomitem]["item"]
		local amount = Config.DoorItems[randomitem]["amount"]
		Player.Functions.RemoveItem("car_door", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['car_door'], "remove")
		TriggerClientEvent('skeepy-chopshop:doorchopanim', src)
		Citizen.Wait(12500)
		Player.Functions.AddItem(item, amount, false, info)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
	else
		TriggerClientEvent('QBCore:Notify', src, 'You have no doors to scrap..', 'error')
	end
end)

RegisterNetEvent("skeepy-chopshop:server:chopwheel")
AddEventHandler("skeepy-chopshop:server:chopwheel", function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local wheel = "car_wheel"

	if Player.Functions.GetItemByName(wheel) ~= nil then
		local randomitem = math.random(1, 3)
		local item = Config.WheelItems[randomitem]["item"]
		local amount = Config.WheelItems[randomitem]["amount"]
		Player.Functions.RemoveItem("car_wheel", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['car_wheel'], "remove")
		TriggerClientEvent('skeepy-chopshop:wheelchopanim', src)
		Citizen.Wait(14000)
		Player.Functions.AddItem(item, amount, false, info)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
	else
		TriggerClientEvent('QBCore:Notify', src, 'You have no wheels to scrap..', 'error')
	end
end)


RegisterNetEvent("skeepy-chopshop:server:chophood")
AddEventHandler("skeepy-chopshop:server:chophood", function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local hood = "radiator" 

	if Player.Functions.GetItemByName(hood) ~= nil then
		local randomitem = math.random(1, 5)
		local item = Config.DoorItems[randomitem]["item"]
		local amount = Config.DoorItems[randomitem]["amount"]
		Player.Functions.RemoveItem("radiator", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['radiator'], "remove")
		TriggerClientEvent('skeepy-chopshop:hoodchopanim', src)
		Citizen.Wait(12500)
		Player.Functions.AddItem(item, amount, false, info)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
	else
		TriggerClientEvent('QBCore:Notify', src, 'You have no hoods to scrap..', 'error')
	end
end)


RegisterNetEvent("skeepy-chopshop:server:choptrunk")
AddEventHandler("skeepy-chopshop:server:choptrunk", function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local trunk = "trunk"

	if Player.Functions.GetItemByName(trunk) ~= nil then
		local randomitem = math.random(1, 5)
		local item = Config.DoorItems[randomitem]["item"]
		local amount = Config.DoorItems[randomitem]["amount"]
		Player.Functions.RemoveItem("trunk", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['trunk'], "remove")
		TriggerClientEvent('skeepy-chopshop:trunkchopanim', src)
		Citizen.Wait(12500)
		Player.Functions.AddItem(item, amount, false, info)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
	else
		TriggerClientEvent('QBCore:Notify', src, 'You have no trunks to scrap..', 'error')
	end
end)

