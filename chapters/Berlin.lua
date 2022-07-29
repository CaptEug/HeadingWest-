Berlin = {}
require 'Tank'



function Berlin:load()
    sti = require 'libraries/sti'
    gamemap = sti('chapters/maps/checkpointC.lua')

    wf = require 'libraries/windfield'
    world = wf.newWorld(0, 0)
    walls = {}
    if gamemap.layers["wall"] then
        for i, obj in pairs(gamemap.layers["wall"].objects) do
            local wall = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            wall:setType('static')
            table.insert(walls, wall)
        end
    end
    
    Tank:load()
end



function Berlin:update(dt)
    world:update(dt)
    Tank:update(dt)
end



function Berlin:draw()
    cam:attach()
        --gamemap:drawLayer(gamemap.layers["ground"])
        Tank:draw()
        --gamemap:drawLayer(gamemap.layers["veg"])
        --gamemap:drawLayer(gamemap.layers["top"])
        world:draw()
    cam:detach()
end