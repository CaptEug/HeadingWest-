Tank = {}
tanks = {}
tank = {}
tank.__index = tanks

MAUS_tracksound = love.audio.newSource('music/sound/Heavy-truck-driving-sound-loop.mp3', "stream")

function tanks.new(
    tank_name,
    x,
    y,
    angle,
    turret_angle,
    turret_path,
    bodywork_path,
    turret_offset,
    maxspeed,
    back_maxspeed,
    acceleration,
    back_acceleration,
    stop_acceleration,
    max_Rotation_speed,
    Rotation_acceleration,
    stop_rotation_ac,
    turret_max_Rotation_speed,
    turret_Rotation_acceleration,
    turret_stop_rotation_ac
    )
    local instance = setmetatable({}, tank)
    instance.tank_name = tank_name or 'tank'
    instance.x = x or 0
    instance.y = y or 0
    instance.angle = angle or 0
    instance.turret_angle = turret_angle or 0
    instance.turret_path = turret_path
    instance.bodywork_path = bodywork_path
    instance.turret_offset = turret_offset or 0
    instance.maxspeed = maxspeed or 0
    instance.back_maxspeed = back_maxspeed or 0
    instance.acceleration = acceleration or 0
    instance.back_acceleration = back_acceleration or 0
    instance.stop_acceleration = stop_acceleration or 0
    instance.max_Rotation_speed = max_Rotation_speed or 0
    instance.Rotation_acceleration = Rotation_acceleration or 0
    instance.stop_rotation_ac = stop_rotation_ac or 0
    instance.turret_max_Rotation_speed = turret_max_Rotation_speed or 0
    instance.turret_Rotation_acceleration = turret_Rotation_acceleration or 0
    instance.turret_stop_rotation_ac = turret_stop_rotation_ac or 0

    return instance
end


function tanks:getdata()
    return 
    self.tank_name,
    self.x,
    self.y,
    self.angle,
    self.turret_angle,
    self.turret_path,
    self.bodywork_path,
    self.turret_offset,
    self.maxspeed,
    self.back_maxspeed,
    self.acceleration,
    self.back_acceleration,
    self.stop_acceleration,
    self.max_Rotation_speed,
    self.Rotation_acceleration,
    self.stop_rotation_ac,
    self.turret_max_Rotation_speed,
    self.turret_Rotation_acceleration,
    self.turret_stop_rotation_ac
end



function tanks:create()
    MAUS_Ammo = Ammo.new()
    APCBC_128mm = Ammo.newShell(25600,0,MAUS_Ammo)
    Reload_time = 3
    Reload_timer = 0

    self.a = love.graphics.newImage(self.bodywork_path)
    self.b = love.graphics.newImage(self.turret_path)
    self.aw , self.ah = self.a:getDimensions()
    self.bw , self.bh = self.b:getDimensions()
    self.tankbox = world:newRectangleCollider(self.x, self.y, self.aw*0.2, self.ah*0.2)
    self.tankbox:setFixedRotation(true)
    self.tankbox:setRestitution(1)
    self.speed = 0
    self.Rotation_speed = 0
    self.vx = 0
    self.vy = 0
    self.vt = 0
end

