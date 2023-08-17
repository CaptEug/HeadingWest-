ChapterUI = {}
cityButtons = {}
require 'gamestates/Chapter/Console'
require 'gamestates.Chapter.CityInfoPanel'
require 'gamestates/Chapter/CommandPanel'
require 'Data/Constructure/ConstractureInfoPanel'
require 'Data/Tank/TankDesigner'
require 'Data/Tank/TankInfoPanel'
require 'gamestates/Chapter/ResearchPanel'
require 'Data/Constructure/ConstructMenu'

function ChapterUI:load()
    Console:load()
    TankInfoPanel:load()
    CityInfoPanel:load()
    CommandPanel:load()

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

    CurrentPlace.CommandPanelWindow.open = false
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


    if CurrentPlace.state == 'Battlefield' then

    end
end

function ChapterUI:update(dt)
    Console:update(dt)
    TankInfoPanel:update(dt)
    CityInfoPanel:update(dt)
    CommandPanel:update(dt)
    if CurrentPlace.state == 'Peace' then
        ConstructMenu:update(dt)
        TankDesigner:update(dt)
        
    end
    if CurrentPlace.state == 'Battlefield' then
        
    end
end

function ChapterUI:draw()
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
    CommandPanel:draw()
    if CurrentPlace.state == 'Peace' then
        cityButtons.ConstructButtons:use()
        ConstructMenu:draw()
        for i, building in ipairs(CurrentPlace.exsist_building) do
            if building.name == 'Tank Assembler' then
                cityButtons.TankFacButtons:use()
                TankDesigner:draw()
            end
        end
        
        if CurrentPlace.researchinstitude then
            cityButtons.ResearchInsButtons:use()
            ResearchPanel:draw()
        end
    end
    if CurrentPlace.state == 'Battlefield' then
        
    end
    PenetrateLog()
end