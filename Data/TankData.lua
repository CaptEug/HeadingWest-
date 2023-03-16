TankData = {}

Blank_line = love.graphics.newImage('Assets/tanks/Blank_line.png')
--t72a
T72A_hull = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_hull.png')
T72A_hull_line = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_Hull_line.png')
T72A_turret = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_turret.png')
T72A_turret_line = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_Turret_line.png')
    --accessory
    T72A_smokegernade_turret = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_smokegernade_turret.png')
    T72A_smokegernade_turret_line = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_smokegernade_turret_line.png')
    T72A_kontakt1_hull = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_kontakt1_hull.png')
    T72A_kontakt1_hull_line = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_kontakt1_hull_line.png')
    T72A_kontakt1_turret = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_kontakt1_turret.png')
    T72A_kontakt1_turret_line = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_kontakt1_turret_line.png')
--t72b
T72B_hull = love.graphics.newImage('Assets/tanks/soviet/T-72/T72B_hull.png')
T72B_hull_line = love.graphics.newImage('Assets/tanks/soviet/T-72/T72B_hull_line.png')
T72B_turret = love.graphics.newImage('Assets/tanks/soviet/T-72/T72B_turret.png')
T72B_turret_line = love.graphics.newImage('Assets/tanks/soviet/T-72/T72B_turret_line.png')
    --accessory
    T72B_kontakt1_hull = love.graphics.newImage('Assets/tanks/soviet/T-72/T72B_kontakt1_hull.png')
    T72B_kontakt1_hull_line = love.graphics.newImage('Assets/tanks/soviet/T-72/T72B_kontakt1_hull_line.png')
    T72B_kontakt1_turret = love.graphics.newImage('Assets/tanks/soviet/T-72/T72B_kontakt1_turret.png')
    T72B_kontakt1_turret_line = love.graphics.newImage('Assets/tanks/soviet/T-72/T72B_kontakt1_turret_line.png')
    T72B_kontakt5_hull = love.graphics.newImage('Assets/tanks/soviet/T-72/T72B_kontakt5_hull.png')
    T72B_kontakt5_hull_line = love.graphics.newImage('Assets/tanks/soviet/T-72/T72B_kontakt5_hull_line.png')
    T72B_kontakt5_turret = love.graphics.newImage('Assets/tanks/soviet/T-72/T72B_kontakt5_turret.png')
    T72B_kontakt5_turret_line = love.graphics.newImage('Assets/tanks/soviet/T-72/T72B_kontakt5_turret_line.png')
--t90
T90_hull = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_hull.png')
T90_hull_line = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_hull_line.png')
T90_turret = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_turret.png')
T90_turret_line = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_turret_line.png')
    --accessory
    T90_kontakt5_hull = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_kontakt5_hull.png')
    T90_kontakt5_hull_line = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_kontakt5_hull_line.png')
    T90_kontakt5_turret = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_kontakt5_turret.png')
    T90_kontakt5_turret_line = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_kontakt5_turret_line.png')
    T90_curtain_turret_line = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_curtain_turret_line.png')
    T90_curtain_turret = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_curtain_turret.png')
--Leopard2A4
Leopard2A4_hull=love.graphics.newImage('Assets/tanks/german/Leopard2/Leopard2A4_Hull.png')
Leopard2A4_hull_line=love.graphics.newImage('Assets/tanks/german/Leopard2/Leopard2A4_Hull_line.png')
Leopard2A4_turret=love.graphics.newImage('Assets/tanks/german/Leopard2/Leopard2A4_Turret.png')
Leopard2A4_turret_line=love.graphics.newImage('Assets/tanks/german/Leopard2/Leopard2A4_Turret_line.png')
    --accessory
    Leopard2A4_ExtraArmor1_turret=love.graphics.newImage('Assets/tanks/german/Leopard2/Leopard2A4_ExtraArmor1_Turret.png')
    Leopard2A4_ExtraArmor1_turret_line=love.graphics.newImage('Assets/tanks/german/Leopard2/Leopard2A4_ExtraArmor1_Turret_line.png')
