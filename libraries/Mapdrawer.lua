Buildings = {}
Obstacles = {}

function loadMap(mapName)
    destroyAll()
    gameMap = sti("chapters/maps/" .. mapName .. ".lua")

    if gameMap.layers['Buildings'] then
        for i, j in pairs(gameMap.layers['Buildings'].objects) do
            local Collider = world:newRectangleCollider(j.x, j.y, j.width*Size, j.height*Size)
            Collider.width = j.width
            Collider.height = j.height
            Collider:setType('static')
            table.insert(Buildings, Collider)
        end
    end
    
    if gameMap.layers['Obstacles'] then
        for i, j in pairs(gameMap.layers['Obstacles'].objects) do
            local Collider = world:newRectangleCollider(j.x, j.y, j.width*Size, j.height*Size)
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