function tanks:move(dt)
    ismove = false
    Reload_timer = Reload_timer - dt
    if love.mouse.isDown(1) and Reload_timer <= 0 then
        MAUS_Ammo:shoot(APCBC_128mm, APCBC)
        Reload_timer = Reload_time
    end

    if love.keyboard.isDown('up') then
        ismove = true
        if self.speed<self.maxspeed then
            self.speed=self.speed+self.acceleration*dt
        end
    else
        if self.speed>0 then
            if self.speed>-0.1 and self.speed<0.1 then
                self.speed = 0
            end
            self.speed=self.speed-self.stop_acceleration*dt
        end
    end

    if love.keyboard.isDown('down') then
        ismove = true
        if self.speed>-self.back_maxspeed then
            self.speed=self.speed-self.back_acceleration*dt
        end
    else
        if self.speed<0 then
            if self.speed>-0.1 and self.speed<0.1 then
                self.speed = 0
            end
            self.speed=self.speed+self.stop_acceleration*dt
        end
    end

    if love.keyboard.isDown('left') then
        ismove = true
        if self.Rotation_speed>-self.max_Rotation_speed then
            self.Rotation_speed=self.Rotation_speed-self.Rotation_acceleration*dt
        end
    else
        if self.Rotation_speed<0 then
            if self.Rotation_speed>-0.1 and self.Rotation_speed<0.1 then
                self.Rotation_speed = 0
            end
            self.Rotation_speed=self.Rotation_speed+self.stop_rotation_ac*dt
        end
    end

    if love.keyboard.isDown('right') then
        ismove = true
        if self.Rotation_speed<self.max_Rotation_speed then
            self.Rotation_speed=self.Rotation_speed+self.Rotation_acceleration*dt
        end
    else
        if self.Rotation_speed>0 then
            if self.Rotation_speed>-0.1 and self.Rotation_speed<0.1 then
                self.Rotation_speed = 0
            end
            self.Rotation_speed=self.Rotation_speed-self.stop_rotation_ac*dt
        end
    end

    if ismove then
        --love.audio.play(MAUS_tracksound)
        --cam:move(math.random(-1,1),math.random(-1,1))
    end
    if not ismove then
        --love.audio.pause(MAUS_tracksound)
    end

    cos = math.cos(self.angle)
    sin = math.sin(self.angle)


    self.bx = self.tankbox:getX() - self.turret_offset * sin
    self.by = self.tankbox:getY() + self.turret_offset * cos

    self.vx =  self.speed * sin
    self.vy =  self.speed * cos * -1

    self.x = self.tankbox:getX() 
    self.y = self.tankbox:getY() 

    self.angle = self.tankbox:getAngle()

    self.vt = self.Rotation_speed


    self.tankbox:setLinearVelocity(self.vx , self.vy)
    self.tankbox:setAngularVelocity(self.vt)
end


function tanks:use()
    love.graphics.draw(self.a,self.x,self.y,self.angle ,0.2,0.2,self.aw/2,self.ah/2)
    love.graphics.draw(self.b,self.bx,self.by,self.turret_angle ,0.2,0.2,self.bw/2,self.bh/2)
end



-- function Tank:update(dt)
--     if love.keyboard.isDown('up') then
--         if arrow.speed<arrow.maxspeed then
--             arrow.speed=arrow.speed+arrow.ac*dt
--         end
--     else
--         if arrow.speed>0 then
--             if arrow.speed>-0.1 and arrow.speed<0.1 then
--                 arrow.speed = 0
--             end
--             arrow.speed=arrow.speed-arrow.stopac*dt
--         end
--     end

--     if love.keyboard.isDown('down') then
--         if arrow.speed>-arrow.back_maxspeed then
--             arrow.speed=arrow.speed-arrow.backac*dt
--         end
--     else
--         if arrow.speed<0 then
--             if arrow.speed>-0.1 and arrow.speed<0.1 then
--                 arrow.speed = 0
--             end
--             arrow.speed=arrow.speed+arrow.stopac*dt
--         end
--     end
    
--     if love.keyboard.isDown('left') then
--         if arrow.turnspeed>-arrow.maxturnsp then
--             arrow.turnspeed=arrow.turnspeed-arrow.turnac*dt
--         end
--     else
--         if arrow.turnspeed<0 then
--             if arrow.turnspeed>-0.1 and arrow.turnspeed<0.1 then
--                 arrow.turnspeed = 0
--             end
--             arrow.turnspeed=arrow.turnspeed+arrow.stopturnac*dt
--         end
--     end

