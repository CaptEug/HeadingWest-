Berlin = {}
require 'Tank'



function Berlin:load()
    sti = require 'libraries/sti'
    gamemap = sti('chapters/maps/checkpointC.lua')
    spike_image=love.graphics.newImage('objects/Spike1.png')
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
    Spikes={}
    Spike_data={}
    Spike_data.x=0
    Spike_data.y=0
    if gamemap.layers["Spike"] then
        for i, obj in pairs(gamemap.layers["Spike"].objects) do
            local Spike = {world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)}
            table.insert(Spikes, Spike)
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
        for i, obj in ipairs(gamemap.layers["Spike"].objects) do
            love.graphics.draw(spike_image,obj.x,obj.y,0,0.5,0.5)
        end
    cam:detach()
end