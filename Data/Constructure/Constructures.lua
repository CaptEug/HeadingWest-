Constructures = {
    OilDriller = {
        name = 'Oil Driller',
        type = 'resource',
        requirement = 'oil field',
        width = 256,
        length = 128,
        steel_cost = 20,
        oil_cost = 0,
        steel_production = 0,
        oil_productioon = 1,
        hitpoint = 3,
        image = love.graphics.newImage('Assets/pictures/Stalin_red.png'),
        anime_sheet = love.graphics.newImage('Assets/pictures/Stalin_red.png'),
        buildtime = 10
    },

    --[[Maxim_Gorky = {
        name = 'Maxim Gorky II',
        type = 'defence',
        requirement = 'none',
        width = 288,
        length = 288,
        steel_cost = 100,
        oil_cost = 50,
        hitpoint = 100,
        turret_image = love.graphics.newImage(''),
        base_image = love.graphics.newImage(''),
        anime_sheet = love.graphics.newImage(''),
        buildtime = 10
    }]]
}

table.insert(Nizhny_Tagil.constructurelist, Constructures.OilDriller)

