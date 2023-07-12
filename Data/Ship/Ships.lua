Blank_line = love.graphics.newImage('Assets/tanks/Blank_line.png')
Image_in_progress = love.graphics.newImage('Assets/tanks/ImageInProgress.png')
Blank_Gear = {name = 'Blank', steel_cost = 0, oil_cost = 0, line_image = Blank_line, turret_image = Blank_line, hull_image = Blank_line}
Tank_Grid = anim8.newGrid(288, 288, 288*7, 288*2)
BigGunOpenFire = love.audio.newSource('Assets/audio/sound/DeathFlash.flac', 'static')
AutoGunOpenFire = love.audio.newSource('Assets/audio/sound/synthetic_explosion_1.flac', 'static')

Ships = {
    --USA
    Montana = {
        name = 'Montana',
        class = 'ship',
        width = 650, 
        length = 4800,
        turret_offset = 0,
        image_offset = 0,
        gun_offset = 150,
        main_turret_number = 4,
        main_turret_offset = {
            {x = 0, y = -1308, height = 1, angle = 0, angle1 = 0, fwangle = 35/180*math.pi},
            {x = 0, y = -954, height = 2, angle = 0, angle1 = 0, fwangle = 35/180*math.pi},
            {x = 0, y = 762, height = 2, angle = math.pi, angle1 = math.pi, fwangle = 35/180*math.pi},
            {x = 0, y = 1116, height = 1, angle = math.pi,angle1 = math.pi,  fwangle = 35/180*math.pi}
        },
        engine_offset = -43,
        exhaust_offset = {x = -34, y = -34},
        exhaust_angle = math.pi,
        weight = 70000,
        crew = 3,
        max_f_speed = 60,
        max_r_speed = -4,
        turnspeed = 0,
        frontspeed = {x = 0, y = 0},
        turret_t_speed = 50,
        vision = 600,
        steel_cost = 7,
        oil_cost = 3,
        reload_time = 7,
        firing_time = 0.7,
        fuel_capacity = 12,
        fuel_cosumption = 3.5,
        ammorack_size = 40,
        ammunition = {
            {name = '3bm22', type = 'APFSDS', pentype = 'KE', velocity = 1700, mass = 0.1, pen = 415},
            {name = '3of26', type = 'HE', pentype = 'CE', velocity = 850, mass = 0.1, pen = 65, TNT_eq = 6},
            {name = '3bk18', type = 'HEAT', pentype = 'CE', velocity = 950, mass = 0.1, pen = 550}
        },
        armorthickness = {
            hull = {front = {330, 450}, side = {80, 80}, back = {50, 50}},
            turret = {front = {500, 550}, side = {300, 300}, back = {70, 70}}
        },
        innerstructure = {
            htl = 0.7,
            hull = {crew = 0.5, ammo = 0.4, engine = 0.3, fuel = 0.5},
            turret = {crew = 0.7, ammo = 0, engine = 0, fuel = 0}
        },
        hull_image = love.graphics.newImage('Assets/ships/usa/Montana/Montana.png'),
        turret_image = love.graphics.newImage('Assets/ships/usa/Montana/406mmMk7.png'),
        anime_sheet = love.graphics.newImage('Assets/tanks/soviet/T-72a/T72A_firingsprite.png'),
        gun_sound = BigGunOpenFire,
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
                Blank_Gear
            },
            --mob
            {
                {
                    name = 'V_46',
                    steel_cost = 0,
                    oil_cost = 0,
                    line_image = Blank_line,
                    hp = 172000,
                    tag = 'Mob'
                }
            }
        },
        buildtime = 2,
        fixedbuildtime = 2
    },

    Atlanta = {
        name = 'Atlanta',
        class = 'ship',
        width = 64, 
        length = 127,
        turret_offset = 0,
        image_offset = 0,
        gun_offset = 150,
        main_turret_number = 2,
        main_turret_offset = {
            {x = 0, y = -1308, ahead = 1, height = 1},
            {x = 0, y = -954, ahead = 1, height = 2},
            {x = 0, y = 762, ahead = 0, height = 2},
            {x = 0, y = 1116, ahead = 0, height = 1}
        },
        engine_offset = -43,
        exhaust_offset = {x = -34, y = -34},
        exhaust_angle = math.pi,
        weight = 41.5,
        crew = 3,
        max_f_speed = 60,
        max_r_speed = -4,
        turret_t_speed = 25,
        vision = 600,
        steel_cost = 7,
        oil_cost = 3,
        reload_time = 7,
        firing_time = 0.7,
        fuel_capacity = 12,
        fuel_cosumption = 3.5,
        ammorack_size = 40,
        ammunition = {
            {name = '3bm22', type = 'APFSDS', pentype = 'KE', velocity = 1700, mass = 0.1, pen = 415},
            {name = '3of26', type = 'HE', pentype = 'CE', velocity = 850, mass = 0.1, pen = 65, TNT_eq = 6},
            {name = '3bk18', type = 'HEAT', pentype = 'CE', velocity = 950, mass = 0.1, pen = 550}
        },
        armorthickness = {
            hull = {front = {330, 450}, side = {80, 80}, back = {50, 50}},
            turret = {front = {500, 550}, side = {300, 300}, back = {70, 70}}
        },
        innerstructure = {
            htl = 0.7,
            hull = {crew = 0.5, ammo = 0.4, engine = 0.3, fuel = 0.5},
            turret = {crew = 0.7, ammo = 0, engine = 0, fuel = 0}
        },
        hull_image = love.graphics.newImage('Assets/ships/usa/Montana/Montana.png'),
        turret_image = love.graphics.newImage('Assets/ships/usa/Montana/406mmMk7.png'),
        anime_sheet = love.graphics.newImage('Assets/tanks/soviet/T-72a/T72A_firingsprite.png'),
        gun_sound = BigGunOpenFire,
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
                Blank_Gear
            },
            --mob
            {
                {
                    name = 'V_46',
                    steel_cost = 0,
                    oil_cost = 0,
                    line_image = Blank_line,
                    hp = 780,
                    tag = 'Mob'
                }
            }
        },
        buildtime = 2,
        fixedbuildtime = 2
    },
}