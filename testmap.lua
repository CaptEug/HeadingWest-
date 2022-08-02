testmap = {}
testmap = Gamestate.new()
require 'Tank'

local buttons = {}

function buttons.newButton(text, fn)
    local instance = {
            text = text,
            fn = fn,
            w = Rbuttonfont:getWidth(text),
            h = Rbuttonfont:getHeight(text),
            now = false,
            last = false
    }
    table.insert(buttons, instance)
    return instance
end

function buttons:use()
    for k, button in ipairs(buttons) do
        local ButtonColor = {1, 1, 1, 0.5}
        local bx = 0
        local by = 0
        local mx, my = love.mouse.getPosition()
        local Hot = mx>=bx and mx<=bx+button.w and my>=by and my<=by+button.h
        
        love.graphics.setFont(Rbuttonfont)
        
        if Hot then
            ButtonColor ={1, 0.2, 0.2, 1}
        end
        
        if love.mouse.isDown(1) and Hot then
            button.fn()
        end
        
        love.graphics.setColor(unpack(ButtonColor))
        love.graphics.print(button.text, bx, by)
    end
    love.graphics.setColor(1, 1, 1)
end

function testmap:init()
    sti = require 'libraries/sti'
    gamemap = sti('chapters/maps/checkpointC.lua')
    spike_image=love.graphics.newImage('objects/Spike1.png')
    wf = require 'libraries/windfield'
    world = wf.newWorld(0, 0)
    
    Back = buttons.newButton(
        "Back",
        function()
            Gamestate.switch(MainMenu)
        end
    )

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



function testmap:update(dt)
    world:update(dt)
    MAUS1:move(dt)
end


function testmap:draw()
    buttons:use()
    
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