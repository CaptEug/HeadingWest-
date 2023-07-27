CityUI = {}
cityButtons = {}
require 'gamestates/city/Console'
require 'gamestates.city.CityInfoPanel'
require 'Data/Constructure/ConstractureInfoPanel'
require 'Data/Tank/TankDesigner'
require 'Data/Tank/TankInfoPanel'
require 'Data/Constructure/ConstructMenu'

function CityUI:load()
    Console:load()
    TankInfoPanel:load()
    CityInfoPanel:load()

    --Buttons in captured
    cityButtons.DefButtons = Buttons.new()
    Settings = Buttons.newToolButton(
        Gear,
        function()
            Gamestate.push(Pause)
        end,
        cityButtons.DefButtons,
        16,
        wh - 16
    )
    RadioStation = Buttons.newToolButton(
        RadioStation_icon,
        function ()
            Cities:playRadio(CurrentPlace.songlist)
        end,
        cityButtons.DefButtons,
        ww - 16,
        wh - 16
    )
    CityInfoPanel_button = Buttons.newToolButton(
        CityInfoPanel_icon,
        function ()
            if CurrentPlace.CityInfoPanelWindow.open then
                CurrentPlace.CityInfoPanelWindow.open = false
            else
                CurrentPlace.CityInfoPanelWindow.open = true
            end
        end,
        cityButtons.DefButtons
    )

    if CurrentPlace.state == 'Peace' then
        ConstructMenu:load()
        cityButtons.ConstructButtons = Buttons.new()
        ConstructMenu_button = Buttons.newToolButton(
            Constructmenu_icon,
            function ()
                if CurrentPlace.ConstructMenuWindow.open then
                    CurrentPlace.ConstructMenuWindow.open = false
                else
                    CurrentPlace.ConstructMenuWindow.open = true
                end
            end,
            cityButtons.ConstructButtons,
            80
        )
        if CurrentPlace.tankfactory then
            TankDesigner:load()
            cityButtons.TankFacButtons = Buttons.new()
            FacDesigner = Buttons.newToolButton(
                Tankdesigner_icon,
                function ()
                    if CurrentPlace.TankDesignerWindow.open then
                        CurrentPlace.TankDesignerWindow.open = false
                    else
                        CurrentPlace.TankDesignerWindow.open = true
                    end
                end,
                cityButtons.TankFacButtons,
                48
            )
        end
        if CurrentPlace.researchinstitude then
            --TankDesigner:load()
            cityButtons.ResearchInsButtons = Buttons.new()
            TechTree = Buttons.newToolButton(
                TechTreePanel_icon,
                function ()
                    --[[if CurrentPlace.TankDesignerWindow.open then
                        CurrentPlace.TankDesignerWindow.open = false
                    else
                        CurrentPlace.TankDesignerWindow.open = true
                    end]]
                end,
                cityButtons.ResearchInsButtons,
                112
            )
        end
    end
    if CurrentPlace.state == 'Battlefield' then

    end
end

function CityUI:update(dt)
    Console:update(dt)
    TankInfoPanel:update(dt)
    CityInfoPanel:update(dt)
    if CurrentPlace.state == 'Peace' then
        ConstructMenu:update(dt)
        if CurrentPlace.tankfactory then
            TankDesigner:update(dt)
        end
    end
    if CurrentPlace.state == 'Battlefield' then
        
    end
end

function CityUI:draw()
    love.graphics.setFont(Rtextfont)
    love.graphics.draw(Steel_icon, ww-128)
    love.graphics.print(tostring(math.floor(CurrentPlace.steel_stored)), ww-96)
    love.graphics.print('+'..CurrentPlace.steel_production, ww-96, 16)
    love.graphics.draw(Oil_icon, ww-128, 32)
    love.graphics.print(tostring(math.floor(CurrentPlace.oil_stored)), ww-96, 32)
    love.graphics.print('+'..CurrentPlace.oil_production, ww-96, 48)

    cityButtons.DefButtons:use()
    Console:draw()
    TankInfoPanel:draw()
    ConstructureInfoPanel:draw()
    CityInfoPanel:draw()
    if CurrentPlace.state == 'Peace' then
        cityButtons.ConstructButtons:use()
        ConstructMenu:draw()
        if CurrentPlace.tankfactory then
            cityButtons.TankFacButtons:use()
            TankDesigner:draw()
        end
        if CurrentPlace.researchinstitude then
            cityButtons.ResearchInsButtons:use()
            --TankDesigner:draw()
        end
    end
    if CurrentPlace.state == 'Battlefield' then
        
    end
    PenetrateLog()
end