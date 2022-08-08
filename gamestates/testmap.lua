testmap = {}
testmap = Gamestate.new()
require 'Saving'
require 'gamestates/loadmenu'
local tankedata=Data
function testmap:init()
    gamemap = sti('chapters/maps/checkpointC.lua')
    
    world = wf.newWorld(0, 0)
    
    Gbuttons = buttons.new()
    Back = buttons.newButton(
        1,
        "Back",
        function()
            Gamestate.switch(MainMenu)
        end,
        Gbuttons
    )

    SetColliders:get("wall","static")
    SetColliders:get("Spike")

    MAUS1 = tanks.new(
    'mause',
    tankedata.x,
    tankedata.y,
    0,
    0,
    'tanks/german/MAUS/MAUS turret.png',
    'tanks/german/MAUS/MAUS hull.png',
    27,
    200,
    40,
    30,
    20,
    150,
    0.8,
    0.3,
    0.7,
    0.5,
    0.4,
    0.8
    )
    MAUS1:create()
end



function testmap:update(dt)
    world:update(dt)
    MAUS1:move(dt)
    if love.keyboard.isDown("e")
    then
        Saving:filesave(1)
    end
    if cam.scale > 1.5 then
        cam:zoomTo(1.5)
    end
    if cam.scale < 0.2 then
        cam:zoomTo(0.2)
    end
end


function testmap:draw()
    Gbuttons:use()
    
    cam:attach()
        --gamemap:drawLayer(gamemap.layers["ground"])
        MAUS1:use()
        --gamemap:drawLayer(gamemap.layers["veg"])
        --gamemap:drawLayer(gamemap.layers["top"])
        SetColliders:draw("objects/Spike1.png")
        world:draw()
        
    cam:detach()
end