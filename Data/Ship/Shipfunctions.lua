Ship = {}
Ship.__index = Ship


function Buildship(place, ship, type, x, y, ...)
    local status = ...
    local shipy = {
        name = ship.name,
        class = ship.class,
        width = ship.width,
        length = ship.length,
        weight = ship.weight,
        crew = ship.crew,
        max_f_speed = ship.max_f_speed,
        max_r_speed = ship.max_r_speed,
        turnspeed = 0,
        frontspeed = {x = 0, y = 0},
        turret_t_speed = ship.turret_t_speed,
        turret_angle = 0,
        hull_image = ship.hull_image,
        turret_image = ship.turret_image,
        el_turret_image = ship.el_turret_image,
        image_offset = ship.image_offset,
        engineput = ship.engine_output,
        vision = ship.vision,
        main_turret_offset = ship.main_turret_offset,
        el_turret_offset =  ship.el_turret_offset,
        turret_t_speed = ship.turret_t_speed,
        ammorack = ship.ammorack,
        el_ammorack = ship.el_ammorack,
        gun_offset = ship.gun_offset,
        el_gun_offset = ship.el_gun_offset,
        el_turret_t_speed = ship.el_turret_t_speed,
        velocity = {vx = 0, vy = 0, v = 0},
        location = {x = x, y = y, hull_angle = 0},
        destination = {x = x, y = y},
        target1 = {x = nil, y = nil},
        image_location = {},
        turret_location = {},
        el_turret_location = {},
        functions = {},
        reload_time = ship.reload_time,
        el_reload_time = ship.el_reload_time,
        battery = {},
        el_battery = {},
    }
    for i, turret in ipairs(shipy.main_turret_offset) do
        table.insert(shipy.turret_location, turret.id, {ID = turret.id,x = x - turret.x, y = y - turret.y, height = turret.height})
        table.insert(shipy.battery, i, {battery_location = {x = turret.x, y = turret.y}, reload_time = shipy.reload_time, reload_timer = shipy.reload_time, aready = true, gun = {}, battery_angle = 0})
        shipy.battery[i].ammorack = shipy.ammorack
    end 
    for i, turret in ipairs(shipy.el_turret_offset) do
        table.insert(shipy.el_turret_location, turret.id, {ID = turret.id,x = x - turret.x, y = y - turret.y, height = turret.height})
        table.insert(shipy.el_battery, i, {battery_location = {x = turret.x, y = turret.y}, reload_time = shipy.el_reload_time, reload_timer = shipy.el_reload_time, aready = true, gun = {}, battery_angle = 0})
        shipy.el_battery[i].ammorack = shipy.el_ammorack
    end 

    setmetatable(shipy, Ship)
    table.insert(place.exsist_ship, shipy)
    ShipSpawner:loadship(place, shipy)
end

nor = function(angle)
    while angle > math.pi do
        angle = angle - 2 * math.pi
    end
    while angle < -math.pi do
        angle = angle + 2 * math.pi
    end
    return angle
end

nor2 = function(angle)
    while angle >= 2*math.pi do
        angle = angle - 2 * math.pi
    end
    while angle < 0 do
        angle = angle + 2 * math.pi
    end
    return angle
end


