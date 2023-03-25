ingameUI={}
require 'UI/TankDesigner'
require 'UI/TankInfoPanel'
require 'UI/ArmyEditor'

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
    ArmyEditor_button = buttons.newToolButton(
        ArmyEditor_icon,
        function ()
            if CurrentPlace.openarmyeditor then
                CurrentPlace.openarmyeditor = false
            else
                CurrentPlace.openarmyeditor = true
            end
        end,
        DefButtons,
        48
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
    ArmyEditor:draw()
    if CurrentPlace.state == 'Peace' then
        if CurrentPlace.factory == true then
            Facbutton:use()
            TankDesigner:draw()
        end
    end
    if CurrentPlace.state == 'Battlefield' then
        
    end
    TankProjectiles:draw()
end