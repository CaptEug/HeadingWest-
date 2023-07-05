TankSpawner = {}

function TankSpawner:loadtank(place, tank)
    tank.collider = world:newRectangleCollider(tank.location.x, tank.location.y, tank.width, tank.length)
    tank.collider:setCollisionClass('Hull')
    tank.collider:setObject(tank)
    tank.collider:setMass(tank.weight)
    tank.collider:setRestitution(0.1)
    tank.collider:setLinearDamping(3)
    tank.collider:setInertia(500*tank.weight)
    tank.collider:setAngularDamping(5)
    tank.collider:setAngle(tank.location.hull_angle)
    tank.functions.move = AutoControlfunction
    if tank.type == 'friendly' then
        tank.Infobuttons = buttons.new()
        buttons.newCampicButton(
            invisible_button,
            function ()
                tank.picked = true
                TankPanelopen = true
                TankChoosen = tank
            end,
            tank.Infobuttons
            
        )
        
    end
    if tank.armor.type == 'ERA' then
        tank.status.era[1] = true
    end
    
    tank:CreatParticles()
end

function TankSpawner:update(dt)
    for i, tank in ipairs(CurrentPlace.exsist_tank) do
        tank:Update(dt)
        tank:CheckStatus(i)
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
        love.graphics.circle("line", tank.location.x, tank.location.y, tank.vision)
    end
    for i, tank in ipairs(CurrentPlace.broken_tank) do
        tank:DrawBrokenTank()
    end
end