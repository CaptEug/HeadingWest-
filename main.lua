require("T54")

function love.load()
    video = love.graphics.newVideo("OP.ogv")
    --video:play()
    widthVideo, heightVideo = video:getDimensions()
    
    logo = love.graphics.newImage("planetware.png")
    width, height = logo:getDimensions()
    
    gamefont = love.graphics.newFont("Russian.ttf", 50)
    
    alpha = 0
   
    T54:load()
end
 
function love.update(dt)
   
    time = love.timer.getTime()
   
    if time > 25 then
        if alpha <= 0.7 then
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
    --love.graphics.setColor(1, 1, 1)
    --love.graphics.draw(video,love.graphics.getWidth()/ 2 - widthVideo/ 2, love.graphics.getHeight()/ 2 - heightVideo/ 2)
    

    --if time > 5 then
        --love.graphics.setColor(1, 0, 0, alpha)
        --love.graphics.draw(logo,love.graphics.getWidth()/ 2 - width/ 10, love.graphics.getHeight()/ 2 - height/ 10, 0, 0.2, 0.2)
    --end



    T54:draw()
end



