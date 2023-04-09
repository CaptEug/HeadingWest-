AutoControlfunction = function (i,dt)
    
end

ManulControlfunction = function (tank,dt)
    local hp = 50*tank.data.mob.hp*0.745
    local fx = hp*math.cos(tank.location.hull_angle - 0.5*math.pi)
    local fy = hp*math.sin(tank.location.hull_angle - 0.5*math.pi)
    local max_f = tank.data.max_f_speed
    local max_r = math.abs(tank.data.max_r_speed)
    local speed = tank.velocity.v/5
    local mx, my = cam:mousePosition()
    local isaim = AimCheck(tank, mx, my, dt)

    cam:lookAt(tank.location.x, tank.location.y)
    
    if love.keyboard.isDown('w') and speed <= max_f then
        tank.collider:applyForce(fx, fy)
    end
    if love.keyboard.isDown('s') and speed <= max_r then
        tank.collider:applyForce(-fx, -fy)
    end
    if love.keyboard.isDown('a') then
        tank.collider:applyTorque(-5*hp)
    end
    if love.keyboard.isDown('d') then
        tank.collider:applyTorque(5*hp)
    end

    if Cursormode == 'firing' and love.mouse.isDown(1) and #tank.data.ammorack > 0 and isaim and tank.data.reload_timer <= 0 then
        Shoot(tank)
        tank.firing_timer = 0.7
        tank.data.reload_timer = tank.data.reload_time
    end
end

FortifyControlfunction = function (tank,dt)
    
end

AimCheck = function (tank, x, y, dt)
    local isaim = false
    local tx, ty = tank.location.x,tank.location.y
    local angle_to_target = math.atan2(y - ty, x - tx)
    local ta = tank.data.turret_angle + tank.location.hull_angle - 0.5*math.pi

    if angle_to_target <= 0 then
        angle_to_target = angle_to_target + math.pi*2
    end
    while ta > 2*math.pi do
        ta = ta - 2*math.pi
    end
    while ta < 0 do
        ta = ta + 2*math.pi
    end
    if ta > angle_to_target then
        if ta - angle_to_target <= math.pi then
            tank.data.turret_angle = tank.data.turret_angle - 0.5*dt
        else
            tank.data.turret_angle = tank.data.turret_angle + 0.5*dt
        end
    end
    if ta < angle_to_target then
        if angle_to_target - ta <= math.pi then
            tank.data.turret_angle = tank.data.turret_angle + 0.5*dt
        else
            tank.data.turret_angle = tank.data.turret_angle - 0.5*dt
        end
    end
    if ta < angle_to_target + math.pi/36 and ta > angle_to_target - math.pi/36 then
        isaim = true
    end
    return isaim
end

function TankDead(tank)
    
end 