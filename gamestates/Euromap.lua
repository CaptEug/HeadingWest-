Euromap = {}
Euromap = Gamestate.new()

require 'UI/EuromapUI'

Berlin_Bear = love.graphics.newImage('Assets/pictures/Berlin_Bear.png')
UVZ_Icon = love.graphics.newImage('Assets/pictures/UVZ_Icon.png')

function Euromap:init()
    
    EuromapUI:load()

end

function Euromap:update(dt)

    EuromapUI:update(dt)

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

function Euromap:draw()
    cam:attach()
        DrawEurope()
        DrawCountries()
    cam:detach()

    EuromapUI:draw()
end

function Euromap:drawWithoutUI()
    cam:attach()
    
    cam:detach()
end