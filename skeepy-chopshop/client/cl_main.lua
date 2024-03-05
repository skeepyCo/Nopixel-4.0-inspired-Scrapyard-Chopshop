-- New Core and Old Core stuff
if Config.Version == "new" then
    QBCore = exports['qb-core']:GetCoreObject()
end

local PlayerJob = {}
local secondwave = false
local vehicle
local start = false
local removedpart = false

local dropoffx = nil
local dropoffy = nil
local dropoffz = nil
local dropoffm = nil

local LicensePlate = nil
local randomLoc = nil
local vehicle = nil
local copsCalled = false
local cooldown = false
local scrapblip = false


-- Job Update and checks
RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = true
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
    onDuty = true
end)

Citizen.CreateThread(function()
    Wait(500)
    if QBCore.Functions.GetPlayerData() ~= nil then
        PlayerJob = QBCore.Functions.GetPlayerData().job
        onDuty = true
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200)
        while dropoffx or dropoffy or dropoffz ~= nil do
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local dis = #(pos - vector3(dropoffx, dropoffy, dropoffz))
            SetDrawOrigin(dropoffx, dropoffy, dropoffz, 0)
            if dis <= 8 then
                if dis <= 8 and IsPedInAnyVehicle(ped) and start == false then
                    DrawSprite("skeepy_ui", "key", 0, 0, 0.018, 0.030, 0, 255, 255, 255, 255)
                    DrawSprite("skeepy_ui", "start_chop", 0.044, 0, 0.06, 0.028, 0, 255, 255, 255, 255)
                    -- DrawText3Ds(dropoffx, dropoffy, dropoffz, Config.Locale["chop"])
                    if IsControlJustPressed(0, 38) then
                        ScrapVehicle()
                    end
                end
            end
            Citizen.Wait(3)
        end
    end
end)

local mert = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200)
        if scrapblip then
            Citizen.Wait(1000)
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local dist = #(pos - vector3(Config.VehicleCoords[randomCoords]['coords'].x, Config.VehicleCoords[randomCoords]['coords'].y, Config.VehicleCoords[randomCoords]['coords'].z))
            local scanner = vector3(Config.VehicleCoords[randomCoords]['radarCoords'].x,
                Config.VehicleCoords[randomCoords]['radarCoords'].y, Config.VehicleCoords[randomCoords]['radarCoords'].z)

            Citizen.Wait(1)

            if not mert then
                print(scanner)
                exports['skeepy-chopshop']:SetupDigiScanner(scanner, {})
                mert = true
            end
            if dist <= 3 then
                if not copsCalled then
                    local s1, s2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.PointerValueInt(),
                        Citizen.PointerValueInt())
                    local street1 = GetStreetNameFromHashKey(s1)
                    local street2 = GetStreetNameFromHashKey(s2)
                    local streetLabel = street1
                    if street2 ~= nil then
                        streetLabel = streetLabel .. " " .. street2
                    end
                    TriggerServerEvent("skeepy-chopshop:server:callCops", "Chopshop", 0, streetLabel, pos)
                    copsCalled = true
                end
                Citizen.Wait(5000)
                QBCore.Functions.Notify(Config.Locale["FoundVeh"], 'success')
                exports["skeepy-ui"]:Show(Config.Locale["title"], Config.Locale["chop3"])
                Citizen.Wait(10000)
                QBCore.Functions.Notify(Config.Locale["ScrapBlip"], 'primary')
                CreateBlip2()
                SetNewWaypoint(dropoffx, dropoffy)
                scrapblip = false
            end
        end
    end
end)

RegisterNetEvent('skeepy-chopshop:jobaccept')
AddEventHandler('skeepy-chopshop:jobaccept', function()
    if cooldown == false then
        if LicensePlate ~= nil then
            QBCore.Functions.Notify(Config.Locale["JobActive"], 'error')
        else
            -- randomVeh = math.random(1, 1)
            -- randomCoords = math.random(1, 1) --TESTING
            -- randomLoc = math.random(1, 1)
            randomVeh = math.random(1, 47)
            randomCoords = math.random(1,6) --EDIT
            randomLoc = math.random(1,4)
            SpawnVehicle(Config.VehicleList[randomVeh].vehicle, Config.VehicleCoords[randomCoords]['coords'].x,
                Config.VehicleCoords[randomCoords]['coords'].y, Config.VehicleCoords[randomCoords]['coords'].z,
                Config.VehicleCoords[randomCoords]['coords'].w)
        end
    else
        QBCore.Functions.Notify(Config.Locale["CoolDown"], 'error')
    end
end)


