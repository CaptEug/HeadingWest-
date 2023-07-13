Ship = {}
Ship.__index = Ship


function Buildship(place, ship, type, x, y, ...)
    local status = ...
    local shipy = {
        type = type,
        number = tostring(math.random(000,999)),
        name = ship.name,
        class = ship.class,
        width = ship.width,
        length = ship.length,
        weight = ship.weight,
        crew = ship.crew,
        survivor = ship.crew,
        reload_time = ship.reload_time,
        reload_timer = ship.reload_time,
        m_reload_time = ship.m_reload_time or nil,
        m_reload_timer = ship.m_reload_time or nil,
        deploy_time = ship.deploy_time or nil,
        deploy_timer = -1,
        fuel = ship.fuel_capacity,
        fuel_capacity = ship.fuel_capacity,
        fuel_cosumption = ship.fuel_cosumption,
        ammorack_size = ship.ammorack_size,
        ammorack = copytable(ship.ammorack or {}),
        missilerack_size = ship.missilerack_size,
        missilerack = copytable(ship.missilerack or {}),
        armorthickness = ship.armorthickness,
        innerstructure = ship.innerstructure,
        max_f_speed = ship.max_f_speed,
        max_r_speed = ship.max_r_speed,
        turnspeed = ship.turnspeed,
        frontspeed = ship.frontspeed,
        turret_t_speed = ship.turret_t_speed,
        turret_t_angle = ship.turret_t_angle or nil,
        vision = ship.vision,
        hull_image = ship.hull_image,
        hull_image_line = ship.hull_image_line,
        hull_image_broken = ship.hull_image_broken,
        turret_image = ship.turret_image,
        turret_image_line = ship.turret_image_line,
        turret_image_broken = ship.turret_image_broken,
        anime_sheet = ship.anime_sheet,
        turret_anime = anim8.newAnimation(Tank_Grid('1-7', 1), 0.1),
        firing_anime = anim8.newAnimation(Tank_Grid('1-7', 1), 0.1),
        deploy_anime = anim8.newAnimation(Tank_Grid('1-7', 2), 0.2),
        gun_sound = ship.gun_sound:clone(),
        image_offset = ship.image_offset,
        turret_offset = ship.turret_offset,
        gun_offset = ship.gun_offset or nil,
        luncher_offset = ship.luncher_offset or nil,
        engine_offset = ship.engine_offset,
        exhaust_offset = ship.exhaust_offset,
        exhaust_offset2 = ship.exhaust_offset2 or nil,
        exhaust_angle = ship.exhaust_angle,
        exhaust_angle2 = ship.exhaust_angle2 or nil,
        main_turret_offset = ship.main_turret_offset or nil,
        turret_angle = 0,
        armor = ship.armor or copytable(ship.accessories[1][ship.armor_num or 1] or Blank_Gear),
        aim = ship.aim or copytable(ship.accessories[2][ship.aim_num or 1] or Blank_Gear),
        mob = ship.mob or copytable(ship.accessories[3][ship.mob_num or 1] or Blank_Gear),
        velocity = {vx = 0, vy = 0, v = 0},
        location = {x = x, y = y, hull_angle = 0},
        destination = {x = x, y = y},
        target1 = {x = nil, y = nil},
        image_location = {},
        turret_location = {},
        gun_location = {},
        luncher_location = {},
        engine_location = {},
        exhaust_location = {},
        exhaust_location2 = {},
        functions = {},
        Infobuttons = {},
        status = status or
        {
            dead = false,
            onfire = false,
            immobilized = false,
            era = false,
            penetrated = false
        },
        firing_time = ship.firing_time,
        firing_timer = 0,
        pen_timer = 0,
        picked = false,
        leader = false,
        incomp = false,
        deployed = false
    }
    if type == 'enemy' then
        while #shipy.ammorack < shipy.ammorack_size do
            table.insert(shipy.ammorack, ship.ammunition[1])
        end
        if ship.missilerack_size then
            while #shipy.missilerack < shipy.missilerack_size do
                for i, ammo in ipairs(ship.ammunition) do
                    if ammo.type == 'ATGM' then
                        table.insert(shipy.missilerack, ammo)
                    end
                end
            end
        end
    end
    if shipy.ammorack_size then
        for i, ammo in ipairs(shipy.ammorack) do
            ammo.add = nil
            ammo.remove = nil
        end
    end
    if shipy.missilerack_size then
        for i, missile in ipairs(shipy.missilerack) do
            missile.add = nil
            missile.remove = nil
        end
    end
    
    setmetatable(shipy, Ship)
    --ship.__index = ship
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
    local hp = 50*ship.mob.hp*0.745
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

    

    if not ship.deployed and ship.destination.x ~= ship.location.x  and distance_to_mouse >= 500 then
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
end

