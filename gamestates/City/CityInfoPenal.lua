CityInfoPenal = {}

function CityInfoPenal:load()
    CurrentPlace.CityInfoPenalWindow = Window.new(64, 64, 432, 560)

end

function CityInfoPenal:update(dt)

end

function CityInfoPenal:draw()
    CurrentPlace.CityInfoPenalWindow:use(
        function ()
            love.graphics.draw(CityInfoPenal_screen)
        end
    )
end