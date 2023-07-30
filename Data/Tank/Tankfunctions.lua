Tank = {}
Tank.__index = Tank


function Buildtank(place, tank, type, x, y, ...)
    local tanky = {
        type = tank.type or type,
        number = tank.number or tostring(math.random(000,999)),
        name = tank.name,
        class = tank.class,
        width = tank.width,
        length = tank.length,
        weight = tank.weight,
        crew = tank.crew,
        survivor = tank.crew,
        reload_time = tank.reload_time,
        reload_timer = tank.reload_time,
        m_reload_time = tank.m_reload_time or nil,
        m_reload_timer = tank.m_reload_time or nil,
        deploy_time = tank.deploy_time or nil,
        deploy_timer = -1,
        fuel = tank.fuel_capacity,
        fuel_capacity = tank.fuel_capacity,
        fuel_cosumption = tank.fuel_cosumption,
        ammorack_size = tank.ammorack_size,
        ammorack = copytable(tank.ammorack or {}),
        missilerack_size = tank.missilerack_size,
        missilerack = copytable(tank.missilerack or {}),
        armorthickness = tank.armorthickness,
        innerstructure = tank.innerstructure,
        max_f_speed = tank.max_f_speed,
        max_r_speed = tank.max_r_speed,
        turret_t_speed = tank.turret_t_speed,
        turret_t_angle = tank.turret_t_angle or nil,
        vision = tank.vision,
        hull_image = tank.hull_image,
        hull_image_line = tank.hull_image_line,
        hull_image_broken = tank.hull_image_broken,
        turret_image = tank.turret_image,
        turret_image_line = tank.turret_image_line,
        turret_image_broken = tank.turret_image_broken,
        anime_sheet = tank.anime_sheet,
        turret_anime = anim8.newAnimation(Tank_Grid('1-7', 1), 0.1),
        firing_anime = anim8.newAnimation(Tank_Grid('1-7', 1), 0.1),
        deploy_anime = anim8.newAnimation(Tank_Grid('1-7', 2), 0.2),
        gun_sound = tank.gun_sound:clone(),
        image_offset = tank.image_offset,
        turret_offset = tank.turret_offset,
        gun_offset = tank.gun_offset or nil,
        luncher_offset = tank.luncher_offset or nil,
        engine_offset = tank.engine_offset,
        exhaust_offset = tank.exhaust_offset,
        exhaust_offset2 = tank.exhaust_offset2 or nil,
        exhaust_angle = tank.exhaust_angle,
        exhaust_angle2 = tank.exhaust_angle2 or nil,
        main_turret_offset = tank.main_turret_offset or nil,
        turret_angle = 0,
        armor = tank.armor or copytable(tank.accessories[1][tank.armor_num or 1] or Blank_Gear),
        aim = tank.aim or copytable(tank.accessories[2][tank.aim_num or 1] or Blank_Gear),
        mob = tank.mob or copytable(tank.accessories[3][tank.mob_num or 1] or Blank_Gear),
        velocity = {vx = 0, vy = 0, v = 0},
        location = tank.location or {x = x, y = y, hull_angle = 0},
        destination = {x = x, y = y},
        image_location = {},
        turret_location = {},
        gun_location = {},
        luncher_location = {},
        engine_location = {},
        exhaust_location = {},
        exhaust_location2 = {},
        functions = {},
        InfoButtons = {},
        center = {x = x, y = y },
        a = 0,
        status = tank.status or
        {
            dead = false,
            onfire = false,
            immobilized = false,
            era = false,
            penetrated = false
        },
        firing_time = tank.firing_time,
        firing_timer = 0,
        pen_timer = 0,
        picked = false,
        leader = false,
        incomp = false,
        deployed = false,
        caml = {x = 0, y = 0}
    }
    if type == 'enemy' then
        if tank.ammorack_size then
            while #tanky.ammorack < tanky.ammorack_size do
                table.insert(tanky.ammorack, tank.ammunition[1])
            end
        end
        if tank.missilerack_size then
            while #tanky.missilerack < tanky.missilerack_size do
                for i, ammo in ipairs(tank.ammunition) do
                    if ammo.type == 'ATGM' then
                        table.insert(tanky.missilerack, ammo)
                    end
                end
            end
        end
    end
    if tanky.ammorack_size then
        for i, ammo in ipairs(tanky.ammorack) do
            ammo.add = nil
            ammo.remove = nil
        end
    end
    if tanky.missilerack_size then
        for i, missile in ipairs(tanky.missilerack) do
            missile.add = nil
            missile.remove = nil
        end
    end

    
    setmetatable(tanky, Tank)
    --Tank.__index = Tank
    table.insert(place.exsist_tank, tanky)
    TankSpawner:loadtank(place, tanky)