function Ship:Setdeployed()
    if self.deployed then
        self.deploy_timer = -1
        self.deployed = false
    else
        self.deploy_timer = self.deploy_time
    end
end



function Ship:AimCheck(x, y, dt)
    local isaim = false
    local hull_angle = self.location.hull_angle
    local ta = self.turret_angle + hull_angle - 0.5*math.pi
    local tspeed = self.turret_t_speed * math.pi/180
    local array = self.main_turret_offset
    local a = self.location.hull_angle - 0.5*math.pi

    if x ~= nil and y ~= nil then
        for i, turret in ipairs(array) do
            turret.angle1 = nor(turret.angle1)
            local turret_x_start, turret_y_start = turret.x , turret.y 
            local turret_y = turret_y_start * math.cos(hull_angle) + turret_x_start * math.sin(hull_angle) + self.location.y
            local turret_x = turret_x_start * math.cos(hull_angle) - turret_y_start * math.sin(hull_angle) + self.location.x
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
            if ta < angle_to_target + math.pi/36 and ta > angle_to_target - math.pi/36 then
                isaim = true
            end
        end
    end
    return isaim
end

function Ship:FacePosition(x, y)
    local hp = 50*self.mob.hp*0.745
    local ha = self.location.hull_angle + math.pi/2
    local hx, hy = self.location.x, self.location.y
    local angle_to_target = math.atan2(y - hy, x - hx)

    if angle_to_target <= 0 then
        angle_to_target = angle_to_target + math.pi*2
    end
    while ha > 2*math.pi do
        ha = ha - 2*math.pi
    end
    while ha < 0 do
        ha = ha + 2*math.pi
    end

    if not self.deployed and ha > angle_to_target then
        if ha - angle_to_target <= math.pi then
            self.collider:applyTorque(5*hp)
        else
            self.collider:applyTorque(-5*hp)
        end
    end
    if not self.deployed and ha < angle_to_target then
        if angle_to_target - ha <= math.pi then
            self.collider:applyTorque(-5*hp)
        else
            self.collider:applyTorque(5*hp)
        end
    end
end

