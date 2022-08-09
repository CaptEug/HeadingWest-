testmap = {}
testmap = Gamestate.new()
require 'Saving'
require 'gamestates/loadmenu'
require 'libraries/battle_fog'

function testmap:init()
    MapNumber=1
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

battle_fog_shader = nil

function love.load()
    battle_fog_shader = love.graphics.newShader(battle_fog_shader_code)
end

function testmap:update(dt)
    world:update(dt)
    MAUS1:move(dt)

    if cam.scale > 1.5 then
        cam:zoomTo(1.5)
    end
    if cam.scale < 0.2 then
        cam:zoomTo(0.2)
    end
end

function love.draw()
    love.graphics.setShader(battle_fog_shader)

    shader:send("screen", {
        love.graphics.getWidth(),
        love.graphics.getHeight()
    })

    shader:send("num_lights", 1)

    do
       local name = "lights[" .. 0 .."]"
       shader:send(name .. ".position", {love.graphics.getWidth() / 2, love.graphics.getHeight() / 2})
       shader:send(name .. ".diffuse", {1.0, 1.0, 1.0})
       shader:send(name .. ".power", 64)
    end
    love.graphics.setShader()
end

function testmap:draw()
    
    cam:attach()
        --gamemap:drawLayer(gamemap.layers["ground"])
        MAUS1:use()
        --gamemap:drawLayer(gamemap.layers["veg"])
        --gamemap:drawLayer(gamemap.layers["top"])
        SetColliders:draw("objects/Spike1.png")
        world:draw()
        
    cam:detach()
end