require("Tank")

function love.load()
    camera = require 'libraries/camera'
    cam = camera()
    sti = require 'libraries/sti'
    gamemap = sti('maps/Berlin1.lua')
    
    video = love.graphics.newVideo("OP.ogv")
    --video:play()
    widthVideo, heightVideo = video:getDimensions()
    
    logo = love.graphics.newImage("StudioLogo.png")
    widthlogo, heightlogo = logo:getDimensions()
    
    gamefont = love.graphics.newFont("Russian.ttf", 50)
    
    alpha = 0
   
    Tank:load()

    Center = {
        x = love.graphics.getWidth() / 2, 
        y = love.graphics.getWidth() / 2
    }
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
    
    Tank:update(dt)

    if love.keyboard.isDown("w") then
        Center.y = Center.y - 5
    end
    if love.keyboard.isDown("s") then
        Center.y = Center.y + 5
    end
    if love.keyboard.isDown("a") then
        Center.x = Center.x - 5
    end
    if love.keyboard.isDown("d") then
        Center.x = Center.x + 5
    end
        
    cam:lookAt(Center.x, Center.y)
    
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    if Center.x < w / 2 then
        Center.x = w / 2
    end
    if Center.y < h / 2 then
        Center.y = h / 2
    end
    local mapw, maph = gamemap.width * gamemap.tilewidth, gamemap.height * gamemap.tileheight
    if Center.x > (mapw - w / 2) then
        Center.x =(mapw - w / 2) 
    end
    if Center.y > (maph - h / 2) then
        Center.y =(maph - h / 2)
    end 
    
    function love.wheelmoved(x, y)
        if y > 0 then
            cam:zoom(1.1)
        elseif y < 0 then
            cam:zoom(0.9)
        end
    end
    
    if love.graphics.getWidth() > mapw then
            cam:zoomto(mapw)
    end

end



function love.draw()
    
--    love.graphics.setColor(1, 1, 1)
    
--    if love.graphics.getWidth() / love.graphics.getHeight() < 720 / 480 then
--        love.graphics.draw(
--            video,
--            0,
--            love.graphics.getHeight() / 2 - (heightVideo * love.graphics.getWidth())/ (2 * widthVideo),
--            0,
--            love.graphics.getWidth() / widthVideo
--        )   
--    else
--        love.graphics.draw(
--            video,
--            love.graphics.getWidth() / 2 - (widthVideo * love.graphics.getHeight())/ (2 * heightVideo),
--            0,
--            0,
--            love.graphics.getHeight() / heightVideo
--        )
--    end
    
--    love.graphics.setColor(1, 1, 1)
--    love.graphics.print('time: '..time, 10, 0)

--    love.graphics.setColor(1, 1, 1, alpha)
    
--    if love.graphics.getWidth() / love.graphics.getHeight() < 2732 / 2048 then
--        love.graphics.draw(
--            logo,
--            0,
--            love.graphics.getHeight() / 2 - (heightlogo * love.graphics.getWidth()) / (2 * widthlogo),
--            0,
--            love.graphics.getWidth() / widthlogo
--        )
--    else
--        love.graphics.draw(
--            logo,
--            love.graphics.getWidth() / 2 - (widthlogo * love.graphics.getHeight()) / (2 * heightlogo),
--            0,
--            0,
--            love.graphics.getHeight() / heightlogo
--        )
--    end
    
    love.graphics.setColor(1, 1, 1)
    
    cam:attach()
        gamemap:drawLayer(gamemap.layers["Ground"])
        Tank:draw()
    cam:detach()    
end