function Ship:CheckStatus(i, dt)
    if self.status.era then
        if self.armor.life <= 0 then
            self.armor.hull_image = Blank_line
            self.armor.turret_image = Blank_line
            self.armor.hull_image_line = Blank_line
            self.armor.turret_image_line = Blank_line
            self.status.era = false
        end
    end

    if self.status.onfire then
        self.particles.onfire:start()
    else
        self.particles.onfire:stop()
    end

    if self.status.immobilized or self.fuel == 0 then
        self.mob.hp = 0
        self.particles.enginesmoke:stop()
    end

    if self.survivor <= 0 then
        table.insert(CurrentPlace.broken_tank, table.remove(CurrentPlace.exsist_ship, i))
    end

    if self.status.penetrated then
        self.pen_timer = self.pen_timer + dt
        if self.pen_timer >= 1 then
            self.status.penetrated = false
            self.pen_timer = 0
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

    self.reload_timer = self.reload_timer - dt
    self.firing_timer = self.firing_timer - dt
    if self.m_reload_timer then
        self.m_reload_timer = self.m_reload_timer - dt
    end
    

    --functions update
    self.functions.move(self,dt)
    if self.velocity.v > 0 then
        self.fuel = self.fuel - self.fuel_cosumption*dt/100
    end
    if self.fuel < 0 then
        self.fuel = 0
    end

    --ainme update
    if self.class == 'spg' then
        self.turret_anime = self.deploy_anime
    else
        self.turret_anime = self.firing_anime
    end
    if self.firing_timer <= 0 then
        self.firing_anime:gotoFrame(1)
    end
    if self.deployed then
        self.turret_anime = self.firing_anime
    else
        if self.deploy_timer <= -1 then
            self.deploy_anime:gotoFrame(1)
        end
        if self.deploy_timer <= 0 and self.deploy_timer > -1 then
            self.deployed = true
        end
    end
    self.turret_anime:update(dt)
end


function compareTurrets(a, b)
    return a.height < b.height
end

function Ship:Draw()
    local x, y = self.image_location.x, self.image_location.y
    local hull_angle = self.collider:getAngle()
    local a = self.location.hull_angle
    local array = self.main_turret_offset
    local image = self.hull_image
    local width = image:getWidth()
    local height = image:getHeight()
    love.graphics.draw(image,x,y,a,1,1,width/2,height/2)
    local image1 = self.turret_image
    local width1 = image1:getWidth()
    local height1 = image1:getHeight()

    if array then
        table.sort(array, compareTurrets) 
        for i, turret in ipairs(array) do
            local turret_x_start, turret_y_start = turret.x , turret.y 
            local turret_y = turret_y_start * math.cos(hull_angle) + turret_x_start * math.sin(hull_angle) + self.location.y
            local turret_x = turret_x_start * math.cos(hull_angle) - turret_y_start * math.sin(hull_angle) + self.location.x
            love.graphics.draw(self.turret_image,turret_x,turret_y,a+array[i].angle,1,1,width1/2,height1/2)
            love.graphics.setColor(1, 0, 0)
            local length = 10000
            local end_x = turret_x + length * math.cos(a+array[i].angle-0.5*math.pi)
            local end_y = turret_y + length * math.sin(a+array[i].angle-0.5*math.pi)
            love.graphics.line(turret_x,turret_y, end_x, end_y)
            love.graphics.setColor(1, 1, 1, 1)
        end
    else
        local turret_x, turret_y = self.turret_location.x, self.turret_location.y
        
        love.graphics.draw(self.turret_image,turret_x,turret_y,a+self.turret_angle,1,1,width/2,height/2)
    end
end

-- function Ship:DrawBrokenship()
--     local x, y = self.collider:getPosition()
--     local a = self.collider:getAngle()
--     love.graphics.draw(self.hull_image_broken,x,y,a,1,1,144,144)
--     love.graphics.draw(self.turret_image_broken,x,y,a+self.turret_angle,1,1,144,144)
-- end

function Ship:Detonate()
    
end

-- function Ship:CreatParticles()
--     self.particles = {
--         muzzlesmoke = love.graphics.newParticleSystem(Smoke),
--         enginesmoke = love.graphics.newParticleSystem(ExhaustGas),
--         onfire = love.graphics.newParticleSystem(Fire),
--     }
--     self.particles.muzzlesmoke:setEmitterLifetime(1.5)
--     self.particles.muzzlesmoke:setParticleLifetime(2)
-- 	self.particles.muzzlesmoke:setEmissionRate(50)
-- 	self.particles.muzzlesmoke:setSizeVariation(0.5)
--     self.particles.muzzlesmoke:setSizes(0.2, 1)
--     self.particles.muzzlesmoke:setLinearDamping(5)
-- 	self.particles.muzzlesmoke:setColors(1, 1, 1, 1, 1, 1, 1, 0)
--     self.particles.muzzlesmoke:stop()

