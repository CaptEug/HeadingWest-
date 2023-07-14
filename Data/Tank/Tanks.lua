Blank_line = love.graphics.newImage('Assets/tanks/Blank_line.png')
Image_in_progress = love.graphics.newImage('Assets/tanks/ImageInProgress.png')
Blank_Gear = {name = 'Blank', steel_cost = 0, oil_cost = 0, line_image = Blank_line, turret_image = Blank_line, hull_image = Blank_line}
Tank_Grid = anim8.newGrid(288, 288, 288*7, 288*2)
BigGunOpenFire = love.audio.newSource('Assets/audio/sound/DeathFlash.flac', 'static')
AutoGunOpenFire = love.audio.newSource('Assets/audio/sound/synthetic_explosion_1.flac', 'static')

Tanks = {
    --USSR--
    T72A = {
        name = 'T-72a',
        class = 'tank',
        width = 64,
        length = 127,
        turret_offset = 0,
        image_offset = 0,
        gun_offset = 109,
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
        hull_image = love.graphics.newImage('Assets/tanks/soviet/T-72a/T72A_Hull.png'),
        hull_image_line = love.graphics.newImage('Assets/tanks/soviet/T-72a/T72A_Hull_line.png'),
        hull_image_broken = love.graphics.newImage('Assets/tanks/soviet/T-72a/T72A_Hull_Broken.png'),
        turret_image = love.graphics.newImage('Assets/tanks/soviet/T-72a/T72A_Turret.png'),
        turret_image_line = love.graphics.newImage('Assets/tanks/soviet/T-72a/T72A_Turret_line.png'),
        turret_image_broken = love.graphics.newImage('Assets/tanks/soviet/T-72a/T72A_Turret_Broken.png'),
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

    T72B = {
        name = 'T-72b',
        class = 'tank',
        width = 64,
        length = 127,
        turret_offset = 0,
        image_offset = 0,
        gun_offset = 109,
        engine_offset = -43,
        exhaust_offset = {x = -34, y = -34},
        exhaust_angle = math.pi,
        weight = 44.5,
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
        fuel_cosumption = 3.8,
        ammorack_size = 40,
        ammunition = {
            {name = '3bm42', type = 'APFSDS', pentype = 'KE', velocity = 1700, mass = 0.1, pen = 457},
            {name = '3of26', type = 'HE', pentype = 'CE', velocity = 850, mass = 0.1, pen = 65, TNT_eq = 6},
            {name = '3bk18', type = 'HEAT', pentype = 'CE', velocity = 950, mass = 0.1, pen = 550}
        },
        armorthickness = {
            hull = {front = {500, 600}, side = {80, 80}, back = {50, 50}},
            turret = {front = {600, 700}, side = {350, 375}, back = {70, 70}}
        },
        innerstructure = {
            htl = 0.7,
            hull = {crew = 0.5, ammo = 0.4, engine = 0.3, fuel = 0.5},
            turret = {crew = 0.7, ammo = 0, engine = 0, fuel = 0}
        },
        hull_image = love.graphics.newImage('Assets/tanks/soviet/T-72b/T72B_Hull.png'),
        hull_image_line = love.graphics.newImage('Assets/tanks/soviet/T-72b/T72B_Hull_line.png'),
        hull_image_broken = Blank_line,
        turret_image = love.graphics.newImage('Assets/tanks/soviet/T-72b/T72B_Turret.png'),
        turret_image_line = love.graphics.newImage('Assets/tanks/soviet/T-72b/T72B_Turret_line.png'),
        turret_image_broken = Blank_line,
        anime_sheet = love.graphics.newImage('Assets/tanks/soviet/T-72b/T72B_firingsprite.png'),
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
        buildtime = 3,
        fixedbuildtime = 3
    },

    T90 = {
        name = 'T-90',
        class = 'tank',
        width = 64,
        length = 127,
        turret_offset = 0,
        image_offset = 0,
        gun_offset = 109,
        engine_offset = -43,
        exhaust_offset = {x = -34, y = -34},
        exhaust_angle = math.pi,
        weight = 46,
        crew = 3,
        max_f_speed = 60,
        max_r_speed = -4,
        turret_t_speed = 25,
        vision = 700,
        steel_cost = 7,
        oil_cost = 3,
        reload_time = 7,
        firing_time = 0.7,
        fuel_capacity = 12,
        fuel_cosumption = 3.8,
        ammorack_size = 40,
        ammunition = {
            {name = '3bm42', type = 'APFSDS', pentype = 'KE', velocity = 1700, mass = 0.1, pen = 457},
            {name = '3of26', type = 'HE', pentype = 'CE', velocity = 850, mass = 0.1, pen = 65, TNT_eq = 6},
            {name = '3bk18', type = 'HEAT', pentype = 'CE', velocity = 950, mass = 0.1, pen = 550}
        },
        armorthickness = {
            hull = {front = {500, 600}, side = {80, 80}, back = {50, 50}},
            turret = {front = {625, 725}, side = {200, 200}, back = {50, 50}}
        },
        innerstructure = {
            htl = 0.7,
            hull = {crew = 0.5, ammo = 0.4, engine = 0.3, fuel = 0.5},
            turret = {crew = 0.7, ammo = 0, engine = 0, fuel = 0}
        },
        hull_image = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_hull.png'),
        hull_image_line = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_hull_line.png'),
        hull_image_broken = Blank_line,
        turret_image = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_turret.png'),
        turret_image_line = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_turret_line.png'),
        turret_image_broken = Blank_line,
        anime_sheet = love.graphics.newImage('Assets/tanks/soviet/T-90/T90_firingsprite.png'),
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
        buildtime = 3,
        fixedbuildtime = 3
    },

    --German
    Leopard2A4 = {
        name = 'Leopard2A4',
        class = 'tank',
        width = 68,
        length = 136,
        turret_offset = 0,
        image_offset = 9,
        gun_offset = 94,
        engine_offset = -49,
        exhaust_offset = {x = 0, y = -78},
        exhaust_angle = math.pi/2,
        weight = 60,
        crew = 4,
        max_f_speed = 72,
        max_r_speed = 38,
        turret_t_speed = 35,
        vision = 800,
        steel_cost = 0,
        oil_cost = 0,
        reload_time = 6,
        firing_time = 0.7,
        fuel_capacity = 19,
        fuel_cosumption = 4.5,
        ammorack_size = 40,
        ammunition = {
            {name = 'DM53', type = 'APFSDS', pentype = 'KE', velocity = 1700, mass = 0.1, pen = 652},
        },
        armorthickness = {
            hull = {front = {400, 750}, side = {60, 60}, back = {30, 30}},
            turret = {front = {410, 800}, side = {200, 350}, back = {20, 20}}
        },
        innerstructure = {
            htl = 0.6,
            hull = {crew = 0.5, ammo = 0, engine = 0.4, fuel = 0.4},
            turret = {crew = 0.6, ammo = 0.3, engine = 0, fuel = 0}
        },
        hull_image = love.graphics.newImage('Assets/tanks/german/Leopard2/Leopard2A4_hull.png'),
        hull_image_line = love.graphics.newImage('Assets/tanks/german/Leopard2/Leopard2A4_hull_line.png'),
        turret_image = love.graphics.newImage('Assets/tanks/german/Leopard2/Leopard2A4_turret.png'),
        turret_image_line = love.graphics.newImage('Assets/tanks/german/Leopard2/Leopard2A4_turret_line.png'),
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
            Blank_Gear
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
    },

    --US
    M1 = {
        name = 'M1',
        class = 'tank',
        width = 66,
        length = 140,
        turret_offset = 0,
        image_offset = 7,
        gun_offset = 94,
        engine_offset = -49,
        exhaust_offset = {x = 0, y = -78},
        exhaust_angle = math.pi/2,
        weight = 55,
        crew = 4,
        max_f_speed = 72,
        max_r_speed = 38,
        turret_t_speed = 35,
        vision = 800,
        steel_cost = 0,
        oil_cost = 0,
        reload_time = 6,
        firing_time = 0.7,
        fuel_capacity = 19,
        fuel_cosumption = 4.5,
        ammorack_size = 40,
        ammunition = {
            {name = 'M900', type = 'APFSDS', pentype = 'KE', velocity = 1700, mass = 0.1, pen = 530},
        },
        armorthickness = {
            hull = {front = {400, 750}, side = {60, 60}, back = {30, 30}},
            turret = {front = {410, 800}, side = {200, 350}, back = {20, 20}}
        },
        innerstructure = {
            htl = 0.6,
            hull = {crew = 0.5, ammo = 0, engine = 0.4, fuel = 0.4},
            turret = {crew = 0.6, ammo = 0.3, engine = 0, fuel = 0}
        },
        hull_image = love.graphics.newImage('Assets/tanks/usa/M1/M1_Hull.png'),
        hull_image_line = love.graphics.newImage('Assets/tanks/usa/M1/M1_Hull_line.png'),
        hull_image_broken = Blank_line,
        turret_image = love.graphics.newImage('Assets/tanks/usa/M1/M1_Turret.png'),
        turret_image_line = love.graphics.newImage('Assets/tanks/usa/M1/M1_Turret_line.png'),
        turret_image_broken = Blank_line,
        anime_sheet = love.graphics.newImage('Assets/tanks/usa/M1/M1_firingsprite.png'),
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
                    turret_image = Blank_line,
                    turret_image_line = Blank_line,
                    tag = 'Armor',
                    type = 'Coposit'
                }
            },
            --aim
            {
                Blank_Gear
            },
            --mob
            {
                {
                    name = 'Honeywell AGT1500',
                    steel_cost = 0,
                    oil_cost = 0,
                    line_image = Blank_line,
                    hp = 1500,
                    tag = 'Mob'
                }
            }
        },
        buildtime = 2,
        fixedbuildtime = 2
    }
}

