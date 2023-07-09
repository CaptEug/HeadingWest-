ShipSpawner = {}

require 'Data.Ship.Shipfunctions'

function ShipSpawner:loadship(place, ship)
    ship.collider = place.world:newRectangleCollider(ship.location.x, ship.location.y, ship.width, ship.length)
    ship.collider:setCollisionClass('Hull')
    ship.collider:setObject(ship)
    ship.collider:setMass(ship.weight)
    ship.collider:setRestitution(0.1)
    ship.collider:setLinearDamping(3)
    ship.collider:setInertia(500*ship.weight)
    ship.collider:setAngularDamping(5)
    ship.collider:setAngle(ship.location.hull_angle)
    ship.functions.move = Mouse_Controlfunction
    -- if ship.type == 'friendly' then
    --     ship.Infobuttons = buttons.new()
    --     buttons.newCampicButton(
    --         invisible_button,
    --         function ()
    --             ship.picked = true
    --             ShipPanelopen = true
    --             ShipChoosen = ship
    --         end,
    --         ship.Infobuttons
            
    --     )
    -- end
    -- if ship.armor.type == 'ERA' then
    --     ship.status.era = true

    -- end
    
    --ship:CreatParticles()
end

function ShipSpawner:update(dt)
    for i, ship in ipairs(CurrentPlace.exsist_ship) do
        ship:Update(dt)
        --ship:CheckStatus(i, dt)
        --ship:ParticleUpdate(dt)
    end
end

function ShipSpawner:drawship()
    for i, ship in ipairs(CurrentPlace.exsist_ship) do
        if ship.collider == nil then
            return nil
        end
        ship:Draw()
        --ship:ParticleDraw()

        --decide cursor
        -- if ship.functions.move == ManualControlfunction then
        --     Cursormode = 'firing'
        -- end

        --draw vision circle
        love.graphics.circle("line", ship.location.x, ship.location.y, ship.vision)
    end
    -- for i, ship in ipairs(CurrentPlace.broken_tank) do
    --     --ship:DrawBrokenShip()
    -- end
end