function SpawnVehicle(vehicle, x, y, z, w)
    local coords = vector4(x, y, z, w)
    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        SetEntityHeading(veh, coords.w)
        SetVehicleEngineOn(veh, false, false)
        SetVehicleOnGroundProperly(veh)
        SetVehicleNeedsToBeHotwired(veh, false)
        SetVehicleColours(vehicle, 0, 0)
        exports[Config.Fuel]:SetFuel(veh, 100.0)
        for i = 0, 5 do
            SetVehicleDoorShut(veh, i, true)
        end
        LicensePlate = GetVehicleNumberPlateText(veh)
        dropoffx, dropoffy, dropoffz, dropoffm = Config.DeliveryCoords[randomLoc]['coords'].x,
            Config.DeliveryCoords[randomLoc]['coords'].y, Config.DeliveryCoords[randomLoc]['coords'].z,
            Config.DeliveryCoords[randomLoc]['coords'].w
        if Config.Email == true then
            QBCore.Functions.Notify(Config.Locale["Email"], 'success')
        else
            QBCore.Functions.Notify(Config.Locale["Ui"], 'success')
        end
        exports["skeepy-ui"]:Show(Config.Locale["title"], Config.Locale["chop1"])
        Citizen.Wait(math.random(5000,10000 ))
        print(randomCoords)
        if Config.Email == true then
            TriggerServerEvent('qb-phone:server:sendNewMail', {
                sender = "Chop Shop",
                subject = "Vehicle Located",
                message = "Hello,<br><br> The vehicle you need to collect is a<br><b>" ..
                vehicle ..
                " </b> <br><br>The license plate is - <br><b>" ..
                LicensePlate ..
                "</b>.<br><br>The approximate position of the <b>vehicle</b> and the <b>scrapyard</b> you <b>need</b> to bring it to are marked on your GPS.",
            })
        else
            exports["skeepy-ui"]:Show(Config.Locale["title"],
                "The customer requests this vehicle.<br>Plate: " .. LicensePlate)
        end
        Citizen.Wait(math.random(1000, 2000))
        CreateBlip(coords.x, coords.y)
        scrapblip = true
        cooldown = true
        Citizen.Wait(Config.CoolDown * 60000)
        cooldown = false
    end, coords, true)
end

function ScrapVehicle()
    local ped = PlayerPedId()
    vehicle = GetVehiclePedIsIn(ped, false)
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    if GetVehicleNumberPlateText(veh) ~= LicensePlate then
        QBCore.Functions.Notify(Config.Locale["WrongVeh"], 'error')
    else
        local netId = NetworkGetNetworkIdFromEntity(vehicle)
        QBCore.Functions.Notify(Config.Locale["Reminder"], 8000)
        exports["skeepy-ui"]:Show(Config.Locale["title"], Config.Locale["chop4"])
        StartChopping()
        DeleteBlip()
    end
end

