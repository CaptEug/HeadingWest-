ingame = {}
ingame = Gamestate.new()
require "entity_test.tanks_new"

function ingame:init()
    Saving:getdata(Filenumber)
    Data()
    MapNumber=Data.MapNumber

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

    loadMap(Maps[MapNumber])

    Target = {}
    Target.hp = 100
    Target.collider = world:newCircleCollider(200,200,300)
    Target.collider:setCollisionClass('Amour')
    Target.collider:setObject(Target)

    
end

function ingame:update(dt)
    local ww, wh = love.graphics.getDimensions()
    Settings.bx = 32
    Settings.by = wh - 32
    
    world:update(dt)
    tanks_table:update(dt)
    Ammo.update(dt)

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
    Gbuttons:use()
    love.graphics.print(tostring(Target.hp), 100, 100)
end

function ingame:drawWithoutButton()
    cam:attach()
        drawMap()
        world:draw()
    cam:detach()
end