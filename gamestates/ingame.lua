ingame = {}
ingame = Gamestate.new()
require "entity_test.tanks_new"
require 'UI/BattlefieldUI'

function ingame:init(map_type)
    
    Saving:getdata(Filenumber)
    Data()

    local map=Maps[MapNumber]
    loadMap(map)
    BattlefieldUI:load()

    --[[psystem = love.graphics.newParticleSystem(PlaneIcon, 32)
    psystem:setParticleLifetime(2, 5) -- Particles live at least 2s and at most 5s.
	psystem:setEmissionRate(5)
	psystem:setSizeVariation(1)
	psystem:setLinearAcceleration(-20, -20, 20, 20) -- Random movement in all directions.
	psystem:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.]]
end

function ingame:update(dt)
    BattlefieldUI:update()

    world:update(dt)
    particleworld:update(dt)
    tanks_table:update(dt)
    Ammo.update(dt)
    Airstrike.update(dt)
    --psystem:update(dt)
    
    if cam.scale > 1.5 then
        cam:zoomTo(1.5)
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
        world:draw()
        particleworld:draw()
    cam:detach()
    BattlefieldUI:draw()
end

function ingame:drawWithoutUI()
    cam:attach()
        drawMap()
        world:draw()
    cam:detach()
end
