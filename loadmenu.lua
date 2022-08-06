Loadmenu = {}
Loadmenu = Gamestate.new()
require 'tank'
require'Saving'

function Loadmenu:init()


    Lbuttons = buttons.new()
    FILE1 = buttons.newButton(
        "FILE1",
        function()
            Saving:fileload(1)
        end,
        Lbuttons
    )

    FILE2 = buttons.newButton(
        "FILE2",
        function()
            Saving:fileload(2)
        end,
        Lbuttons
    )

    FILE3 = buttons.newButton(
        "FILE3",
        function()
            Saving:fileload(3)
        end,
        Lbuttons
    )

    JUMP = buttons.newButton(
        "JUMP",
        function()
            Gamestate.switch(testmap)
        end,
        Lbuttons
    )
end

function Loadmenu:update()
    ww, wh = love.graphics.getDimensions()
    FILE1.bx = ww / 3
    FILE2.bx = ww / 2
    FILE3.bx = ww *(2 / 3)
    FILE1.by = wh *(2 / 3)
    FILE2.by = wh *(2 / 3)
    FILE3.by = wh *(2 / 3)
    JUMP.by=wh / 2

end

function Loadmenu:draw()
    Lbuttons:use()
    
    cam:attach()
        
    cam:detach()
end
