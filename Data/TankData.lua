TankData = {}

Blank_line = love.graphics.newImage('Assets/tanks/Blank_line.png')
--t72a
T72A_line = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_line.png')
T72A_turret = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_turret.png')
T72A_hull = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_hull.png')
    --accessory
    T72A_smokegernade_line = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_smokegernade_line.png')
    T72A_smokegernade_turret = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_smokegernade_turret.png')
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
--t90
T90_line = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_line.png')
T90_turret = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_turret.png')
T90_hull = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_hull.png')
    --accessory
    T90_kontakt5_line = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_kontak5_line.png')
    T90_kontakt5_turret = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_kontakt5_turret.png')
    T90_curtain_line = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_curtain_line.png')
    T90_curtain_turret = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_curtain_turret.png')
--Leopard2A4
Leopard2A4_line=love.graphics.newImage('Assets/tanks/german/Leopard2/Leopard2A4_line.png')
Leopard2A4_turret=love.graphics.newImage('Assets/tanks/german/Leopard2/Leopard2A4_Turret.png')
Leopard2A4_hull=love.graphics.newImage('Assets/tanks/german/Leopard2/Leopard2A4_Hull.png')
    --accessory
    Leopard2A4_turret_ExtraArmor1_line=love.graphics.newImage('Assets/tanks/german/Leopard2/Leopard2A4_Turret_ExtraArmor1_line.png')
    Leopard2A4_turret_ExtraArmor1=love.graphics.newImage('Assets/tanks/german/Leopard2/Leopard2A4_Turret_ExtraArmor1.png')

function TankData:load()
    Blank_Gear = {name = 'Blank', steel_cost = 0, oil_cost = 0, line_image = Blank_line, turret_image = Blank_line, hull_image = Blank_line}

    T72A = {
        name = 'T-72a',
        width = 64,
        length = 127,
        turret_offset=0,
        weight = 41.5,
        steel_cost = 7,
        oil_cost = 3,
        line_image = T72A_line,
        turret_image = T72A_turret,
        hull_image = T72A_hull,
        accessories = {
            --armor
            {
                {name = 'BASE_ARMOR', steel_cost = 0, oil_cost = 0, line_image = T72A_smokegernade_line, turret_image = T72A_smokegernade_turret, hull_image = Blank_line, tag = 'Armor'},
                {name = 'Kontakt_1', steel_cost = 1, oil_cost = 0, line_image = T72A_kontakt1_line, turret_image = T72A_kontakt1_turret, hull_image = T72A_kontakt1_hull, tag = 'Armor'},
            },
            --aim
            {

            },
            --ammo
            {
                {name = '3BM22', steel_cost = 0, oil_cost = 0, line_image = Blank_line, tag = 'Ammo'},
            },
            --mob
            {
                {name = 'V_84', steel_cost = 0, oil_cost = 0, line_image = Blank_line, hp = 780, tag = 'Mob' }
            }
        },
        buildtime = 2
    }
    table.insert(UVZ.tanklist, T72A)

    T72B = {
        name = 'T-72b',
        width = 64,
        length = 127,
        turret_offset=0,
        weight = 44.5,
        steel_cost = 8,
        oil_cost = 3,
        line_image = T72B_line,
        turret_image = T72B_turret,
        hull_image = T72B_hull,
        accessories = {
            --armor
            {
                {name = 'BASE_ARMOR', steel_cost = 0, oil_cost = 0, line_image = Blank_line, turret_image = Blank_line, hull_image = Blank_line, tag = 'Armor'},
                {name = 'Kontakt_1', steel_cost = 1, oil_cost = 0, line_image = T72B_kontakt1_line, turret_image = T72B_kontakt1_turret, hull_image = T72B_kontakt1_hull, tag = 'Armor'},
                {name = 'Kontakt_5', steel_cost = 2, oil_cost = 0, line_image = T72B_kontakt5_line, turret_image = T72B_kontakt5_turret, hull_image = T72B_kontakt5_hull, tag = 'Armor'},
            },
            --aim
            {

            },
            --ammo
            {
                {name = '3BM22', steel_cost = 0, oil_cost = 0, line_image = Blank_line, tag = 'Ammo'},
                {name = '3BM42', steel_cost = 1, oil_cost = 0, line_image = Blank_line, tag = 'Ammo'},
            },
            --mob
            {
                {name = 'V_84', steel_cost = 0, oil_cost = 0, line_image = Blank_line, hp = 780, tag = 'Mob' },
                {name = 'V_92', steel_cost = 2, oil_cost = 1, line_image = Blank_line, hp = 1130, tag = 'Mob' }
            }
        },
        buildtime = 3
    }
    table.insert(UVZ.tanklist, T72B)

    T90 = {
        name = 'T-90',
        width = 64,
        length = 127,
        turret_offset=0,
        weight = 44.5,
        steel_cost = 7,
        oil_cost = 3,
        line_image = T90_line,
        turret_image = T90_turret,
        hull_image = T90_hull,
        accessories = {
            --armor
            {
                {name = 'BASE_ARMOR', steel_cost = 0, oil_cost = 0, line_image = Blank_line, turret_image = Blank_line, hull_image = Blank_line, tag = 'Armor'},
                {name = 'Kontakt_5', steel_cost = 2, oil_cost = 0, line_image = T90_kontakt5_line, turret_image = T90_kontakt5_turret, hull_image = T72B_kontakt5_hull, tag = 'Armor'},
            },
            --aim
            {
                {name = 'BASIC_OPTICS', steel_cost = 1, oil_cost = 0, line_image = Blank_line, turret_image = Blank_line, tag = 'Aim'},
                {name = 'Curtain', steel_cost = 1, oil_cost = 0, line_image = T90_curtain_line, turret_image = T90_curtain_turret, tag = 'Aim'}
            },
            --ammo
            {
                {name = '3BM42', steel_cost = 1, oil_cost = 0, line_image = Blank_line, tag = 'Ammo'}
            },
            --mob
            {
                {name = 'V_92', steel_cost = 2, oil_cost = 1, line_image = Blank_line, hp = 1130, tag = 'Mob' }
            }
        },
        buildtime = 3
    }
    table.insert(UVZ.tanklist, T90)

    Leopard2A4={
        name = 'Leopard2A4',
        width = 64,
        length = 134,
        turret_offset=10,
        weight = 44.5,
        steel_cost = 8,
        oil_cost = 3,
        line_image = Leopard2A4_line,
        turret_image = Leopard2A4_turret,
        hull_image = Leopard2A4_hull,
        accessories = {
            --armor
            {
                {name = 'BASE_ARMOR', steel_cost = 0, oil_cost = 0, line_image = Blank_line, turret_image = Blank_line, hull_image = Blank_line, tag = 'Armor'},
                {name = 'ExArmor1', steel_cost = 1, oil_cost = 0, line_image = Leopard2A4_turret_ExtraArmor1_line, turret_image = Leopard2A4_turret_ExtraArmor1, hull_image = Blank_line, tag = 'Armor'},
            },
            --aim
            {

            },
            --ammo
            {
                {name = 'DM53', steel_cost = 0, oil_cost = 0, line_image = Blank_line, tag = 'Ammo'},
            },
            --mob
            {
                {name = 'V_84', steel_cost = 0, oil_cost = 0, line_image = Blank_line, hp = 780, tag = 'Mob' },
            }
        },
        buildtime = 3
    }
    table.insert(UVZ.tanklist, Leopard2A4)
end