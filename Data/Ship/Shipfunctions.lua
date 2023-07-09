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

    local speedMagnitude = math.sqrt((ship.destination.x - ship.location.x)^2 + (ship.destination.y - ship.location.y)^2)
    local tx = ((ship.destination.x - ship.location.x) / speedMagnitude)*hp
    local ty = ((ship.destination.y - ship.location.y) / speedMagnitude)*hp
    local sx = hp*math.cos(ship.location.hull_angle - 0.6*math.pi)
    local sy = hp*math.sin(ship.location.hull_angle - 0.6*math.pi)
    local rx = hp*math.cos(ship.location.hull_angle - 0.4*math.pi)
    local ry = hp*math.sin(ship.location.hull_angle - 0.4*math.pi)

    
    if love.mouse.isDown(2) then
        ship.destination.x, ship.destination.y = cam:mousePosition()
    end


    if not ship.deployed and ship.destination.x ~= ship.location.x  then
        local angle_to_mouse = math.atan2(ship.destination.y - ship.location.y, ship.destination.x - ship.location.x)
        local distance_to_mouse = math.sqrt((ship.destination.x - ship.location.x)^2 + (ship.destination.y - ship.location.y)^2)
        -- if distance_to_mouse >= 100 then
        --     if ship.location.hull_angle - 0.5*math.pi - angle_to_mouse < 0.2 * math.pi and ship.location.hull_angle - 0.5*math.pi - angle_to_mouse > -0.2 * math.pi then
        --         ship.collider:applyForce(fx, fy)
        --     else
        --         ship.collider:applyForce(fx/3, fy/3)
        --     end
        -- end

        if distance_to_mouse >= 100 and ship.location.hull_angle - 0.5*math.pi - angle_to_mouse < 0.2 * math.pi then
            if ship.location.hull_angle - 0.5*math.pi - angle_to_mouse > 0 then
                ship.collider:applyForce(tx, ty)
                ship.collider:applyTorque(-1*hp)
            else
                ship.collider:applyForce(tx, ty)
                ship.collider:applyTorque(1*hp)
            end
        elseif distance_to_mouse >= 100 and ship.location.hull_angle - 0.5*math.pi - angle_to_mouse > 0.2 * math.pi then
            if ship.location.hull_angle - 0.5*math.pi - angle_to_mouse > 0 then
                ship.collider:applyForce(sx, sy)
                ship.collider:applyTorque(-3*hp)
            else
                ship.collider:applyForce(rx, ry)
                ship.collider:applyTorque(3*hp)
            end
        end
    end

    for i, target in ipairs(CurrentPlace.exsist_ship) do
        if math.sqrt((target.location.x - ship.location.x)^2 + (target.location.y - ship.location.y)^2) < ship.vision then
            if target.type ~= ship.type then
                enemy = target
                alert = true
                break
            end
        end
    end
    if alert then
        ship:FacePosition(enemy.location.x, enemy.location.y)
        local isaim = ship:AimCheck(enemy.location.x, enemy.location.y, dt)
        if #ship.ammorack > 0 and isaim and ship.reload_timer <= 0 then
            if ship.class == 'spg' then
                if ship.deployed then
                    Bomb(ship, enemy.location.x, enemy.location.y)
                end
            else
                Shoot(ship)
            end
        end
        if #ship.missilerack > 0 and isaim and ship.m_reload_timer <= 0 then
            LaunchMissile(ship, enemy)
        end
    end
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
    local tx, ty = self.turret_location.x, self.turret_location.y
    local angle_to_target = math.atan2(y - ty, x - tx)
    local hull_angle = self.location.hull_angle
    local ta = self.turret_angle + hull_angle - 0.5*math.pi
    local tspeed = self.turret_t_speed * math.pi/180

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
            self.turret_angle = self.turret_angle - tspeed*dt
        else
            self.turret_angle = self.turret_angle + tspeed*dt
        end
    end
    if ta < angle_to_target then
        if angle_to_target - ta <= math.pi then
            self.turret_angle = self.turret_angle + tspeed*dt
        else
            self.turret_angle = self.turret_angle - tspeed*dt
        end
    end
    if self.turret_t_angle then
        local l, r = self.turret_t_angle.l/180*math.pi, self.turret_t_angle.r/180*math.pi
        if self.turret_angle > l then
            self.turret_angle = l
        end
        if self.turret_angle < -r then
            self.turret_angle = -r
        end
    end
    if ta < angle_to_target + math.pi/36 and ta > angle_to_target - math.pi/36 then
        isaim = true
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
    -- if array then 
    --     local rows = #array
    --     for i = 1, rows do  --adjust collider's and image's location
    --         self.turret_location.x, self.turret_location.y = array[i][1], array[i][2]
    --         self.turret_offset = array[i][2]
    --         self.turret_location.x, self.turret_location.y = self.image_location.x - self.turret_offset*math.sin(hull_angle), self.image_location.y + self.turret_offset*math.cos(hull_angle)
    --         if self.gun_offset then
    --             self.gun_location.x, self.gun_location.y = self.turret_location.x + (self.gun_offset)*math.sin(hull_angle+self.turret_angle),
    --                                                self.turret_location.y - (self.gun_offset)*math.cos(hull_angle+self.turret_angle)
    --         end
    --         if self.luncher_offset then
    --             self.luncher_location.x, self.luncher_location.y = self.turret_location.x + (self.luncher_offset.y)*math.sin(hull_angle+self.turret_angle) + self.luncher_offset.x*math.cos(hull_angle+self.turret_angle),
    --                                                        self.turret_location.y - (self.luncher_offset.y)*math.cos(hull_angle+self.turret_angle) + self.luncher_offset.x*math.sin(hull_angle+self.turret_angle)
    --         end
    
    --         self.engine_location.x, self.engine_location.y = self.image_location.x + (self.engine_offset)*math.sin(hull_angle),
    --                                                  self.image_location.y - (self.engine_offset)*math.cos(hull_angle)
    --         self.exhaust_location.x, self.exhaust_location.y = self.image_location.x + self.exhaust_offset.y*math.sin(hull_angle) + self.exhaust_offset.x*math.cos(hull_angle),
    --                                                    self.image_location.y - self.exhaust_offset.y*math.cos(hull_angle) + self.exhaust_offset.x*math.sin(hull_angle)
    --         if self.exhaust_offset2 then
    --             self.exhaust_location2.x, self.exhaust_location2.y = self.image_location.x + self.exhaust_offset2.y*math.sin(hull_angle) + self.exhaust_offset2.x*math.cos(hull_angle),
    --                                                          self.image_location.y - self.exhaust_offset2.y*math.cos(hull_angle) + self.exhaust_offset2.x*math.sin(hull_angle)
    --         end
    --     end
    -- else
    --     self.image_location.x, self.image_location.y = x + self.image_offset*math.sin(hull_angle), y - self.image_offset*math.cos(hull_angle)     --adjust collider's and image's location
    --     self.turret_location.x, self.turret_location.y = self.image_location.x - self.turret_offset*math.sin(hull_angle), self.image_location.y + self.turret_offset*math.cos(hull_angle)
    --     if self.gun_offset then
    --         self.gun_location.x, self.gun_location.y = self.turret_location.x + (self.gun_offset)*math.sin(hull_angle+self.turret_angle),
    --                                                self.turret_location.y - (self.gun_offset)*math.cos(hull_angle+self.turret_angle)
    --     end
    --     if self.luncher_offset then
    --         self.luncher_location.x, self.luncher_location.y = self.turret_location.x + (self.luncher_offset.y)*math.sin(hull_angle+self.turret_angle) + self.luncher_offset.x*math.cos(hull_angle+self.turret_angle),
    --                                                        self.turret_location.y - (self.luncher_offset.y)*math.cos(hull_angle+self.turret_angle) + self.luncher_offset.x*math.sin(hull_angle+self.turret_angle)
    --     end
    
    --     self.engine_location.x, self.engine_location.y = self.image_location.x + (self.engine_offset)*math.sin(hull_angle),
    --                                                      self.image_location.y - (self.engine_offset)*math.cos(hull_angle)
    --     self.exhaust_location.x, self.exhaust_location.y = self.image_location.x + self.exhaust_offset.y*math.sin(hull_angle) + self.exhaust_offset.x*math.cos(hull_angle),
    --                                                       self.image_location.y - self.exhaust_offset.y*math.cos(hull_angle) + self.exhaust_offset.x*math.sin(hull_angle)
    --     if self.exhaust_offset2 then
    --     self.exhaust_location2.x, self.exhaust_location2.y = self.image_location.x + self.exhaust_offset2.y*math.sin(hull_angle) + self.exhaust_offset2.x*math.cos(hull_angle),
    --                                                          self.image_location.y - self.exhaust_offset2.y*math.cos(hull_angle) + self.exhaust_offset2.x*math.sin(hull_angle)
    --     end
    -- end

    

    --timer update
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

