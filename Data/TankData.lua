TankData = {}

Blank_line = love.graphics.newImage('Assets/tanks/Blank_line.png')

function TankData:load()
    Blank_Gear = {name = 'Blank', steel_cost = 0, oil_cost = 0, line_image = Blank_line, turret_image = Blank_line, hull_image = Blank_line}
    Tank_Grid = anim8.newGrid(288, 288, 288*7, 288)

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
            {name = '3bm22', type = 'APFSDS', pentype = 'KE', velocity = 1700, mass = 0.1, pen = 425},
            {name = '3of26', type = 'HE', pentype = 'CE', velocity = 850, mass = 0.1, pen = 65},
            {name = '3bk18', type = 'HEAT', pentype = 'CE', velocity = 950, mass = 0.1, pen = 550}
        },
        armorthickness = {
            hull = {front = {310, 450}, side = {80, 80}, back = {50, 50}},
            turret = {front = {450, 550}, side = {300, 300}, back = {70, 70}}
        },
        innerstructure = {
            htl = 0.7,
            hull = {crew = 0.7, ammo = 0.5, engine = 0.5, fuel = 0.4},
            turret = {crew = 0.9, ammo = 0, engine = 0, fuel = 0}
        },
        hull_image = love.graphics.newImage('Assets/tanks/soviet/T-72a/T72A_hull.png'),
        hull_image_line = love.graphics.newImage('Assets/tanks/soviet/T-72a/T72A_Hull_line.png'),
        turret_image = love.graphics.newImage('Assets/tanks/soviet/T-72a/T72A_turret.png'),
        turret_image_line = love.graphics.newImage('Assets/tanks/soviet/T-72a/T72A_Turret_line.png'),
        anime_sheet = love.graphics.newImage('Assets/tanks/soviet/T-72a/T72A_firingsprite.png'),
        accessories = {
            --armor
            {
                {
                    name = 'BASE_ARMOR',
                    steel_cost = 0,
                    oil_cost = 0,
                    armorthickness = {
                        hull = {front = {0, 0}, side = {0, 0}, back = {0, 0}},
                        turret = {front = {0, 0}, side = {0, 0}, back = {0, 0}}
                    },
                    hull_image = Blank_line,
                    hull_image_line = Blank_line,
                    turret_image = love.graphics.newImage('Assets/tanks/soviet/T-72a/T72A_smokegernade_turret.png'),
                    turret_image_line = love.graphics.newImage('Assets/tanks/soviet/T-72a/T72A_smokegernade_turret_line.png'),
                    tag = 'Armor',
                    type = 'Coposit'
                },
                {
                    name = 'Kontakt_1',
                    steel_cost = 1,
                    oil_cost = 0,
                    armorthickness = {
                        hull = {front = {5, 400}, side = {5, 400}, back = {0, 0}},
                        turret = {front = {5, 400}, side = {5, 400}, back = {0, 0}}
                    },
                    hull_image =love.graphics.newImage('Assets/tanks/soviet/T-72a/T72A_kontakt1_hull.png'),
                    hull_image_line = love.graphics.newImage('Assets/tanks/soviet/T-72a/T72A_kontakt1_hull_line.png'),
                    turret_image = love.graphics.newImage('Assets/tanks/soviet/T-72a/T72A_kontakt1_turret.png'),
                    turret_image_line = love.graphics.newImage('Assets/tanks/soviet/T-72a/T72A_kontakt1_turret_line.png'),
                    tag = 'Armor',
                    type = 'ERA',
                    life = 3
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
    table.insert(Nizhny_Tagil.tanklist, T72A)

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
            {name = '3bm22', type = 'APFSDS', pentype = 'KE', velocity = 1700, mass = 0.1, pen = 425}
        },
        armorthickness = {
            hull = {front = {500, 600}, side = {80, 80}, back = {50, 50}},
            turret = {front = {600, 700}, side = {350, 375}, back = {70, 70}}
        },
        innerstructure = {
            htl = 0.7,
            hull = {crew = 0.7, ammo = 0.5, engine = 0.5, fuel = 0.4},
            turret = {crew = 0.9, ammo = 0, engine = 0, fuel = 0}
        },
        hull_image = love.graphics.newImage('Assets/tanks/soviet/T-72b/T72B_hull.png'),
        hull_image_line = love.graphics.newImage('Assets/tanks/soviet/T-72b/T72B_hull_line.png'),
        turret_image = love.graphics.newImage('Assets/tanks/soviet/T-72b/T72B_turret.png'),
        turret_image_line = love.graphics.newImage('Assets/tanks/soviet/T-72b/T72B_turret_line.png'),
        accessories = {
            --armor
            {
                {
                    name = 'BASE_ARMOR',
                    steel_cost = 0,
                    oil_cost = 0,
                    armorthickness = {
                        hull = {front = {0, 0}, side = {0, 0}, back = {0, 0}},
                        turret = {front = {0, 0}, side = {0, 0}, back = {0, 0}}
                    },
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
                    armorthickness = {
                        hull = {front = {5, 400}, side = {5, 400}, back = {0, 0}},
                        turret = {front = {5, 400}, side = {5, 400}, back = {0, 0}}
                    },
                    hull_image = love.graphics.newImage('Assets/tanks/soviet/T-72b/T72B_kontakt1_hull.png'),
                    hull_image_line = love.graphics.newImage('Assets/tanks/soviet/T-72b/T72B_kontakt1_hull_line.png'),
                    turret_image = love.graphics.newImage('Assets/tanks/soviet/T-72b/T72B_kontakt1_turret.png'),
                    turret_image_line = love.graphics.newImage('Assets/tanks/soviet/T-72b/T72B_kontakt1_turret_line.png'),
                    tag = 'Armor',
                    type = 'ERA',
                    life = 3
                },
                {
                    name = 'Kontakt_5',
                    steel_cost = 2,
                    oil_cost = 0,
                    armorthickness = {
                        hull = {front = {120, 450}, side = {120, 450}, back = {0, 0}},
                        turret = {front = {120, 450}, side = {120, 450}, back = {0, 0}}
                    },
                    hull_image = love.graphics.newImage('Assets/tanks/soviet/T-72b/T72B_kontakt5_hull.png'),
                    hull_image_line = love.graphics.newImage('Assets/tanks/soviet/T-72b/T72B_kontakt5_hull_line.png'),
                    turret_image = love.graphics.newImage('Assets/tanks/soviet/T-72b/T72B_kontakt5_turret.png'),
                    turret_image_line = love.graphics.newImage('Assets/tanks/soviet/T-72b/T72B_kontakt5_turret_line.png'),
                    tag = 'Armor',
                    type = 'ERA',
                    life = 4
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
    table.insert(Nizhny_Tagil.tanklist, T72B)

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
        armorthickness = {
            hull = {front = {500, 600}, side = {80, 80}, back = {50, 50}},
            turret = {front = {625, 725}, side = {200, 200}, back = {50, 50}}
        },
        innerstructure = {
            htl = 0.7,
            hull = {crew = 0.7, ammo = 0.5, engine = 0.5, fuel = 0.4},
            turret = {crew = 0.9, ammo = 0, engine = 0, fuel = 0}
        },
        hull_image = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_hull.png'),
        hull_image_line = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_hull_line.png'),
        turret_image = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_turret.png'),
        turret_image_line = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_turret_line.png'),
        accessories = {
            --armor
            {
                {
                    name = 'BASE_ARMOR',
                    steel_cost = 0,
                    oil_cost = 0,
                    armorthickness = {
                        hull = {front = {0, 0}, side = {0, 0}, back = {0, 0}},
                        turret = {front = {0, 0}, side = {0, 0}, back = {0, 0}}
                    },
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
                    armorthickness = {
                        hull = {front = {120, 450}, side = {120, 450}, back = {0, 0}},
                        turret = {front = {120, 450}, side = {120, 450}, back = {0, 0}}
                    },
                    hull_image = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_kontakt5_hull.png'),
                    hull_image_line = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_kontakt5_hull_line.png'),
                    turret_image = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_kontakt5_turret.png'),
                    turret_image_line = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_kontakt5_turret_line.png'),
                    tag = 'Armor',
                    type = 'ERA',
                    life = 4
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
                    line_image = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_curtain_turret_line.png'),
                    turret_image = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_curtain_turret.png'),
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
    table.insert(Nizhny_Tagil.tanklist, T90)

    Leopard2A4={
        name = 'Leopard2A4',
        width = 64,
        length = 134,
        hull_offset=10,
        gun_offset = 94,
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
        armorthickness = {
             
        },
        hull_image = love.graphics.newImage('Assets/tanks/german/Leopard2/Leopard2A4_Hull.png'),
        hull_image_line = love.graphics.newImage('Assets/tanks/german/Leopard2/Leopard2A4_Hull_line.png'),
        turret_image = love.graphics.newImage('Assets/tanks/german/Leopard2/Leopard2A4_Turret.png'),
        turret_image_line = love.graphics.newImage('Assets/tanks/german/Leopard2/Leopard2A4_Turret_line.png'),
        accessories = {
            --armor
            {
                {
                    name = 'BASE_ARMOR',
                    steel_cost = 0,
                    oil_cost = 0,
                    armorthickness = {
                        hull = {front = {0, 0}, side = {0, 0}, back = {0, 0}},
                        turret = {front = {0, 0}, side = {0, 0}, back = {0, 0}}
                    },
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
                    turret_image = love.graphics.newImage('Assets/tanks/german/Leopard2/Leopard2A4_ExtraArmor1_Turret.png'),
                    turret_image_line = love.graphics.newImage('Assets/tanks/german/Leopard2/Leopard2A4_ExtraArmor1_Turret_line.png'),
                    tag = 'Armor',
                    type = 'NERA'
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
    table.insert(Nizhny_Tagil.tanklist, Leopard2A4)
end

