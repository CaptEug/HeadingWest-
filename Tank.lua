Tank = {}

function Tank:load(tank)
    a = love.graphics.newImage('tanks/german/MAUS/MAUS hull_1.png')
    b = love.graphics.newImage('tanks/german/MAUS/MAUS turret.png')
    aw , ah = a:getDimensions()
    bw , bh = b:getDimensions()
    
    
    arrow = {
        x = 500,
        y = 500,
        z = 27,
        speed = 0,
        maxspeed = 100,
        back_maxspeed = 40,
        backac = 10,
        ac = 20,
        stopac = 50,

        angle = 1.57,
        b_angle = 0,
        turnspeed = 0,
        b_selfturnspeed = 0,
        maxturnsp = 0.5,
        turnac = 0.1,
        stopturnac = 0.5,
        b_turnac = 0.2,
        b_stopturnac = 0.6,
        b_maxturnsp = 0.3,
    }
    arrow.tankbox = world:newRectangleCollider(400, 600, aw*0.2, ah*0.2)
    arrow.tankbox:setFixedRotation(true)
    va = 0 
    vb = 0
    vc = 0
end

function Tank:update(dt)
    if love.keyboard.isDown('up') then
        if arrow.speed<arrow.maxspeed then
            arrow.speed=arrow.speed+arrow.ac*dt
        end
    else
        if arrow.speed>0 then
            if arrow.speed>-0.1 and arrow.speed<0.1 then
                arrow.speed = 0
            end
            arrow.speed=arrow.speed-arrow.stopac*dt
        end
    end

    if love.keyboard.isDown('down') then
        if arrow.speed>-arrow.back_maxspeed then
            arrow.speed=arrow.speed-arrow.backac*dt
        end
    else
        if arrow.speed<0 then
            if arrow.speed>-0.1 and arrow.speed<0.1 then
                arrow.speed = 0
            end
            arrow.speed=arrow.speed+arrow.stopac*dt
        end
    end
    
    if love.keyboard.isDown('left') then
        if arrow.turnspeed>-arrow.maxturnsp then
            arrow.turnspeed=arrow.turnspeed-arrow.turnac*dt
        end
    else
        if arrow.turnspeed<0 then
            if arrow.turnspeed>-0.1 and arrow.turnspeed<0.1 then
                arrow.turnspeed = 0
            end
            arrow.turnspeed=arrow.turnspeed+arrow.stopturnac*dt
        end
    end

    if love.keyboard.isDown('right') then
        if arrow.turnspeed<arrow.maxturnsp then
            arrow.turnspeed=arrow.turnspeed+arrow.turnac*dt
        end
    else
        if arrow.turnspeed>0 then
            if arrow.turnspeed>-0.1 and arrow.turnspeed<0.1 then
                arrow.turnspeed = 0
            end
            arrow.turnspeed=arrow.turnspeed-arrow.stopturnac*dt
        end
    end
    --[[b_turnspeed = arrow.b_selfturnspeed + arrow.turnspeed
    mx,my = love.mouse.getPosition()
    angle1 = math.atan2(my - arrow.y,mx - arrow.x)
    distance = math.sqrt((my - arrow.y)^2+(mx - arrow.x)^2)
    stopdis = arrow.speed ^ 2 / (arrow.stopac * 2)
    stopturndis = arrow.turnspeed ^ 2 / (arrow.stopturnac * 2)
    b_stopturndis = arrow.b_selfturnspeed ^ 2 / (arrow.b_stopturnac * 2) + stopturndis
    
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

    if  b_turndis < b_stopturndis and arrow.b_selfturnspeed >= 0 then
        arrow.b_selfturnspeed = arrow.b_selfturnspeed - arrow.b_stopturnac * dt
    end
    if  b_turndis < b_stopturndis and arrow.b_selfturnspeed <= 0 then
        arrow.b_selfturnspeed = arrow.b_selfturnspeed + arrow.b_stopturnac * dt
    end


    
    
    m = b_turndis - b_stopturndis

    if arrow.angle < angle1 then 
        if 3.14*2 - angle1 + arrow.angle > angle1 - arrow.angle then
            if arrow.turnspeed < arrow.maxturnsp and turndis > stopturndis and arrow.turnspeed > arrow.maxturnsp * (-1) then
                arrow.turnspeed = arrow.turnspeed + arrow.turnac * dt
            end
            arrow.angle = arrow.angle + arrow.turnspeed * dt
        else 
            if arrow.turnspeed < arrow.maxturnsp and turndis > stopturndis and arrow.turnspeed > arrow.maxturnsp * (-1) then
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
            if arrow.turnspeed < arrow.maxturnsp and turndis > stopturndis and arrow.turnspeed > arrow.maxturnsp * (-1) then
                arrow.turnspeed = arrow.turnspeed - arrow.turnac * dt
            end
            arrow.angle = arrow.angle + arrow.turnspeed * dt
        else 
            if arrow.turnspeed < arrow.maxturnsp and turndis > stopturndis and arrow.turnspeed > arrow.maxturnsp * (-1) then
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
            if arrow.b_selfturnspeed < arrow.b_maxturnsp and b_turndis > b_stopturndis and arrow.b_selfturnspeed > arrow.b_maxturnsp * (-1) then
                arrow.b_selfturnspeed = arrow.b_selfturnspeed + arrow.b_turnac * dt
            end
            arrow.b_angle = arrow.b_angle + b_turnspeed * dt
        else 
            if arrow.b_selfturnspeed < arrow.b_maxturnsp and b_turndis > b_stopturndis and arrow.b_selfturnspeed > arrow.b_maxturnsp * (-1) then
                if arrow.b_selfturnspeed >= 0 then
                    arrow.b_selfturnspeed = arrow.b_selfturnspeed - arrow.b_stopturnac * dt
                else
                    arrow.b_selfturnspeed = arrow.b_selfturnspeed - arrow.b_turnac * dt
                end
            end
            arrow.b_angle = arrow.b_angle + b_turnspeed * dt
        end
    else
        if 3.14*2 - arrow.angle + angle1 > arrow.angle - angle1 then
            if arrow.b_selfturnspeed < arrow.b_maxturnsp and b_turndis > b_stopturndis and arrow.b_selfturnspeed > arrow.b_maxturnsp * (-1) then
                arrow.b_selfturnspeed = arrow.b_selfturnspeed - arrow.b_turnac * dt
            end
            arrow.b_angle = arrow.b_angle + b_turnspeed * dt
        else 
            if arrow.b_selfturnspeed < arrow.b_maxturnsp and b_turndis > b_stopturndis and arrow.b_selfturnspeed > arrow.b_maxturnsp * (-1) then
                if arrow.b_selfturnspeed <= 0 then
                    arrow.b_selfturnspeed = arrow.b_selfturnspeed + arrow.b_stopturnac * dt
                else
                    arrow.b_selfturnspeed = arrow.b_selfturnspeed + arrow.b_turnac * dt
                end
            end
            arrow.b_angle = arrow.b_angle + b_turnspeed * dt
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
    end]]--

    
    cos = math.cos(arrow.angle)
    sin = math.sin(arrow.angle)



    --arrow.y = arrow.y + arrow.speed * sin * dt
    --arrow.x = arrow.x + arrow.speed * cos * dt

    xb = arrow.tankbox:getX() - arrow.z * sin
    yb = arrow.tankbox:getY() + arrow.z * cos

    va =  arrow.speed * sin
    vb =  arrow.speed * cos * -1

    arrow.x = arrow.tankbox:getX() 
    arrow.y = arrow.tankbox:getY() 

    arrow.angle = arrow.tankbox:getAngle()

    vc = arrow.turnspeed
    

    arrow.tankbox:setLinearVelocity(va , vb)
    arrow.tankbox:setAngularVelocity(vc)
end    

function Tank:draw()
    
    love.graphics.print('aw: '..aw,10,10)
    love.graphics.print('ah: '..arrow.angle,10,25)
    love.graphics.print('va: '..va,10,40)
    love.graphics.print('vb: '..vb,10,70)
    love.graphics.print('turnspeed: '..arrow.turnspeed,10,55)

    
    love.graphics.draw(a,arrow.x,arrow.y,arrow.angle  ,0.2,0.2,aw/2,ah/2)
    love.graphics.draw(b,xb,yb,arrow.b_angle ,0.2,0.2,bw/2,bh/2)
end