--     if love.keyboard.isDown('right') then
--         if arrow.turnspeed<arrow.maxturnsp then
--             arrow.turnspeed=arrow.turnspeed+arrow.turnac*dt
--         end
--     else
--         if arrow.turnspeed>0 then
--             if arrow.turnspeed>-0.1 and arrow.turnspeed<0.1 then
--                 arrow.turnspeed = 0
--             end
--             arrow.turnspeed=arrow.turnspeed-arrow.stopturnac*dt
--         end
--     end
--     --[[b_turnspeed = arrow.b_selfturnspeed + arrow.turnspeed
--     mx,my = love.mouse.getPosition()
--     angle1 = math.atan2(my - arrow.y,mx - arrow.x)
--     distance = math.sqrt((my - arrow.y)^2+(mx - arrow.x)^2)
--     stopdis = arrow.speed ^ 2 / (arrow.stopac * 2)
--     stopturndis = arrow.turnspeed ^ 2 / (arrow.stopturnac * 2)
--     b_stopturndis = arrow.b_selfturnspeed ^ 2 / (arrow.b_stopturnac * 2) + stopturndis
    
--     if arrow.maxturnsp*(-1)*0.6 > arrow.turnspeed or arrow.maxturnsp*0.6 < arrow.turnspeed then
--         if distance <= arrow.maxspeed * 0.5 and distance >=2 then
--             if arrow.speed >= 0 then
--                 arrow.speed = arrow.speed - ( arrow.stopac + arrow.ac ) * dt
--             elseif arrow.speed >= arrow.back_maxspeed then
--                 arrow.speed = arrow.speed - ( arrow.backac + arrow.stopac ) * dt
--             end
--         else
--             if arrow.speed >= arrow.maxspeed * 0.5 then 
--                 arrow.speed = arrow.speed - ( arrow.stopac + arrow.ac ) * dt
--             end
--         end
--     end

--     if arrow.angle < angle1 then
--         if 3.14*2 - angle1 + arrow.angle > angle1 - arrow.angle then
--             turndis = angle1 - arrow.angle
--         else 
--             turndis = 3.14*2 - angle1 + arrow.angle
--         end
--     else
--         if 3.14*2 - arrow.angle + angle1 > arrow.angle - angle1 then
--             turndis = arrow.angle - angle1
--         else 
--             turndis = 3.14*2 - arrow.angle + angle1
--         end
--     end


--     if arrow.b_angle < angle1 then
--         if 3.14*2 - angle1 + arrow.b_angle > angle1 - arrow.b_angle then
--             b_turndis = angle1 - arrow.b_angle
--         else 
--             b_turndis = 3.14*2 - angle1 + arrow.angle
--         end
--     else
--         if 3.14*2 - arrow.b_angle + angle1 > arrow.b_angle - angle1 then
--             b_turndis = arrow.b_angle - angle1
--         else 
--             b_turndis = 3.14*2 - arrow.b_angle + angle1
--         end
--     end




--     if arrow.speed < arrow.maxspeed and distance > stopdis + 10 then
--         if arrow.speed >= 0 then
--             arrow.speed = arrow.speed + arrow.ac * dt
--         else
--             arrow.speed = arrow.speed + arrow.stopac * dt
--         end
--     end

--     if  distance < stopdis and arrow.speed >= 0 then
--         arrow.speed = arrow.speed - arrow.stopac * dt
--     end

--     if distance < 2 then
--         arrow.speed = 0
--         arrow.turnspeed = 0   
--     end
    
--     if  turndis < stopturndis and arrow.turnspeed >= 0 then
--         arrow.turnspeed = arrow.turnspeed - arrow.stopturnac * dt
--     end
--     if  turndis < stopturndis and arrow.turnspeed <= 0 then
--         arrow.turnspeed = arrow.turnspeed + arrow.stopturnac * dt
--     end

--     if  b_turndis < b_stopturndis and arrow.b_selfturnspeed >= 0 then
--         arrow.b_selfturnspeed = arrow.b_selfturnspeed - arrow.b_stopturnac * dt
--     end
--     if  b_turndis < b_stopturndis and arrow.b_selfturnspeed <= 0 then
--         arrow.b_selfturnspeed = arrow.b_selfturnspeed + arrow.b_stopturnac * dt
--     end


    
    
--     m = b_turndis - b_stopturndis

--     if arrow.angle < angle1 then 
--         if 3.14*2 - angle1 + arrow.angle > angle1 - arrow.angle then
--             if arrow.turnspeed < arrow.maxturnsp and turndis > stopturndis and arrow.turnspeed > arrow.maxturnsp * (-1) then
--                 arrow.turnspeed = arrow.turnspeed + arrow.turnac * dt
--             end
--             arrow.angle = arrow.angle + arrow.turnspeed * dt
--         else 
--             if arrow.turnspeed < arrow.maxturnsp and turndis > stopturndis and arrow.turnspeed > arrow.maxturnsp * (-1) then
--                 if arrow.turnspeed >= 0 then
--                     arrow.turnspeed = arrow.turnspeed - arrow.stopturnac * dt
--                 else
--                     arrow.turnspeed = arrow.turnspeed - arrow.turnac * dt
--                 end
--             end
--             arrow.angle = arrow.angle + arrow.turnspeed * dt
--         end
--     else
--         if 3.14*2 - arrow.angle + angle1 > arrow.angle - angle1 then
--             if arrow.turnspeed < arrow.maxturnsp and turndis > stopturndis and arrow.turnspeed > arrow.maxturnsp * (-1) then
--                 arrow.turnspeed = arrow.turnspeed - arrow.turnac * dt
--             end
--             arrow.angle = arrow.angle + arrow.turnspeed * dt
--         else 
--             if arrow.turnspeed < arrow.maxturnsp and turndis > stopturndis and arrow.turnspeed > arrow.maxturnsp * (-1) then
--                 if arrow.turnspeed <= 0 then
--                     arrow.turnspeed = arrow.turnspeed + arrow.stopturnac * dt
--                 else
--                     arrow.turnspeed = arrow.turnspeed + arrow.turnac * dt
--                 end
--             end
--             arrow.angle = arrow.angle + arrow.turnspeed * dt
--         end
--     end


--     if arrow.b_angle < angle1 then 
--         if 3.14*2 - angle1 + arrow.b_angle > angle1 - arrow.b_angle then
--             if arrow.b_selfturnspeed < arrow.b_maxturnsp and b_turndis > b_stopturndis and arrow.b_selfturnspeed > arrow.b_maxturnsp * (-1) then
--                 arrow.b_selfturnspeed = arrow.b_selfturnspeed + arrow.b_turnac * dt
--             end
--             arrow.b_angle = arrow.b_angle + b_turnspeed * dt
--         else 
--             if arrow.b_selfturnspeed < arrow.b_maxturnsp and b_turndis > b_stopturndis and arrow.b_selfturnspeed > arrow.b_maxturnsp * (-1) then
--                 if arrow.b_selfturnspeed >= 0 then
--                     arrow.b_selfturnspeed = arrow.b_selfturnspeed - arrow.b_stopturnac * dt
--                 else
--                     arrow.b_selfturnspeed = arrow.b_selfturnspeed - arrow.b_turnac * dt
--                 end
--             end
--             arrow.b_angle = arrow.b_angle + b_turnspeed * dt
--         end
--     else
--         if 3.14*2 - arrow.angle + angle1 > arrow.angle - angle1 then
--             if arrow.b_selfturnspeed < arrow.b_maxturnsp and b_turndis > b_stopturndis and arrow.b_selfturnspeed > arrow.b_maxturnsp * (-1) then
--                 arrow.b_selfturnspeed = arrow.b_selfturnspeed - arrow.b_turnac * dt
--             end
--             arrow.b_angle = arrow.b_angle + b_turnspeed * dt
--         else 
--             if arrow.b_selfturnspeed < arrow.b_maxturnsp and b_turndis > b_stopturndis and arrow.b_selfturnspeed > arrow.b_maxturnsp * (-1) then
--                 if arrow.b_selfturnspeed <= 0 then
--                     arrow.b_selfturnspeed = arrow.b_selfturnspeed + arrow.b_stopturnac * dt
--                 else
--                     arrow.b_selfturnspeed = arrow.b_selfturnspeed + arrow.b_turnac * dt
--                 end
--             end
--             arrow.b_angle = arrow.b_angle + b_turnspeed * dt
--         end
--     end



--     if arrow.angle <= -3.14 then 
--         arrow.angle = arrow.angle + 3.14*2
--     end

--     if arrow.angle >= 3.14 then 
--         arrow.angle = arrow.angle - 3.14*2
--     end


--     if arrow.b_angle <= -3.14 then 
--         arrow.b_angle = arrow.b_angle + 3.14*2
--     end

--     if arrow.b_angle >= 3.14 then 
--         arrow.b_angle = arrow.b_angle - 3.14*2
--     end]]--

    
--     cos = math.cos(arrow.angle)
--     sin = math.sin(arrow.angle)



--     --arrow.y = arrow.y + arrow.speed * sin * dt
--     --arrow.x = arrow.x + arrow.speed * cos * dt

--     xb = arrow.tankbox:getX() - arrow.z * sin
--     yb = arrow.tankbox:getY() + arrow.z * cos

--     va =  arrow.speed * sin
--     vb =  arrow.speed * cos * -1

--     arrow.x = arrow.tankbox:getX() 
--     arrow.y = arrow.tankbox:getY() 

--     arrow.angle = arrow.tankbox:getAngle()

--     vc = arrow.turnspeed
    

--     arrow.tankbox:setLinearVelocity(va , vb)
--     arrow.tankbox:setAngularVelocity(vc)
-- end    

-- function Tank:draw()
    
    

    
--     love.graphics.draw(a,arrow.x,arrow.y,arrow.angle  ,0.2,0.2,aw/2,ah/2)
--     love.graphics.draw(b,xb,yb,arrow.b_angle ,0.2,0.2,bw/2,bh/2)
-- end