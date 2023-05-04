TestT = {}

local pic
local time =0

function TestT:load()
    pic = love.graphics.newImage('Assets/maps/berlintiles.png')
    love.graphics.draw(pic)
end

function TestT:update(dt)
    time = time + 1
end

function TestT:draw()
    love.graphics.draw(pic)
    love.graphics.print(tostring(time),0,250)
end

TestT:draw()