end

CalculateAngleBetweenVectors = function(x1, y1, x2, y2)
    local dotProduct = x1 * x2 + y1 * y2
    local magnitude1 = math.sqrt(x1 * x1 + y1 * y1)
    local magnitude2 = math.sqrt(x2 * x2 + y2 * y2)
    local cosAngle = dotProduct / (magnitude1 * magnitude2)
    local angle = math.acos(cosAngle)
    return angle
end

IsDirectionOpposite = function(x_speed, y_speed, angle)
    -- 将速度向量和角度向量归一化
    local speedMagnitude = math.sqrt(x_speed * x_speed + y_speed * y_speed)
    local normalizedXSpeed = x_speed / speedMagnitude
    local normalizedYSpeed = y_speed / speedMagnitude
    local angleVectorX = math.cos(angle)
    local angleVectorY = math.sin(angle)

    -- 计算夹角
    local angleBetweenVectors = CalculateAngleBetweenVectors(normalizedXSpeed, normalizedYSpeed, angleVectorX, angleVectorY)

    -- 判断夹角是否接近于 180 度（相反方向）
    local tolerance = 0.5
    local isOppositeDirection = math.abs(angleBetweenVectors - math.pi) < tolerance

    return isOppositeDirection
end

function Compare(a, b)
    return a.length < b.length
end


function Isalert(unit, enemy, alert, x, y)
    local centerX = unit.center.x
    local centerY = unit.center.y
    local radius = unit.vision
    local a = false
    for i, target in ipairs(CurrentPlace.exsist_tank) do
        if math.sqrt((target.location.x - unit.location.x)^2 + (target.location.y - unit.location.y)^2) < unit.vision then
            if target.type ~= unit.type then
                local colliders = CurrentPlace.world:queryLine(centerX, centerY, target.location.x, target.location.y, {'All'})
                if colliders ~= nil then
                    if colliders[2] ~= nil then
                        table.sort(colliders, Compare)
                    end

                    if colliders[1] == target.collider then
                        x, y = colliders.test.x, colliders.test.y
                        enemy = target
                        alert = true
                        a = {alert, x, y}
                    end
                end
            end
        end
    end
    return a
end


AutoControlfunction = function(tank, dt)
    local hp = 50*tank.mob.hp*0.745
    local fx = hp*math.cos(tank.location.hull_angle - 0.5*math.pi)
    local fy = hp*math.sin(tank.location.hull_angle - 0.5*math.pi)
    local max_f = tank.max_f_speed
    local max_r = math.abs(tank.max_r_speed)
    local speed = tank.velocity.v/5
    local alert = false
    --enemy confirmation
    local enemy = {}
    local centerX = tank.center.x
    local centerY = tank.center.y
    local radius = tank.vision
    local startAngle = 0
    local endAngle = math.pi/2 
    local x, y = tank.center.x, tank.center.y
    tank.destination.x, tank.destination.y = tank.location.x, tank.location.y


    local data_alert = Isalert(tank, alert, x, y)
    if data_alert ~= false then 
        alert, x, y = data_alert[1], data_alert[2], data_alert[3]
    end

    if alert then
        tank:FacePosition(x, y)
        local isaim = tank:AimCheck(x, y, dt)
        if #tank.ammorack > 0 and isaim and tank.reload_timer <= 0 then
            if tank.class == 'spg' then
                if tank.deployed then
                    Bomb(tank, enemy.location.x, enemy.location.y)
                end
            else
                Shoot(tank)
            end
        end
        if #tank.missilerack > 0 and isaim and tank.m_reload_timer <= 0 then
            LaunchMissile(tank, enemy)
        end
    end
end

