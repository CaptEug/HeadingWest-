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

    rotation_data = function(Rotation_speed, max_Rotation_speed, Rotational_acceleration, stop_rotation_ac)
        local r = Component.new "rotation_data"
        r.Rotational_speed = Rotation_speed
        r.max_Rotational_speed = max_Rotation_speed
        r.Rotational_acceleration = Rotational_acceleration
        r.stop_rotation_ac = stop_rotation_ac
        return r
    end,

    turret_rdata = function(Rotation_speed, max_Rotation_speed, Rotational_acceleration, stop_rotation_ac)
        local r = Component.new "turret_rdata"
        r.Rotational_speed = Rotation_speed
        r.max_Rotational_speed = max_Rotation_speed
        r.Rotational_acceleration = Rotational_acceleration
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

    new_bodywork = function(bodywork_path)
        local bodywork = Component.new "bodywork"
        bodywork.picture = love.graphics.newImage(bodywork_path)
        bodywork.weight, bodywork.height = bodywork.picture:getDimensions()
        bodywork.hitbox = world:newRectangleCollider(0, 0, bodywork.weight*0.2, bodywork.height*0.2)
        return bodywork
    end,

    new_turret = function(turret_path, offset)
        local turret = Component.new "turret"
        turret.picture = love.graphics.newImage(turret_path)
        turret.weight, turret.height = turret.picture:getDimensions()
        turret.offset = offset
        turret.x = 0
        turret.y = 0
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
        local bodywork = self:get "bodywork"
        local turret = self:get "turret"
        local move = self:get "move"
        local r = self:get "rotation_data"
        local m = self:get "move_data"
        local cos = math.cos(move.angle)
        local sin = math.sin(move.angle)
        local vx =  move.speed * sin
        local vy =  move.speed * cos * -1

        turret.x = bodywork.hitbox:getX() - turret.offset * sin
        turret.y = bodywork.hitbox:getY() + turret.offset * cos
        
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
            if r.Rotational_speed>-r.max_Rotational_speed then
                r.Rotational_speed = r.Rotational_speed-r.Rotational_acceleration*dt
            end
        else
            if r.Rotational_speed<0 then
                if r.Rotational_speed>-0.1 and r.Rotational_speed<0.1 then
                    r.Rotational_speed = 0
                end
                r.Rotational_speed=r.Rotational_speed+r.stop_rotation_ac*dt
            end
        end

        if love.keyboard.isDown('right') then
            if r.Rotational_speed<r.max_Rotational_speed then
                r.Rotational_speed=r.Rotational_speed+r.Rotational_acceleration*dt
            end
        else
            if r.Rotational_speed>0 then
                if r.Rotational_speed>-0.1 and r.Rotational_speed<0.1 then
                    r.Rotational_speed = 0
                end
                r.Rotational_speed=r.Rotational_speed-r.stop_rotation_ac*dt
            end
        end

        --local 
        angle1 = math.atan2( - turret.y, - turret.x)

        bodywork.hitbox:setLinearVelocity(vx, vy)
        bodywork.hitbox:setAngularVelocity(r.Rotational_speed)
    end

}