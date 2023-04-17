ConstructureSpawner = {}

function ConstructureSpawner:loadBuilding(building, place)
    building.collider = world:newRectangleCollider(building.location.x, building.location.y, building.width, building.length)
    building.collider:setType('static')

end

function ConstructureSpawner:drawbuilding()
    for i, building in ipairs(CurrentPlace.exsist_building) do
        building:Draw()
    end
end