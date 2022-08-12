Camera = require 'libraries/camera'
cam = Camera()
Gamestate = require "libraries/gamestate"
sti = require 'libraries/sti'
wf = require 'libraries/windfield'

--files required
require 'libraries/CGplayer'
require 'libraries/shaders'
require 'libraries/buttons'
require 'Tank'
require 'libraries/SetColliders'
require 'Ammo'
require 'Saving'
require 'libraries/Mapdrawer'
require 'libraries/destroyAll'
require 'libraries/show'

--Gamestates required
require 'gamestates/MainMenu'
require 'gamestates/testmap'
require 'gamestates/Loadmenu'
require 'gamestates/Pause'

Maps={testmap,Loadmenu,MainMenu}
MapNumber=1
Filenumber=1

Europe_BandW = love.graphics.newImage('Assets/Europe/Europe_BandW.png')
EUw, EUh = Europe_BandW:getDimensions()
USSR = love.graphics.newImage('Assets/Europe/USSR.png')
Poland = love.graphics.newImage('Assets/Europe/Poland.png')
Czechoslovakia = love.graphics.newImage('Assets/Europe/Czechoslovakia.png')
Hungary = love.graphics.newImage('Assets/Europe/Hungary.png')
Romania = love.graphics.newImage('Assets/Europe/Romania.png')
Bulgaria = love.graphics.newImage('Assets/Europe/Bulgaria.png')
East_Germany = love.graphics.newImage('Assets/Europe/East_Germany.png')

BandWshader = love.graphics.newShader(BandWshader_code)
battle_fog_shader = love.graphics.newShader(battle_fog_shader_code)

Gear = love.graphics.newImage('Assets/pictures/Gear.png')



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
    world = wf.newWorld(0, 0)
    cg1 = CG.new('Assets/CGs/OP.ogv')
end



function love.update(dt)
    cammovement()
end



function love.draw()
    --cg1:playCG()
end
