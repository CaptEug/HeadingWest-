function love.load()
    love.window.setTitle("На запад!")
    
    video = love.graphics.newVideo("iron curtain.ogv")
    video:play()
    widthVideo, heightVideo = video:getDimensions()
    
    logo = love.graphics.newImage("planetware.png")
    width, height = logo:getDimensions()
    
    
    gamefont = love.graphics.newFont("Russian.ttf", 50)
    
    
    
    alpha = 0
    x = 500
end
 
function love.update(dt)
    x = x - 100 * dt
   
    if alpha <= 0.7 then
        alpha = alpha + 0.05 * dt
    end
end    

function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(video,love.graphics.getWidth()/ 2 - widthVideo/ 2, love.graphics.getHeight()/ 2 - heightVideo/ 2)
    
    love.graphics.setColor(1, 0, 0, alpha)
    love.graphics.draw(logo,love.graphics.getWidth()/ 2 - width/ 10, love.graphics.getHeight()/ 2 - height/ 10, 0, 0.2, 0.2)

    
    love.graphics.setColor(1, 0, 0)
    love.graphics.setFont(gamefont, 50)
    love.graphics.print("На запад!", x)
end