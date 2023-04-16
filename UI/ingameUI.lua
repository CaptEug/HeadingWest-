ingameUI={}
require 'UI/TankDesigner'
require 'UI/TankInfoPanel'
require 'UI/ArmyEditor'

function ingameUI:load()
    TankInfoPanel:load()
    ArmyEditor:load()
    if CurrentPlace.state == 'Peace' then
        if CurrentPlace.factory then
            TankDesigner:load()
        end
    end
    if CurrentPlace.state == 'Battlefield' then

    end

    --buttons in captured
    CurrentPlace.Tbuttons = buttons.new()
    DefButtons = buttons.new() 
    RadioStation = buttons.newToolButton(
        RadioStation_icon,
        function ()
            Cities:playRadio(CurrentPlace.songlist)
        end,
        DefButtons,
        ww - 16,
        wh - 16
    )
    ArmyEditor_button = buttons.newToolButton(
        ArmyEditor_icon,
        function ()
            if CurrentPlace.openArmyEditor then
                CurrentPlace.openArmyEditor = false
            else
                CurrentPlace.openArmyEditor = true
            end
        end,
        DefButtons,
        48
    )

    TankFacButtons = buttons.new()
    FacDesigner = buttons.newToolButton(
        Tankdesigner_icon,
        function ()
            if CurrentPlace.openTankDesigner then
                CurrentPlace.openTankDesigner = false
            else
                CurrentPlace.openTankDesigner = true
            end
        end,
        TankFacButtons
    )

    --[[ConstructButtons = buttons.new()
    ConstructMenu_button = buttons.newToolButton(
        Constructmenu_icon,
        function ()
            if CurrentPlace.openConstructMenu then
                CurrentPlace.openConstructMenu = false
            else
                CurrentPlace.openConstructMenu = true
            end
        end,
        ConstructButtons
    )]]
end

function ingameUI:update(dt)
    TankInfoPanel:update(dt)
    ArmyEditor:update(dt)
    if CurrentPlace.state == 'Peace' then
        if CurrentPlace.factory then
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
        if CurrentPlace.factory then
            TankFacButtons:use()
            TankDesigner:draw()
        end
    end
    if CurrentPlace.state == 'Battlefield' then
        
    end
    PenetrateLog()
end