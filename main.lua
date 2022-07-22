require("T54")

function love.load()
    video = love.graphics.newVideo("OP.ogv")
    video:play()
    widthVideo, heightVideo = video:getDimensions()
    
    logo = love.graphics.newImage("StudioLogo.png")
    widthlogo, heightlogo = logo:getDimensions()
    
    gamefont = love.graphics.newFont("Russian.ttf", 50)
    
    alpha = 0
   
    T54:load()
end
 


function love.update(dt)
   
    time = love.timer.getTime()
   
    if time > 25 then
        if alpha <= 1 then
        alpha = alpha + 0.05 * dt
        end
    end 
    
    if time > 50 then
        if alpha > 0 then
        alpha = alpha - 0.15 * dt
        end
    end 
    
    T54:update(dt)
end



function love.draw()
    
    love.graphics.setColor(1, 1, 1)
    
    if love.graphics.getWidth() / love.graphics.getHeight() < 720 / 480 then
        love.graphics.draw(
            video,
            0,
            love.graphics.getHeight() / 2 - (heightVideo * love.graphics.getWidth())/ (2 * widthVideo),
            0,
            love.graphics.getWidth() / widthVideo
        )   
    else
        love.graphics.draw(
            video,
            love.graphics.getWidth() / 2 - (widthVideo * love.graphics.getHeight())/ (2 * heightVideo),
            0,
            0,
            love.graphics.getHeight() / heightVideo
        )
    end
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.print('time: '..time, 10, 0)

    love.graphics.setColor(1, 1, 1, alpha)
    
    if love.graphics.getWidth() / love.graphics.getHeight() < 2732 / 2048 then
        love.graphics.draw(
            logo,
            0,
            love.graphics.getHeight() / 2 - (heightlogo * love.graphics.getWidth()) / (2 * widthlogo),
            0,
            love.graphics.getWidth() / widthlogo
        )
    else
        love.graphics.draw(
            logo,
            love.graphics.getWidth() / 2 - (widthlogo * love.graphics.getHeight()) / (2 * heightlogo),
            0,
            0,
            love.graphics.getHeight() / heightlogo
        )
    end
    
    love.graphics.setColor(1, 1, 1)
    T54:draw()
end







