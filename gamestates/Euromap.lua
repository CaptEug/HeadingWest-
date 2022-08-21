Euromap = {}
Euromap = Gamestate.new()

function Euromap:init()
    Year = 1946

    Ebuttons = buttons.new()
    Settings = buttons.newToolButton(
        Gear,
        function()
            Saving:fileload()
        end,
        Ebuttons
    )

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
    
    Year = Year + dt / 10
    local ww, wh = love.graphics.getDimensions()
    Settings.bx = 32
    Settings.by = wh - 32
    Berlin.bx = 1835
    Berlin.by = 1345

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

    Ebuttons:use()
    
    love.graphics.setFont(Rtitlefont)
    love.graphics.print(tostring(math.floor(Year)), love.graphics.getWidth() / 2 - Rtitlefont:getWidth(tostring(math.floor(Year))) / 2, love.graphics.getHeight() / 13)
end