--     self.particles.enginesmoke:setParticleLifetime(0.5)
-- 	self.particles.enginesmoke:setSizeVariation(0.5)
--     self.particles.enginesmoke:setSizes(0.4, 1)
--     self.particles.enginesmoke:setLinearDamping(5)
-- 	self.particles.enginesmoke:setColors(1, 1, 1, 1, 1, 1, 1, 0)
--     if self.exhaust_offset2 then
--         self.particles.enginesmoke2 = self.particles.enginesmoke:clone()
--     end

--     self.particles.onfire:setParticleLifetime(1)
-- 	self.particles.onfire:setEmissionRate(50)
-- 	self.particles.onfire:setSizeVariation(1)
--     self.particles.onfire:setSizes(0.2, 1)
--     self.particles.onfire:setLinearDamping(5)
-- 	self.particles.onfire:setColors(1, 1, 1, 1, 1, 0.2, 0, 1, 0, 0, 0, 0)
--     self.particles.onfire:stop()
-- end

-- function Ship:ParticleUpdate(dt)
--     local ix, iy = math.cos(self.location.hull_angle+self.turret_angle-math.pi/2),
--                     math.sin(self.location.hull_angle+self.turret_angle-math.pi/2)
--     local hx, hy = math.cos(self.location.hull_angle+self.exhaust_angle), math.sin(self.location.hull_angle+self.exhaust_angle)
--     self.particles.muzzlesmoke:setPosition(self.gun_location.x + 4*math.sin(self.location.hull_angle+self.turret_angle),
--                                            self.gun_location.y - 4*math.cos(self.location.hull_angle+self.turret_angle))
-- 	self.particles.muzzlesmoke:setLinearAcceleration(150*ix+math.random(-30,30), 150*iy+math.random(-30,30))
--     self.particles.muzzlesmoke:update(dt)

--     self.particles.enginesmoke:setPosition(self.exhaust_location.x, self.exhaust_location.y)
--     self.particles.enginesmoke:setLinearAcceleration(150*hx+math.random(-50,50), 150*hy+math.random(-50,50))
--     self.particles.enginesmoke:update(dt)
--     if self.exhaust_offset2 then
--         local hx2, hy2 = math.cos(self.location.hull_angle+self.exhaust_angle2), math.sin(self.location.hull_angle+self.exhaust_angle2)
--         self.particles.enginesmoke2:setPosition(self.exhaust_location2.x, self.exhaust_location2.y)
--         self.particles.enginesmoke2:setLinearAcceleration(150*hx2+math.random(-50,50), 150*hy2+math.random(-50,50))
--         self.particles.enginesmoke2:update(dt)
--     end

--     self.particles.onfire:setPosition(self.engine_location.x + math.random(-3,3), self.engine_location.y + math.random(-3,3))
--     self.particles.onfire:setLinearAcceleration(50, 50, -50, -50)
--     self.particles.onfire:update(dt)
-- end

-- function Ship:ParticleDraw()
--     if self.firing_timer > 0 and self.firing_timer < 0.2 then
--         self.particles.muzzlesmoke:start()
--     end
--     love.graphics.draw(self.particles.muzzlesmoke)

--     if self.velocity.v > 5 or math.abs(self.collider:getAngularVelocity()) > 0 then
--         self.particles.enginesmoke:setEmissionRate(50)
--         if self.exhaust_offset2 then
--             self.particles.enginesmoke2:setEmissionRate(50)
--         end
--     else
--         self.particles.enginesmoke:setEmissionRate(10)
--         if self.exhaust_offset2 then
--             self.particles.enginesmoke2:setEmissionRate(10)
--         end
--     end
--     love.graphics.draw(self.particles.enginesmoke)
--     if self.exhaust_offset2 then
--         love.graphics.draw(self.particles.enginesmoke2)
--     end
--     love.graphics.draw(self.particles.onfire)
-- end