IFVs = {
    --USSR
    BMP2 = {
        name = 'BMP-2',
        class = 'ifv',
        width = 56,
        length = 117,
        turret_offset = 0,
        image_offset = -16,
        gun_offset = 57,
        luncher_offset = {x = 7, y = -2},
        engine_offset = 40,
        exhaust_offset = {x = 27, y = 28},
        exhaust_angle = 0,
        weight = 14,
        crew = 3,
        max_f_speed = 65,
        max_r_speed = -10,
        turret_t_speed = 50,
        vision = 600,
        steel_cost = 5,
        oil_cost = 3,
        reload_time = 0.15,
        m_reload_time = 2,
        firing_time = 0.2,
        fuel_capacity = 4.6,
        fuel_cosumption = 0.8,
        ammorack_size = 500,
        missilerack_size = 4,
        ammunition = {
            {name = '3ubr8', type = 'APDS', pentype = 'KE', velocity = 1000, mass = 0.01, pen = 82},
            {name = '9m113', type = 'ATGM', pentype = 'CE', velocity = 400, turningtorque = 120, mass = 0.5, pen = 500, TNT_eq = 4, pic = love.graphics.newImage('Assets/tanks/soviet/Weapons/9M113Konkurs.png')}
        },
        armorthickness = {
            hull = {front = {50, 50}, side = {15, 15}, back = {16, 16}},
            turret = {front = {50, 50}, side = {30, 30}, back = {10, 10}}
        },
        innerstructure = {
            htl = 0.8,
            hull = {crew = 0.5, ammo = 0.4, engine = 0.3, fuel = 0.5},
            turret = {crew = 0.7, ammo = 0.1, engine = 0, fuel = 0}
        },
        hull_image = love.graphics.newImage('Assets/tanks/soviet/BMP2/BMP2_Hull.png'),
        hull_image_line = love.graphics.newImage('Assets/tanks/soviet/BMP2/BMP2_Hull_line.png'),
        hull_image_broken = Blank_line,
        turret_image = love.graphics.newImage('Assets/tanks/soviet/BMP2/BMP2_Turret.png'),
        turret_image_line = love.graphics.newImage('Assets/tanks/soviet/BMP2/BMP2_Turret_line.png'),
        turret_image_broken = Blank_line,
        anime_sheet = love.graphics.newImage('Assets/tanks/soviet/BMP2/BMP2_firingsprite.png'),
        gun_sound = AutoGunOpenFire,
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
                    type = 'Alloy'
                }
            },
            --aim
            {
                Blank_Gear
            },
            --mob
            {
                {
                    name = 'UTD_20/3',
                    steel_cost = 0,
                    oil_cost = 0,
                    line_image = Blank_line,
                    hp = 300,
                    tag = 'Mob'
                }
            }
        },
        buildtime = 2,
        fixedbuildtime = 2
    }
}

