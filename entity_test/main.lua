local t_world = require 'world'
local Component = require "tank_component"
local System = require "tank_system"

function new_body(x, y)
    local body = Component.new "body"
    body.x = x
    body.y = y
    return body
end

function new_rectangle_component()
    return Component.new "rect"
end

function new_renderer_system()
    local render = System.new {"body", "rect"}
    function render:load(entity) 
        print("found one!")
    end

    function render:draw(entity) 
        local body = entity:get "body"
        love.graphics.rectangle("fill", body.x, body.y, 32, 32)
    end
    return render
end

function love.load()
    t_world:register(new_renderer_system())
    local entity = t_world:creat_tank()
    entity:add(new_body(100, 100))
    entity:add(new_rectangle_component())
end

function love.update(dt)
    t_world:update(dt)
end

function love.draw()
    t_world:draw()
end