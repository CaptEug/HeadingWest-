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
            table.insert(Buildings, Collider)
        end
    end
    
    if gameMap.layers['Obstacles'] then
        for i, j in pairs(gameMap.layers['Obstacles'].objects) do
            local Collider = world:newRectangleCollider(j.x, j.y, j.width, j.height)
            Collider.width = j.width
            Collider.height = j.height
            table.insert(Obstacles, Collider)
        end
    end
end

function drawMap()
    if gameMap.layers["Ground"] then
        gameMap:drawLayer(gameMap.layers["Ground"])
    end

    if gameMap.layers["Objects"] then
        gameMap:drawLayer(gameMap.layers["Objects"])
    end

    if gameMap.layers["Sky"] then
        gameMap:drawLayer(gameMap.layers["Sky"])
    end

    Ammo.draw()

end

function DrawCollider(Filelocation)
    local Collider_image=love.graphics.newImage(Filelocation)

    for i in pairs(Obstacles)do
        local collider_x,collider_y=Obstacles[i]:getPosition()
        local collider_angle=Obstacles[i]:getAngle()
        local collider_width=Obstacles[i].width
        local collider_height=Obstacles[i].height

        love.graphics.draw(Collider_image,collider_x,collider_y,collider_angle,128/2,128/2,collider_width,collider_height)
    end
end