Camera = require 'libraries/camera'
cam = Camera()
Gamestate = require "libraries/gamestate"
sti = require 'libraries/sti'
wf = require 'libraries/windfield'

--files required
require 'libraries/CGplayer'
require 'libraries/shader'
require 'libraries/buttons'
require 'Tank'
require 'libraries/SetColliders'

--Gamestates required
require 'gamestates/MainMenu'
require 'gamestates/testmap'
require 'gamestates/Loadmenu'
require 'gamestates/Pause'

Europe_BandW = love.graphics.newImage('Europe/Europe_BandW.png')
EUw, EUh = Europe_BandW:getDimensions()
USSR = love.graphics.newImage('Europe/USSR.png')
Poland = love.graphics.newImage('Europe/Poland.png')
Czechoslovakia = love.graphics.newImage('Europe/Czechoslovakia.png')
Hungary = love.graphics.newImage('Europe/Hungary.png')
Romania = love.graphics.newImage('Europe/Romania.png')
Bulgaria = love.graphics.newImage('Europe/Bulgaria.png')
East_Germany = love.graphics.newImage('Europe/East_Germany.png')

BandWshader = love.graphics.newShader(BandWshader_code)
deeper_backgroundShader = love.graphics.newShader(deeper_backgroundShader_code)


local function cammovement()
    local ww, wh = love.graphics.getDimensions()
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

function DrawEurope()
    love.graphics.draw(Europe_BandW, 0, 0)
end

function DrawCountries()
    love.graphics.draw(USSR, 0, 0)
    love.graphics.draw(Poland, 0, 0)
    love.graphics.draw(Czechoslovakia, 0, 0)
    love.graphics.draw(Hungary, 0, 0)
    love.graphics.draw(Romania, 0, 0)
    love.graphics.draw(Bulgaria, 0, 0)
    love.graphics.draw(East_Germany, 0, 0)
end

function love.load()
    
    Gamestate.registerEvents()
    Gamestate.switch(MainMenu)
    
    cg1 = CG.new('CGs/OP.ogv')
end



function love.update(dt)
    cammovement()
    if Gamestate.current() ~= MainMenu and key == 'p' then
        return Gamestate.push(Pause)
    end
end



function love.draw()
     --cg1:playCG()
end