Mouse_Controlfunction = function(ship, dt)
    local hp = 50*ship.engineput
    local fx = hp*math.cos(ship.location.hull_angle - 0.5*math.pi)
    local fy = hp*math.sin(ship.location.hull_angle - 0.5*math.pi)
    local max_f = ship.max_f_speed
    local max_r = math.abs(ship.max_r_speed)
    local speed = ship.velocity.v/5
    local alert = false
    --enemy confirmation
    local enemy = {}
    local hull_angle = ship.location.hull_angle

    local turnspeed = ship.turnspeed
    local turnspeedf = turnspeed*-1
    local fs = ship.frontspeed
    local angle_to_mouse = math.atan2(ship.destination.y - ship.location.y, ship.destination.x - ship.location.x)
    local distance_to_mouse = math.sqrt((ship.destination.x - ship.location.x)^2 + (ship.destination.y - ship.location.y)^2)
    local array = ship.main_turret_offset
    local array1 = ship.el_turret_offset
    local tspeed = ship.turret_t_speed * math.pi/180
    if love.mouse.isDown(2) then
        ship.destination.x, ship.destination.y = cam:mousePosition()
    end

    if love.keyboard.isDown("e") then
        ship.target1.x, ship.target1.y = cam:mousePosition()
    end



    if speed >= 0 then 
        if ship.location.hull_angle - 0.5*math.pi - angle_to_mouse > 0 then
            turnspeed = turnspeed - hp*dt
            ship.turnspeed = turnspeed
        else
            turnspeed = turnspeed + hp*dt
            ship.turnspeed = turnspeed
        end
    else
        if ship.location.hull_angle + 0.5*math.pi - angle_to_mouse > 0 then
            turnspeedf = turnspeedf + hp*dt
            ship.turnspeed = turnspeedf*-1
        else
            turnspeedf = turnspeedf - hp*dt
            ship.turnspeed = turnspeedf*-1
        end
    end

    local speeda = math.abs(speed)

    if speeda <= max_f/2 then 
        if turnspeed >= 5*hp or turnspeed >= 5*hp*speeda then
            turnspeed = turnspeed - hp*dt
        elseif turnspeed <= -5*hp or turnspeed <= -5*hp*speeda then
            turnspeed = turnspeed + hp*dt
        end
        ship.turnspeed = turnspeed
    else
        if turnspeed >= 3*hp or turnspeed >= 3*hp*speeda then
            turnspeed = turnspeed - hp*dt
        elseif turnspeed <= -3*hp or turnspeed <= -3*hp*speeda then
            turnspeed = turnspeed + hp*dt
        end
        ship.turnspeed = turnspeed
    end

    if speed > max_f then
        fs.x = 0
        fs.y = 0
        ship.frontspeed.x = fs.x
        ship.frontspeed.y = fs.y
    elseif turnspeed >= 3*hp or turnspeed >= 3*hp*speed and speed > max_f*2/5 then 
        fs.x = fs.x - hp*dt*math.cos(ship.location.hull_angle - 0.5*math.pi)*0.3
        fs.y = fs.y - hp*dt*math.sin(ship.location.hull_angle - 0.5*math.pi)*0.3
        ship.frontspeed.x = fs.x
        ship.frontspeed.y = fs.y
    else
        fs.x = fs.x + hp*dt*math.cos(ship.location.hull_angle - 0.5*math.pi)*0.3
        fs.y = fs.y + hp*dt*math.sin(ship.location.hull_angle - 0.5*math.pi)*0.3
        ship.frontspeed.x = fs.x
        ship.frontspeed.y = fs.y
    end

    

    if ship.destination.x ~= ship.location.x  and distance_to_mouse >= 500 then
        if speed >= 0 then 
            ship.collider:applyForce(fs.x, fs.y)
            ship.collider:applyTorque(turnspeed)
        else
            ship.collider:applyForce(fs.x, fs.y)
            ship.collider:applyTorque(turnspeedf)
        end
    else
        fs.x = 0
        fs.y = 0
        ship.frontspeed.x = fs.x
        ship.frontspeed.y = fs.y
    end
    ship:AimCheck(ship.target1.x, ship.target1.y, dt)
    for i, turret in ipairs(array) do
        if turret.get == true and ship.battery[i].aready == true then
            Bomb(ship.battery[i], ship.target1.x, ship.target1.y)
            ship.battery[i].aready = false
        end
    end
    for i, turret in ipairs(array1) do
        if turret.get == true and ship.el_battery[i].aready == true then
            Shoot(ship.el_battery[i], ship.target1.x, ship.target1.y)
            ship.el_battery[i].aready = false
        end
    end
end