-- Police alert function used to alert all active police on Duty
RegisterNetEvent('skeepy-chopshop:client:robberyCall')
AddEventHandler('skeepy-chopshop:client:robberyCall', function(type, key, streetLabel, coords)
    if PlayerJob.name == "police" and onDuty then
        local bank = "Vehicle Robbery"
        if type == "Chopshop" then
            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            TriggerEvent('chatMessage', "DISPATCH", "warning", "Vehicle robbery")
            TriggerEvent('qb-policealerts:client:AddPoliceAlert', {
                timeOut = 15000,
                alertTitle = "Possible Vehicle Robbery",
                coords = {
                    x = coords.x,
                    y = coords.y,
                    z = coords.z,
                },
                details = {
                    [1] = {
                        icon = '<i class="fas fa-car"></i>',
                        detail = bank,
                    },
                    [2] = {
                        icon = '<i class="fas fa-globe-europe"></i>',
                        detail = streetLabel,
                    },
                },
                callSign = QBCore.Functions.GetPlayerData().metadata["callsign"],
            })

            local transG = 250
            local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
            SetBlipSprite(blip, 227)
            SetBlipColour(blip, 4)
            SetBlipDisplay(blip, 4)
            SetBlipAlpha(blip, transG)
            SetBlipScale(blip, 1.9)
            SetBlipFlashes(blip, true)
            SetBlipAsShortRange(blip, false)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString("911: Vehicle Robbery")
            EndTextCommandSetBlipName(blip)

            while transG ~= 0 do
                Wait(180 * 4)
                transG = transG - 1
                SetBlipAlpha(blip, transG)
                if transG == 0 then
                    SetBlipSprite(blip, 2)
                    RemoveBlip(blip)
                    return
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while not HasStreamedTextureDictLoaded("skeepy_ui") do
        Wait(10)
        RequestStreamedTextureDict("skeepy_ui", true)
    end
    local sleep
    while true do
        sleep = 100
        if start then
            FreezeEntityPosition(vehicle, true)
            for k = 1, #Config.CarTable, 1 do
                SetDrawOrigin(Config.CarTable[k].coords.x, Config.CarTable[k].coords.y, Config.CarTable[k].coords.z, 0)
                if Config.CarTable[k].chopped == "cando" and DoesEntityExist(vehicle) and not IsPedInAnyVehicle(PlayerPedId(-1)) then
                    sleep = 0
                    local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),
                        Config.CarTable[k].coords.x, Config.CarTable[k].coords.y, Config.CarTable[k].coords.z, true)
                    if distance > 1 and distance < 5 then
                        DrawSprite("skeepy_ui", "point", 0, 0, 0.015, 0.025, 0, 255, 255, 255, 200)
                    end
                    if distance < Config.CarTable[k].distance then
                        DrawSprite("skeepy_ui", "key", 0, 0, 0.018, 0.030, 0, 255, 255, 255, 255)
                        DrawSprite("skeepy_ui", "remove", 0.044, 0, 0.06, 0.028, 0, 255, 255, 255, 255)
                        if (IsControlJustPressed(1, 38)) then
                            StartAnimation(k)
                        end
                        if removedpart == false then
                            removedpart = true
                        end
                    end
                end
            end
            if Config.CarTable[7].chopped == true and Config.CarTable[8].chopped == true and Config.CarTable[9].chopped == true and Config.CarTable[10].chopped == true and secondwave == false then
                for i = 1, 6, 1 do
                    Config.CarTable[i].chopped = "cando"
                end
                secondwave = true
            end
            if GetVehiclePedIsIn(GetPlayerPed(-1)) == vehicle and removedpart == true then
                local pos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "windscreen"))
                sleep = 0
                -- DrawText3Ds(pos.x,pos.y,pos.z,Config.Locale["destroy"])
                SetDrawOrigin(pos.x, pos.y, pos.z, 0)
                DrawSprite("skeepy_ui", "key", 0, 0, 0.018, 0.030, 0, 255, 255, 255, 255)
                DrawSprite("skeepy_ui", "destroy_car", 0.044, 0, 0.06, 0.028, 0, 255, 255, 255, 255)
                if (IsControlJustPressed(1, 38)) then
                    QBCore.Functions.Progressbar("crushing", Config.Locale["crushing"], (6500), false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {}, {}, {}, function()
                        TaskLeaveVehicle(GetPlayerPed(-1), vehicle, 1)
                        exports["skeepy-ui"]:Close()
                        Citizen.Wait(1500)
                        NetworkFadeOutEntity(vehicle, false, false)
                        Citizen.Wait(1000)
                        DeleteEntity(vehicle)
                        Reset()
                        LicensePlate, dropoffx, dropoffy, dropoffz, dropoffm, randomVeh, randomCoords = nil
                    end)
                end
            end
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(-1)), dropoffx, dropoffy, dropoffz, true) > 50 and start == true then
                VehicleToFar()
            end
        end
        Wait(sleep)
    end
end)

