ConstructureSpawner = {}

function ConstructureSpawner:loadBuilding(building, place)
    building.collider = world:newRectangleCollider(building.location.x, building.location.y, building.width, building.length)
    building.collider:setType('static')
    if building.type == 'resource' then
        SteelProduction = SteelProduction + building.steel_production
        OilProduction = OilProduction + building.oil_production
    end
end

function ConstructureSpawner:update(dt)
    for i, building in ipairs(CurrentPlace.exsist_building) do
        building:Update(dt)
    end
end

function ConstructureSpawner:drawbuilding()
    for i, building in ipairs(CurrentPlace.exsist_building) do
        building:Draw()
    end
end