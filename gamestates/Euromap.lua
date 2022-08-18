Euromap = {}
Euromap = Gamestate.new()

function Euromap:init()
    
end

function Euromap:update()
    
end

function Euromap:draw()
    cam:attach()
        DrawEurope()
        DrawCountries()
    cam:detach()
    
    love.graphics.setFont(Rtitlefont)
    love.graphics.print(Year, love.graphics.getWidth() / 2 - Rtitlefont:getWidth("SAVED FILES") / 2, love.graphics.getHeight() / 13)
end