function Ship:AimCheck(x, y, dt)
    local array = self.main_turret_offset
    local array1 = self.el_turret_offset
    local hull_angle = self.location.hull_angle
    local tspeed = self.turret_t_speed * math.pi/180
    local tspeed1 = self.el_turret_t_speed * math.pi/180
    local a = self.location.hull_angle - 0.5*math.pi
    local turl = self.turret_location
    local turl1 = self.el_turret_location
    table.sort(array, compareTurrets) 
    table.sort(turl, compareTurrets)

    if x ~= nil and y ~= nil then
        for i, turret in ipairs(array) do
            turret.angle1 = nor(turret.angle1)
            local turret_x = turl[i].x
            local turret_y = turl[i].y
            local angle_to_mouse1 = nor(math.atan2(y - turret_y, x - turret_x))
            local angle_to_mouse2 = nor(math.atan2(y - self.location.y, x - self.location.x))
            local contral = array[i].angle1 + math.pi - array[i].fwangle
            turret.get = false
            if nor(angle_to_mouse2 - a) >= 0 then
                if array[i].angle1 == 0 then
                    if array[i].angle > nor(angle_to_mouse1 - a) then
                        array[i].angle = array[i].angle - tspeed*dt
                    elseif array[i].angle < nor(angle_to_mouse1 - a) then 
                        if array[i].angle <= math.pi - array[i].fwangle - array[i].angle1 then
                            array[i].angle = array[i].angle + tspeed*dt
                        end
                    end
                end
                if array[i].angle1 == math.pi then
                    if array[i].angle > nor(angle_to_mouse1 - a) then
                        if array[i].angle >= array[i].fwangle then
                            array[i].angle = array[i].angle - tspeed*dt
                        end
                    elseif array[i].angle < nor(angle_to_mouse1 - a) then 
                            array[i].angle = array[i].angle + tspeed*dt
                    end
                end
            end
            if nor(angle_to_mouse2 - a) <= 0 then
                if array[i].angle1 == 0 then
                    if array[i].angle < nor(angle_to_mouse1 - a) then
                        array[i].angle = array[i].angle + tspeed*dt
                    elseif array[i].angle > nor(angle_to_mouse1 - a) then 
                        if array[i].angle >= array[i].fwangle - math.pi then
                            array[i].angle = array[i].angle - tspeed*dt
                        end
                    end
                end
                if array[i].angle1 == math.pi then
                    if nor2(array[i].angle) > nor2(angle_to_mouse1 - a) then
                        array[i].angle = nor2(array[i].angle - tspeed*dt)
                    else
                        if array[i].angle <= math.pi*2 - array[i].fwangle then
                            array[i].angle = nor2(array[i].angle + tspeed*dt)
                        end
                    end
                end
            end
            local tx, ty = turret_x, turret_y
            local angle_to_target = math.atan2(y - ty, x - tx)
            local test1 = nor(turret.angle + a) < nor(angle_to_target + math.pi/36) and nor(turret.angle + a) > nor(angle_to_target - math.pi/36)
            local test2 = nor2(turret.angle + a) < nor2(angle_to_target + math.pi/36) and nor2(turret.angle + a) > nor2(angle_to_target - math.pi/36)
            if test1 or test2 then
                turret.get = true
            end
        end
    end
    if x ~= nil and y ~= nil then
        for i, turret in ipairs(array1) do
            turret.angle1 = nor(turret.angle1)
            local turret_x = turl1[i].x
            local turret_y = turl1[i].y
            local angle_to_mouse1 = nor(math.atan2(y - turret_y, x - turret_x))
            local angle_to_mouse2 = nor(math.atan2(y - self.location.y, x - self.location.x))
            local contral = array1[i].angle1 + math.pi - array1[i].fwangle
            turret.get = false
            if nor(angle_to_mouse2 - a) >= 0 and turret.x > 0 and  nor(angle_to_mouse1 - a) >= 0 then
                if array1[i].angle1 == 0 then
                    if array1[i].angle > nor(angle_to_mouse1 - a) then
                        array1[i].angle = array1[i].angle - tspeed1*dt
                    elseif array1[i].angle < nor(angle_to_mouse1 - a) then 
                        if array1[i].angle <= math.pi - array1[i].fwangle - array1[i].angle1 then
                            array1[i].angle = array1[i].angle + tspeed1*dt
                        end
                    end
                end
                if array1[i].angle1 == math.pi then
                    if array1[i].angle > nor(angle_to_mouse1 - a) then
                        if array1[i].angle >= array1[i].fwangle then
                            array1[i].angle = array1[i].angle - tspeed1*dt
                        end
                    elseif array1[i].angle < nor(angle_to_mouse1 - a) then 
                            array1[i].angle = array1[i].angle + tspeed1*dt
                    end
                end
            end
            if nor(angle_to_mouse2 - a) <= 0 and turret.x < 0 and  nor(angle_to_mouse1 - a) <= 0 then
                if array1[i].angle1 == 0 then
                    if array1[i].angle < nor(angle_to_mouse1 - a) then
                        array1[i].angle = array1[i].angle + tspeed1*dt
                    elseif array1[i].angle > nor(angle_to_mouse1 - a) then 
                        if array1[i].angle >= array1[i].fwangle - math.pi then
                            array1[i].angle = array1[i].angle - tspeed1*dt
                        end
                    end
                end
                if array1[i].angle1 == math.pi then
                    if nor2(array1[i].angle) > nor2(angle_to_mouse1 - a) then
                        array1[i].angle = nor2(array1[i].angle - tspeed1*dt)
                    else
                        if array1[i].angle <= math.pi*2 - array1[i].fwangle then
                            array1[i].angle = nor2(array1[i].angle + tspeed1*dt)
                        end
                    end
                end
            end
            local tx, ty = turret_x, turret_y
            local angle_to_target = math.atan2(y - ty, x - tx)
            local test1 = nor(turret.angle + a) < nor(angle_to_target + math.pi/36) and nor(turret.angle + a) > nor(angle_to_target - math.pi/36)
            local test2 = nor2(turret.angle + a) < nor2(angle_to_target + math.pi/36) and nor2(turret.angle + a) > nor2(angle_to_target - math.pi/36)
            if test1 or test2 then
                turret.get = true
            end
        end
    end
