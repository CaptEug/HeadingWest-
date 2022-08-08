Loadmenu = {}
Loadmenu = Gamestate.new()
require 'tank'
require 'Saving'
require 'libraries/shader'
Stalin = love.graphics.newImage('pictures/Joseph_Stalin.png')
Khrushchev = love.graphics.newImage('pictures/Khrushchev.png')
Brezhnev = love.graphics.newImage('pictures/Brezhnev.png')
Tankdata={}

function Loadmenu:init()
    
    Lbuttons = buttons.new()
    FILE1 = buttons.newPicButton(
        0,
        Stalin,
        function()
            Tankdata=Saving:fileload(1)
        end,
        Lbuttons
    )

    FILE2 = buttons.newPicButton(
        0,
        Khrushchev,
        function()
            Tankdata=Saving:fileload(2)
        end,
        Lbuttons
    )

    FILE3 = buttons.newPicButton(
        0,
        Brezhnev,
        function()
            Tankdata=Saving:fileload(3)
        end,
        Lbuttons
    )

    JUMP = buttons.newButton(
        1,
        "JUMP",
        function()
            Gamestate.switch(testmap)
        end,
        Lbuttons
    )
end

function Loadmenu:update()
    ww, wh = love.graphics.getDimensions()
    FILE1.bx = ww / 5
    FILE2.bx = ww / 2
    FILE3.bx = ww *(4 / 5)
    FILE1.by = wh *(1 / 2)
    FILE2.by = wh *(1 / 2)
    FILE3.by = wh *(1 / 2)
    JUMP.by=wh / 2

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
        love.graphics.setShader(deeper_backgroundShader)
        DrawEurope()
    cam:detach()
    love.graphics.setFont(Rtitlefont)
    love.graphics.print("SAVED FILES", love.graphics.getWidth() / 2 - Rtitlefont:getWidth("SAVED FILES") / 2, love.graphics.getHeight() / 13)
    Lbuttons:use()
end
