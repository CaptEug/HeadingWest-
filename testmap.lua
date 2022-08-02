testmap = {}
testmap = Gamestate.new()
require 'Tank'
require 'SetSpikes'


function testmap:init()
    sti = require 'libraries/sti'
    gamemap = sti('chapters/maps/checkpointC.lua')
    spike_image=love.graphics.newImage('objects/Spike1.png')
    wf = require 'libraries/windfield'
    world = wf.newWorld(0, 0)
    
    Gbuttons = buttons.new()
    Back = buttons.newButton(
        "Back",
        function()
            Gamestate.switch(MainMenu)
        end,
        Gbuttons
    )

    walls = {}
    if gamemap.layers["wall"] then
        for i, obj in pairs(gamemap.layers["wall"].objects) do
            local wall = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            wall:setType('static')
            table.insert(walls, wall)
        end
    end
    
    SetSpikes:get()
    --[[Spike_data={}
    Spike_data.collision={}
    Spike_data.width=128
    Spike_data.height=128

    if gamemap.layers["Spike"] then
        for i, j in pairs(gamemap.layers["Spike"].objects) do
            Spike_data.collision[i] = world:newRectangleCollider(j.x, j.y, j.width, j.height)
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



function testmap:update(dt)
    world:update(dt)
    MAUS1:move(dt)
end


function testmap:draw()
    Gbuttons:use()
    
    cam:attach()
        --gamemap:drawLayer(gamemap.layers["ground"])
        MAUS1:use()
        --gamemap:drawLayer(gamemap.layers["veg"])
        --gamemap:drawLayer(gamemap.layers["top"])
        world:draw()
        SetSpikes:draw()
        --[[for i in pairs(Spike_data.collision)do
            local spike_x,spike_y=Spike_data.collision[i]:getPosition()
            local spike_angle=Spike_data.collision[i]:getAngle()
            love.graphics.draw(spike_image,spike_x,spike_y,spike_angle,0.5,0.5,Spike_data.width,Spike_data.height)
        end--]]
    cam:detach()
end