SPGs = {
    --USSR
    Pion2S7 = {
        name = '2S7 Pion',
        class = 'spg',
        width = 60,
        length = 158,
        image_offset = 0,
        turret_offset = 60,
        gun_offset = 150,
        engine_offset = 24,
        exhaust_offset = {x = -30, y = 26},
        exhaust_offset2 = {x = 30, y = 26},
        exhaust_angle = math.pi,
        exhaust_angle2 = 0,
        weight = 46.5,
        crew = 6,
        max_f_speed = 50,
        max_r_speed = -50,
        turret_t_speed = 7,
        turret_t_angle = {l = 15, r = 15},
        vision = 1000,
        steel_cost = 0,
        oil_cost = 0,
        reload_time = 15,
        firing_time = 0.7,
        deploy_time = 1.2,
        fuel_capacity = 12,
        fuel_cosumption = 3.8,
        ammorack_size = 40,
        ammunition = {
        {name = '203mmHE', type = 'HE', pentype = 'CE', velocity = 960, mass = 0.2, pen = 203, TNT_eq = 27}
        },
        armorthickness = {
        hull = {front = {10, 10}, side = {10, 10}, back = {10, 10}},
        turret = {front = {10, 10}, side = {10, 10}, back = {10, 10}}
        },
        innerstructure = {
        htl = 0.8,
        hull = {crew = 0.7, ammo = 0.2, engine = 0.5, fuel = 0.5},
        turret = {crew = 0, ammo = 0, engine = 0, fuel = 0}
        },
        hull_image = love.graphics.newImage('Assets/tanks/soviet/2S7/2S7_Hull.png'),
        hull_image_line = love.graphics.newImage('Assets/tanks/soviet/2S7/2S7_Hull_line.png'),
        hull_image_broken = Blank_line,
        turret_image = love.graphics.newImage('Assets/tanks/soviet/2S7/2S7_Gun.png'),
        turret_image_line = love.graphics.newImage('Assets/tanks/soviet/2S7/2S7_Gun_line.png'),
        turret_image_broken = Blank_line,
        anime_sheet = love.graphics.newImage('Assets/tanks/soviet/2S7/2S7_sprite.png'),
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
            type = 'RHA'
        }
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
    }
}



