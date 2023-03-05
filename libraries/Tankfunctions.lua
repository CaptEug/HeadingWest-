AutoControlfunction = function (i,dt)
    
end

ManulControlfunction = function (tank,dt)
    local hp = 50*tank.data.mob.hp*0.745
    local fx = hp*math.cos(tank.location.hull_angle - 0.5*math.pi)
    local fy = hp*math.sin(tank.location.hull_angle - 0.5*math.pi)
    local max_f = tank.data.max_f_speed
    local max_r = tank.data.max_r_speed
    local speed = tank.collider:getLinearVelocity()/math.cos(tank.location.hull_angle - 0.5*math.pi)/5
    local ta = tank.data.turret_angle + tank.location.hull_angle - 0.5*math.pi
    local mx, my = cam:mousePosition()
    local tx, ty = tank.location.x,tank.location.y
    local angle_to_mouse = math.atan2(my - ty, mx - tx)

    if love.keyboard.isDown('up') and speed <= max_f then
        tank.collider:applyForce(fx, fy)
    end
    if love.keyboard.isDown('down') and speed >= max_r then
        tank.collider:applyForce(-fx, -fy)
    end
    if love.keyboard.isDown('left') then
        tank.collider:applyTorque(-5*hp)
    end
    if love.keyboard.isDown('right') then
        tank.collider:applyTorque(5*hp)
    end

    if angle_to_mouse <= 0 then
        angle_to_mouse = angle_to_mouse + math.pi*2
    end
    while ta > 2*math.pi do
        ta = ta - 2*math.pi
    end
    while ta < 0 do
        ta = ta + 2*math.pi
    end
    if ta > angle_to_mouse then
        if ta - angle_to_mouse <= math.pi then
            tank.data.turret_angle = tank.data.turret_angle - 0.5*dt
        else
            tank.data.turret_angle = tank.data.turret_angle + 0.5*dt
        end
    end
    if ta < angle_to_mouse then
        if angle_to_mouse - ta <= math.pi then
            tank.data.turret_angle = tank.data.turret_angle + 0.5*dt
        else
            tank.data.turret_angle = tank.data.turret_angle - 0.5*dt
        end
    end

    if love.mouse.isDown(1) then
        Ammo:test_shoot('APCBC',APCBC,tank)
    end
end

TankUpdate=function (tank)
    local x,y=tank.collider:getPosition()
    local hull_angle=tank.collider:getAngle()
    tank.location={x=x,y=y}
    tank.location.hull_angle=hull_angle
    tank.image_location.x,tank.image_location.y=x+tank.data.hull_offset*math.sin(hull_angle),y-tank.data.hull_offset*math.cos(hull_angle)
end