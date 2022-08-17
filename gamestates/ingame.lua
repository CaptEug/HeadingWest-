ingame = {}
ingame = Gamestate.new()
require "entity_test.tanks_new"

function ingame:getdata()
    Saving:getdata(Filenumber)
    Data()
end

function ingame:init()
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

    loadMap('checkpointC')
    
    --[[MAUS1 = tanks.new(
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
    TankAI:create('M48A1')]]--
    m = Tanks.new()
    tank1 = m:newtank("entity_test/shushu.txt", Data.ax , Data.ay)
    m:addai(tank1, keybroadcontrol)
end

function ingame:update(dt)
    local ww, wh = love.graphics.getDimensions()
    Settings.bx = 32
    Settings.by = wh - 32
    
    world:update(dt)
    m:update(dt)

    if cam.scale > 1.5 then
        cam:zoomTo(1.5)
    end
    if cam.scale < 0.2 then
        cam:zoomTo(0.2)
    end
end

function ingame:draw()
    cam:attach()
        drawMap()
        --world:draw()
    cam:detach()
    Gbuttons:use()
end

function ingame:drawWithoutButton()
    cam:attach()
        drawMap()
        --world:draw()
    cam:detach()
end