Ships = {
    --USA
    Montana = {
        name = 'Montana',
        class = 'ship',
        width = 64, 
        length = 127,
        image_offset = 0,
        gun_offset = 150,
        main_turret_number = 2,
        main_turret_offset = {{0, 34},{0, -34}},
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
        hull_image = love.graphics.newImage('Assets/tanks/soviet/T-72a/T72A_Hull.png'),
        hull_image_line = love.graphics.newImage('Assets/tanks/soviet/T-72a/T72A_Hull_line.png'),
        hull_image_broken = love.graphics.newImage('Assets/tanks/soviet/T-72a/T72A_Hull_Broken.png'),
        turret_image = love.graphics.newImage('Assets/tanks/soviet/T-72a/T72A_Turret.png'),
        turret_image_line = love.graphics.newImage('Assets/tanks/soviet/T-72a/T72A_Turret_line.png'),
        turret_image_broken = love.graphics.newImage('Assets/tanks/soviet/T-72a/T72A_Turret_Broken.png'),
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

table.insert(Nizhny_Tagil.tankfactory.tanklist, Tanks.T72A)
table.insert(Nizhny_Tagil.tankfactory.tanklist, Tanks.T72B)
table.insert(Nizhny_Tagil.tankfactory.tanklist, Tanks.T90)
table.insert(Nizhny_Tagil.tankfactory.tanklist, IFVs.BMP2)
table.insert(Nizhny_Tagil.tankfactory.tanklist, SPGs.Pion2S7)
--table.insert(Nizhny_Tagil.tankfactory.tanklist, Ships.Montana)
table.insert(Nizhny_Tagil.tankfactory.tanklist, Tanks.M1)