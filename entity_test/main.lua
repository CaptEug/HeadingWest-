local t_world = require 'world'
local Component = require "tank_component"
local System = require "tank_system"





function new_location(x, y)
    local location = Component.new "location"
    location.x = x
    location.y = y
    return location
end

function new_bodywork(bodywork_path)
    local bodywork = Component.new "bodywork"
    bodywork.picture = love.graphics.newImage(bodywork_path)
    return bodywork
end

function new_renderer_system()
    local render = System.new {"location", "bodywork"}
    function render:load(entity) 
        print("found one!")
    end

    function render:draw(entity) 
        local bodywork = entity:get "bodywork"
        local location = entity:get "location"
        love.graphics.draw(bodywork.picture, location.x, location.y,0, 0.2, 0.2)
    end
    return render
end

function load()
    local entitis = t_world:creat_tank()
    t_world:register(new_renderer_system())
    entitis:add(new_bodywork('MAUShull.png'))
    entitis:add(new_location(100, 100))
end

function update(dt)
    t_world:update(dt)
end

function draw()
    t_world:draw()
end