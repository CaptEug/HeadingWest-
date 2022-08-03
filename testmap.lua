testmap = {}
testmap = Gamestate.new()



function testmap:init()
    gamemap = sti('chapters/maps/checkpointC.lua')
    
    world = wf.newWorld(0, 0)
    
    Gbuttons = buttons.new()
    Back = buttons.newButton(
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
    400,
    500,
    0,
    0,
    'tanks/german/MAUS/MAUS turret.png',
    'tanks/german/MAUS/MAUS hull_1.png',
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