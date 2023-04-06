ingame = {}
ingame = Gamestate.new()
require "entity_test.tanks_new"
require 'UI.ingameUI'
require 'libraries/TimeToShoot'
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

    --[[Saving:getdata(Filenumber)
    Data()]]

    local map=Maps[MapNumber]
    loadMap(map)
    ingameUI:load()

    selection = {}
    selection.active = false

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
    TankSpawner:update(dt)
    TankProjectiles:update(dt)
    --cam contral
    if cam.scale > 2 then
        cam:zoomTo(2)
    end
    if cam.scale < 0.2 then
        cam:zoomTo(0.2)
    end
    --mouse square selection
    function love.mousepressed(x, y, button)
        if button == 1 and Cursormode == 'normal' then
            selection.active = true
            selection.startX = x
            selection.startY = y
        end
    end
    function love.mousereleased(x, y, button)
        if button == 1 and selection.active then
            selection.active = false
            selection.endX = x
            selection.endY = y
        end
        if selection.startX ~= selection.endX and selection.startY ~= selection.endY then
            for i, tank in ipairs(CurrentPlace.exsist_tank) do
                local x,y = cam:cameraCoords(tank.location.x, tank.location.y)
                if ((x > selection.startX and x < selection.endX) or (x < selection.startX and x > selection.endX)) and 
                ((y > selection.startY and y < selection.endY) or (y < selection.startY and y > selection.endY)) then
                    tank.picked = true
                else
                    tank.picked = false
                end
            end
        end
    end
end

function ingame:draw()
    cam:attach()
        drawMap()
        world:draw()
        particleworld:draw()
        Shelltrails:draw()
    cam:detach()
    --draw selection
    if selection.active and Cursormode == 'normal' then
        love.graphics.setColor(0,179/255,0)
        love.graphics.rectangle("line", selection.startX, selection.startY,
        love.mouse.getX() - selection.startX, love.mouse.getY() - selection.startY)
    end

    ingameUI:draw()
    Gbuttons:use()
end

function ingame:drawWithoutUI()
    cam:attach()
        drawMap()
        world:draw()
    cam:detach()
end
