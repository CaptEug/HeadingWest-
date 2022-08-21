ingameUI = {}

function ingameUI:load()
    Gbuttons = buttons.new()
    Settings = buttons.newToolButton(
        Gear,
        function()
            Gamestate.push(Pause)
        end,
        Gbuttons
    )

    --[[TankSummon = buttons.newToolButton(
        TankIcon,
        function ()
            
        end,
        Gbuttons
    )]]--
end

function ingameUI:update()
    local ww, wh = love.graphics.getDimensions()
    Settings.bx = 32
    Settings.by = wh - 32
end

function ingameUI:draw()
    Gbuttons:use()
end