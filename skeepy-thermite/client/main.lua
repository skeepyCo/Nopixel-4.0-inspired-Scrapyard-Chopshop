local successCb
local failCb
local resultReceived = false

RegisterNUICallback('ThermiteResult', function(data, cb)
    -- exports['exo-inventory']:ToggleHotBar(true) Toggle so that inventory doesnt work..
    SetNuiFocus(false, false)
    resultReceived = true
    if data.success then
        successCb()
    else
        failCb()
    end
    cb('ok')
    -- TriggerEvent('progressbar:client:ToggleBusyness', false) -- To check if another progressbar is running
end)

RegisterCommand('thermite2', function(source, args)
    -- Please check the parameters below for exports
    exports["skeepy-thermite"]:thermiteminigame(8, 3, 2, 120,
    function() -- success
        print("success")
    end,
    function() -- failure
        print("failure")
    end)
end)

exports('thermiteminigame', function(correctBlocks, incorrectBlocks, timetoShow, timetoLose, success, fail)
    -- correctBlocks = Number of correct blocks the player needs to click
    -- incorrectBlocks = number of incorrect blocks after which the game will fail
    -- timetoShow = time in secs for which the right blocks will be shown
    -- timetoLose = maximum time after timetoshow expires for player to select the right blocks
    resultReceived = false
    successCb = success
    failCb = fail
    -- exports['exo-inventory']:ToggleHotBar(false) Toggle so that inventory doesnt work.. 
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "Start",
        correct = correctBlocks,
        incorrect = incorrectBlocks,
        showtime = timetoShow,
        losetime = timetoLose + timetoShow,
    })
    -- TriggerEvent('progressbar:client:ToggleBusyness', true) -- To check if another progressbar is running
end)
