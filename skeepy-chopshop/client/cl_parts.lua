RegisterNetEvent('skeepy-chopshop:StartMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = 'Chop Parts',
            -- icon = 'fas fa-code',
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },
        {
            header = 'Door',
            icon = 'fas fa-code-merge',
            txt = 'Print a message!',
            params = {
                event = "skeepy-chopshop:chopdoor",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },  
        {
            header = 'Wheel',
            icon = 'fas fa-code-merge',
            txt = 'Print a message!',
            params = {
                event = "skeepy-chopshop:chopwheel",
                args = {
                    number = 1,
                    id = 2
                }
            }
        }, 
        {
            header = 'Hood',
            icon = 'fas fa-code-merge',
            params = {
                event = "skeepy-chopshop:chophood",
                args = {
                    number = 1,
                    id = 2
                }
            }
        }, 
        {
            header = 'Trunk',
            icon = 'fas fa-code-merge',
            params = {
                event = "skeepy-chopshop:choptrunk",
                args = {
                    number = 1,
                    id = 2
                }
            }
        }, 

    })
end)

RegisterNetEvent('skeepy-chopshop:chopdoor')
AddEventHandler('skeepy-chopshop:chopdoor', function()
    TriggerServerEvent("skeepy-chopshop:server:chopdoor")
end)

RegisterNetEvent('skeepy-chopshop:chopwheel')
AddEventHandler('skeepy-chopshop:chopwheel', function()
    TriggerServerEvent("skeepy-chopshop:server:chopwheel")
end)

RegisterNetEvent('skeepy-chopshop:chophood')
AddEventHandler('skeepy-chopshop:chophood', function()
    TriggerServerEvent("skeepy-chopshop:server:chophood")
end)

RegisterNetEvent('skeepy-chopshop:choptrunk')
AddEventHandler('skeepy-chopshop:choptrunk', function()
    TriggerServerEvent("skeepy-chopshop:server:choptrunk")
end)