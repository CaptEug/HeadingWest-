T54 = {}

function T54:load()
    a = love.graphics.newImage('T-5455hullbody.png')
    aw , ah = a:getDimensions()
    arrow = {
        x = 100,
        y = 100,
        speed = 0,
        maxspeed = 100,
        ac = 30,

        angle = 0,
        turnspeed = 0,
        maxturnsp = 0.8,
        turnac = 0.3,
    }
end

function T54:update(dt)
    mx,my = love.mouse.getPosition()
    angle1 = math.atan2(my - arrow.y,mx - arrow.x)
    distance = math.sqrt((my - arrow.y)^2+(mx - arrow.x)^2)
    stopdis = arrow.speed ^ 2 / (arrow.ac * 2)
    stopturndis = arrow.turnspeed ^ 2 / (arrow.turnac * 2)


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

    if arrow.speed < arrow.maxspeed and distance > stopdis + 10 then
        arrow.speed = arrow.speed + arrow.ac * dt
    end

    if  distance < stopdis and arrow.speed >= 0 then
        arrow.speed = arrow.speed - arrow.ac * dt
    end

    if distance < 2 then
        arrow.speed = 0
        arrow.turnspeed = 0
    end
    

    if arrow.turnspeed < arrow.maxturnsp and turndis > stopturndis + 0.1 then
        arrow.turnspeed = arrow.turnspeed + arrow.turnac * dt
    end

    if  turndis < stopturndis and arrow.turnspeed >= 0 then
        arrow.turnspeed = arrow.turnspeed - arrow.turnac * dt
    end

   
    if arrow.angle < angle1 then 
        if 3.14*2 - angle1 + arrow.angle > angle1 - arrow.angle then
            arrow.angle = arrow.angle + arrow.turnspeed * dt
        else 
            arrow.angle = arrow.angle - arrow.turnspeed * dt
        end
    else
        if 3.14*2 - arrow.angle + angle1 > arrow.angle - angle1 then
            arrow.angle = arrow.angle - arrow.turnspeed * dt
        else 
            arrow.angle = arrow.angle + arrow.turnspeed * dt
        end
    end



    if arrow.angle <= -3.14 then 
        arrow.angle = arrow.angle + 3.14*2
    end

    if arrow.angle >= 3.14 then 
        arrow.angle = arrow.angle - 3.14*2
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
    love.graphics.print('turnspeed: '..arrow.turnspeed,10,55)
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(a,arrow.x,arrow.y,arrow.angle + 1.57,0.2,0.2,aw/2,ah/2)
end