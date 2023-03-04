AutoControlfunction = function (i,dt)
    
end

ManulControlfunction = function (i,dt)
    local hp = 50*CurrentPlace.exsist_tank[i].data.mob.hp*0.745
    local fx = hp*math.cos(CurrentPlace.exsist_tank[i].collider:getAngle() - 0.5*math.pi)
    local fy = hp*math.sin(CurrentPlace.exsist_tank[i].collider:getAngle() - 0.5*math.pi)
    local max_f = CurrentPlace.exsist_tank[i].data.max_f_speed
    local max_r = CurrentPlace.exsist_tank[i].data.max_r_speed
    local speed = CurrentPlace.exsist_tank[i].collider:getLinearVelocity()/math.cos(CurrentPlace.exsist_tank[i].collider:getAngle() - 0.5*math.pi)/5
    local ta = CurrentPlace.exsist_tank[i].data.turret_angle + CurrentPlace.exsist_tank[i].collider:getAngle() - 0.5*math.pi
    local mx, my = cam:mousePosition()
    local tx, ty = CurrentPlace.exsist_tank[i].collider:getPosition()
    local angle_to_mouse = math.atan2(my - ty, mx - tx)

    if love.keyboard.isDown('up') and speed <= max_f then
        CurrentPlace.exsist_tank[i].collider:applyForce(fx, fy)
    end
    if love.keyboard.isDown('down') and speed >= max_r then
        CurrentPlace.exsist_tank[i].collider:applyForce(-fx, -fy)
    end
    if love.keyboard.isDown('left') then
        CurrentPlace.exsist_tank[i].collider:applyTorque(-5*hp)
    end
    if love.keyboard.isDown('right') then
        CurrentPlace.exsist_tank[i].collider:applyTorque(5*hp)
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
            CurrentPlace.exsist_tank[i].data.turret_angle = CurrentPlace.exsist_tank[i].data.turret_angle - 0.5*dt
        else
            CurrentPlace.exsist_tank[i].data.turret_angle = CurrentPlace.exsist_tank[i].data.turret_angle + 0.5*dt
        end
    end
    if ta < angle_to_mouse then
        if angle_to_mouse - ta <= math.pi then
            CurrentPlace.exsist_tank[i].data.turret_angle = CurrentPlace.exsist_tank[i].data.turret_angle + 0.5*dt
        else
            CurrentPlace.exsist_tank[i].data.turret_angle = CurrentPlace.exsist_tank[i].data.turret_angle - 0.5*dt
        end
    end
end