Citizen.CreateThread(function()
  if Config.Target == "qb" then
    exports['qb-target']:AddBoxZone("ChopShopParts", vector3(471.5797, -1312.1295, 30.2579), 1.40, 1.35, {
      name="ChopShopParts",
      heading=113.1992,
      debugPoly=false,
      minZ=28.77834,
      maxZ=29.87834,
      }, {
    options = {
      {
        type = "client",
        event = "skeepy-chopshop:StartMenu",
        icon = "fas fa-hammer",
        label = "Chop Parts",
        job = all,
      },
    },
    distance = 3.5
    })
    exports['qb-target']:SpawnPed({
      [5487] = {
          model = 'csb_prologuedriver',
          coords = Config.StartLoc,
          minusOne = true,
          freeze = true,
          invincible = true,
          blockevents = true,
          scenario = 'WORLD_HUMAN_CLIPBOARD',
          target = {
            options = {
              {
                type = "client",
                event = "skeepy-chopshop:jobaccept",
                icon = 'fas fa-car',
                label = 'Locate A Vehicle',
              }
            },
            distance = 1.5,
          }
      }
      })
  elseif Config.Target == "berkie" then
    exports['berkie-target']:AddBoxZone("ChopShopParts", vector3(471.5797, -1312.1295, 30.2579), 1.40, 1.35, {
      name="ChopShopParts",
      heading=113.1992,
      debugPoly=false,
      minZ=28.77834,
      maxZ=29.87834,
      }, {
    options = {
      {
        type = "client",
        event = "skeepy-chopshop:StartMenu",
        icon = "fas fa-hammer",
        label = "Chop Parts",
        job = all,
      },
    },
    distance = 3.5
    })
  
    exports['berkie-target']:SpawnPed({
      [2328] = {
          model = 'csb_prologuedriver',
          coords = Config.StartLoc,
          minusOne = true,
          freeze = true,
          invincible = true,
          blockevents = true,
          scenario = 'WORLD_HUMAN_CLIPBOARD',
          target = {
            options = {
              {
                type = "client",
                event = "skeepy-chopshop:jobaccept",
                icon = 'fas fa-car',
                label = 'Locate A Vehicle',
              }
            },
            distance = 1.5,
          }
      }
      })
    elseif Config.Target == "bt" then
      exports['bt-target']:AddBoxZone("ChopShopParts", vector3(471.5797, -1312.1295, 30.2579), 1.40, 1.35, {
        name="ChopShopParts",
        heading=113.1992,
        debugPoly=false,
        minZ=28.77834,
        maxZ=29.87834,
        }, {
      options = {
        {
          type = "client",
          event = "skeepy-chopshop:StartMenu",
          icon = "fas fa-hammer",
          label = "Chop Parts",
          job = {"all"},
        },
      },
      distance = 3.5
      })
      exports['bt-target']:AddBoxZone("StartChopJob", vector3(Config.StartLoc.x, Config.StartLoc.y, Config.StartLoc.z), 1, 1, {
        name="StartChopJob",
        heading=113.1992,
        debugPoly=false,
        minZ = Config.StartLoc.z - 1,
        maxZ = Config.StartLoc.z + 1,
        }, {
      options = {
        {
          type = "client",
          event = "skeepy-chopshop:jobaccept",
          icon = "fas fa-car",
          label = "Locate A Vehicle",
          job = {"all"},
        },
      },
      distance = 3.5
      })
    end
end)