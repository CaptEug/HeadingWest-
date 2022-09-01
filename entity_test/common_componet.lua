local Component = require "entity_test.tank_component"
local functions = require "entity_test.Commonly_used_functions"


return{
    
    new_location = function(x, y)
        local location = Component.new "location"
        location.x = x
        location.y = y
        return location
    end,

    move = function(speed, angle)
        local move = Component.new "move"
        move.speed = speed
        move.angle = angle
        return move
    end,

    rotation_data = function(Rotation_speed, max_Rotation_speed, Rotation_acceleration, stop_rotation_ac)
        local r = Component.new "rotation_data"
        r.Rotation_speed = Rotation_speed
        r.max_Rotation_speed = max_Rotation_speed
        r.Rotation_acceleration = Rotation_acceleration
        r.stop_rotation_ac = stop_rotation_ac
        return r
    end,

    turret_rdata = function(angle, Rotation_speed, max_Rotation_speed, Rotation_acceleration, stop_rotation_ac)
        local r = Component.new "turret_rdata"
        r.angle = angle - math.pi*0.5
        r.angledrta = angle
        r.Rotation_speed = Rotation_speed
        r.max_Rotation_speed = max_Rotation_speed
        r.Rotation_acceleration = Rotation_acceleration
        r.stop_rotation_ac = stop_rotation_ac
        return r
    end,

    move_data = function(maxspeed, back_maxspeed, acceleration, back_acceleration, stop_acceleration)
        local m = Component.new "move_data"
        m.maxspeed = maxspeed
        m.back_maxspeed = back_maxspeed
        m.acceleration = acceleration
        m.back_acceleration = back_acceleration
        m.stop_acceleration = stop_acceleration 
        return m
    end,

    tank_ammo = function(speed, numbers, mass, times)
        local t = Component.new "tankammo"
        t.ammo = Ammo.new()
        t.rack = Ammo.newShell(speed, numbers, mass, t.ammo)
        t.time = times
        t.timer = 0
        return t
    end,

    new_hull = function(hull_path, hp, mass)
        local hull = Component.new "hull"
        hull.picture = love.graphics.newImage(hull_path)
        hull.weight, hull.height = hull.picture:getDimensions()
        hull.hitbox = world:newRectangleCollider(0, 0, hull.weight, hull.height)
        hull.hitbox:setCollisionClass('Amour')
        hull.hitbox:setObject(hull)
        hull.hitbox:setMass(mass)
        hull.hitbox:setLinearDamping(5)
        hull.hitbox:setAngularDamping(10)
        hull.hitbox:setRestitution(0.8)
        hull.fullhp=hp
        hull.hp = hp
        return hull
    end,

    new_turret = function(turret_path, offset, length)
        local turret = Component.new "turret"
        turret.picture = love.graphics.newImage(turret_path)
        turret.weight, turret.height = turret.picture:getDimensions()
        turret.offset = offset
        turret.x = 0
        turret.AMx = 0
        turret.y = 0
        turret.AMy = 0
        turret.length = length
        return turret
    end,


    functional = function(fn)
        local functional = Component.new "functional"
        functional.fn = fn
        return functional
    end,

    init = function(fn)
        local functiona = Component.new "init"
        functiona.fn = fn
        return functiona
    end,

    movetype = function(self, dt)
        local hull = self:get "hull"
        local turret = self:get "turret"
        local turret1 = self:get "turret_rdata"
        local move = self:get "move"
        local r = self:get "rotation_data"
        local m = self:get "move_data"
        local t = self:get "tankammo"
        local cos = math.cos(move.angle)
        local sin = math.sin(move.angle)
        local cos1 = math.cos(turret1.angle)
        local sin1 = math.sin(turret1.angle)
        local vx =  move.speed * sin
        local vy =  move.speed * cos * - 1
        

        turret.AMx = turret.x + turret.length * cos1
        turret.AMy = turret.y + turret.length * sin1
        local mX, mY = cam:mousePosition()

        local isaim = functions.turret_to_target(self, dt, mX, mY)

        t.timer = t.timer - dt
        if love.mouse.isDown(1) and t.timer <= 0 and isaim then
            t.ammo:shoot(t.rack, 'APCBC', APCBC, self)
            t.timer = t.time
        end

        
        
        if love.keyboard.isDown('up') then
            if move.speed<m.maxspeed then
                move.speed = m.maxspeed
            end
        elseif love.keyboard.isDown('down') then
            if move.speed>-m.back_maxspeed then
                move.speed = m.maxspeed
            end
        else
                move.speed = 0
        end
    
        
        if love.keyboard.isDown('left') then
            if r.Rotation_speed>-r.max_Rotation_speed then
                r.Rotation_speed = r.Rotation_speed-r.Rotation_acceleration*dt
            end
        elseif love.keyboard.isDown('right') then
            if r.Rotation_speed<r.max_Rotation_speed then
                r.Rotation_speed=r.Rotation_speed+r.Rotation_acceleration*dt
            end
        else
            if r.Rotation_speed < -0.1 then
                r.Rotation_speed = r.Rotation_speed+r.stop_rotation_ac*dt
            elseif r.Rotation_speed > 0.1 then
                r.Rotation_speed = r.Rotation_speed-r.stop_rotation_ac*dt
            else
                r.Rotation_speed = 0
            end
        end


        hull.hitbox:setLinearVelocity(vx, vy)
        hull.hitbox:setAngularVelocity(r.Rotation_speed)
    end,

    poorAI=function(self, dt)
        local px,py=tanks_table:getdata(tank1)
        local ax,ay,arg=tanks_table:getdata(self)
        local hull = self:get "hull"
        local turret = self:get "turret"
        local turret1 = self:get "turret_rdata"
        local move = self:get "move"
        local r = self:get "rotation_data"
        local m = self:get "move_data"
        local t = self:get "tankammo"
        local cos = math.cos(move.angle)
        local sin = math.sin(move.angle)
        local cos1 = math.cos(turret1.angle)
        local sin1 = math.sin(turret1.angle)
        local vx =  move.speed * sin
        local vy =  move.speed * cos * - 1
        local state = 1

        local directx=px-ax
        local directy=py-ay
        local cosA=math.cos(arg)
        local sinA=math.sin(arg)
        local cosCA=(cosA*directx+sinA*directy)/(((directx^2+directy^2)^0.5))
        local direction=(directx^2+directy^2)^0.5

        if hull.hp<=0 then
            state=0
            hull.hitbox:setType('static')
        end

        if state==1 then
            local isAim = functions.turret_to_target(self, dt, px, py)
            turret.AMx = turret.x + 160 * sin1
            turret.AMy = turret.y - 160 * cos1
            t.timer = t.timer - dt

            if isAim and direction<700 and direction>500 and t.timer <= 0 then
                t.ammo:shoot(t.rack, 'APCBC', APCBC, self)
                t.timer = t.time
            end
        
            if math.abs(cosCA)<=math.pi/4 and direction>700 then --up
                if move.speed<m.maxspeed then
                    move.speed = move.speed + m.acceleration*dt
                end
            else
                if move.speed>0 then
                    if move.speed>-0.1 and move.speed<0.1 then
                        move.speed = 0
                    end
                    move.speed = move.speed - m.stop_acceleration*dt
                end
            end

            if direction<500 then
                if move.speed>-m.back_maxspeed then
                    move.speed = move.speed - m.back_acceleration*dt
                end
            else
                if move.speed<0 then
                    if move.speed>-0.1 and move.speed<0.1 then
                        move.speed = 0
                    end
                    move.speed = move.speed + m.stop_acceleration*dt
                end
            end

            if  cosCA<-0.1 then --left
                if r.Rotation_speed>-r.max_Rotation_speed then
                    r.Rotation_speed = r.Rotation_speed-r.Rotation_acceleration*dt
                end
            else
                if r.Rotation_speed<0 then
                    if r.Rotation_speed>-0.1 and r.Rotation_speed<0.1 then
                        r.Rotation_speed = 0
                    end
                    r.Rotation_speed=r.Rotation_speed+r.stop_rotation_ac*dt
                end
            end
        
            if cosCA>0.1 then  --right
                if r.Rotation_speed<r.max_Rotation_speed then
                    r.Rotation_speed=r.Rotation_speed+r.Rotation_acceleration*dt
                end
            else
                if r.Rotation_speed>0 then
                    if r.Rotation_speed>-0.1 and r.Rotation_speed<0.1 then
                        r.Rotation_speed = 0
                    end
                        r.Rotation_speed=r.Rotation_speed-r.stop_rotation_ac*dt
                end
            end
        end

        hull.hitbox:setLinearVelocity(vx, vy)
        hull.hitbox:setAngularVelocity(r.Rotation_speed)
    end

}