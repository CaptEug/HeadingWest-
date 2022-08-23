EuromapUI = {}

function EuromapUI:load()
    Year = 1946

    Ebuttons = buttons.new()
    Settings = buttons.newToolButton(
        Gear,
        function()
            Saving:fileload()
        end,
        Ebuttons
    )

end

function EuromapUI:update(dt)
    Year = Year + dt / 10
    Settings.bx = 32
    Settings.by = wh - 32
    
end

function EuromapUI:draw()
    Ebuttons:use()
    
    love.graphics.setFont(Rtitlefont)
    love.graphics.print(tostring(math.floor(Year)), love.graphics.getWidth() / 2 - Rtitlefont:getWidth(tostring(math.floor(Year))) / 2, 0)
    
end