MouseControlfunction = function(tank, dt)
    local hp = 50*tank.mob.hp*0.745
    local fx = hp*math.cos(tank.location.hull_angle - 0.5*math.pi)
    local fy = hp*math.sin(tank.location.hull_angle - 0.5*math.pi)
    local max_f = tank.max_f_speed
    local max_r = math.abs(tank.max_r_speed)
    local speed = tank.velocity.v/5
    local alert = false
    --enemy confirmation
    local enemy = {}

    if love.mouse.isDown(2) then
        tank.destination.x, tank.destination.y = cam:mousePosition()
    end

    if not tank.deployed and tank.destination.x ~= tank.location.x  then
        local angle_to_mouse = math.atan2(tank.destination.y - tank.location.y, tank.destination.x - tank.location.x)
        local distance_to_mouse = math.sqrt((tank.destination.x - tank.location.x)^2 + (tank.destination.y - tank.location.y)^2)
        if distance_to_mouse >= 100 then
            if tank.location.hull_angle - 0.5*math.pi - angle_to_mouse < 0.2 * math.pi and tank.location.hull_angle - 0.5*math.pi - angle_to_mouse > -0.2 * math.pi then
                tank.collider:applyForce(fx, fy)
            else
                tank.collider:applyForce(fx/3, fy/3)
            end
        end

        if distance_to_mouse >= 50 then
            if tank.location.hull_angle - 0.5*math.pi - angle_to_mouse > 0.1 * math.pi then
                tank.collider:applyTorque(-5*hp)
            elseif  0 < tank.location.hull_angle - 0.5*math.pi - angle_to_mouse and tank.location.hull_angle - 0.5*math.pi - angle_to_mouse < 0.2 * math.pi then
                tank.collider:applyTorque(-1*hp)
            elseif 0 > tank.location.hull_angle - 0.5*math.pi - angle_to_mouse and tank.location.hull_angle - 0.5*math.pi - angle_to_mouse > -0.2 * math.pi then
                tank.collider:applyTorque(1*hp)
            elseif  tank.location.hull_angle - 0.5*math.pi - angle_to_mouse < -0.1 * math.pi then
                tank.collider:applyTorque(5*hp)
        end
        end
    end

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
        tank:FacePosition(enemy.location.x, enemy.location.y)
        local isaim = tank:AimCheck(enemy.location.x, enemy.location.y, dt)
        if #tank.ammorack > 0 and isaim and tank.reload_timer <= 0 then
            if tank.class == 'spg' then
                if tank.deployed then
                    Bomb(tank, enemy.location.x, enemy.location.y)
                end
            else
                Shoot(tank)
            end
        end
        if #tank.missilerack > 0 and isaim and tank.m_reload_timer <= 0 then
            LaunchMissile(tank, enemy)
        end
    end
end

function lerp(a, b, t)
    return a + (b - a) * t
end


function cammove(tank, length, dt)
    local xm, ym = cam:mousePosition()
    local x1, y1 = tank.location.x, tank.location.y
    local alen = math.sqrt((x1-xm)^2+(y1-ym)^2)
   
    local a = math.atan2(ym-y1, xm-x1)
    local x2 = alen*math.cos(a)*length 
    local y2 = alen*math.sin(a)*length 
    local ease = 0.05
    tank.caml.x = lerp(tank.caml.x, x2, ease)
    tank.caml.y = lerp(tank.caml.y, y2, ease)
    local newX, newY = tank.caml.x + x1, tank.caml.y + y1
    cam:lookAt(newX, newY)
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
    local vx, vy = tank.collider:getLinearVelocity()
    tank.destination.x, tank.destination.y = tank.location.x, tank.location.y
    if love.mouse.isDown(2) then
        cammove(tank, 0.4, dt)
    else
        cammove(tank, 0.1, dt)
    end

    if not tank.deployed and love.keyboard.isDown('w') and speed <= max_f then
        tank.collider:applyForce(fx, fy)
    end
    if not tank.deployed and love.keyboard.isDown('s') and speed <= max_r then
        tank.collider:applyForce(-fx, -fy)
    end
    if not tank.deployed and love.keyboard.isDown('a')  then
        if love.keyboard.isDown('s') then
            tank.collider:applyTorque(5*hp)
        else
            tank.collider:applyTorque(-5*hp)
        end
    end
    if not tank.deployed and love.keyboard.isDown('d')  then
        if love.keyboard.isDown('s') then
            tank.collider:applyTorque(-5*hp)
        else
            tank.collider:applyTorque(5*hp)
        end
    end

    if Cursormode == 'firing' and love.mouse.isDown(1) and #tank.ammorack > 0 and isaim and tank.reload_timer <= 0 then
        if tank.class == 'spg' then
            if tank.deployed then
                Bomb(tank, mx, my)
            end
        else
            Shoot(tank)
        end
    end
    if Cursormode == 'firing' and love.mouse.isDown(2) and #tank.missilerack > 0 and isaim and tank.m_reload_timer <= 0 then
        LaunchMissile(tank)
    end
