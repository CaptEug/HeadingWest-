ingameUI = {}

TankIcon = love.graphics.newImage('Assets/pictures/Tank_Icon.png') 

function ingameUI:load()
    drawTankList = false

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
            drawTankList = true
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
    if drawTankList then
        drawtanklist()
    end
end

function drawtanklist()
    love.graphics.setColor(1, 1, 1, 0.7)
    love.graphics.rectangle("fill", ww-200, 64, 200, wh-128)
    love.graphics.setColor(1, 1, 1)
end