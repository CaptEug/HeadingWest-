Buildings = {}
Obstacles = {}

function loadMap(mapName)
    destroyAll()
    gameMap = sti("chapters/maps/" .. mapName .. ".lua")

    if gameMap.layers['Buildings'] then
        for i, j in pairs(gameMap.layers['Buildings'].objects) do
            local Collider = world:newRectangleCollider(j.x, j.y, j.width, j.height)
            Collider.width = j.width
            Collider.height = j.height
            Collider:setType('static')
            Collider:setCollisionClass('Wall')
            table.insert(Buildings, Collider)
        end
    end
    
    if gameMap.layers['Objects'] then
        for i, j in pairs(gameMap.layers['Objects'].objects) do
            local Collider = world:newRectangleCollider(j.x, j.y, j.width, j.height)
            Collider.width = j.width
            Collider.height = j.height
            table.insert(Obstacles, Collider)
        end
    end

    tank1 = tanks_table:newtank("Assets/tanks/german/MAUS/MAUS.txt", Data.ax , Data.ay, Data.angle)
    tank2 = tanks_table:newtank("Assets/tanks/usa/M48A1/M48A1.txt", 1000 , 1000, 0)
    tank3 = tanks_table:newtank("Assets/tanks/soviet/T-5455/T-54.txt", 1500 , 1500, 0)
    tanks_table:addai(tank1, keybroadcontrol)
    --tanks_table:addai(tank2,poorai)
    --tanks_table:addai(tank3,poorai)
end

function drawMap()
    if gameMap.layers["Ground"] then
        gameMap:drawLayer(gameMap.layers["Ground"])
    end
    
    tanks_table:draw()
    Ammo.draw()
    DrawCollider()

    if gameMap.layers["Roof"] then
        gameMap:drawLayer(gameMap.layers["Roof"])
    end

    if gameMap.layers["Sky"] then
        gameMap:drawLayer(gameMap.layers["Sky"])
    end

    --shaders.dark()
end

function DrawCollider()
    for i, j in pairs(Obstacles) do
        local collider_x,collider_y = j:getPosition()
        local collider_angle = j:getAngle()
        love.graphics.draw(love.graphics.newImage("Assets/objects/Spike1.png"), collider_x,collider_y, collider_angle, 1, 1, j.width/2, j.height/2)
    end

    --[[for i, j in pairs() do
        local collider_x,collider_y = j:getPosition()
        local collider_angle = j:getAngle()
        love.graphics.draw(love.graphics.newImage(), collider_x,collider_y, collider_angle, 1, 1, j.width, j.height)
    end]]--
end