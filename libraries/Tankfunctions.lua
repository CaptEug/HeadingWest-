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


    if love.keyboard.isDown('up') and speed <= max_f then
        tank.collider:applyForce(fx, fy)
    end
    if love.keyboard.isDown('down') and speed <= max_r then
        tank.collider:applyForce(-fx, -fy)
    end
    if love.keyboard.isDown('left') then
        tank.collider:applyTorque(-5*hp)
    end
    if love.keyboard.isDown('right') then
        tank.collider:applyTorque(5*hp)
    end

    
    if love.mouse.isDown(1) and table.getn(tank.data.ammorack) > 0 and isaim and tank.data.reload_timer <= 0 then
        Shoot(tank)
        tank.data.reload_timer = tank.data.reload_time
    end
end

TankUpdate=function (tank,dt)
    local x,y=tank.collider:getPosition()
    local hull_angle=tank.collider:getAngle()
    local vx, vy = tank.collider:getLinearVelocity()
    tank.velocity={vx=vx,vy=vy,v=math.sqrt(vx^2+vy^2)}
    tank.location={x=x,y=y}
    tank.location.hull_angle=hull_angle
    tank.image_location.x,tank.image_location.y=x+tank.data.hull_offset*math.sin(hull_angle),y-tank.data.hull_offset*math.cos(hull_angle)
    tank.gun_location.x,tank.gun_location.y = x+(tank.data.hull_offset+tank.data.gun_offset)*math.sin(hull_angle+tank.data.turret_angle),
                                              y-(tank.data.hull_offset+tank.data.gun_offset)*math.cos(tank.data.turret_angle+hull_angle)
    tank.data.reload_timer = tank.data.reload_timer - dt
end

StatusChecker=function (tankStatus)
    
    if tankStatus.dead==true then
        
    end
    
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