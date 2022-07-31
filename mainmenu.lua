mainmenu = {}



function mainmenu:load()
    Europe = love.graphics.newImage('Europe.png')
    love.graphics.setFont(love.graphics.newFont('Russian.ttf', 50))
end



function mainmenu:update()
end



function mainmenu:draw()
    cam:attach()
        love.graphics.draw(Europe, 0, 0)
    cam:detach()
    love.graphics.print("НА ЗАПАД!", love.graphics.getWidth() / 2, love.graphics.getHeight() / 4)
end