end

function gunoffset(turret_x_start, turret_y_start, hull_angle)
    local turret_x = turret_x_start * math.cos(hull_angle) - turret_y_start * math.sin(hull_angle)
    local turret_y = turret_y_start * math.cos(hull_angle) + turret_x_start * math.sin(hull_angle)
    return turret_x, turret_y
end

function Ship:Update(dt)
    --location update
    local x,y = self.collider:getPosition()
    local hull_angle = self.collider:getAngle()
    local vx, vy = self.collider:getLinearVelocity()
    local a = self.location.hull_angle
    self.velocity = {vx = vx, vy = vy, v = math.sqrt(vx^2 + vy^2)}
    self.location = {x = x, y = y, hull_angle = hull_angle}
    local array = self.main_turret_offset
    local array1 = self.el_turret_offset
    local gun = self.gun_offset
    local gun1 = self.el_gun_offset
    self.image_location.x, self.image_location.y = x + self.image_offset*math.sin(hull_angle), y - self.image_offset*math.cos(hull_angle)  

    if array then
        table.sort(array, compareTurrets) 
        for i, turret in ipairs(array) do
            local turret_x_start, turret_y_start = turret.x, turret.y 
            local turret_y = turret_y_start * math.cos(hull_angle) + turret_x_start * math.sin(hull_angle) + self.location.y
            local turret_x = turret_x_start * math.cos(hull_angle) - turret_y_start * math.sin(hull_angle) + self.location.x
            if self.turret_location[turret.id] ~= nil then
                table.remove(self.turret_location, turret.id)
                table.insert(self.turret_location, turret.id, {ID = turret.id, x = turret_x, y = turret_y, height = turret.height})
            else
                table.insert(self.turret_location, turret.id, {ID = turret.id, x = turret_x, y = turret_y, height = turret.height})
            end
            for j, gunl in ipairs(gun) do
                local x, y = gunl.x, gunl.y
                local x1, y1 = gunoffset(x, y, a+turret.angle)
                self.battery[i].gun[j] =  {x = x1 + turret_x, y = y1 + turret_y}
            end
            self.battery[i].battery_angle = a+turret.angle
            self.battery[i].battery_location = {x = turret_x, y = turret_y}
            self.battery[i].reload_timer = self.battery[i].reload_timer - dt
            if self.battery[i].reload_timer <= 0 then
                self.battery[i].aready = true
            end
        end
    end

    if array1 then
        for i, turret in ipairs(array1) do
            local turret_x_start, turret_y_start = turret.x, turret.y 
            local turret_y = turret_y_start * math.cos(hull_angle) + turret_x_start * math.sin(hull_angle) + self.location.y
            local turret_x = turret_x_start * math.cos(hull_angle) - turret_y_start * math.sin(hull_angle) + self.location.x
            if self.el_turret_location[turret.id] ~= nil then
                table.remove(self.el_turret_location, turret.id)
                table.insert(self.el_turret_location, turret.id, {ID = turret.id, x = turret_x, y = turret_y, height = turret.height})
            else
                table.insert(self.el_turret_location, turret.id, {ID = turret.id, x = turret_x, y = turret_y, height = turret.height})
            end
            for j, gunl in ipairs(gun1) do
                local x, y = gunl.x, gunl.y
                local x1, y1 = gunoffset(x, y, a+turret.angle)
                self.el_battery[i].gun[j] =  {x = x1 + turret_x, y = y1 + turret_y}
            end
            self.el_battery[i].battery_angle = a+turret.angle
            self.el_battery[i].battery_location = {x = turret_x, y = turret_y}
            self.el_battery[i].reload_timer = self.el_battery[i].reload_timer - dt
            if self.el_battery[i].reload_timer <= 0 then
                self.el_battery[i].aready = true
            end
        end
    end


    --functions update
    self.functions.move(self,dt)


    --ainme update
