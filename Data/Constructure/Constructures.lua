Icon_in_progress = love.graphics.newImage('Assets/constructures/ImageinProgress.png')

Constructures = {
    OilDriller = {
        name = 'Oil Driller',
        class = 'resource',
        requirement = 'oil field',
        width = 128,
        length = 128,
        preBuild = {
            width = 128,
            length = 128,
        },
        vision = 200,
        steel_cost = 20,
        oil_cost = 0,
        oil_production = 0.01,
        oil_storage = 20,
        oil_stored = 0,
        hitpoint = 10,
        armorthickness = 0,
        icon = Icon_in_progress,
        image = Image_in_progress,
        anime_sheet = Image_in_progress,
        buildtime = 10,
        fixedbuildtime = 10
    },

    SteelForge = {
        name = 'Steel Forge',
        class = 'resource',
        requirement = '',
        width = 128,
        length = 128,
        preBuild = {
            width = 128,
            length = 128,
        },
        vision = 200,
        steel_cost = 20,
        oil_cost = 0,
        steel_production = 0.01,
        steel_storage = 20,
        steel_stored = 0,
        hitpoint = 10,
        armorthickness = 0,
        icon = Icon_in_progress,
        image = Image_in_progress,
        anime_sheet = Image_in_progress,
        buildtime = 10,
        fixedbuildtime = 10
    },

    OilStorage = {
        name = 'Oil Storage',
        class = 'resource',
        width = 64,
        length = 192,
        vision = 200,
        preBuild = {
            width = 64,
            length = 192,
        },
        steel_cost = 20,
        oil_cost = 0,
        oil_storage = 500,
        oil_stored = 0,
        hitpoint = 100,
        armorthickness = 0,
        icon = Icon_in_progress,
        image = love.graphics.newImage('Assets/constructures/resource/Oil/OilStorage_small.png'),
        anime_sheet = love.graphics.newImage('Assets/constructures/resource/Oil/OilStorage_small.png'),
        buildtime = 10,
        fixedbuildtime = 10
    },

    Pipe = {
        name = 'Pipe',
        class = 'logistic',
        width = 32,
        length = 32,
        preBuild = {
            width = 32,
            length = 32,
        },
        vision = 0,
        steel_cost = 1,
        oil_cost = 0,
        hitpoint = 10,
        armorthickness = 0,
        icon = Icon_in_progress,
        image = love.graphics.newImage('Assets/constructures/logistic/Pipe/pipe_cross.png'),
        anime_sheet = love.graphics.newImage('Assets/constructures/logistic/Pipe/pipe_cross.png'),
        buildtime = 1,
        fixedbuildtime = 1
    },

    Maxim_Gorky = {
        name = 'Maxim Gorky II',
        class = 'defence',
        mode = 'bomb',
        requirement = 'none',
        width = 288,
        length = 288,
        preBuild = {
            width = 544,
            length = 544,
        },
        vision = 1800,
        turret_offset = {x = 144, y = 144},
        turret_t_speed = 50,

        gun_offset = {{x = 0, y = -250}, {x = -48, y = -250}, {x = 48, y = -250}},
        steel_cost = 100,
        oil_cost = 50,
        hitpoint = 500,
        armorthickness = 305,
        ammorack = {
            {name = '305mmHE', type = 'HE', pentype = 'CE', velocity = 800, mass = 1, pen = 305, TNT_eq = 55,  shells = love.graphics.newImage('Assets/ships/usa/Weapons/406mmHCShells.png')}
        },
        
        reload_time = 3,
        firing_time = 1,
        buildtime = 10,
        fixedbuildtime = 10,
        icon = love.graphics.newImage('Assets/constructures/defence/MaximGorky/MaximGorky_icon.png'),
        image = love.graphics.newImage('Assets/constructures/defence/MaximGorky/MaximGorky.png'),
        base_image = love.graphics.newImage('Assets/constructures/defence/MaximGorky/MaximGorky_Base.png'),
        anime_sheet = love.graphics.newImage('Assets/constructures/defence/MaximGorky/MaximOpenFire.png'),
        anime_grid = anim8.newGrid(512, 512, 512*10, 512*1),
    }
}

table.insert(Nizhny_Tagil.constructurelist, Constructures.OilDriller)
table.insert(Nizhny_Tagil.constructurelist, Constructures.SteelForge)
table.insert(Nizhny_Tagil.constructurelist, Constructures.OilStorage)
table.insert(Nizhny_Tagil.constructurelist, Constructures.Pipe)
table.insert(Nizhny_Tagil.constructurelist, Constructures.Maxim_Gorky)

