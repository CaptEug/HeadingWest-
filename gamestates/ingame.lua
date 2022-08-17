ingame = {}
ingame = Gamestate.new()
require "entity_test.tanks_new"

function ingame:init()
    MapNumber=1
    Saving:getdata(Filenumber)
    Data()
    
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