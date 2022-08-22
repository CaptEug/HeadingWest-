ingameUI = {}

TankIcon = love.graphics.newImage('Assets/pictures/Tank_Icon') 

function ingameUI:load()
    Gbuttons = buttons.new()
    Settings = buttons.newToolButton(
        Gear,
        function()
            Gamestate.push(Pause)
        end,
        Gbuttons
    )

    TankSummon = buttons.newToolButton(
        TankIcon,
        function ()
            
        end,
        Gbuttons
    )
end

function ingameUI:update(dt)
    Settings.bx = 32
    Settings.by = wh - 32
    TankSummon.bx = ww - 32
    TankSummon.by = 32
end

function ingameUI:draw()
    Gbuttons:use()
    love.graphics.rectangle("fill", ww-200, 50, 200, wh-100)
end