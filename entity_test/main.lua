local t_world = require 'world'
local Component = require "tank_component"
local System = require "tank_system"
local coms = require  "common_componet"



function new_renderer_system()
    local render = System.new {"location", "bodywork"}
    function render:load(entity) 
        print("found one!")
    end

    function render:draw(entity) 
        local bodywork = entity:get "bodywork"
        local location = entity:get "location"
        love.graphics.rectangle("fill", location.x, location.y, 32, 32)
    end
    return render
end


function new_functional_system()
    local system = System.new {"functional"}
    function system:load(entity) 
        print("found one!")
    end

    function system:update(dt, entity) 
        local fn = entity:get ("functional").fn
        fn(entity, dt)
    end
    return system
end

function love.load()
    
    t_world:register(new_renderer_system())
    t_world:register(new_functional_system())


    t_world:create_tank()
        :madd(coms.new_bodywork('MAUS hull.png'))
        :madd(coms.new_location(500, 100))

    local test = t_world:assemble{
        {coms.new_location, 100, 100},
        {coms.new_bodywork, 'MAUS hull.png'}
    }
    test:add(coms.functional(function(self, dt)
        local body = self:get "location"
        body.x = body.x + dt*20
    end))
end

function love.update(dt)
    t_world:update(dt)
end

function love.draw()
    t_world:draw()
end