end

function Tank:Setdeployed()
    if self.deployed then
        self.deploy_timer = -1
        self.deployed = false
    else
        self.deploy_timer = self.deploy_time
    end
end

function Tank:AimCheck(x, y, dt)
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

function Tank:FacePosition(x, y)
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

function Tank:CheckStatus(i, dt)
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
        table.insert(CurrentPlace.broken_tank, table.remove(CurrentPlace.exsist_tank, i))
    end

    if self.status.penetrated then
        self.pen_timer = self.pen_timer + dt
        if self.pen_timer >= 1 then
            self.status.penetrated = false
            self.pen_timer = 0
        end
    end
end

function Tank:Update(dt)
    --location update
    self.a = self.a + dt*10
    local x,y = self.collider:getPosition()
    local hull_angle = self.collider:getAngle()
    local vx, vy = self.collider:getLinearVelocity()
    self.velocity = {vx = vx, vy = vy, v = math.sqrt(vx^2 + vy^2)}
    self.location = {x = x, y = y, hull_angle = hull_angle}
    self.image_location.x, self.image_location.y = x + self.image_offset*math.sin(hull_angle), y - self.image_offset*math.cos(hull_angle)

    self.image_location.x, self.image_location.y = x + self.image_offset*math.sin(hull_angle), y - self.image_offset*math.cos(hull_angle)     --adjust collider's and image's location
    self.turret_location.x, self.turret_location.y = self.image_location.x - self.turret_offset*math.sin(hull_angle), self.image_location.y + self.turret_offset*math.cos(hull_angle)
    self.center.x ,self.center.y= self.turret_location.x, self.turret_location.y
    if self.gun_offset then
        self.gun_location.x, self.gun_location.y = self.turret_location.x + (self.gun_offset)*math.sin(hull_angle+self.turret_angle),
                                                self.turret_location.y - (self.gun_offset)*math.cos(hull_angle+self.turret_angle)
    end
    if self.luncher_offset then
        self.luncher_location.x, self.luncher_location.y = self.turret_location.x + (self.luncher_offset.y)*math.sin(hull_angle+self.turret_angle) + self.luncher_offset.x*math.cos(hull_angle+self.turret_angle),
                                                        self.turret_location.y - (self.luncher_offset.y)*math.cos(hull_angle+self.turret_angle) + self.luncher_offset.x*math.sin(hull_angle+self.turret_angle)
    end
    
    self.engine_location.x, self.engine_location.y = self.image_location.x + (self.engine_offset)*math.sin(hull_angle),
                                                        self.image_location.y - (self.engine_offset)*math.cos(hull_angle)
    self.exhaust_location.x, self.exhaust_location.y = self.image_location.x + self.exhaust_offset.y*math.sin(hull_angle) + self.exhaust_offset.x*math.cos(hull_angle),
                                                        self.image_location.y - self.exhaust_offset.y*math.cos(hull_angle) + self.exhaust_offset.x*math.sin(hull_angle)
    if self.exhaust_offset2 then
    self.exhaust_location2.x, self.exhaust_location2.y = self.image_location.x + self.exhaust_offset2.y*math.sin(hull_angle) + self.exhaust_offset2.x*math.cos(hull_angle),
                                                             self.image_location.y - self.exhaust_offset2.y*math.cos(hull_angle) + self.exhaust_offset2.x*math.sin(hull_angle)
    end

    --button update
    for n, button in ipairs(self.InfoButtons) do
        button.bx, button.by = self.image_location.x, self.image_location.y
    end

    --timer update
    if self.reload_timer then
        self.reload_timer = self.reload_timer - dt
        self.firing_timer = self.firing_timer - dt
    end
    if self.m_reload_timer then
        self.m_reload_timer = self.m_reload_timer - dt
    end
    if self.class == 'spg' then
        self.deploy_timer = self.deploy_timer - dt
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

