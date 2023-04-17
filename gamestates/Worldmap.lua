Worldmap = {}
Worldmap = Gamestate.new()

require 'UI/WorldmapUI'
require 'Data/Cities'
require 'Data/Tanks'
require 'Data.Tankfunctions'
require 'Data/Constructures'
require 'Data/Constructurefunctions'

function Worldmap:init()
    Year = 1946

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