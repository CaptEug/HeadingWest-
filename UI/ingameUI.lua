ingameUI={}
require 'UI/TankDesigner'
require 'UI/TankInfoPanel'

function ingameUI:load()
    TankInfoPanel:load()
    --buttons in captured
    CurrentPlace.Tbuttons = buttons.new()
    DefButtons = buttons.new() 
    RadioStation = buttons.newToolButton(
        RadioStation_icon,
        function ()
            CityData:playRadio(CurrentPlace.songlist)
        end,
        DefButtons,
        ww - 16,
        wh - 16
    )
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

    if CurrentPlace.state == 'Peace' then
        if CurrentPlace.factory == true then
            TankDesigner:load()
        end
    end
    if CurrentPlace.state == 'Battlefield' then

    end
end

function ingameUI:update(dt)
    TankInfoPanel:update(dt)

    if CurrentPlace.state == 'Peace' then
        if CurrentPlace.factory == true then
            TankDesigner:update(dt)
        end
    end
    if CurrentPlace.state == 'Battlefield' then
        
    end
end

function ingameUI:draw()
    TankInfoPanel:draw()
    DefButtons:use()
    if CurrentPlace.state == 'Peace' then
        if CurrentPlace.factory == true then
            Facbutton:use()
            TankDesigner:draw()
        end
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