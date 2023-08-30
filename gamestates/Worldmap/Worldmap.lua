Worldmap = {}
Worldmap = Gamestate.new()

require 'gamestates/Worldmap/WorldmapUI'
require 'Data.City.Cities'
require 'Data.City.Cityfunction'
require 'Data.Tank.Tanks'
require 'Data.Ship.Ships'
require 'Data.Tank.Tankfunctions'
require 'Data.Ship.Shipfunctions'
require 'Data/Constructure/Constructures'
require 'Data/Constructure/Constructurefunctions'
require 'gamestates.Chapter.ChapterUI'
require 'Data.Tank.TankSpawner'
require 'Data.Ship.ShipSpawner'
require 'Data.Constructure.ConstructureSpawner'
require 'gamestates.Chapter.TimeToShoot'
require 'gamestates/Chapter/TimeToBomb'
require 'gamestates/Chapter/TimeToLaunchMissile'

function Worldmap:init()
    Year = 1946
    SteelProduction = 0
    OilProduction = 0
    Cities:load()

    NewSaving:LoadFile(Filenumber)
    NewSaving:LoadResource()

    WorldmapUI:load()
end

function Worldmap:update(dt)
    WorldmapUI:update(dt)
    --secret map
    if love.keyboard.isDown('g') then
        MapNumber=2
        Saving:fileload()
    end
    --cam contral
    if cam.scale > 4 then
        cam:zoomTo(4)
    end
    if cam.scale < wh / Worldh then
        cam:zoomTo(wh / Worldh)
    end
    cam:lockcamera(0, 0, Worldw, Worldh, 0, ww, 0, wh)

    camx,camy = cam:position()
    if camx > Worldw then
        cam:move(-Worldw,0)
    end
    if camx < 0 then 
        cam:move(Worldw,0)
    end

    --resources update
    WorldResourceUpdate()
end

function WorldResourceUpdate()
    local steel, oil , steel_p, oil_p= 0,0,0,0
    for i, city in ipairs(Cities) do
        steel = steel + city.steel_stored
        oil = oil + city.oil_stored
        steel_p = steel_p + city.steel_production
        oil_p = oil_p + city.oil_production
    end
    Steel = steel
    Oil = oil
    SteelProduction = steel_p
    OilProduction = oil_p
end

function Worldmap:draw()
    cam:attach()
        DrawEarth()
        DrawCountries()
    cam:detach()

    WorldmapUI:draw()
end

function Worldmap:drawWithoutUI()
    cam:attach()
        DrawEarth()
        DrawCountries()
    cam:detach()
end