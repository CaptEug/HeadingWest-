TankSpawner = {}

function TankSpawner:loadtank(place, tank)
    tank.collider = place.world:newRectangleCollider(tank.location.x, tank.location.y, tank.width, tank.length)
    tank.collider:setCollisionClass('TankHull')
    tank.collider:setObject(tank)
    tank.collider:setMass(tank.weight)
    tank.collider:setRestitution(0.1)
    tank.collider:setLinearDamping(3)
    tank.collider:setInertia(500*tank.weight)
    tank.collider:setAngularDamping(5)
    tank.collider:setAngle(tank.location.hull_angle)
    tank.functions.move = AutoControlfunction
    tank.collider.munber = tank.number
    if tank.type == 'friendly' then
        tank.InfoButtons = Buttons.new()
        Buttons.newCampicButton(
            invisible_button,
            function ()
                tank.picked = true
                CurrentPlace.TankInfoPanelWindow.open = true
                TankChoosen = tank
            end,
            tank.InfoButtons
        )
    end
    if tank.armor.type == 'ERA' then
        tank.status.era = true
    end
    
    tank:CreatParticles()
end

function TankSpawner:update(dt)
    for i, tank in ipairs(CurrentPlace.exsist_tank) do
        tank:Update(dt)
        tank:CheckStatus(i, dt)
        tank:ParticleUpdate(dt)
    end
end

function TankSpawner:drawtank()
    for i, tank in ipairs(CurrentPlace.exsist_tank) do
        if tank.collider == nil then
            return nil
        end
        tank:Draw()
        tank:ParticleDraw()

        --decide cursor
        if tank.functions.move == ManualControlfunction then
            Cursormode = 'firing'
        end

        --draw vision circle
    end
    for i, tank in ipairs(CurrentPlace.broken_tank) do
        tank:DrawBrokenTank()
    end
end