mainmenu = {}



function mainmenu:load()
    Europe = love.graphics.newImage('Europe.png')
    love.graphics.setFont(love.graphics.newFont('Russian.ttf', 100))
end



function mainmenu:update()
end



function mainmenu:draw()
    love.graphics.setColor(1, 0, 0)
    cam:attach()
        love.graphics.draw(Europe, 0, 0)
    cam:detach()
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("НА ЗАПАД!", (love.graphics.getWidth() / 2)-170, love.graphics.getHeight() / 4)
end