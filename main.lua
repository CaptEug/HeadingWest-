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
Earth = love.graphics.newImage('Assets/countries/WorldMap.png')
WdMap = sti('Assets/countries/Worldmap.lua')
Worldw, Worldh = Earth:getDimensions()
USSR_flag = love.graphics.newImage('Assets/countries/USSR_Flag.png')
US_flag = love.graphics.newImage('Assets/countries/US_Flag.png')
UK_flag = love.graphics.newImage('Assets/countries/UK_Flag.png')
EastGer_flag = love.graphics.newImage('Assets/countries/EastGer_Flag.png')
WestGer_flag = love.graphics.newImage('Assets/countries/WestGer_Flag.png')
FR_flag = love.graphics.newImage('Assets/countries/FR_Flag.png')
PL_flag = love.graphics.newImage('Assets/countries/PL_Flag.png')
--botton
Stalin = love.graphics.newImage('Assets/pictures/Stalin.png')
Khrushchev = love.graphics.newImage('Assets/pictures/Khrushchev.png')
Brezhnev = love.graphics.newImage('Assets/pictures/Brezhnev.png')
Gear = love.graphics.newImage('Assets/pictures/buttons/Gear.png')
City_capital = love.graphics.newImage('Assets/pictures/Icons/City_capital.png')
City_capital_Hot = love.graphics.newImage('Assets/pictures/Icons/City_capital_Hot.png')
City_normal = love.graphics.newImage('Assets/pictures/Icons/City_normal.png')
City_normal_Hot = love.graphics.newImage('Assets/pictures/Icons/City_normal_Hot.png')
Berlin_icon = love.graphics.newImage('Assets/pictures/icons/Berlin_icon.png')
UVZ_Icon = love.graphics.newImage('Assets/pictures/icons/UVZ_Icon.png')
leftArrow = love.graphics.newImage('Assets/pictures/buttons/leftArrow.png')
rightArrow = love.graphics.newImage('Assets/pictures/buttons/rightArrow.png')
Close_icon = love.graphics.newImage('Assets/pictures/buttons/X.png')
ClosePanel_icon = love.graphics.newImage('Assets/pictures/buttons/TankInfoPanel_Close.png')
ManulControl_icon = love.graphics.newImage('Assets/pictures/buttons/manul_control.png')
ManulControlOn_icon = love.graphics.newImage('Assets/pictures/buttons/manul_control_On.png')
SetCommander_icon = love.graphics.newImage('Assets/pictures/buttons/set_commander.png')
SetCommanderOn_icon = love.graphics.newImage('Assets/pictures/buttons/set_commander_On.png')
Armor_icon = love.graphics.newImage('Assets/pictures/buttons/Armor.png')
Aiming_icon = love.graphics.newImage('Assets/pictures/buttons/Aiming.png')
Ammo_icon = love.graphics.newImage('Assets/pictures/buttons/Ammo.png')
Mobility_icon = love.graphics.newImage('Assets/pictures/buttons/Mobility.png')
Go = love.graphics.newImage('Assets/pictures/buttons/Go.png')
Go_Hot = love.graphics.newImage('Assets/pictures/buttons/GoHot.png')
Tankdesigner_icon = love.graphics.newImage('Assets/pictures/buttons/Tankdesigner.png')
RadioStation_icon = love.graphics.newImage('Assets/pictures/buttons/RadioStation.png')
Build_icon = love.graphics.newImage('Assets/pictures/buttons/Build.png')
Build_Hot = love.graphics.newImage('Assets/pictures/buttons/Build_Hot.png')
Delete_icon = love.graphics.newImage('Assets/pictures/buttons/Delete.png')
EquipmentSelect = love.graphics.newImage('Assets/pictures/buttons/EquipmentSelect.png')
EquipmentSelectHot = love.graphics.newImage('Assets/pictures/buttons/EquipmentSelectHot.png')
invisible_button = love.graphics.newImage('Assets/pictures/buttons/Invisible_button.png')
--UI
factory_screen = love.graphics.newImage('Assets/pictures/factory_screen.png')
city_page = love.graphics.newImage('Assets/pictures/Citypage.png')
production_box = love.graphics.newImage('Assets/pictures/Pbox.png')
tank_info_panel = love.graphics.newImage('Assets/pictures/TankInfoPanel.png')
crew_icon = love.graphics.newImage('Assets/pictures/Icons/crew_member.png')
injured_crew_icon = love.graphics.newImage('Assets/pictures/Icons/crew_member_injured.png')
--audio
cg1 = CG.new('Assets/audio/OP.ogv')
Letsgo = love.audio.newSource('Assets/audio/music/俄罗斯军队模范亚历山德罗夫红旗歌舞团 - В путь.mp3', 'stream')
--cursor
pointcursor = love.mouse.newCursor('Assets/pictures/cursors/PointCursor.png', 0, 0)
handcursor = love.mouse.newCursor('Assets/pictures/cursors/HandCursor.png', 7, 0)
--font
Rtitlefont = love.graphics.newFont('Assets/fonts/pixelfont.otf', 100)
Rbuttonfont = love.graphics.newFont('Assets/fonts/pixelfont.otf', 50)
Rheadfont = love.graphics.newFont('Assets/fonts/pixelfont.otf', 20)
Rtextfont = love.graphics.newFont('Assets/fonts/pixelfont.otf')


Maps={'checkpointC','Testmap','UVZfac'}
MapNumber=1
Filenumber=1

function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(MainMenu)
    world = wf.newWorld(0, 0)
    particleworld = wf.newWorld(0, 0)
    tanks_table = Tanks.new()
    
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
    --love.graphics.draw(Earth, 0, 0)
    WdMap:drawLayer(WdMap.layers['Earth'])
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
    world:addCollisionClass('tankhull')
end