function Ship:Draw()
    local x, y = self.image_location.x, self.image_location.y
    local hull_angle = self.collider:getAngle()
    local a = self.location.hull_angle
    local array = self.main_turret_offset
    love.graphics.draw(self.hull_image,x,y,a,1,1,144,144)
    love.graphics.draw(self.armor.hull_image,x,y,a,1,1,144,144)
    if array then
        local rows = #array
        for i = 1, rows do
            local turret_x_start, turret_y_start = array[i][1] , array[i][2] 
            local turret_y = turret_y_start * math.cos(hull_angle) + turret_x_start * math.sin(hull_angle) + self.location.y
            local turret_x = turret_x_start * math.cos(hull_angle) - turret_y_start * math.sin(hull_angle) + self.location.x
            self.turret_anime:draw(self.anime_sheet,turret_x,turret_y,a+self.turret_angle,1,1,144,144)    --draw turret/*+self.turret_offset*/
            love.graphics.draw(self.aim.turret_image,turret_x,turret_y,a+self.turret_angle,1,1,144,144)
            love.graphics.draw(self.armor.turret_image,turret_x,turret_y,a+self.turret_angle,1,1,144,144)
        end
    else
        local turret_x, turret_y = self.turret_location.x, self.turret_location.y
        self.turret_anime:draw(self.anime_sheet,turret_x,turret_y,a+self.turret_angle,1,1,144,144+self.turret_offset)    --draw turret/*+self.turret_offset*/
        love.graphics.draw(self.aim.turret_image,turret_x,turret_y,a+self.turret_angle,1,1,144,144)
        love.graphics.draw(self.armor.turret_image,turret_x,turret_y,a+self.turret_angle,1,1,144,144)
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