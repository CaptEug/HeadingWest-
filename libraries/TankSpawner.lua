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

function TankSpawner:newtank(place,tank)
    tank.collider = world:newRectangleCollider(place.slot_info[tank.selected_slot].x, place.slot_info[tank.selected_slot].y, tank.width, tank.length)
    tank.collider:setCollisionClass('tankhull')
    tank.collider:setObject(tank)
    tank.collider:setMass(tank.weight)
    tank.collider:setRestitution(0.1)
    tank.collider:setLinearDamping(5)
    tank.collider:setAngularDamping(5)
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
    if tank.armor.type == 'ERA' then
        tank.status.era[1] = true
    end
    tank.functions.move = AutoControlfunction
    SetTankParticle(tank)
    table.insert(place.exsist_tank, tank)
end

function TankSpawner:update(dt)
    for i, tank in ipairs(CurrentPlace.exsist_tank) do
        TankUpdate(tank,dt)
        StatusCheck(tank,i)
        tank.functions.move(tank,dt)
    end
end

function TankSpawner:draw_tank()
    for i, tank in ipairs(CurrentPlace.exsist_tank) do
        if tank.collider==nil then
            return nil
        end

        local x,y=tank.image_location.x,tank.image_location.y
        local a=tank.location.hull_angle

        love.graphics.draw(tank.hull_image,x,y,a,1,1,144,144)
        love.graphics.draw(tank.armor.hull_image,x,y,a,1,1,144,144)
        --love.graphics.draw(tank.turret_image,x,y,a+tank.turret_angle,1,1,144,144)
        tank.turret_anime:draw(tank.anime_sheet,x,y,a+tank.turret_angle,1,1,144,144)
        love.graphics.draw(tank.aim.turret_image,x,y,a+tank.turret_angle,1,1,144,144)
        love.graphics.draw(tank.armor.turret_image,x,y,a+tank.turret_angle,1,1,144,144)

        --decide cursor
        if tank.functions.move == ManulControlfunction then
            Cursor = sightcursor
            Cursormode = 'firing'
        end
    end
end

StatusCheck = function (tank, i)
    if tank.status.era[1] then
        if tank.armor.life <= 0 then
            tank.armor.hull_image = Blank_line
            tank.armor.turret_image = Blank_line
            tank.armor.hull_image_line = Blank_line
            tank.armor.turret_image_line = Blank_line
            tank.status.era[1] = false
        end
    end

    if tank.survivor <= 0 then
        TankDead(tank)
        table.insert(CurrentPlace.broken_tank, table.remove(CurrentPlace.exsist_tank, i))
    end
end

TankUpdate = function (tank, dt)
    local x,y=tank.collider:getPosition()
    local hull_angle=tank.collider:getAngle()
    local vx, vy = tank.collider:getLinearVelocity()
    tank.velocity={vx=vx,vy=vy,v=math.sqrt(vx^2+vy^2)}
    tank.location={x=x,y=y}
    tank.location.hull_angle=hull_angle
    tank.image_location.x,tank.image_location.y = x+tank.hull_offset*math.sin(hull_angle),y-tank.hull_offset*math.cos(hull_angle)
    tank.gun_location.x,tank.gun_location.y = x+(tank.hull_offset+tank.gun_offset)*math.sin(hull_angle+tank.turret_angle),
                                              y-(tank.hull_offset+tank.gun_offset)*math.cos(tank.turret_angle+hull_angle)
    tank.exhaust_location.x, tank.exhaust_location.y = x+tank.exhaust_offset.y*math.sin(hull_angle)+tank.exhaust_offset.x*math.cos(hull_angle),
                                                       y-tank.exhaust_offset.y*math.cos(hull_angle)+tank.exhaust_offset.x*math.sin(hull_angle)
    tank.reload_timer = tank.reload_timer - dt
    tank.firing_timer = tank.firing_timer - dt

    --ainme update
    if tank.firing_timer <= 0 then
        tank.turret_anime:gotoFrame(1)
    end
    tank.turret_anime:update(dt)
end

function SetTankParticle(tank)
    tank.particles = {
        muzzlesmoke = love.graphics.newParticleSystem(Smoke),
        enginesmoke = love.graphics.newParticleSystem(ExhaustGas)
    }
    tank.particles.muzzlesmoke:setEmitterLifetime(1.5)
    tank.particles.muzzlesmoke:setParticleLifetime(2)
	tank.particles.muzzlesmoke:setEmissionRate(50)
	tank.particles.muzzlesmoke:setSizeVariation(1)
    tank.particles.muzzlesmoke:setSizes(0.2, 0.6, 1)
    tank.particles.muzzlesmoke:setLinearDamping(5)
	tank.particles.muzzlesmoke:setColors(1, 1, 1, 1, 1, 1, 1, 0)
    tank.particles.muzzlesmoke:stop()

    tank.particles.enginesmoke:setParticleLifetime(2)
	tank.particles.enginesmoke:setEmissionRate(5)
	tank.particles.enginesmoke:setSizeVariation(1)
    tank.particles.enginesmoke:setSizes(0.4, 0.7, 1)
    tank.particles.enginesmoke:setLinearDamping(5)
	tank.particles.enginesmoke:setColors(1, 1, 1, 1, 1, 1, 1, 0)
end

function TankParticleUpdate(dt)
    for i, tank in ipairs(CurrentPlace.exsist_tank) do
        local ix, iy = math.cos(tank.location.hull_angle+tank.turret_angle-math.pi/2),
                       math.sin(tank.location.hull_angle+tank.turret_angle-math.pi/2)
        local hx, hy = math.cos(tank.location.hull_angle+tank.exhaust_angle), math.sin(tank.location.hull_angle+tank.exhaust_angle)
        tank.particles.muzzlesmoke:setPosition(tank.gun_location.x, tank.gun_location.y)
	    tank.particles.muzzlesmoke:setLinearAcceleration(150*ix+math.random(-30,30), 150*iy+math.random(-30,30))
        tank.particles.muzzlesmoke:update(dt)

        tank.particles.enginesmoke:setPosition(tank.exhaust_location.x, tank.exhaust_location.y)
        tank.particles.enginesmoke:setLinearAcceleration(100*hx+math.random(-50,50), 100*hy+math.random(-50,50))
        tank.particles.enginesmoke:update(dt)
    end
end

function TankParticleDraw()
    for i, tank in ipairs(CurrentPlace.exsist_tank) do
        if tank.firing_timer > 0 and tank.firing_timer < 0.2 then
            tank.particles.muzzlesmoke:start()
        end
        love.graphics.draw(tank.particles.muzzlesmoke)

        if tank.velocity.v > 5 or math.abs(tank.collider:getAngularVelocity()) > 0 then
            tank.particles.enginesmoke:setEmissionRate(50)
        else
            tank.particles.enginesmoke:setEmissionRate(5)
        end
        love.graphics.draw(tank.particles.enginesmoke)
    end
end