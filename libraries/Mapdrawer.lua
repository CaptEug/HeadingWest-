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

end

--[[function SetColliders:draw(Filelocation)
    local Collider_image=love.graphics.newImage(Filelocation)

    for i in pairs(Collider_data.collision)do
        local collider_x,collider_y=Collider_data.collision[i]:getPosition()
        local collider_angle=Collider_data.collision[i]:getAngle()
        local collider_width=Collider_data.width[i]
        local collider_height=Collider_data.height[i]

        love.graphics.draw(Collider_image,collider_x,collider_y,collider_angle,Size/2,Size/2,collider_width,collider_height)
    end
end]]--