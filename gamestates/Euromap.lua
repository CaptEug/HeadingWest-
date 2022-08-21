Euromap = {}
Euromap = Gamestate.new()

require 'UI/EuromapUI'

function Euromap:init()
    EuromapUI:load()

    Cbuttons = buttons.new()
    Berlin = buttons.newCamButton(
        Berlin_Bear,
        function ()
            MapNumber=1
            Saving:fileload() --加载柏林那关
        end,
        Cbuttons
    )
end

function Euromap:update(dt)
    local ww, wh = love.graphics.getDimensions()
    Berlin.bx = 1835
    Berlin.by = 1345
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
        if cam.scale >= 0.7 then
            Cbuttons:use()
        end
        
    cam:detach()

    EuromapUI:draw()
end