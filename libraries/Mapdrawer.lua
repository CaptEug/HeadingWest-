Structure = {}
Obstacles = {}

require 'libraries.TankSpawner'

function loadMap(mapName)
    destroyAll()
    gameMap = sti("Assets/maps/" .. mapName .. ".lua")

    if gameMap.layers['Structure'] then
        for i, j in pairs(gameMap.layers['Structure'].objects) do
            local Collider = world:newRectangleCollider(j.x, j.y, j.width, j.height)
            Collider.width = j.width
            Collider.height = j.height
            Collider:setType('static')
            Collider:setCollisionClass('Wall')
            table.insert(Structure, Collider)
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

function DrawMapDown()
    if gameMap.layers["Ground"] then
        gameMap:drawLayer(gameMap.layers["Ground"])
    end

    if gameMap.layers["Objects"] then
        gameMap:drawLayer(gameMap.layers["Objects"])
    end

    if gameMap.layers["Buildings"] then
        gameMap:drawLayer(gameMap.layers["Buildings"])
    end

    DrawCollider()
end

function DrawMapUp()
    if gameMap.layers["Ceiling"] then
        gameMap:drawLayer(gameMap.layers["Ceiling"])
    end

    if gameMap.layers["Roof"] and cam.scale < 1 then
        love.graphics.setColor(1,1,1,0.5/cam.scale)
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
