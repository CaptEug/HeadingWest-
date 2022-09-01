ingame = {}
ingame = Gamestate.new()
require "entity_test.tanks_new"
require 'UI/ingameUI'

function ingame:init()
    
    Saving:getdata(Filenumber)
    Data()

    local map=Maps[MapNumber]
    loadMap(map)
    ingameUI:load()

end

function ingame:update(dt)
    ingameUI:update()

    world:update(dt)
    tanks_table:update(dt)
    Ammo.update(dt)
    Airstrike.update(dt)
    
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
    cam:detach()
    ingameUI:draw()
end

function ingame:drawWithoutUI()
    cam:attach()
        drawMap()
        world:draw()
    cam:detach()
end
