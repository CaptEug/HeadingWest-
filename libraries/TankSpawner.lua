TankSpawner={}

function TankSpawner:slot_distribution(place)
    local slot_full=true
    local selected_slot
    for i, slot in ipairs(place.slot_info) do
        if slot.available==true then
            slot.available=false
            selected_slot=i
            slot_full=false
            break
        end
    end
    if slot_full==true then
        selected_slot=0
    end
    return selected_slot
end

function TankSpawner:newtank(place, tank)
    tank.collider = world:newRectangleCollider(tank.location.x, tank.location.y, tank.width, tank.length)
    tank.collider:setCollisionClass('tankhull')
    tank.collider:setObject(tank)
    tank.collider:setMass(tank.weight)
    tank.collider:setRestitution(0.1)
    tank.collider:setLinearDamping(3)
    tank.collider:setAngularDamping(5)
    if tank.type == 'Friendly' then
        tank.Infobuttons = buttons.new()
        buttons.newCampicButton(
            invisible_button,
            function ()
                TankPanelopen = true
                TankChoosen = tank
                TankChoosen.picked = true
                for i, tank in ipairs(CurrentPlace.exsist_tank) do
                    if tank ~= TankChoosen and tank.picked then
                        tank.picked = false
                    end
                end
            end,
            tank.Infobuttons
        )
    end
    if tank.armor.type == 'ERA' then
        tank.status.era[1] = true
    end
    tank.functions.move = AutoControlfunction
    tank:CreatParticles()
    table.insert(place.exsist_tank, tank)
end

function TankSpawner:update(dt)
    for i, tank in ipairs(CurrentPlace.exsist_tank) do
        tank:Update(dt)
        tank:CheckStatus(i)
        tank:ParticleUpdate(dt)
        tank.functions.move(tank,dt)
    end
end

function TankSpawner:draw_tank()
    for i, tank in ipairs(CurrentPlace.exsist_tank) do
        if tank.collider == nil then
            return nil
        end
        tank:Draw()
        tank:ParticleDraw()

        --decide cursor
        if tank.functions.move == ManualControlfunction then
            Cursor = sightcursor
            Cursormode = 'firing'
        end

        --draw vision circle
        love.graphics.circle("line", tank.location.x, tank.location.y, tank.vision)
    end
    for i, tank in ipairs(CurrentPlace.broken_tank) do
        tank:DrawBrokenTank()
    end
end