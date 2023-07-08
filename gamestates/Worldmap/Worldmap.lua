Worldmap = {}
Worldmap = Gamestate.new()

require 'gamestates/Worldmap/WorldmapUI'
require 'gamestates.City.Cities'
require 'Data.Tank.Tanks'
require 'Data.Ship.Ships'
require 'Data.Tank.Tankfunctions'
require 'Data.Ship.Shipfunctions'
require 'Data/Constructure/Constructures'
require 'Data/Constructure/Constructurefunctions'
require 'gamestates.city.cityUI'
require 'Data.Tank.TankSpawner'
require 'Data.Ship.ShipSpawner'
require 'Data.Constructure.ConstructureSpawner'
require 'gamestates.city.TimeToShoot'
require 'gamestates/city/TimeToBomb'
require 'gamestates/city/TimeToLaunchMissile'

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
    Steel = Steel + SteelProduction*dt
    Oil = Oil + OilProduction*dt
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