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
    Spike_data.collision=world:newRectangleCollider(1664, 384, 128, 128)
    Spike_data.width=128
    Spike_data.height=128

    --[[if gamemap.layers["Spike"] then
        for i, obj in pairs(gamemap.layers["Spike"].objects) do
            local Spike = {world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)}
            table.insert(Spikes, Spike)
        end
    end
    --]]
    MAUS1 = tanks.new(
    'mause',
    400,
    500,
    0,
    0,
    'tanks/german/MAUS/MAUS turret.png',
    'tanks/german/MAUS/MAUS hull_1.png',
    27,
    200,
    40,
    30,
    20,
    150,
    0.8,
    0.3,
    0.7,
    0.5,
    0.4,
    0.8
    )
    MAUS1:creat()
end



function Berlin:update(dt)
    world:update(dt)
    MAUS1:move(dt)
end


function Berlin:draw()
    cam:attach()
        --gamemap:drawLayer(gamemap.layers["ground"])
        MAUS1:use()
        --gamemap:drawLayer(gamemap.layers["veg"])
        --gamemap:drawLayer(gamemap.layers["top"])
        world:draw()
        --[[for i, obj in pairs(Spike_data.location) do
            love.graphics.draw(spike_image,obj.x,obj.y,0,0.5,0.5)
        end--]]
        local spike_x,spike_y=Spike_data.collision:getPosition()
        local spike_angle=Spike_data.collision:getAngle()
        love.graphics.draw(spike_image,spike_x,spike_y,spike_angle,0.5,0.5,128,128)
    cam:detach()
end