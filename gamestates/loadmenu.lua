Loadmenu = {}
Loadmenu = Gamestate.new()
require 'tank'
require'Saving'
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

end

function Loadmenu:draw()
    cam:attach()
        
        DrawEurope()
        
    cam:detach()
    
    Lbuttons:use()
end
