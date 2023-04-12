Enemyspawner = {}
Enemy = {}

function Enemy:load()
    
end
function BuildEnemytank(place, tank, x, y)
    local tank = {
        type = 'Enemy',
        number = tostring(math.random(000,999)),
        name = tank.name,
        width = tank.width,
        length = tank.length,
        weight = tank.weight,
        crew = tank.crew,
        survivor = tank.crew,
        reload_time = tank.reload_time,
        reload_timer = tank.reload_time,
        ammorack_size = tank.ammorack_size,
        ammorack = {},
        armorthickness = tank.armorthickness,
        innerstructure = tank.innerstructure,
        max_f_speed = tank.max_f_speed,
        max_r_speed = tank.max_r_speed,
        vision = tank.vision,
        hull_image = tank.hull_image,
        hull_image_line = tank.hull_image_line,
        turret_image = tank.turret_image,
        turret_image_line = tank.turret_image_line,
        anime_sheet = tank.anime_sheet,
        turret_anime = anim8.newAnimation(Tank_Grid('1-7', 1), 0.1),
        hull_offset = tank.hull_offset,
        gun_offset = tank.gun_offset,
        exhaust_offset = tank.exhaust_offset,
        exhaust_angle = tank.exhaust_angle,
        turret_angle = 0,
        armor = copytable(tank.accessories[1][1] or Blank_Gear),
        aim = tank.accessories[2][1] or Blank_Gear,
        mob = tank.accessories[3][1] or Blank_Gear,
        buildtime = tank.buildtime,
        fixedbuildtime = tank.buildtime,
        velocity = {},
        location = {x = x, y = y},
        image_location = {},
        gun_location = {},
        exhaust_location = {},
        functions = {},
        Infobuttons = {},
        status = {
            dead = {false},
            onfire = {false, Onfire_icon},
            Immobilized = {false, Immobilized_icon},
            era = {false, ERA_icon}
        },
        firing_timer = 0,
        picked = false,
        incomp = false,
        compCom = false
    }
    setmetatable(tank, Tank)
    Tank.__index = Tank
    TankSpawner:newtank(place, tank)
end