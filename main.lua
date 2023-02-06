--files required
Camera = require 'libraries.utilities.camera'
cam = Camera()
Gamestate = require "libraries.utilities.gamestate"
sti = require 'libraries/sti'
wf = require 'libraries/windfield'
require 'libraries/utilities/CGplayer'
require 'libraries/shaders'
require 'libraries/utilities/buttons'
require 'libraries.Ammo'
require 'libraries/Airstrike'
require 'libraries.TankSpawner'
require 'Saving'
require 'libraries.Mapdrawer'
require 'libraries/utilities/destroyAll'
require 'libraries/utilities/show'

--Gamestates required
require 'gamestates/MainMenu'
require 'gamestates/ingame'
require 'gamestates/Pause'
require 'gamestates/Worldmap'
require 'gamestates/SettingMenu'

--Assets registered
--country
Earth = love.graphics.newImage('Assets/countries/WorldMap1945.png')
Worldw, Worldh = Earth:getDimensions()
--botton
Stalin = love.graphics.newImage('Assets/pictures/Stalin.png')
Khrushchev = love.graphics.newImage('Assets/pictures/Khrushchev.png')
Brezhnev = love.graphics.newImage('Assets/pictures/Brezhnev.png')
Gear = love.graphics.newImage('Assets/pictures/buttons/Gear.png')
Berlin_icon = love.graphics.newImage('Assets/pictures/icons/Berlin_icon.png')
UVZ_Icon = love.graphics.newImage('Assets/pictures/icons/UVZ_Icon.png')
T54 = love.graphics.newImage('Assets/tanks/soviet/T-5455/T54.png')
TankIcon = love.graphics.newImage('Assets/pictures/icons/Tank_Icon.png')
PlaneIcon = love.graphics.newImage('Assets/pictures/icons/Plane_Icon.png')
leftArrow = love.graphics.newImage('Assets/pictures/buttons/leftArrow.png')
rightArrow = love.graphics.newImage('Assets/pictures/buttons/rightArrow.png')
Close_icon = love.graphics.newImage('Assets/pictures/buttons/X.png')
Armor_icon = love.graphics.newImage('Assets/pictures/buttons/Armor.png')
Aiming_icon = love.graphics.newImage('Assets/pictures/buttons/Aiming.png')
Ammo_icon = love.graphics.newImage('Assets/pictures/buttons/Ammo.png')
Mobility_icon = love.graphics.newImage('Assets/pictures/buttons/Mobility.png')
Go = love.graphics.newImage('Assets/pictures/buttons/Go.png')
Tankdesigner_icon = love.graphics.newImage('Assets/pictures/buttons/Tankdesigner.png')
RadioStation_icon = love.graphics.newImage('Assets/pictures/buttons/RadioStation.png')
Build_icon = love.graphics.newImage('Assets/pictures/buttons/Build.png')
Delete_icon = love.graphics.newImage('Assets/pictures/buttons/Delete.png')
EquipmentSelectOn = love.graphics.newImage('Assets/pictures/buttons/EquipmentSelectOn.png')
EquipmentSelectOff = love.graphics.newImage('Assets/pictures/buttons/EquipmentSelectOff.png')
EquipmentSelectHot = love.graphics.newImage('Assets/pictures/buttons/EquipmentSelectHot.png')
--UI
factory_screen = love.graphics.newImage('Assets/pictures/factory_screen.png')
city_page = love.graphics.newImage('Assets/pictures/Citypage.png')
production_box = love.graphics.newImage('Assets/pictures/Pbox.png')
--audio
cg1 = CG.new('Assets/audio/OP.ogv')
Letsgo = love.audio.newSource('Assets/audio/music/俄罗斯军队模范亚历山德罗夫红旗歌舞团 - В путь.mp3', 'stream')
--cursor
pointcursor = love.mouse.newCursor('Assets/pictures/cursors/PointCursor.png', 0, 0)
handcursor = love.mouse.newCursor('Assets/pictures/cursors/HandCursor.png', 7, 0)
bombcursor = love.mouse.newCursor('Assets/pictures/cursors/RedBomb.png', 32, 32)
--font
Rtitlefont = love.graphics.newFont('Assets/fonts/pixelfont.otf', 100)
Rbuttonfont = love.graphics.newFont('Assets/fonts/pixelfont.otf', 50)
Rheadfont = love.graphics.newFont('Assets/fonts/pixelfont.otf', 20)
Rtextfont = love.graphics.newFont('Assets/fonts/pixelfont.otf')


Maps={'checkpointC','Testmap','UVZfac'}
MapNumber=1
Filenumber=1
Dx=1


function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(MainMenu)
    world = wf.newWorld(0, 0)
    particleworld = wf.newWorld(0, 0)
    tanks_table = Tanks.new()
    TankSpawner:load()
    
    addCollisionClass()

    Cursor = pointcursor
    love.mouse.setCursor(Cursor)
    Saving:load_settings()
end



function love.update(dt)
    ww, wh = love.graphics.getDimensions()
    cammovement()
end



function love.draw()
    --cg1:playCG()
    Cursor = pointcursor
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

function DrawMaps()
    love.graphics.draw(Earth, 0, 0)
end

function DrawCountries()
    Countries = {}
    for i, country in pairs(Countries) do
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