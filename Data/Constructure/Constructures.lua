Constructures = {
    OilDriller = {
        name = 'Oil Driller',
        class = 'resource',
        requirement = 'oil field',
        width = 288,
        length = 288,
        vision = 0,
        steel_cost = 20,
        oil_cost = 0,
        steel_production = 0,
        oil_productioon = 1,
        hitpoint = 10,
        armorthickness = 0,
        icon = love.graphics.newImage('Assets/pictures/buttons/MaximGorky_icon.png'),
        image = Image_in_progress,
        anime_sheet = Image_in_progress,
        buildtime = 10,
        fixedbuildtime = 10
    },

    Maxim_Gorky = {
        name = 'Maxim Gorky II',
        class = 'defence',
        mode = 'bomb',
        requirement = 'none',
        width = 288,
        length = 288,
        vision = 1800,
        turret_offset = 0,
        turret_t_speed = 5,
        gun_offset = {x = 0, y = 250},
        gun_offset2 = {x = -48, y = 250},
        gun_offset3 = {x = 48, y = 250},
        steel_cost = 100,
        oil_cost = 50,
        hitpoint = 500,
        armorthickness = 305,
        ammorack = {
            {name = '305mmHE', type = 'HE', pentype = 'CE', velocity = 100, mass = 1, pen = 305, TNT_eq = 55}
        },
        reload_time = 20,
        firing_time = 1,
        buildtime = 10,
        fixedbuildtime = 10,
        icon = love.graphics.newImage('Assets/pictures/buttons/MaximGorky_icon.png'),
        image = love.graphics.newImage('Assets/constructures/defence/MaximGorky/MaximGorky.png'),
        base_image = love.graphics.newImage('Assets/constructures/defence/MaximGorky/MaximGorky_Base.png'),
        anime_sheet = love.graphics.newImage('Assets/constructures/defence/MaximGorky/MaximOpenFire.png'),
        anime_grid = anim8.newGrid(512, 512, 512*10, 512*1),
    }
}

table.insert(Nizhny_Tagil.constructurelist, Constructures.OilDriller)
table.insert(Nizhny_Tagil.constructurelist, Constructures.Maxim_Gorky)

