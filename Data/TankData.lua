TankData = {}

Blank_line = love.graphics.newImage('Assets/tanks/Blank_line.png')
--t72a
T72A_line = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_line.png')
T72A_turret = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_turret.png')
T72A_hull = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_hull.png')
    --accessory
    T72A_kontakt1_line = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_kontakt1_line.png')
    T72A_kontakt1_turret = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_kontakt1_turret.png')
    T72A_kontakt1_hull = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_kontakt1_hull.png')
--t72b
T72B_line = love.graphics.newImage('Assets/tanks/soviet/T-72/T72B_line.png')
T72B_turret = love.graphics.newImage('Assets/tanks/soviet/T-72/T72B_turret.png')
T72B_hull = love.graphics.newImage('Assets/tanks/soviet/T-72/T72B_hull.png')
    --accessory
    T72B_kontakt1_line = love.graphics.newImage('Assets/tanks/soviet/T-72/T72B_kontakt1_line.png')
    T72B_kontakt1_turret = love.graphics.newImage('Assets/tanks/soviet/T-72/T72B_kontakt1_turret.png')
    T72B_kontakt1_hull = love.graphics.newImage('Assets/tanks/soviet/T-72/T72B_kontakt1_hull.png')
    T72B_kontakt5_line = love.graphics.newImage('Assets/tanks/soviet/T-72/T72B_kontakt5_line.png')
    T72B_kontakt5_turret = love.graphics.newImage('Assets/tanks/soviet/T-72/T72B_kontakt5_turret.png')
    T72B_kontakt5_hull = love.graphics.newImage('Assets/tanks/soviet/T-72/T72B_kontakt5_hull.png')

function TankData:load()
    Blank_Gear = {name = 'Blank', line_image = Blank_line, turret_image = Blank_line, hull_image = Blank_line}

    T72A = {
        name = 'T-72a',
        width = 64,
        length = 127,
        weight = 41.5,
        line_image = T72A_line,
        turret_image = T72A_turret,
        hull_image = T72A_hull,
        accessories = {
            --armor
            {
                {name = 'Kontakt_1', line_image = T72A_kontakt1_line, turret_image = T72A_kontakt1_turret, hull_image = T72A_kontakt1_hull, tag = 'Armor'},
            },
            --aim
            {

            },
            --ammo
            {
                {name = '3BM22', line_image = Blank_line},
            },
            --mob
            {
                {name = 'V12_diesel', line_image = Blank_line, hp = 780, tag = 'Mob' }
            }
        },
        buildtime = 2
    }
    table.insert(UVZ.tanklist, T72A)

    T72B = {
        name = 'T-72b',
        width = 64,
        length = 127,
        weight = 44.5,
        line_image = T72B_line,
        turret_image = T72B_turret,
        hull_image = T72B_hull,
        accessories = {
            --armor
            {
                {name = 'Kontakt_1', line_image = T72B_kontakt1_line, turret_image = T72B_kontakt1_turret, hull_image = T72B_kontakt1_hull,tag = 'Armor'},
                {name = 'Kontakt_5', line_image = T72B_kontakt5_line, turret_image = T72B_kontakt5_turret, hull_image = T72B_kontakt5_hull,tag = 'Armor'},
            },
            --aim
            {

            },
            --ammo
            {
                {name = '3BM22', line_image = Blank_line},
                {name = '3BM42', line_image = Blank_line},
            },
            --mob
            {
                {name = 'V12_diesel', line_image = Blank_line, hp = 780, tag = 'Mob' },
                {name = 'V_92S2F', line_image = Blank_line, hp = 1130, tag = 'Mob' }
            }
        },
        buildtime = 2
    }
    table.insert(UVZ.tanklist, T72B)
end