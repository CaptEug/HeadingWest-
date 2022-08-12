local t_world = require 'world'
local Component = require "tank_component"
local coms = require  "common_componet"
local syfn = require  "tank_sy_fn"
wf = require 'windfield'

world = wf.newWorld(0, 0)




function love.load()
    
    t_world:register(syfn.new_renderer_system())
    t_world:register(syfn.new_functional_system())


    t_world:create_tank()
        :madd(coms.new_bodywork('MAUS hull.png'))
        :madd(coms.new_location(500, 300))

    local test = t_world:assemble{
        {coms.new_location, 100, 300},
        {coms.new_bodywork, 'MAUS hull.png'}
    } 
    test:add(coms.functional(function(self, dt)
        local bodywork = self:get "bodywork"
        bodywork.hitbox:setLinearVelocity(100, 0)
    end))
end

function love.update(dt)
    t_world:update(dt)
    world:update(dt)
end

function love.draw()
    t_world:draw()
    world:draw()
end