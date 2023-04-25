Tank = {}

function Buildtank()
    local selected_slot = TankDesigner:slot_distribution(CurrentPlace)
    local tank = {
        selected_slot = selected_slot,
        type = 'Friendly',
        number = tostring(math.random(000,999)),
        name = TankPresent.name,
        width = TankPresent.width,
        length = TankPresent.length,
        weight = TankPresent.weight,
        crew = TankPresent.crew,
        survivor = TankPresent.crew,
        reload_time = TankPresent.reload_time,
        reload_timer = TankPresent.reload_time,
        ammorack_size = TankPresent.ammorack_size,
        ammorack = copytable(TankPresent.ammorack),
        armorthickness = TankPresent.armorthickness,
        innerstructure = TankPresent.innerstructure,
        max_f_speed = TankPresent.max_f_speed,
        max_r_speed = TankPresent.max_r_speed,
        turret_t_speed = TankPresent.turret_t_speed,
        vision = TankPresent.vision,
        hull_image = TankPresent.hull_image,
        hull_image_line = TankPresent.hull_image_line,
        hull_image_broken = TankPresent.hull_image_broken,
        turret_image = TankPresent.turret_image,
        turret_image_line = TankPresent.turret_image_line,
        turret_image_broken = TankPresent.turret_image_broken,
        anime_sheet = TankPresent.anime_sheet,
        turret_anime = anim8.newAnimation(Tank_Grid('1-7', 1), 0.1),
        hull_offset = TankPresent.hull_offset,
        gun_offset = TankPresent.gun_offset,
        engine_offset = TankPresent.engine_offset,
        exhaust_offset = TankPresent.exhaust_offset,
        exhaust_angle = TankPresent.exhaust_angle,
        turret_angle = 0,
        armor = copytable(TankPresent.equipment.armor),
        aim = copytable(TankPresent.equipment.aim),
        mob = copytable(TankPresent.equipment.mob),
        buildtime = TankPresent.buildtime,
        fixedbuildtime = TankPresent.buildtime,
        velocity = {},
        location = {x = CurrentPlace.slot_info[selected_slot].x, y = CurrentPlace.slot_info[selected_slot].y},
        image_location = {},
        gun_location = {},
        engine_location = {},
        exhaust_location = {},
        functions = {},
        Infobuttons = {},
        status = {
            dead = {false},
            onfire = {false, Onfire_icon},
            immobilized = {false, Immobilized_icon},
            era = {false, ERA_icon}
        },
        firing_timer = 0,
        picked = false,
        incomp = false,
        compCom = false
    }
    Steel = Steel - TankDesigner.tank_steel_cost
    Oil = Oil - TankDesigner.tank_oil_cost
    setmetatable(tank, Tank)
    Tank.__index = Tank
    table.insert(CurrentPlace.ProductionQueue, 1, tank)
    CurrentPlace.ProductionNumber = CurrentPlace.ProductionNumber + 1
end

function BuildEnemytank(place, tank, x, y)
    local enemy = {
        type = 'Enemy',
        number = tostring(math.random(000,999)),
        name = tank.name,
        width = tank.width,
        length = tank.length,
        weight = tank.weight,
        crew = tank.crew,
        survivor = tank.crew,
        reload_time = tank.reload_time,
        reload_timer = tank.reload_time,
        ammorack_size = tank.ammorack_size,
        ammorack = {},
        armorthickness = tank.armorthickness,
        innerstructure = tank.innerstructure,
        max_f_speed = tank.max_f_speed,
        max_r_speed = tank.max_r_speed,
        turret_t_speed = tank.turret_t_speed,
        vision = tank.vision,
        hull_image = tank.hull_image,
        hull_image_line = tank.hull_image_line,
        hull_image_broken = tank.hull_image_broken,
        turret_image = tank.turret_image,
        turret_image_line = tank.turret_image_line,
        turret_image_broken = tank.turret_image_broken,
        anime_sheet = tank.anime_sheet,
        turret_anime = anim8.newAnimation(Tank_Grid('1-7', 1), 0.1),
        hull_offset = tank.hull_offset,
        gun_offset = tank.gun_offset,
        engine_offset = tank.engine_offset,
        exhaust_offset = tank.exhaust_offset,
        exhaust_angle = tank.exhaust_angle,
        turret_angle = 0,
        armor = copytable(tank.accessories[1][1] or Blank_Gear),
        aim = copytable(tank.accessories[2][1] or Blank_Gear),
        mob = copytable(tank.accessories[3][1] or Blank_Gear),
        buildtime = tank.buildtime,
        fixedbuildtime = tank.buildtime,
        velocity = {},
        location = {x = x, y = y},
        image_location = {},
        gun_location = {},
        engine_location = {},
        exhaust_location = {},
        functions = {},
        Infobuttons = {},
        status = {
            dead = {false},
            onfire = {false, Onfire_icon},
            immobilized = {false, Immobilized_icon},
            era = {false, ERA_icon}
        },
        firing_timer = 0,
        picked = false,
        incomp = false,
        compCom = false
    }
    while #enemy.ammorack < enemy.ammorack_size do
        table.insert(enemy.ammorack, tank.ammunition[1])
    end
    setmetatable(enemy, Tank)
    Tank.__index = Tank
    table.insert(place.exsist_tank, enemy)
    TankSpawner:loadtank(place, enemy)