function Tank:Draw()
    --Visual(self)
    local x, y = self.image_location.x, self.image_location.y
    local hull_angle = self.collider:getAngle() - math.pi/2
    local a = self.location.hull_angle
    love.graphics.draw(self.hull_image,x,y,a,1,1,144,144)
    love.graphics.draw(self.armor.hull_image,x,y,a,1,1,144,144)
    local turret_x, turret_y = self.turret_location.x, self.turret_location.y
    self.turret_anime:draw(self.anime_sheet,turret_x,turret_y,a+self.turret_angle,1,1,144,144+self.turret_offset)    --draw turret/*+self.turret_offset*/
    love.graphics.draw(self.aim.turret_image,turret_x,turret_y,a+self.turret_angle,1,1,144,144)
    love.graphics.draw(self.armor.turret_image,turret_x,turret_y,a+self.turret_angle,1,1,144,144)
    --button use
    if self.type == 'friendly' then
        self.InfoButtons:use()
    end
    
end

function Tank:DrawBrokenTank()
    local x, y = self.collider:getPosition()
    local a = self.collider:getAngle()
    love.graphics.draw(self.hull_image_broken,x,y,a,1,1,144,144)
    love.graphics.draw(self.turret_image_broken,x,y,a+self.turret_angle,1,1,144,144)
end

function Tank:Detonate()
    
end


function Visual(unit)
    local centerX = unit.center.x
    local centerY = unit.center.y
    local radius = unit.vision
    local startAngle = 0
    local endAngle = math.pi/2 

    love.graphics.setColor(1, 1, 0, 0.5) 
    love.graphics.setLineWidth(1)
    local a = 0
    local b1 = {}
    local b2 = {}

    while a < 360.5 do 
        local B = math.rad(a)

        local endX = centerX + radius * math.cos(B)
        local endY = centerY + radius * math.sin(B)
        local colliders = CurrentPlace.world:queryLine(centerX, centerY, endX, endY, {'Wall'})

        if colliders == nil then
            if b1[1] == nil then
                table.insert(b1, 1, {endX, endY})
            else
                local t = {b1[1][1], b1[1][2], centerX, centerY, endX, endY}
                table.insert(b1, 2, {endX, endY})
                table.remove(b1,1)
                love.graphics.polygon("fill", t)
            end
            b2 = {{endX, endY}}
        else 
            if b2[1] == nil then
                table.insert(b2, 1, {colliders.test.x, colliders.test.y})
            else
                local t = {b2[1][1], b2[1][2], centerX, centerY, colliders.test.x, colliders.test.y}
                table.insert(b2, 2, {colliders.test.x, colliders.test.y})
                table.remove(b2,1)
                love.graphics.polygon("fill", t)
            end
            b1 = {{colliders.test.x, colliders.test.y}}
        end
        a = a + 0.5
    end
    love.graphics.setColor(1, 1, 1)
    love.graphics.setLineWidth(1)

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
    if self.exhaust_offset2 then
        self.particles.enginesmoke2 = self.particles.enginesmoke:clone()
    end

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
    if self.gun_offset then
        self.particles.muzzlesmoke:setPosition(self.gun_location.x + 4*math.sin(self.location.hull_angle+self.turret_angle),
                                           self.gun_location.y - 4*math.cos(self.location.hull_angle+self.turret_angle))
	    self.particles.muzzlesmoke:setLinearAcceleration(150*ix+math.random(-30,30), 150*iy+math.random(-30,30))
        self.particles.muzzlesmoke:update(dt)
    end
    self.particles.enginesmoke:setPosition(self.exhaust_location.x, self.exhaust_location.y)
    self.particles.enginesmoke:setLinearAcceleration(150*hx+math.random(-50,50), 150*hy+math.random(-50,50))
    self.particles.enginesmoke:update(dt)
    if self.exhaust_offset2 then
        local hx2, hy2 = math.cos(self.location.hull_angle+self.exhaust_angle2), math.sin(self.location.hull_angle+self.exhaust_angle2)
        self.particles.enginesmoke2:setPosition(self.exhaust_location2.x, self.exhaust_location2.y)
        self.particles.enginesmoke2:setLinearAcceleration(150*hx2+math.random(-50,50), 150*hy2+math.random(-50,50))
        self.particles.enginesmoke2:update(dt)
    end

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
        if self.exhaust_offset2 then
            self.particles.enginesmoke2:setEmissionRate(50)
        end
    else
        self.particles.enginesmoke:setEmissionRate(10)
        if self.exhaust_offset2 then
            self.particles.enginesmoke2:setEmissionRate(10)
        end
    end
    love.graphics.draw(self.particles.enginesmoke)
    if self.exhaust_offset2 then
        love.graphics.draw(self.particles.enginesmoke2)
    end
    love.graphics.draw(self.particles.onfire)
end