Loadmenu = {}
Loadmenu = Gamestate.new()
require 'tank'
function Loadmenu:init()


    Lbuttons = buttons.new()
    FILE1 = buttons.newButton(
        "FILE1",
        function()
            fileload(1)
        end,
        Lbuttons
    )

    FILE2 = buttons.newButton(
        "FILE2",
        function()
            fileload(2)
        end,
        Lbuttons
    )

    FILE3 = buttons.newButton(
        "FILE3",
        function()
            fileload(3)
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

function createsave(filenum)
    data={}
    data.stage=0
    data.tankx=0
    data.tanky=0
    data.tankangle=0
    data.filenumber=filenum
end
function filesave (filenum)
    local number=filenum
    data.stage="testmap"
    data.tankx=tanks.x
    data.tanky=tanks.y
    data.tankangle=tanks.angle

    if number ==1 then
        love.filesystem.write("file1.lua", table.show(), size (number))
    else if filenum ==2 then 
        love.filesystem.write("file2.lua", data (string), size (number))
        else
        love.filesystem.write("file3.lua", data (string), size (number))
        end
    end
end

function fileload (filenum)
    local number=filenum

    if number ==1 then
        love.filesystem.write("file1.lua", data (string), size (number))
    else if filenum ==2 then 
        love.filesystem.write("file2.lua", data (string), size (number))
        else
        love.filesystem.write("file3.lua", data (string), size (number))
        end
    end
end