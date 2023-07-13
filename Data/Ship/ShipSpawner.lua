ShipSpawner = {}

function ShipSpawner:loadship(place, ship)
    ship.collider = place.world:newRectangleCollider(ship.location.x - ship.width/2, ship.location.y - ship.length/2, ship.width, ship.length)
    ship.collider:setCollisionClass('Hull')
    ship.collider:setObject(ship)
    ship.collider:setMass(ship.weight)
    ship.collider:setRestitution(0.1)
    ship.collider:setLinearDamping(0.5)
    ship.collider:setInertia(500*ship.weight)
    ship.collider:setAngularDamping(20)
    ship.collider:setAngle(ship.location.hull_angle)
    ship.functions.move = Mouse_Controlfunction
end

function ShipSpawner:update(dt)
    for i, ship in ipairs(CurrentPlace.exsist_ship) do
        ship:Update(dt)
    end
end

function ShipSpawner:drawship()
    for i, ship in ipairs(CurrentPlace.exsist_ship) do
        if ship.collider == nil then
            return nil
        end
        ship:Draw()
        love.graphics.circle("line", ship.location.x, ship.location.y, ship.vision)
    end
end