t1_Tank = {}
t1_tanks = {}
t1_tank = {}
t1_tank.__index = t1_tanks

local tank_world = require 'world'



function t1_tanks.new()
    local instance = setmetatable({}, t1_tank)
    return instance
end

function t1_tanks:load()
    entity_tank = t_tanks.new()
    local entitis = tank_world:creat_tank()
    tank_world:register(entity_tank:new_renderer_system())
    entitis:add(entity_tank:new_bodywork('MAUS hull.png'))
    entitis:add(entity_tank:new_location(100, 100))
end