function StartAnimation(k)
    if Config.CarTable[k].anim == "wheel1" or Config.CarTable[k].anim == "wheel2" or Config.CarTable[k].anim == "wheel3" or Config.CarTable[k].anim == "wheel4" then
        TriggerEvent('skeepy-chopshop:wheelanimation')
        Citizen.Wait(7000)
        if Config.CarTable[k].anim == "wheel1" then
            SetVehicleWheelXOffset(vehicle, 0, -2000)
        elseif Config.CarTable[k].anim == "wheel2" then
            SetVehicleWheelXOffset(vehicle, 2, -2000)
        elseif Config.CarTable[k].anim == "wheel3" then
            SetVehicleWheelXOffset(vehicle, 1, -2000)
        elseif Config.CarTable[k].anim == "wheel4" then
            SetVehicleWheelXOffset(vehicle, 3, -2000)
        end
        Config.CarTable[k].chopped = true
        TriggerServerEvent('skeepy-chopshop:server:rewardplayer', Config.CarTable[k].anim)
    elseif Config.CarTable[k].anim == "door" then
        TaskOpenVehicleDoor(GetPlayerPed(-1), vehicle, 3000, Config.CarTable[k].getin, 10)
        Citizen.Wait(2500)
        TriggerEvent('skeepy-chopshop:dooranimation')
        Citizen.Wait(4200)
        SetVehicleDoorBroken(vehicle, Config.CarTable[k].destroy, true)
        Config.CarTable[k].chopped = true
        TriggerServerEvent('skeepy-chopshop:server:rewardplayer', Config.CarTable[k].anim)
    elseif Config.CarTable[k].anim == "trunk" then
        SetVehicleDoorOpen(vehicle, Config.CarTable[k].destroy, false, true)
        TriggerEvent('skeepy-chopshop:trunkanimation')
        Citizen.Wait(2000)
        Config.CarTable[k].chopped = true
        TriggerServerEvent('skeepy-chopshop:server:rewardplayer', Config.CarTable[k].anim)
        Citizen.Wait(1000)
        SetVehicleDoorBroken(vehicle, Config.CarTable[k].destroy, true)
    elseif Config.CarTable[k].anim == "hood" then
        SetVehicleDoorOpen(vehicle, Config.CarTable[k].destroy, false, true)
        TriggerEvent('skeepy-chopshop:hoodanimation')
        Citizen.Wait(4000)
        SetVehicleDoorBroken(vehicle, Config.CarTable[k].destroy, true)
        Config.CarTable[k].chopped = true
        TriggerServerEvent('skeepy-chopshop:server:rewardplayer', Config.CarTable[k].anim)
    end
end

function VehicleToFar()
    DeleteEntity(vehicle)
    Reset()
    exports["skeepy-ui"]:Close()
    QBCore.Functions.Notify(Config.Locale["FarAway"], 'error')
end

function CreateBlip(x, y)
    DeleteBlip()
    x = x + math.random(-75.0, 75.0)
    y = y + math.random(-75.0, 75.0)

    blip = AddBlipForRadius(x, y, 0.0, 100.0)
    SetBlipSprite(blip, 9)
    SetBlipColour(blip, 38)
    SetBlipAlpha(blip, 80)
end

function CreateBlip2()
    DeleteBlip()
    blip2 = AddBlipForCoord(dropoffx, dropoffy, dropoffz)
    SetBlipSprite(blip2, 380)
    SetBlipColour(blip2, 33)
    SetBlipAlpha(blip2, 200)
    SetBlipDisplay(blip2, 4)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Scrap Yard")
    EndTextCommandSetBlipName(blip2)
end

function DrawText3Ds(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function DeleteBlip()
    if DoesBlipExist(blip) then
        RemoveBlip(blip)
    end
    if DoesBlipExist(blip2) then
        RemoveBlip(blip2)
    end
end

function StartChopping()
    for i = 1, #Config.CarTable, 1
    do
        local pos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, Config.CarTable[i].vehBone))
        Config.CarTable[i].coords = pos
    end
    start = true
    for k = -1, 2, 1
    do
        local pedseat = GetPedInVehicleSeat(vehicle, k)
        TaskLeaveVehicle(pedseat, vehicle, 1)
    end
end

function Reset()
    for i = 1, #Config.CarTable, 1
    do
        if i <= 6 then
            Config.CarTable[i].chopped = false
        else
            Config.CarTable[i].chopped = "cando"
        end
    end
    secondwave = false
    vehicle = nil
    start = false
    removedpart = false
end

-- SCANNER

local scaleform = RequestScaleformMovie("DIGISCANNER")
local inScaleform = false
local ped = PlayerPedId()
local targetCoords = vector3(0, 0, 0)
local params = {}
local sfpos = {
    x = 0.1,
    y = 0.24,
    width = 0.21,
    height = 0.51,
}
local wait, blip
local sfcolors = {
    red = { r = 255, g = 10, b = 10 },
    yellow = { r = 255, g = 209, b = 67 },
    lightblue = { r = 67, g = 200, b = 255 },
    green = { r = 0, g = 255, b = 80 }

}

local function ScaleformMethod(sf, name, data)
    BeginScaleformMovieMethod(sf, name)
    for _, v in ipairs(data or {}) do
        if name == "SET_DISTANCE" then
            PushScaleformMovieMethodParameterFloat(v)
        else
            PushScaleformMovieMethodParameterInt(v)
        end
    end
    PopScaleformMovieFunctionVoid()
