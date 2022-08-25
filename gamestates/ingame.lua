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
    Target = {}
    Target.hp = 100
    Target.collider = world:newCircleCollider(200,200,300)
    Target.collider:setCollisionClass('Amour')
    Target.collider:setObject(Target)

    
end

function ingame:update(dt)
    ingameUI:update()

    world:update(dt)
    tanks_table:update(dt)
    Ammo.update(dt)

    if Target.hp <= 0 then
        Target.collider:destroy()
    end

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
        world:draw()
    cam:detach()
    ingameUI:draw()
    love.graphics.print(tostring(Target.hp), 100, 100)
end

function ingame:drawWithoutUI()
    cam:attach()
        drawMap()
        world:draw()
    cam:detach()
end