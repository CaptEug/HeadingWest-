function loadMap(mapName)
    gameMap = sti("chapters/maps/" .. mapName .. ".lua")

    if gameMap.layers['Buildings'] then
        for i, j in pairs(gameMap.layers['Buildings'].objects) do
            local Collider_data={}
            Collider_data.collision={}
            Collider_data.width={}
            Collider_data.height={}
            Collider_data.collision[i] = world:newRectangleCollider(j.x, j.y, j.width*Size, j.height*Size)
            Collider_data.width[i]=j.width
            Collider_data.height[i]=j.height
            Collider_data.collision[i]:setType('static')
        end
    end
    if gameMap.layers['Obstacles'] then
        for i, j in pairs(gameMap.layers['Obstacles'].objects) do
            local Collider_data={}
            Collider_data.collision={}
            Collider_data.width={}
            Collider_data.height={}
            Collider_data.collision[i] = world:newRectangleCollider(j.x, j.y, j.width*Size, j.height*Size)
            Collider_data.width[i]=j.width
            Collider_data.height[i]=j.height
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

