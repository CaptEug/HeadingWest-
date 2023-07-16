CityUI = {}
citybuttons = {}
require 'gamestates/city/Console'
require 'gamestates.city.CityInfoPenal'
require 'Data/Constructure/ConstractureInfoPanel'
require 'Data/Tank/TankDesigner'
require 'Data/Tank/TankInfoPanel'
require 'Data/Constructure/ConstructMenu'

function CityUI:load()
    Console:load()
    TankInfoPanel:load()
    CityInfoPenal:load()

    --buttons in captured
    citybuttons.DefButtons = buttons.new()
    Settings = buttons.newToolButton(
        Gear,
        function()
            Gamestate.push(Pause)
        end,
        citybuttons.DefButtons,
        16,
        wh - 16
    )
    RadioStation = buttons.newToolButton(
        RadioStation_icon,
        function ()
            Cities:playRadio(CurrentPlace.songlist)
        end,
        citybuttons.DefButtons,
        ww - 16,
        wh - 16
    )
    CityInfoPenal_button = buttons.newToolButton(
        CityInfoPenal_icon,
        function ()
            if CurrentPlace.openCityInfoPenal then
                CurrentPlace.openCityInfoPenal = false
            else
                CurrentPlace.openCityInfoPenal = true
            end
        end,
        citybuttons.DefButtons
    )

    if CurrentPlace.state == 'Peace' then
        ConstructMenu:load()
        citybuttons.ConstructButtons = buttons.new()
        ConstructMenu_button = buttons.newToolButton(
            Constructmenu_icon,
            function ()
                if CurrentPlace.openConstructMenu then
                    CurrentPlace.openConstructMenu = false
                else
                    CurrentPlace.openConstructMenu = true
                end
            end,
            citybuttons.ConstructButtons,
            80
        )
        if CurrentPlace.tankfactory then
            TankDesigner:load()
            citybuttons.TankFacButtons = buttons.new()
            FacDesigner = buttons.newToolButton(
                Tankdesigner_icon,
                function ()
                    if CurrentPlace.openTankDesigner then
                        CurrentPlace.openTankDesigner = false
                    else
                        CurrentPlace.openTankDesigner = true
                    end
                end,
                citybuttons.TankFacButtons,
                48
            )
        end
    end
    if CurrentPlace.state == 'Battlefield' then

    end
end

function CityUI:update(dt)
    Console:update(dt)
    TankInfoPanel:update(dt)
    CityInfoPenal:update(dt)
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
    love.graphics.print(tostring(math.floor(Steel)), ww-96)
    love.graphics.print('+'..SteelProduction, ww-96, 16)
    love.graphics.draw(Oil_icon, ww-128, 32)
    love.graphics.print(tostring(math.floor(Oil)), ww-96, 32)
    love.graphics.print('+'..OilProduction, ww-96, 48)

    citybuttons.DefButtons:use()
    Console:draw()
    TankInfoPanel:draw()
    ConstructureInfoPanel:draw()
    CityInfoPenal:draw()
    if CurrentPlace.state == 'Peace' then
        citybuttons.ConstructButtons:use()
        ConstructMenu:draw()
        if CurrentPlace.tankfactory then
            citybuttons.TankFacButtons:use()
            TankDesigner:draw()
        end
    end
    if CurrentPlace.state == 'Battlefield' then
        
    end
    PenetrateLog()
end