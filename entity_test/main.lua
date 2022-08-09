require "abc"
require "efg"

function love.load()
    amp = t_tanks.new()
    component_tank = t1_tanks.new()
    component_tank:load()
end

function love.update(dt)
    amp:update(dt)
end

function love.draw()
    amp:draw()
end