end


function compareTurrets(a, b)
    return a.height < b.height
end

function getIntersection(observerX, observerY, observerRadius, x1, y1)
    local dx,  dy = x1 - observer, y1 - observerY
    local a = math.atan2(dy, dx)
    local len = math.sqrt(dx * dx + dy * dy)
    if len <= observerRadius then
        return a
    else
        return nil
    end
end

function Ship:Draw()
    local x, y = self.image_location.x, self.image_location.y
    local hull_angle = self.collider:getAngle()
    local a = self.location.hull_angle
    local array = self.main_turret_offset
    local array1 = self.el_turret_offset
    local turl = self.turret_location
    local turl1 = self.el_turret_location
    local image = self.hull_image
    local width = image:getWidth()
    local height = image:getHeight()
    love.graphics.draw(image,x,y,a,1,1,width/2,height/2)
    local image1 = self.turret_image
    local image2 = self.el_turret_image
    local width1 = image1:getWidth()
    local height1 = image1:getHeight()
    local width2 = image2:getWidth()
    local height2 = image2:getHeight()

    if array then
        table.sort(array, compareTurrets) 
        table.sort(turl, compareTurrets)
        for i, turret in ipairs(array) do
            local turret_x = turl[i].x
            local turret_y = turl[i].y
            love.graphics.draw(self.turret_image,turret_x,turret_y,a+array[i].angle,1,1,width1/2,height1/2)
        end
    end
    if array1 then
        for i, turret in ipairs(array1) do
            local turret_x = turl1[i].x
            local turret_y = turl1[i].y
            love.graphics.draw(self.el_turret_image,turret_x,turret_y,a+array1[i].angle,1,1,width2/2,height2/2)
        end
    end
    --Visual(self)
    
end


function Ship:Detonate()
    
end