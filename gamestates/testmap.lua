testmap = {}
testmap = Gamestate.new()

require 'Saving'
require 'Shell'

function testmap:init()
    MapNumber=1
    
    Gbuttons = buttons.new()
    Settings = buttons.newToolButton(
        2,
        Gear,
        function()
            local state = false
            if Gamestate.current ~= Pause then
                Gamestate.push(Pause)
            end
        end,
        Gbuttons
    )

    Saving:getdata(Filenumber)
    Data()
    gamemap = sti('chapters/maps/checkpointC.lua')
    
    world = wf.newWorld(0, 0)
    
    SetColliders:set("wall","static")
    SetColliders:set("Spike")

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
    local ww, wh = love.graphics.getDimensions()
    Settings.bx = 32
    Settings.by = wh - 32
    world:update(dt)
    MAUS1:move(dt)

    if love.mouse.isDown(1) then
        createshell()
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
        love.graphics.setShader(battle_fog_shader)
        battle_fog_shader:send("screen", {
            love.graphics.getWidth(),
            love.graphics.getHeight()
        })
        battle_fog_shader:send("num_lights", 1)
        do
            local name = "lights[" .. 0 .."]"
            battle_fog_shader:send(name .. ".position", {cam:cameraCoords(MAUS1.x,MAUS1.y, ox,oy,w,h)})
            battle_fog_shader:send(name .. ".diffuse", {1.0, 1.0, 1.0})
            battle_fog_shader:send(name .. ".power", 32)
        end
        

        --gamemap:drawLayer(gamemap.layers["ground"])
        MAUS1:use()
        --gamemap:drawLayer(gamemap.layers["veg"])
        --gamemap:drawLayer(gamemap.layers["top"])
        SetColliders:draw("objects/Spike1.png")
        world:draw()
        love.graphics.setShader(nil)
    cam:detach()
end