Camera = require 'libraries/camera'
cam = Camera()
Gamestate = require "libraries/gamestate"

--files required
require 'libraries/CGplayer'
require 'libraries/shader'
require 'libraries/buttons'

--Gamestates required
require 'MainMenu'
require 'testmap'



function cammovement()
    local ww, wh = love.graphics.getDimensions()
    local cx, cy = cam:position()
    
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
end

function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(MainMenu)
    
    cg1 = CG.new('CGs/OP.ogv')
end



function love.update(dt)
    cammovement()
end



function love.draw()
     --cg1:playCG()
end
