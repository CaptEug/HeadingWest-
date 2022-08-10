Loadmenu = {}
Loadmenu = Gamestate.new()

require 'tank'
require 'Saving'

Stalin = love.graphics.newImage('pictures/Joseph_Stalin.png')
Khrushchev = love.graphics.newImage('pictures/Khrushchev.png')
Brezhnev = love.graphics.newImage('pictures/Brezhnev.png')

function Loadmenu:init()
    
    Lbuttons = buttons.new()
    FILE1 = buttons.newPicButton(
        0,
        Stalin,
        function()
            Saving:fileload(1)
        end,
        Lbuttons
    )

    FILE2 = buttons.newPicButton(
        0,
        Khrushchev,
        function()
            Saving:fileload(2)
        end,
        Lbuttons
    )

    FILE3 = buttons.newPicButton(
        0,
        Brezhnev,
        function()
            Saving:fileload(3)
        end,
        Lbuttons
    )

    Back = buttons.newButton(
        1,
        "Back",
        function()
            Gamestate.switch(MainMenu)   
        end,
        Lbuttons
    )
end

function Loadmenu:update()
    local ww, wh = love.graphics.getDimensions()
    FILE1.bx = ww / 5
    FILE2.bx = ww / 2
    FILE3.bx = ww *(4 / 5)
    FILE1.by = wh *(1 / 2)
    FILE2.by = wh *(1 / 2)
    FILE3.by = wh *(1 / 2)
    Back.bx = ww / 2
    Back.by = wh *(12 / 13)

    if cam.scale > 1.5 then
        cam:zoomTo(1.5)
    end
    if cam.scale < wh / EUh then
        cam:zoomTo(wh / EUh)
    end
    cam:lockcamera(0, 0, EUw, EUh, 0, ww, 0, wh)
end

function Loadmenu:draw()
    cam:attach()
        love.graphics.setColor(0.3, 0.3, 0.3, 1)
        DrawEurope()
        DrawCountries()
        love.graphics.setColor(1, 1, 1)
    cam:detach()
    love.graphics.setFont(Rtitlefont)
    love.graphics.print("SAVED FILES", love.graphics.getWidth() / 2 - Rtitlefont:getWidth("SAVED FILES") / 2, love.graphics.getHeight() / 13)
    Lbuttons:use()
end