function TankData:load()
    Blank_Gear = {name = 'Blank', steel_cost = 0, oil_cost = 0, line_image = Blank_line, turret_image = Blank_line, hull_image = Blank_line}

    T72A = {
        name = 'T-72a',
        width = 64,
        length = 127,
        hull_offset=0,
        gun_offset = 109,
        weight = 41.5,
        crew = 3,
        max_f_speed = 60,
        max_r_speed = -4,
        steel_cost = 7,
        oil_cost = 3,
        reload_time = 1,
        ammorack_size = 40,
        ammunition = {
            {name = '3bm22', type = 'APFSDS', pentype = 'KE', velocity = 1700, mass = 0.01, pen = 425},
            {name = '3of26', type = 'HE', pentype = 'CE', velocity = 850, mass = 0.01, pen = 65},
            {name = '3bk18', type = 'HEAT', pentype = 'CE', velocity = 950, mass = 0.01, pen = 550}
        },
        armorthickness = {
            front = {hull = {310, 450}, turret = {450, 550}},
            side = {hull = {80, 80}, turret = {300, 300}},
            back = {hull = {50, 50}, turret = {70, 70}}
        },
        innerstructure = {
            htl = 0.7,
            hull = {crew = 0.6, ammo = 0.5, engine = 0.5, fuel = 0.4},
            turret = {crew = 0.9, ammo = 0, engine = 0, fuel = 0}
        },
        hull_image = T72A_hull,
        hull_image_line = T72A_hull_line,
        turret_image = T72A_turret,
        turret_image_line = T72A_turret_line,
        accessories = {
            --armor
            {
                {
                    name = 'BASE_ARMOR',
                    steel_cost = 0,
                    oil_cost = 0,
                    armorthickness = {
                        front = {hull = {0, 0}, turret = {0, 0}},
                        side = {hull = {0, 0}, turret = {0, 0}},
                        back = {hull = {0, 0}, turret = {0, 0}}
                    },
                    hull_image = Blank_line,
                    hull_image_line = Blank_line,
                    turret_image = T72A_smokegernade_turret,
                    turret_image_line = T72A_smokegernade_turret_line,
                    tag = 'Armor',
                    type = 'Coposit'
                },
                {
                    name = 'Kontakt_1',
                    steel_cost = 1,
                    oil_cost = 0,
                    armorthickness = {
                        front = {hull = {5, 300}, turret = {5, 300}},
                        side = {hull = {5, 300}, turret = {5, 300}},
                        back = {hull = {0, 0}, turret = {0, 0}}
                    },
                    hull_image = T72A_kontakt1_hull,
                    hull_image_line = T72A_kontakt1_hull_line,
                    turret_image = T72A_kontakt1_turret,
                    turret_image_line = T72A_kontakt1_turret_line,
                    tag = 'Armor',
                    type = 'ERA',
                    life = 3,
                    KE = 0,
                    CE = 400
                },
            },
            --aim
            {

            },
            --mob
            {
                {
                    name = 'V_84',
                    steel_cost = 0,
                    oil_cost = 0,
                    line_image = Blank_line,
                    hp = 780,
                    tag = 'Mob'
                }
            }
        },
        buildtime = 2
    }
    table.insert(UVZ.tanklist, T72A)

    T72B = {
        name = 'T-72b',
        width = 64,
        length = 127,
        hull_offset=0,
        gun_offset = 109,
        weight = 44.5,
        crew = 3,
        max_f_speed = 60,
        max_r_speed = -4,
        steel_cost = 8,
        oil_cost = 3,
        reload_time = 7,
        ammorack_size = 40,
        ammunition = {
            
        },
        hull_image = T72B_hull,
        hull_image_line = T72B_hull_line,
        turret_image = T72B_turret,
        turret_image_line = T72B_turret_line,
        accessories = {
            --armor
            {
                {
                    name = 'BASE_ARMOR',
                    steel_cost = 0,
                    oil_cost = 0,
                    hull_image = Blank_line,
                    hull_image_line = Blank_line,
                    turret_image = Blank_line,
                    turret_image_line = Blank_line,
                    tag = 'Armor',
                    type = 'Coposit'
                },
                {
                    name = 'Kontakt_1',
                    steel_cost = 1,
                    oil_cost = 0,
                    hull_image = T72B_kontakt1_hull,
                    hull_image_line = T72B_kontakt1_hull_line,
                    turret_image = T72B_kontakt1_turret,
                    turret_image_line = T72B_kontakt1_turret_line,
                    tag = 'Armor',
                    type = 'ERA',
                    life = 3,
                    KE = 0,
                    CE = 400
                },
                {
                    name = 'Kontakt_5',
                    steel_cost = 2,
                    oil_cost = 0,
                    hull_image = T72B_kontakt5_hull,
                    hull_image_line = T72B_kontakt5_hull_line,
                    turret_image = T72B_kontakt5_turret,
                    turret_image_line = T72B_kontakt5_turret_line,
                    tag = 'Armor',
                    type = 'ERA',
                    life = 4,
                    KE = 120,
                    CE = 400
                },
            },
            --aim
            {

            },
            --mob
            {
                {
                    name = 'V_84',
                    steel_cost = 0,
                    oil_cost = 0,
                    line_image = Blank_line,
                    hp = 780,
                    tag = 'Mob'
                },
                {
                    name = 'V_92',
                    steel_cost = 2,
                    oil_cost = 1,
                    line_image = Blank_line,
                    hp = 1130,
                    tag = 'Mob'
                }
            }
        },
        buildtime = 3
    }
    table.insert(UVZ.tanklist, T72B)

    T90 = {
        name = 'T-90',
        width = 64,
        length = 127,
        hull_offset=0,
        gun_offset = 109,
        weight = 46,
        crew = 3,
        max_f_speed = 60,
        max_r_speed = -4,
        steel_cost = 7,
        oil_cost = 3,
        reload_time = 7,
        ammorack_size = 40,
        ammunition = {
            
        },
        hull_image = T90_hull,
        hull_image_line = T90_hull_line,
        turret_image = T90_turret,
        turret_image_line = T90_turret_line,
        accessories = {
            --armor
            {
                {
                    name = 'BASE_ARMOR',
                    steel_cost = 0,
                    oil_cost = 0,
                    hull_image = Blank_line,
                    hull_image_line = Blank_line,
                    turret_image = Blank_line,
                    turret_image_line = Blank_line,
                    tag = 'Armor',
                    type = 'Coposit'
                },
                {
                    name = 'Kontakt_5',
                    steel_cost = 2,
                    oil_cost = 0,
                    hull_image = T90_kontakt5_hull,
                    hull_image_line = T90_kontakt5_hull_line,
                    turret_image = T90_kontakt5_turret,
                    turret_image_line = T90_kontakt5_turret_line,
                    tag = 'Armor',
                    type = 'ERA',
                    life = 4,
                    KE = 120,
                    CE = 400
                },
            },
            --aim
            {
                {
                    name = 'BASIC_OPTICS',
                    steel_cost = 1,
                    oil_cost = 0,
                    line_image = Blank_line,
                    turret_image = Blank_line,
                    tag = 'Aim'
                },
                {
                    name = 'Curtain',
                    steel_cost = 1,
                    oil_cost = 0,
                    line_image = T90_curtain_turret_line,
                    turret_image = T90_curtain_turret,
                    tag = 'Aim'
                }
            },
            --mob
            {
                {
                    name = 'V_92',
                    steel_cost = 2,
                    oil_cost = 1,
                    line_image = Blank_line,
                    hp = 1130,
                    tag = 'Mob'
                }
            }
        },
        buildtime = 3
    }
    table.insert(UVZ.tanklist, T90)

    Leopard2A4={
        name = 'Leopard2A4',
        width = 64,
        length = 134,
        hull_offset=10,
        weight = 60,
        crew = 4,
        max_f_speed = 65,
        max_r_speed = -20,
        steel_cost = 8,
        oil_cost = 3,
        reload_time = 6,
        ammorack_size = 40,
        ammunition = {
            
        },
        hull_image = Leopard2A4_hull,
        hull_image_line = Leopard2A4_hull_line,
        turret_image = Leopard2A4_turret,
        turret_image_line = Leopard2A4_turret_line,
        accessories = {
            --armor
            {
                {
                    name = 'BASE_ARMOR',
                    steel_cost = 0,
                    oil_cost = 0,
                    hull_image = Blank_line,
                    hull_image_line = Blank_line,
                    turret_image = Blank_line,
                    turret_image_line = Blank_line,
                    tag = 'Armor',
                    type = 'Coposit'
                },
                {
                    name = 'ExArmor1',
                    steel_cost = 2,
                    oil_cost = 0,
                    hull_image = Blank_line,
                    hull_image_line = Blank_line,
                    turret_image = Leopard2A4_ExtraArmor1_turret,
                    turret_image_line = Leopard2A4_ExtraArmor1_turret_line,
                    tag = 'Armor',
                    type = 'NERA',
                    KE = 200,
                    CE = 600
                },
            },
            --aim
            {

            },
            --mob
            {
                {
                    name = 'MB_873',
                    steel_cost = 2,
                    oil_cost = 1,
                    line_image = Blank_line,
                    hp = 1500,
                    tag = 'Mob'
                }
            }
        },
        buildtime = 10
    }
    table.insert(UVZ.tanklist, Leopard2A4)
end

