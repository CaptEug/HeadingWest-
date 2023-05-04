ConstructureSpawner = {}

function ConstructureSpawner:loadBuilding(building, place)
    local x, y = building.location.x - building.width/2, building.location.y - building.length/2
    building.collider = world:newRectangleCollider(x, y, building.width, building.length)
    building.collider:setType('static')
    if building.class == 'resource' then
        SteelProduction = SteelProduction + building.steel_production
        OilProduction = OilProduction + building.oil_production
    end
    if building.class == 'defence' then
        building.functions.defence = AutoDefenceMode
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
        --draw vision circle
        love.graphics.circle("line", building.location.x, building.location.y, building.vision)
    end
end