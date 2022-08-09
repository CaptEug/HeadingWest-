local t_world = require 'world'
local Component = require "tank_component"
local System = require "tank_system"



t_Tank = {}
t_tanks = {}
t_tank = {}
t_tank.__index = t_tanks

function t_tanks.new()
    local instance = setmetatable({}, t_tank)
    return instance
end

function t_tanks:new_location(x, y)
    local location = Component.new "location"
    location.x = x
    location.y = y
    return location
end

function t_tanks:new_bodywork(bodywork_path)
    local bodywork = Component.new "bodywork"
    bodywork.picture = love.graphics.newImage(bodywork_path)
    return bodywork
end

function t_tanks:new_renderer_system()
    local render = System.new {"location", "location"}
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

-- function t_tanks:load()
--     local entitis = t_world:creat_tank()
--     t_world:register(t_tanks:new_renderer_system())
--     entitis:add(t_tanks:new_bodywork('MAUS hull.png'))
--     entitis:add(t_tanks:new_location(100, 100))
-- end

function t_tanks:update(dt)
    t_world:update(dt)
end

function t_tanks:draw()
    t_world:draw()
end