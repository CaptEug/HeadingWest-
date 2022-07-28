require 'chapters/Berlin'
require 'playCG'


function love.load()
    Berlin:load()

    Center = {
        x = love.graphics.getWidth() / 2, 
        y = love.graphics.getWidth() / 2
    }
end
 


function love.update(dt)
    CG1:playCG(dt)

    Berlin:update(dt)
    
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
end



function love.draw()
    Berlin:draw()
end
