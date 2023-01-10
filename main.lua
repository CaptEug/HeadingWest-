--files required
Camera = require 'libraries/camera'
cam = Camera()
Gamestate = require "libraries/gamestate"
sti = require 'libraries/sti'
wf = require 'libraries/windfield'
require 'libraries/utilities/CGplayer'
require 'libraries/shaders'
require 'libraries/utilities/buttons'
require 'Ammo'
require 'Airstrike'
require 'Saving'
require 'libraries.utilities/Mapdrawer'
require 'libraries/utilities/destroyAll'
require 'libraries/utilities/show'

--Gamestates required
require 'gamestates/MainMenu'
require 'gamestates/ingame'
require 'gamestates/Loadmenu'
require 'gamestates/Pause'
require 'gamestates/Worldmap'
require 'gamestates/SettingMenu'

--Assets registered
--country
Europe_BandW = love.graphics.newImage('Assets/Europe/Europe_BandW.png')
EUw, EUh = Europe_BandW:getDimensions()
USSR = love.graphics.newImage('Assets/Europe/USSR.png')
Poland = love.graphics.newImage('Assets/Europe/Poland.png')
Czechoslovakia = love.graphics.newImage('Assets/Europe/Czechoslovakia.png')
Hungary = love.graphics.newImage('Assets/Europe/Hungary.png')
Romania = love.graphics.newImage('Assets/Europe/Romania.png')
Bulgaria = love.graphics.newImage('Assets/Europe/Bulgaria.png')
East_Germany = love.graphics.newImage('Assets/Europe/East_Germany.png')
--botton
Stalin = love.graphics.newImage('Assets/pictures/Joseph_Stalin.png')
Khrushchev = love.graphics.newImage('Assets/pictures/Khrushchev.png')
Brezhnev = love.graphics.newImage('Assets/pictures/Brezhnev.png')
Gear = love.graphics.newImage('Assets/pictures/icons/Gear.png')
Berlin_Bear = love.graphics.newImage('Assets/pictures/icons/Berlin_Bear.png')
UVZ_Icon = love.graphics.newImage('Assets/pictures/icons/UVZ_Icon.png')
T54 = love.graphics.newImage('Assets/tanks/soviet/T-5455/T54.png')
TankIcon = love.graphics.newImage('Assets/pictures/icons/Tank_Icon.png')
PlaneIcon = love.graphics.newImage('Assets/pictures/icons/Plane_Icon.png')
leftArrow = love.graphics.newImage('Assets/pictures/buttons/leftArrow.png')
rightArrow = love.graphics.newImage('Assets/pictures/buttons/rightArrow.png')
Close = love.graphics.newImage('Assets/pictures/buttons/X.png')
Armor_icon = love.graphics.newImage('Assets/pictures/buttons/Armor.png')
Aiming_icon = love.graphics.newImage('Assets/pictures/buttons/Aiming.png')
Ammo_icon = love.graphics.newImage('Assets/pictures/buttons/Ammo.png')
Mobility_icon = love.graphics.newImage('Assets/pictures/buttons/Mobility.png')
Go = love.graphics.newImage('Assets/pictures/buttons/Go.png')
--UI
factory_screen = love.graphics.newImage('Assets/pictures/factory_screen.png')
city_page = love.graphics.newImage('Assets/pictures/Citypage.png')
--audio
cg1 = CG.new('Assets/audio/OP.ogv')
Letsgo = love.audio.newSource('Assets/audio/music/俄罗斯军队模范亚历山德罗夫红旗歌舞团 - В путь.mp3', 'stream')
--cursor
cursor = love.mouse.newCursor('Assets/cursors/Cursor.png', 0, 0)
bombcursor = love.mouse.newCursor('Assets/cursors/RedBomb.png', 32, 32)
--font
Rtitlefont = love.graphics.newFont('Assets/fonts/pixelfont.otf', 100)
Rbuttonfont = love.graphics.newFont('Assets/fonts/pixelfont.otf', 50)
Rheadfont = love.graphics.newFont('Assets/fonts/pixelfont.otf', 20)
Rtextfont = love.graphics.newFont('Assets/fonts/pixelfont.otf')
--tanks
T72A_line = love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_line.png')
T72B_line = love.graphics.newImage('Assets/tanks/soviet/T-72/T72B_line.png')
T72B_kontakt1_line = love.graphics.newImage('Assets/tanks/soviet/T-72/T72B_kontakt1_line.png')
T72B_kontakt5_line = love.graphics.newImage('Assets/tanks/soviet/T-72/T72B_kontakt5_line.png')

Maps={'checkpointC','Testmap'}
MapNumber=1
Filenumber=1



function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(MainMenu)
    world = wf.newWorld(0, 0)
    particleworld = wf.newWorld(0, 0)
    tanks_table = Tanks.new()
    
    addCollisionClass()

    love.mouse.setCursor(cursor)
    Saving:load_settings()
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
    world:addCollisionClass('Explosion')
end