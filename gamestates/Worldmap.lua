Worldmap = {}
Worldmap = Gamestate.new()

require 'UI/WorldmapUI'
require 'Data/CityData'
require 'Data/TankData'

function Worldmap:init()
    Year = 1946

    Saving:getdata(Filenumber)
    Data()
    love.filesystem.write("filetest.lua",TableToString(FileData,"FileData"))
    
    OilProduction = Data.OilProduction
    Oil = Data.Oil
    SteelProduction = Data.SteelProduction
    Steel = Data.Steel

    CityData:load()
    TankData:load()
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
end

function Worldmap:draw()
    cam:attach()
        DrawMaps()
        DrawCountries()
    cam:detach()

    WorldmapUI:draw()
end

function Worldmap:drawWithoutUI()
    cam:attach()
        DrawMaps()
        DrawCountries()
    cam:detach()
end