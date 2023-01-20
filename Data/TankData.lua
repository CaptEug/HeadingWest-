TankData = {}

Blank_line = love.graphics.newImage('Assets/tanks/Blank_line.png')
--t72
T72A_line = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_line.png')
T72A_turret = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_turret.png')
T72A_hull = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_hull.png')
T72A_kontakt1_turret = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_kontakt1_turret.png')
T72A_kontakt1_hull = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_kontakt1_hull.png')
T72A_kontakt1_line = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_kontakt1_line.png')
T72B_line = love.graphics.newImage('Assets/tanks/soviet/T-72/T72B_line.png')
T72B_kontakt1_line = love.graphics.newImage('Assets/tanks/soviet/T-72/T72B_kontakt1_line.png')
T72B_kontakt5_line = love.graphics.newImage('Assets/tanks/soviet/T-72/T72B_kontakt5_line.png')

function TankData:load()
    T72A = {
        name = 'T-72a',
        line_image = T72A_line,
        turret_image = T72A_turret,
        hull_image = T72A_hull,
        accessories = { 
            {name = 'Kontakt_1', line_image = T72A_kontakt1_line, turret_image = T72A_kontakt1_turret, hull_image = T72A_kontakt1_hull, tag = 'Armor'},
        },
        buildtime = 20
    }
    table.insert(UVZ.tanklist, T72A)

    T72B = {
        name = 'T-72b',
        line_image = T72B_line,
        accessories = { 
            {name = 'Kontakt_1', line_image = T72B_kontakt1_line, tag = 'Armor'},
            {name = 'Kontakt_5', line_image = T72B_kontakt5_line, tag = 'Armor'}
        },
        buildtime = 25
    }
    table.insert(UVZ.tanklist, T72B)
end