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
        image_offset = ship.image_offset,
        engineput = ship.engine_output,
        vision = ship.vision,
        main_turret_offset = ship.main_turret_offset,
        turret_t_speed = ship.turret_t_speed,
        velocity = {vx = 0, vy = 0, v = 0},
        location = {x = x, y = y, hull_angle = 0},
        destination = {x = x, y = y},
        target1 = {x = nil, y = nil},
        image_location = {},
        turret_location = {},
        functions = {},
        reload_time = ship.reload_time
        battery = {}
    }
    for i, turret in ipairs(shipy.main_turret_offset) do
        table.insert(shipy.turret_location, turret.id, {ID = turret.id,x = x - turret.x, y = y - turret.y, height = turret.height})
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
    if isaim and ship.reload_timer <= 0 then
        Bomb(ship, ship.destination.x, ship.destination.y)
    end
end




function Ship:AimCheck(x, y, dt)
    local array = self.main_turret_offset
    local hull_angle = self.location.hull_angle
    local tspeed = self.turret_t_speed * math.pi/180
    local a = self.location.hull_angle - 0.5*math.pi
    local turl = self.turret_location
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
            if array[i].angle + a < angle_to_target + math.pi/36 and array[i].angle + a > angle_to_target - math.pi/36 then
                array[i].get = true
            end
        end
    end
end



function Ship:Update(dt)
    --location update
    local x,y = self.collider:getPosition()
    local hull_angle = self.collider:getAngle()
    local vx, vy = self.collider:getLinearVelocity()
    self.velocity = {vx = vx, vy = vy, v = math.sqrt(vx^2 + vy^2)}
    self.location = {x = x, y = y, hull_angle = hull_angle}
    local array = self.main_turret_offset
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
            table.insert(battery, i, {batter_offset = {x = turret_x, y = turret_y }})
        end
    end


    --functions update
    self.functions.move(self,dt)


    --ainme update
end


function compareTurrets(a, b)
    return a.height < b.height
end

function Ship:Draw()
    local x, y = self.image_location.x, self.image_location.y
    local hull_angle = self.collider:getAngle()
    local a = self.location.hull_angle
    local array = self.main_turret_offset
    local turl = self.turret_location
    local image = self.hull_image
    local width = image:getWidth()
    local height = image:getHeight()
    love.graphics.draw(image,x,y,a,1,1,width/2,height/2)
    local image1 = self.turret_image
    local width1 = image1:getWidth()
    local height1 = image1:getHeight()

    if array then
        table.sort(array, compareTurrets) 
        table.sort(turl, compareTurrets)
        for i, turret in ipairs(array) do
            local turret_x = turl[i].x
            local turret_y = turl[i].y
            love.graphics.draw(self.turret_image,turret_x,turret_y,a+array[i].angle,1,1,width1/2,height1/2)
            love.graphics.setColor(1, 0, 0)
            local length = 10000
            local end_x = turret_x + length * math.cos(a+array[i].angle-0.5*math.pi)
            local end_y = turret_y + length * math.sin(a+array[i].angle-0.5*math.pi)
            love.graphics.line(turret_x,turret_y, end_x, end_y)
            love.graphics.setColor(1, 1, 1, 1)
        end
    end
end

function Ship:Detonate()
    
end