end

local sfbars = {
    { dist = 500, bars = 30.0,  wait = 7000 },
    { dist = 400, bars = 40.0,  wait = 6000 },
    { dist = 300, bars = 50.0,  wait = 5000 },
    { dist = 150, bars = 60.0,  wait = 4000 },
    { dist = 80,  bars = 70.0,  wait = 3000 },
    { dist = 40,  bars = 80.0,  wait = 2000 },
    { dist = 10,  bars = 90.0,  wait = 1000 },
    { dist = 0,   bars = 100.0, wait = 500 },
}

local function SetScaleformColor(bar, dot)
    if not inScaleform then return end
    ScaleformMethod(scaleform, "SET_COLOUR", { bar.r, bar.g, bar.b, dot.r, dot.g, dot.b })
end

local function Flashing(dat)
    if dat == true then
        ScaleformMethod(scaleform, "flashOn")
    else
        ScaleformMethod(scaleform, "flashOff")
    end
end

local function TriggerEvents()
    inScaleform = false
    local params = params
    if blip then
        RemoveBlip(blip)
        blip = nil
    end
    if params.event then
        if params.isServer then
            TriggerServerEvent(params.event, params.args)
        elseif params.isCommand then
            ExecuteCommand(params.event)
        elseif params.isAction then
            params.event(params.args)
        else
            TriggerEvent(params.event, params.args)
        end
    end
end


function SetupScaleform(scaleform, Buttons)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Wait(0)
    end
    DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 0, 0)
    for i = 1, #Buttons do
        PushScaleformMovieFunction(scaleform, Buttons[i].type)
        if Buttons[i].int then PushScaleformMovieFunctionParameterInt(Buttons[i].int) end
        if Buttons[i].keyIndex then
            for _, v in pairs(Buttons[i].keyIndex) do
                N_0xe83a3e3557a56640(GetControlInstructionalButton(2, v, true))
            end
        end
        if Buttons[i].name then
            BeginTextCommandScaleformString("STRING")
            AddTextComponentScaleform(Buttons[i].name)
            EndTextCommandScaleformString()
        end
        if Buttons[i].type == 'SET_BACKGROUND_COLOUR' then
            for u = 1, 4 do
                PushScaleformMovieFunctionParameterInt(80)
            end
        end
        PopScaleformMovieFunctionVoid()
    end
    return scaleform
end

local form = nil

function UpdateBars(dist, plate)
    if not scaleform then return end

    for i = 1, #sfbars do
        if dist > sfbars[i].dist then
            wait = sfbars[i].wait
            ScaleformMethod(scaleform, "SET_DISTANCE", { sfbars[i].bars })
            break
        end
    end

    if dist < 1.0 then
        wait = 250
        SetScaleformColor(sfcolors.green, sfcolors.green)
        Flashing(true)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        -- if IsControlJustPressed(0, params.interact.interactKey) then
        --     TriggerEvents()
        -- end
        if not mert then
            exports["skeepy-thermite"]:thermiteminigame(10, 3, 3, 10,
                function()
                    TriggerEvents()
                    TriggerEvent("vehiclekeys:client:SetOwner", LicensePlate)
                    QBCore.Functions.Notify(Config.Locale["RadarSuccess"], 'success')
                    if not copsCalled then
                        local s1, s2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.PointerValueInt(),Citizen.PointerValueInt())
                        local street1 = GetStreetNameFromHashKey(s1)
                        local street2 = GetStreetNameFromHashKey(s2)
                        local streetLabel = street1
                        if street2 ~= nil then
                            streetLabel = streetLabel .. " " .. street2
                        end
                        TriggerServerEvent("skeepy-chopshop:server:callCops", "Chopshop", 0, streetLabel, pos)
                        copsCalled = true
                    end
                    Citizen.Wait(5000)
                    QBCore.Functions.Notify(Config.Locale["FoundVeh"], 'success')
                    exports["skeepy-ui"]:Show(Config.Locale["title"], Config.Locale["chop3"])
                    Citizen.Wait(10000)
                    QBCore.Functions.Notify(Config.Locale["ScrapBlip"], 'primary')
                    CreateBlip2()
                    SetNewWaypoint(dropoffx, dropoffy)
                    scrapblip = false
                end,
                function()
                    QBCore.Functions.Notify(Config.Locale["RadarError"], 'error')
                    Citizen.Wait(2000)
                    mert = false
                end)
            mert = true
        end
        DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
    end
