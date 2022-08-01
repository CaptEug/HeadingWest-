camera = require 'libraries/camera'
cam = camera()
Gamestate = require "libraries/gamestate"
require 'MainMenu'
require 'CGplayer'
require 'shader'
require 'testmap'

function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(MainMenu)
    Europe = love.graphics.newImage('Europe.png')
    EUw, EUh = Europe:getDimensions()
    shader = love.graphics.newShader(shader_code)
    
    cg1 = CG.new('CGs/OP.ogv')
    
    Center = {
        x = love.graphics.getWidth() / 2, 
        y = love.graphics.getWidth() / 2
    }
end



function love.update(dt)
    ww, wh = love.graphics.getDimensions()
    local cx, cy = cam:position()
    
    if love.keyboard.isDown("w") then
        cam:move(0,-5)
    end
    if love.keyboard.isDown("s") then
        cam:move(0,5)
    end
    if love.keyboard.isDown("a") then
        cam:move(-5,0)
    end
    if love.keyboard.isDown("d") then
        cam:move(5,0)
    end
    function love.wheelmoved(x, y)
        if y > 0 then
            cam:zoom(1.1)
        elseif y < 0 then
            cam:zoom(0.9)
        end
    end
    if cx < ww - EUw / 2 then
        cam:lockX(ww - EUw / 2)
    end
    if cx > EUw / 2 then
        cam:lockX(EUw / 2)
    end
    if cy < wh - EUh / 2 then
        cam:lockY(wh - EUh / 2)
    end
    if cy > EUh / 2 then
        cam:lockY(EUh / 2)
    end
end



function love.draw()
    cam:attach()
        love.graphics.setShader(shader)
        love.graphics.draw(Europe, ww / 2 - EUw / 2, wh / 2 - EUh / 2)
    cam:detach()
    
    --cg1:playCG()
end
