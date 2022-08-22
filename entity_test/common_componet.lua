local Component = require "entity_test.tank_component"


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
        r.angle = angle
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

    m1 = function(speed, numbers, times)
        local t = Component.new "tankammo"
        t.ammo = Ammo.new()
        t.rack = Ammo.newShell(speed, numbers, t.ammo)
        t.time = times
        t.timer = 0
        return t
    end,

    new_hull = function(hull_path)
        local hull = Component.new "hull"
        hull.picture = love.graphics.newImage(hull_path)
        hull.weight, hull.height = hull.picture:getDimensions()
        hull.hitbox = world:newRectangleCollider(0, 0, hull.weight*0.2, hull.height*0.2)
        return hull
    end,

    new_turret = function(turret_path, offset)
        local turret = Component.new "turret"
        turret.picture = love.graphics.newImage(turret_path)
        turret.weight, turret.height = turret.picture:getDimensions()
        turret.offset = offset
        turret.x = 0
        turret.AMx = 0
        turret.y = 0
        turret.AMy = 0
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
        local cos = math.cos(move.angle)
        local sin = math.sin(move.angle)
        local cos1 = math.cos(turret1.angle)
        local sin1 = math.sin(turret1.angle)
        local vx =  move.speed * sin
        local vy =  move.speed * cos * -1
        turret1.realspeed = r.Rotation_speed + turret1.Rotation_speed
        turret1.angle = turret1.angle + turret1.realspeed

        turret.AMx = turret.x + 160 * sin1
        turret.AMy = turret.y - 160 * cos1 

        local t = self:get "tankammo"
        turret.x = hull.hitbox:getX() - turret.offset * sin
        turret.y = hull.hitbox:getY() + turret.offset * cos
        t.timer = t.timer - dt
        if love.mouse.isDown(1) and t.timer <= 0 then
            t.ammo:shoot(t.rack, 'APCBC', APCBC)
            t.timer = t.time
        end


        local mx,my = love.mouse.getPosition()
        angle1 = math.atan2(my - turret.y,mx - turret.x)
        
        if love.keyboard.isDown('up') then
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
    
        if love.keyboard.isDown('down') then
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

        if love.keyboard.isDown('left') then
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

        if love.keyboard.isDown('right') then
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

        local angle1 = math.atan2( - turret.y, - turret.x)

        hull.hitbox:setLinearVelocity(vx, vy)
        hull.hitbox:setAngularVelocity(r.Rotation_speed)
    end,

    poorAI=function(self, dt)
        local px,py=tanks_table:getdata(tank1)
        local ax,ay=tanks_table:getdata(tank2)
        local v=5
        
        if ax~=px then 
            ax=ax-(ax-px)*v*dt
        end
        if ay~=py then
            ay=ay-(ay-py)*v*dt
        end

    end

}