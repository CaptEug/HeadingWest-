--files required
Camera = require 'libraries/camera'
cam = Camera()
Gamestate = require "libraries/gamestate"
sti = require 'libraries/sti'
wf = require 'libraries/windfield'
require 'libraries/utilities/CGplayer'
require 'libraries/shaders'
require 'libraries/buttons'
require 'Ammo'
require 'Airstrike'
require 'Saving'
require 'libraries/Mapdrawer'
require 'libraries/utilities/destroyAll'
require 'libraries/utilities/show'

--Gamestates required
require 'gamestates/MainMenu'
require 'gamestates/ingame'
require 'gamestates/Loadmenu'
require 'gamestates/Pause'
require 'gamestates/Euromap'
require 'gamestates/Settings'

--Assets registered
Europe_BandW = love.graphics.newImage('Assets/Europe/Europe_BandW.png')
EUw, EUh = Europe_BandW:getDimensions()
USSR = love.graphics.newImage('Assets/Europe/USSR.png')
Poland = love.graphics.newImage('Assets/Europe/Poland.png')
Czechoslovakia = love.graphics.newImage('Assets/Europe/Czechoslovakia.png')
Hungary = love.graphics.newImage('Assets/Europe/Hungary.png')
Romania = love.graphics.newImage('Assets/Europe/Romania.png')
Bulgaria = love.graphics.newImage('Assets/Europe/Bulgaria.png')
East_Germany = love.graphics.newImage('Assets/Europe/East_Germany.png')

Gear = love.graphics.newImage('Assets/pictures/Gear.png')

T54 = love.graphics.newImage('Assets/tanks/soviet/T-5455/T54.png')

cg1 = CG.new('Assets/CGs/OP.ogv')

--Fonts registered
Rtitlefont = love.graphics.newFont('Russian.ttf', 100)
Rbuttonfont = love.graphics.newFont('Russian.ttf', 50)

Maps={'checkpointC','Testmap'}
MapNumber=1
Filenumber=1



function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(MainMenu)
    world = wf.newWorld(0, 0)
    tanks_table = Tanks.new()
    addCollisionClass()
end



function love.update(dt)
    ww, wh = love.graphics.getDimensions()
    cammovement()
end



function love.draw()
    --cg1:playCG()
end



function cammovement()
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
    RedCountries = {}
    table.insert(RedCountries,USSR)
    table.insert(RedCountries,Poland)
    table.insert(RedCountries,Czechoslovakia)
    table.insert(RedCountries,Hungary)
    table.insert(RedCountries,Romania)
    table.insert(RedCountries,Bulgaria)
    table.insert(RedCountries,East_Germany)
    for i, country in pairs(RedCountries) do
        love.graphics.draw(country, 0, 0)
    end
end

function addCollisionClass()
    world:addCollisionClass('APCBC')
    world:addCollisionClass('HEAT')
    world:addCollisionClass('APDS')
    world:addCollisionClass('Amour')
    world:addCollisionClass('Wall')
end