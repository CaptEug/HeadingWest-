ingame = {}
ingame = Gamestate.new()
require "entity_test.tanks_new"
require 'UI.ingameUI'
function ingame:init()
    Gbuttons = buttons.new()
    Settings = buttons.newToolButton(
        Gear,
        function()
            Gamestate.push(Pause)
        end,
        Gbuttons,
        16,
        wh - 16
    )

    Saving:getdata(Filenumber)
    Data()

    local map=Maps[MapNumber]
    loadMap(map)
    love.graphics.draw(love.graphics.newImage('Assets/tanks/soviet/T-72/T72A_hull.png'))
    TankSpawner:load_collider(CurrentPlace)
    ingameUI:load()

    --[[psystem = love.graphics.newParticleSystem(PlaneIcon, 32)
    psystem:setParticleLifetime(2, 5) -- Particles live at least 2s and at most 5s.
	psystem:setEmissionRate(5)
	psystem:setSizeVariation(1)
	psystem:setLinearAcceleration(-20, -20, 20, 20) -- Random movement in all directions.
	psystem:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.]]
end

function ingame:update(dt)
    ingameUI:update(dt)
    world:update(dt)
    particleworld:update(dt)
    tanks_table:update(dt)
    Ammo.update(dt)
    Airstrike.update(dt)
    --psystem:update(dt)
    
    if cam.scale > 2 then
        cam:zoomTo(2)
    end
    if cam.scale < 0.2 then
        cam:zoomTo(0.2)
    end
    if love.mouse.isDown(1) and love.mouse.getCursor() == bombcursor then
        Bombing(dt)
    end
end

function ingame:draw()
    cam:attach()
        drawMap()
        --TankSpawner:draw(CurrentPlace)
        --TankSpawner:testdraw(CurrentPlace)
        TankSpawner:draw_tank()
        world:draw()
        particleworld:draw()
    cam:detach()


    ingameUI:draw()

    Gbuttons:use() 
end

function ingame:drawWithoutUI()
    cam:attach()
        drawMap()
        world:draw()
    cam:detach()
end
