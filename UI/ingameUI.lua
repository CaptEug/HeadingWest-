ingameUI={}
require 'UI/TankDesigner'

function ingameUI:load()
    --buttons in captured 
    Facbutton = buttons.new()
    FacDesigner = buttons.newToolButton(
        Tankdesigner_icon,
        function ()
            if CurrentPlace.opendesigner then
                CurrentPlace.opendesigner = false
            else
                CurrentPlace.opendesigner = true
            end
        end,
        Facbutton
    )

    if CurrentPlace.state == 'Captured' then
        TankDesigner:load()
    end
    if CurrentPlace.state == 'Battlefield' then
        
    end
end

function ingameUI:update(dt)
    if CurrentPlace.state == 'Captured' then
        TankDesigner:update(dt)
    end
    if CurrentPlace.state == 'Battlefield' then
        
    end
end

function ingameUI:draw()
    if CurrentPlace.state == 'Captured' then
        Facbutton:use()
        TankDesigner:draw()
    end
    if CurrentPlace.state == 'Battlefield' then
        
    end
end

--[[function drawtanklist()
    local locationSet = {{ww-192, 128}, {ww-64, 128}, {ww-192, 256}, {ww-64, 256}}
    
    love.graphics.setColor(1, 1, 1, 0.7)
    love.graphics.rectangle("fill", ww-256, 64, 256, wh-128)
    love.graphics.setColor(1, 1, 1)
    TLButtons = buttons.new()
    for i, pic in pairs(TankList) do
        --love.graphics.draw(pic, unpack(locationSet[i]))
        local TankButton = buttons.newToolButton(
            pic,
            function ()
                
            end,
            TLButtons,
            unpack(locationSet[i])
        )
        TLButtons:use()
    end
end]]