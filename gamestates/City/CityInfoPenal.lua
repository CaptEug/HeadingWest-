CityInfoPenal = {}

function CityInfoPenal:load()
    CurrentPlace.CityInfoPenalWindow = Window.new(64, 64, 432, 560)

    ArmyPage = Buttons.newWindowToolButton(
        ArmyPage_icon,
        function ()

        end,
        CurrentPlace.CityInfoPenalWindow,
        CurrentPlace.CityInfoPenalWindow.buttons,
        29,
        64
    )

    ResourcePage = Buttons.newWindowToolButton(
        ResourcePage_icon,
        function ()

        end,
        CurrentPlace.CityInfoPenalWindow,
        CurrentPlace.CityInfoPenalWindow.buttons,
        29,
        128
    )
end

function CityInfoPenal:update(dt)

end

function CityInfoPenal:draw()
    CurrentPlace.CityInfoPenalWindow:use(
        function ()
            love.graphics.draw(CityInfoPenal_screen)
            love.graphics.setColor(0,0,0)
            love.graphics.setFont(Rheadfont)
            love.graphics.print(CurrentPlace.name, 232 - Rheadfont:getWidth(CurrentPlace.name)/2, 24)
        end
    )
end