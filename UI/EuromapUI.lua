EuromapUI = {}

require 'UI/TankFactories'

function EuromapUI:load()
    Year = 1946

    TankFactories:load()

    Ebuttons = buttons.new()
    Settings = buttons.newToolButton(
        Gear,
        function()
            Gamestate.push(Pause)
        end,
        Ebuttons
    )

    Cbuttons = buttons.new()
    Cbuttons.ison = true
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
            if KMDB.isopen then
                KMDB.isopen = false
            else
                KMDB.isopen = true
            end
            Cbuttons.ison = false
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
        if Cbuttons.ison then
            Cbuttons:use()
        end
    cam:detach()
    TankFactories:draw()
    love.graphics.setFont(Rtitlefont)
    love.graphics.print(tostring(math.floor(Year)), love.graphics.getWidth() / 2 - Rtitlefont:getWidth(tostring(math.floor(Year))) / 2, 0)
    
end