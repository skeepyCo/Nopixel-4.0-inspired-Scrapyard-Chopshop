local QBCore = exports['qb-core']:GetCoreObject()

function Show(title, content)
    SendNUIMessage({
        action = "open",
        title = title,
        content = content
    })
end

function Close()
    print("[SKEEPY] Closing NUI")
    SendNUIMessage({
        action = "close",
    })
end

exports("Show", Show)
exports("Close", Close)


RegisterCommand('open', function(source, args, rawCommand)
    if #args < 2 then
        Show(args[1])
        return
    end

    print(args[1])
    print("[SKEEPY] Opening UI with title: " .. args[1] .. ", content: " .. args[2])

    -- Assuming Show is a function defined elsewhere in your script
    Show(args[1], args[2])
end)


RegisterCommand('close', function(source, args, RawCommand)
    print("[SKEEPY] Closing NUI")
    Close()
end)


RegisterCommand('tsf', function ()
    exports['skeepy-chopshop']:SetupDigiScanner(vector3(331.2, -1490.94, 29.27), {
        event = DoAPrint,
        isAction = true,
        args = {['bin'] = 'lol'},
        blip = {
            text = "Surprise Location",
            sprite = 9,
            display = 2,
            scale = 0.7,
            color = 2,
            opacity = 65,
        },
        interact = {
            interactKey = 38,
            interactMessage = 'View Print',
        }
    })
end)