end

AutoControlfunction = function(tank, dt)
    local alert = false
    --enemy confirmation
    local enemy = {}
    for i, target in ipairs(CurrentPlace.exsist_tank) do
        if math.sqrt((target.location.x - tank.location.x)^2 + (target.location.y - tank.location.y)^2) < tank.vision then
            if target.type ~= tank.type then
                enemy = target
                alert = true
                break
            end
        end
    end
    if alert then
        local isaim = tank:AimCheck(enemy.location.x, enemy.location.y, dt)
        if #tank.ammorack > 0 and isaim and tank.reload_timer <= 0 then
            Shoot(tank)
            tank.firing_timer = 0.7
            tank.reload_timer = tank.reload_time
        end
    end
end

ManualControlfunction = function(tank, dt)
    local hp = 50*tank.mob.hp*0.745
    local fx = hp*math.cos(tank.location.hull_angle - 0.5*math.pi)
    local fy = hp*math.sin(tank.location.hull_angle - 0.5*math.pi)
    local max_f = tank.max_f_speed
    local max_r = math.abs(tank.max_r_speed)
    local speed = tank.velocity.v/5
    local mx, my = cam:mousePosition()
    local isaim = tank:AimCheck(mx, my, dt)

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

    if Cursormode == 'firing' and love.mouse.isDown(1) and #tank.ammorack > 0 and isaim and tank.reload_timer <= 0 then
        Shoot(tank)
        tank.firing_timer = 0.7
        tank.reload_timer = tank.reload_time
    end
end

SetFortified = function(tank, dt)
    
end

function Tank:AimCheck(x, y, dt)
    local isaim = false
    local tx, ty = self.image_location.x, self.image_location.y
    local angle_to_target = math.atan2(y - ty, x - tx)
    local ta = self.turret_angle + self.location.hull_angle - 0.5*math.pi
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
    if ta < angle_to_target + math.pi/36 and ta > angle_to_target - math.pi/36 then
        isaim = true
    end
    return isaim
end

function Tank:CheckStatus(i)
    if self.status.era[1] then
        if self.armor.life <= 0 then
            self.armor.hull_image = Blank_line
            self.armor.turret_image = Blank_line
            self.armor.hull_image_line = Blank_line
            self.armor.turret_image_line = Blank_line
            self.status.era[1] = false
        end
    end

    if self.status.onfire[1] then
        self.particles.onfire:start()
    else
        self.particles.onfire:stop()
    end

    if self.status.immobilized[1] then
        self.mob.hp = 0
        self.particles.enginesmoke:stop()
    end

    if self.survivor <= 0 then
        table.insert(CurrentPlace.broken_tank, table.remove(CurrentPlace.exsist_tank, i))
    end
end

function Tank:Update(dt)
    local x,y = self.collider:getPosition()
    local hull_angle = self.collider:getAngle()
    local vx, vy = self.collider:getLinearVelocity()
    self.velocity = {vx = vx, vy = vy, v = math.sqrt(vx^2 + vy^2)}
    self.location = {x = x, y = y}
    self.location.hull_angle = hull_angle
    self.image_location.x, self.image_location.y = x + self.hull_offset*math.sin(hull_angle), y - self.hull_offset*math.cos(hull_angle)
    self.gun_location.x, self.gun_location.y = self.image_location.x + (self.gun_offset)*math.sin(hull_angle+self.turret_angle),
                                               self.image_location.y - (self.gun_offset)*math.cos(hull_angle+self.turret_angle)
    self.engine_location.x, self.engine_location.y = self.image_location.x + (self.engine_offset)*math.sin(hull_angle),
                                                     self.image_location.y - (self.engine_offset)*math.cos(hull_angle)
    self.exhaust_location.x, self.exhaust_location.y = self.image_location.x + self.exhaust_offset.y*math.sin(hull_angle) + self.exhaust_offset.x*math.cos(hull_angle),
                                                       self.image_location.y - self.exhaust_offset.y*math.cos(hull_angle) + self.exhaust_offset.x*math.sin(hull_angle)
    self.reload_timer = self.reload_timer - dt
    self.firing_timer = self.firing_timer - dt

    --ainme update
    if self.firing_timer <= 0 then
        self.turret_anime:gotoFrame(1)
    end
    self.turret_anime:update(dt)
