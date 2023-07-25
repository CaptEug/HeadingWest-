CityInfoPanel = {}

function CityInfoPanel:load()
    CurrentPlace.CityInfoPanelWindow = Window.new(64, 64, 432, 560)

    ArmyPage = Buttons.newWindowToolButton(
        ArmyPage_icon,
        function ()

        end,
        CurrentPlace.CityInfoPanelWindow,
        CurrentPlace.CityInfoPanelWindow.buttons,
        29,
        64
    )

    ResourcePage = Buttons.newWindowToolButton(
        ResourcePage_icon,
        function ()

        end,
        CurrentPlace.CityInfoPanelWindow,
        CurrentPlace.CityInfoPanelWindow.buttons,
        29,
        128
    )
end

function CityInfoPanel:update(dt)

end

function CityInfoPanel:draw()
    CurrentPlace.CityInfoPanelWindow:use(
        function ()
            love.graphics.draw(CityInfoPanel_screen)
            love.graphics.setColor(0,0,0)
            love.graphics.setFont(Rheadfont)
            love.graphics.print(CurrentPlace.name, 232 - Rheadfont:getWidth(CurrentPlace.name)/2, 24)
        end
    )
end