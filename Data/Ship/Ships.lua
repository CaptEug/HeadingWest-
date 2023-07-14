

Ships = {
    --USA
    Montana = {
        name = 'Montana',
        class = 'ship',
        width = 650, 
        length = 4800,
        image_offset = 0,
        main_turret_number = 4,
        main_turret_offset = {
            {x = 0, y = -1308, height = 1, angle = 0, angle1 = 0, fwangle = 35/180*math.pi, get = false, id = 1},
            {x = 0, y = -954, height = 2, angle = 0, angle1 = 0, fwangle = 35/180*math.pi, get = false, id = 2},
            {x = 0, y = 762, height = 2, angle = math.pi, angle1 = math.pi, fwangle = 35/180*math.pi, get = false, id = 3},
            {x = 0, y = 1116, height = 1, angle = math.pi,angle1 = math.pi,  fwangle = 35/180*math.pi, get = false, id = 4}
        },
        gun_offset = {{x = 52, y = -325}, {x = 0, y = -325}, {x = -52, y = -325}},
        weight = 70000,
        crew = 2700,
        max_f_speed = 60,
        max_r_speed = -4,
        turnspeed = 0,
        frontspeed = {x = 0, y = 0},
        turret_t_speed = 5,
        vision = 6000,
        engine_output = 172000,
        hull_image = love.graphics.newImage('Assets/ships/usa/Montana/Montana.png'),
        turret_image = love.graphics.newImage('Assets/ships/usa/Montana/406mmMk7.png'),
        anime_sheet = love.graphics.newImage('Assets/tanks/soviet/T-72a/T72A_firingsprite.png'),
        ammorack = {
            {name = '406mmHE', type = 'HE', pentype = 'CE', velocity = 820, mass = 1, pen = 406, TNT_eq = 10, shells = love.graphics.newImage('Assets/ships/usa/Weapons/406mmHCShells.png')}
        },
        reload_time = 3,
    }
}