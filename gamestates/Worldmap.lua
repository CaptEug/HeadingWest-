Worldmap = {}
Worldmap = Gamestate.new()

require 'UI/WorldmapUI'
require 'Data/CitiesAndFactories'
require 'Data/TankData'

function Worldmap:init()
    CitiesAndFactories:load()
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
    
    if cam.scale > 1.5 then
        cam:zoomTo(1.5)
    end
    if cam.scale < wh / EUh then
        cam:zoomTo(wh / EUh)
    end
    cam:lockcamera(0, 0, EUw, EUh, 0, ww, 0, wh)
end

function Worldmap:draw()
    cam:attach()
        DrawEurope()
        DrawCountries()
    cam:detach()

    WorldmapUI:draw()
end

function Worldmap:drawWithoutUI()
    cam:attach()
        DrawEurope()
        DrawCountries()
    cam:detach()
end