EuromapUI = {}

require 'UI/buttonList'

function EuromapUI:load()
    Year = 1946

    buttonList:load()
    Ebuttons = buttons.new()
    Settings = buttons.newToolButton(
        Gear,
        function()
            Gamestate.push(Pause)
        end,
        Ebuttons
    )

    Cbuttons = buttons.new()
    Berlin = buttons.newCamButton(
        Berlin_Bear,
        function ()
            MapNumber=1
            Saving:fileload()
        end,
        Cbuttons
    )

    UVZ = buttons.newCamButton(
        UVZ_Icon,
        function ()
            if UVZ_list.drawlist then
                UVZ_list.drawlist = false
            else
                UVZ_list.drawlist = true
            end
        end,
        Cbuttons
    )
end

function EuromapUI:update(dt)
    Year = Year + dt / 10
    Settings.bx = 32
    Settings.by = wh - 32

    Berlin.bx = 1835
    Berlin.by = 1345
    UVZ.bx = 3100
    UVZ.by = 1200
    
end

function EuromapUI:draw()
    Ebuttons:use()

    cam:attach()
        if cam.scale >= 0.5 then
        Cbuttons:use()
        end
        buttonList:draw()
    cam:detach()

    love.graphics.setFont(Rtitlefont)
    love.graphics.print(tostring(math.floor(Year)), love.graphics.getWidth() / 2 - Rtitlefont:getWidth(tostring(math.floor(Year))) / 2, 0)
    
end