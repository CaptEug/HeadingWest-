testmap = {}
testmap = Gamestate.new()
require 'Saving'
require 'gamestates/loadmenu'

function testmap:init()
    Saving:getdata(Filenumber)
    Data()
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
        Data.tank_name,
        Data.x,
        Data.y,
        Data.angle,
        Data.turret_angle,
        Data.turret_path,
        Data.bodywork_path,
        Data.turret_offset,
        Data.maxspeed,
        Data.back_maxspeed,
        Data.acceleration,
        Data.back_acceleration,
        Data.stop_acceleration,
        Data.max_Rotation_speed,
        Data.Rotational_acceleration,
        Data.stop_rotation_ac,
        Data.turret_max_Rotation_speed,
        Data.turret_Rotational_acceleration,
        Data.turret_stop_rotation_ac
    )
    MAUS1:create()
end



function testmap:update(dt)
    world:update(dt)
    MAUS1:move(dt)
    if love.keyboard.isDown("e")
    then
        Saving:filesave(Filenumber)
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