end

local function HeadingCheck(playerCoords, playerHeading, targetCoords)
    local x = targetCoords.x - playerCoords.x
    local y = targetCoords.y - playerCoords.y

    local targetHeading = GetHeadingFromVector_2d(x, y)
    return math.abs(playerHeading - targetHeading) < 20
end

CreateThread(function()
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
end)

local function InitiateDigiScanner()
    ped = PlayerPedId()
    if not inScaleform then
        inScaleform = true
        local data = 0
        local playerCoords = GetEntityCoords(ped)
        local playerHeading = GetEntityHeading(ped)
        local dist = #(playerCoords - targetCoords)
        if HeadingCheck(playerCoords, playerHeading, targetCoords) then
            SetScaleformColor(sfcolors.lightblue, sfcolors.yellow)
        else
            SetScaleformColor(sfcolors.red, sfcolors.red)
        end

        UpdateBars(dist)
        inScaleform = true
        if not IsNamedRendertargetRegistered('digiscanner') then
            RegisterNamedRendertarget('digiscanner', 0)
        end
        LinkNamedRendertarget(GetWeapontypeModel(joaat('weapon_digiscanner')))

        if IsNamedRendertargetRegistered('digiscanner') then
            data = GetNamedRendertargetRenderId('digiscanner')
        end



        while inScaleform do
            SetTextRenderId(data)
            DrawScaleformMovie(scaleform, sfpos.x, sfpos.y, sfpos.width, sfpos.height, 100, 100, 100, 255, 0)
            SetTextRenderId(1)

            if IsPlayerFreeAiming(PlayerId()) then
                playerCoords = GetEntityCoords(ped)
                playerHeading = GetEntityHeading(ped)

                if HeadingCheck(playerCoords, playerHeading, targetCoords) then
                    SetScaleformColor(sfcolors.lightblue, sfcolors.yellow)
                else
                    SetScaleformColor(sfcolors.red, sfcolors.red)
                end

                dist = #(playerCoords - targetCoords)

                UpdateBars(dist)
            end

            if inScaleform == false then
                break
            end
            Wait(1)
        end
    else
        inScaleform = false
        EndScaleformMovieMethodReturn()
    end
end

CreateThread(function()
    local sleep = 1000
    while true do
        if inScaleform then
            if GetSelectedPedWeapon(ped) == joaat('weapon_digiscanner') then
                if IsPlayerFreeAiming(PlayerId()) then
                    local c = GetEntityCoords(ped)
                    PlaySoundFromCoord(-1, "IDLE_BEEP", c.x, c.y, c.z, 'EPSILONISM_04_SOUNDSET', true, 5.0, false)
                end
                Wait(wait)
                sleep = 0
            else
                sleep = 5000
            end
        end
        Wait(sleep)
    end
end)

local function SetupDigiScanner(vector3, parameters)
    params = {}
    if vector3 and parameters then
        -- if not parameters.interact then
        --     parameters.interact = {
        --         interactMessage = "Interact",
        --         interactKey = 38,
        --     }
        -- end
        form = SetupScaleform("instructional_buttons", {
            { type = "CLEAR_ALL" },
            { type = "SET_CLEAR_SPACE",           int = 200 },
            -- {type = "SET_DATA_SLOT", name = parameters.interact.interactMessage, keyIndex = {parameters.interact.interactKey}, int = 0},
            { type = "DRAW_INSTRUCTIONAL_BUTTONS" },
            { type = "SET_BACKGROUND_COLOUR" },
        })
        params = parameters
        targetCoords = vector3
        if parameters.blip then
            blip = AddBlipForCoord(vector3)
            SetBlipSprite(blip, parameters.blip.sprite)
            SetBlipDisplay(blip, parameters.blip.display)
            if parameters.blip.scale then
                SetBlipScale(blip, parameters.blip.scale)
            end
            SetBlipColour(blip, parameters.blip.color)
            if parameters.blip.opacity then
                SetBlipAlpha(blip, parameters.blip.opacity)
            end
            if parameters.blip.text then
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentSubstringPlayerName(parameters.blip.text)
                EndTextCommandSetBlipName(blip)
            end
        end
        InitiateDigiScanner()
    else
        print('these variables must be defined.')
    end
end

exports('SetupDigiScanner', SetupDigiScanner)

local function DoAPrint(args)
    print('Good Job Pengu! ' .. args['bin'])
end