end

function Tank:Draw()
    local x, y = self.image_location.x, self.image_location.y
    local a = self.location.hull_angle
    love.graphics.draw(self.hull_image,x,y,a,1,1,144,144)
    love.graphics.draw(self.armor.hull_image,x,y,a,1,1,144,144)
    self.turret_anime:draw(self.anime_sheet,x,y,a+self.turret_angle,1,1,144,144)
    love.graphics.draw(self.aim.turret_image,x,y,a+self.turret_angle,1,1,144,144)
    love.graphics.draw(self.armor.turret_image,x,y,a+self.turret_angle,1,1,144,144)
end

function Tank:DrawBrokenTank()
    local x, y = self.collider:getPosition()
    local a = self.collider:getAngle()
    love.graphics.draw(self.hull_image_broken,x,y,a,1,1,144,144)
    love.graphics.draw(self.turret_image_broken,x,y,a+self.turret_angle,1,1,144,144)
end

function Tank:Detonate()
    
end

function Tank:CreatParticles()
    self.particles = {
        muzzlesmoke = love.graphics.newParticleSystem(Smoke),
        enginesmoke = love.graphics.newParticleSystem(ExhaustGas),
        onfire = love.graphics.newParticleSystem(Fire),
    }
    self.particles.muzzlesmoke:setEmitterLifetime(1.5)
    self.particles.muzzlesmoke:setParticleLifetime(2)
	self.particles.muzzlesmoke:setEmissionRate(50)
	self.particles.muzzlesmoke:setSizeVariation(0.5)
    self.particles.muzzlesmoke:setSizes(0.2, 1)
    self.particles.muzzlesmoke:setLinearDamping(5)
	self.particles.muzzlesmoke:setColors(1, 1, 1, 1, 1, 1, 1, 0)
    self.particles.muzzlesmoke:stop()

    self.particles.enginesmoke:setParticleLifetime(0.5)
	self.particles.enginesmoke:setSizeVariation(0.5)
    self.particles.enginesmoke:setSizes(0.4, 1)
    self.particles.enginesmoke:setLinearDamping(5)
	self.particles.enginesmoke:setColors(1, 1, 1, 1, 1, 1, 1, 0)

    self.particles.onfire:setParticleLifetime(1)
	self.particles.onfire:setEmissionRate(50)
	self.particles.onfire:setSizeVariation(1)
    self.particles.onfire:setSizes(0.2, 1)
    self.particles.onfire:setLinearDamping(5)
	self.particles.onfire:setColors(1, 1, 1, 1, 1, 0.2, 0, 1, 0, 0, 0, 0)
    self.particles.onfire:stop()
end

function Tank:ParticleUpdate(dt)
    local ix, iy = math.cos(self.location.hull_angle+self.turret_angle-math.pi/2),
                    math.sin(self.location.hull_angle+self.turret_angle-math.pi/2)
    local hx, hy = math.cos(self.location.hull_angle+self.exhaust_angle), math.sin(self.location.hull_angle+self.exhaust_angle)
    self.particles.muzzlesmoke:setPosition(self.gun_location.x + 4*math.sin(self.location.hull_angle+self.turret_angle),
                                           self.gun_location.y - 4*math.cos(self.location.hull_angle+self.turret_angle))
	self.particles.muzzlesmoke:setLinearAcceleration(150*ix+math.random(-30,30), 150*iy+math.random(-30,30))
    self.particles.muzzlesmoke:update(dt)

    self.particles.enginesmoke:setPosition(self.exhaust_location.x, self.exhaust_location.y)
    self.particles.enginesmoke:setLinearAcceleration(150*hx+math.random(-50,50), 150*hy+math.random(-50,50))
    self.particles.enginesmoke:update(dt)

    self.particles.onfire:setPosition(self.engine_location.x + math.random(-3,3), self.engine_location.y + math.random(-3,3))
    self.particles.onfire:setLinearAcceleration(50, 50, -50, -50)
    self.particles.onfire:update(dt)
end

function Tank:ParticleDraw()
    if self.firing_timer > 0 and self.firing_timer < 0.2 then
        self.particles.muzzlesmoke:start()
    end
    love.graphics.draw(self.particles.muzzlesmoke)

    if self.velocity.v > 5 or math.abs(self.collider:getAngularVelocity()) > 0 then
        self.particles.enginesmoke:setEmissionRate(50)
    else
        self.particles.enginesmoke:setEmissionRate(10)
    end
    love.graphics.draw(self.particles.enginesmoke)

    love.graphics.draw(self.particles.onfire)
end