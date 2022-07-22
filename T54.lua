T54 = {}

function T54:load()
    a = love.graphics.newImage('T-5455hullbody.png')
    b = love.graphics.newImage('T-54 turret .png')
    aw , ah = a:getDimensions()
    bw , bh = b:getDimensions()
    
    alpha = 0
    x = 500
    arrow = {
        x = 100,
        y = 100,
        speed = 0,
        maxspeed = 200,
        back_maxspeed = -80,
        backac = 10,
        ac = 40,
        stopac = 60,

        angle = 0,
        b_angle = 0,
        turnspeed = 0,
        b_turnspeed = 0,
        maxturnsp = 1,
        turnac = 0.6,
        stopturnac = 0.6,
        b_turnac = 1,
        b_maxturnsp = 2,
    }
end

function T54:update(dt)

    mx,my = love.mouse.getPosition()
    angle1 = math.atan2(my - arrow.y,mx - arrow.x)
    distance = math.sqrt((my - arrow.y)^2+(mx - arrow.x)^2)
    stopdis = arrow.speed ^ 2 / (arrow.stopac * 2)
    stopturndis = arrow.turnspeed ^ 2 / (arrow.stopturnac * 2)
    b_stopturndis = arrow.b_turnspeed ^ 2 / (arrow.b_turnac * 2)


    if arrow.maxturnsp*(-1)*0.6 > arrow.turnspeed or arrow.maxturnsp*0.6 < arrow.turnspeed then
        if distance <= arrow.maxspeed * 0.5 and distance >=2 then
            if arrow.speed >= 0 then
                arrow.speed = arrow.speed - ( arrow.stopac + arrow.ac ) * dt
            elseif arrow.speed >= arrow.back_maxspeed then
                arrow.speed = arrow.speed - ( arrow.backac + arrow.stopac ) * dt
            end
        else
            if arrow.speed >= arrow.maxspeed * 0.5 then 
                arrow.speed = arrow.speed - ( arrow.stopac + arrow.ac ) * dt
            end
        end
    end

    if arrow.angle < angle1 then
        if 3.14*2 - angle1 + arrow.angle > angle1 - arrow.angle then
            turndis = angle1 - arrow.angle
        else 
            turndis = 3.14*2 - angle1 + arrow.angle
        end
    else
        if 3.14*2 - arrow.angle + angle1 > arrow.angle - angle1 then
            turndis = arrow.angle - angle1
        else 
            turndis = 3.14*2 - arrow.angle + angle1
        end
    end


    if arrow.b_angle < angle1 then
        if 3.14*2 - angle1 + arrow.b_angle > angle1 - arrow.b_angle then
            b_turndis = angle1 - arrow.b_angle
        else 
            b_turndis = 3.14*2 - angle1 + arrow.angle
        end
    else
        if 3.14*2 - arrow.b_angle + angle1 > arrow.b_angle - angle1 then
            b_turndis = arrow.b_angle - angle1
        else 
            b_turndis = 3.14*2 - arrow.b_angle + angle1
        end
    end




    if arrow.speed < arrow.maxspeed and distance > stopdis + 10 then
        if arrow.speed >= 0 then
            arrow.speed = arrow.speed + arrow.ac * dt
        else
            arrow.speed = arrow.speed + arrow.stopac * dt
        end
    end

    if  distance < stopdis and arrow.speed >= 0 then
        arrow.speed = arrow.speed - arrow.stopac * dt
    end

    if distance < 2 then
        arrow.speed = 0
        arrow.turnspeed = 0   
    end
    
    if  turndis < stopturndis and arrow.turnspeed >= 0 then
        arrow.turnspeed = arrow.turnspeed - arrow.stopturnac * dt
    end
    if  turndis < stopturndis and arrow.turnspeed <= 0 then
        arrow.turnspeed = arrow.turnspeed + arrow.stopturnac * dt
    end

    -- if distance <= arrow.maxspeed * 0.5 and distance >=2 then
    --     if  turndis < stopturndis and arrow.turnspeed >= 0 then
    --         arrow.turnspeed = arrow.turnspeed - arrow.stopturnac * dt
    --     end
    --     if  turndis < stopturndis and arrow.turnspeed <= 0 then
    --         arrow.turnspeed = arrow.turnspeed + arrow.stopturnac * dt
    --     end
    -- else
    --     if  turndis < stopturndis and arrow.turnspeed >= 0 then
    --         arrow.turnspeed = arrow.turnspeed - arrow.stopturnac * dt
    --     end
    --     if  turndis < stopturndis and arrow.turnspeed <= 0 then
    --         arrow.turnspeed = arrow.turnspeed + arrow.stopturnac * dt
    --     end
    -- end
    


    if arrow.b_turnspeed < arrow.b_maxturnsp and b_turndis > b_stopturndis then
        arrow.b_turnspeed = arrow.b_turnspeed + arrow.b_turnac * dt
    end

    if  b_turndis < b_stopturndis and arrow.b_turnspeed >= 0 then
        arrow.b_turnspeed = arrow.b_turnspeed - arrow.b_turnac * dt
    end

    
    m = turndis - stopturndis

    if arrow.angle < angle1 then 
        if 3.14*2 - angle1 + arrow.angle > angle1 - arrow.angle then
            if arrow.turnspeed < arrow.maxturnsp and turndis > stopturndis then
                arrow.turnspeed = arrow.turnspeed + arrow.turnac * dt
            end
            arrow.angle = arrow.angle + arrow.turnspeed * dt
        else 
            if arrow.turnspeed < arrow.maxturnsp and turndis > stopturndis then
                if arrow.turnspeed >= 0 then
                    arrow.turnspeed = arrow.turnspeed - arrow.stopturnac * dt
                else
                    arrow.turnspeed = arrow.turnspeed - arrow.turnac * dt
                end
            end
            arrow.angle = arrow.angle + arrow.turnspeed * dt
        end
    else
        if 3.14*2 - arrow.angle + angle1 > arrow.angle - angle1 then
            if arrow.turnspeed < arrow.maxturnsp and turndis > stopturndis then
                arrow.turnspeed = arrow.turnspeed - arrow.turnac * dt
            end
            arrow.angle = arrow.angle + arrow.turnspeed * dt
        else 
            if arrow.turnspeed < arrow.maxturnsp and turndis > stopturndis then
                if arrow.turnspeed <= 0 then
                    arrow.turnspeed = arrow.turnspeed + arrow.stopturnac * dt
                else
                    arrow.turnspeed = arrow.turnspeed + arrow.turnac * dt
                end
            end
            arrow.angle = arrow.angle + arrow.turnspeed * dt
        end
    end


    if arrow.b_angle < angle1 then 
        if 3.14*2 - angle1 + arrow.b_angle > angle1 - arrow.b_angle then
            arrow.b_angle = arrow.b_angle + arrow.b_turnspeed * dt
        else 
            arrow.b_angle = arrow.b_angle - arrow.b_turnspeed * dt
        end
    else
        if 3.14*2 - arrow.b_angle + angle1 > arrow.b_angle - angle1 then
            arrow.b_angle = arrow.b_angle - arrow.b_turnspeed * dt
        else 
            arrow.b_angle = arrow.b_angle + arrow.b_turnspeed * dt
        end
    end



    if arrow.angle <= -3.14 then 
        arrow.angle = arrow.angle + 3.14*2
    end

    if arrow.angle >= 3.14 then 
        arrow.angle = arrow.angle - 3.14*2
    end


    if arrow.b_angle <= -3.14 then 
        arrow.b_angle = arrow.b_angle + 3.14*2
    end

    if arrow.b_angle >= 3.14 then 
        arrow.b_angle = arrow.b_angle - 3.14*2
    end

    
    cos = math.cos(arrow.angle)
    sin = math.sin(arrow.angle)

    arrow.y = arrow.y + arrow.speed * sin * dt
    arrow.x = arrow.x + arrow.speed * cos * dt
end    

function T54:draw()
    
    love.graphics.print('angle: '..angle1,10,10)
    love.graphics.print('angle: '..arrow.angle,10,25)
    love.graphics.print('speed: '..arrow.speed,10,40)
    love.graphics.print('turndistance: '..m,10,70)
    love.graphics.print('turnspeed: '..arrow.turnspeed,10,55)

    
    love.graphics.draw(a,arrow.x,arrow.y,arrow.angle + 1.57,0.2,0.2,aw/2,ah/2)
    love.graphics.draw(b,arrow.x,arrow.y,arrow.b_angle + 1.57,0.2,0.2,bw/2,bh/2)
end