testmap = {}
testmap = Gamestate.new()

function testmap:init()
    
    MapNumber=1

    Gbuttons = buttons.new()
    Settings = buttons.newToolButton(
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
    
    loadMap('checkpointC')
    
    

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

    if cam.scale > 1.5 then
        cam:zoomTo(1.5)
    end
    if cam.scale < 0.2 then
        cam:zoomTo(0.2)
    end
end

function testmap:draw()

    cam:attach()
        drawMap()
        
        MAUS1:use()
        DrawCollider("Assets/objects/Spike1.png")
        world:draw()
        love.graphics.setShader(shaders.Hole_punch_shader)
        local sx,sy = cam:cameraCoords(MAUS1.x,MAUS1.y)
        shaders.Hole_punch_shader:send("X",sx)
        shaders.Hole_punch_shader:send("Y",sy)
        love.graphics.setShader(shaders.trueLight)
        shaders.trueLight:send("X", sx)
        shaders.trueLight:send("Y", sy)
        love.graphics.rectangle("fill", -5000, -5000, 10000, 10000)
        love.graphics.setShader()
    cam:detach()
    Gbuttons:use()
end