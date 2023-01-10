BattlefieldUI = {}
TankList = {}

function BattlefieldUI:load()
    --table.insert(TankList, T54)
    --drawTankList = false

    Gbuttons = buttons.new()
    Settings = buttons.newToolButton(
        Gear,
        function()
            Gamestate.push(Pause)
        end,
        Gbuttons
    )


    CallAirStrike = buttons.newToolButton(
        PlaneIcon,
        function ()
            if love.mouse.getCursor() ==  bombcursor then
                love.mouse.setCursor(cursor)
            else
                love.mouse.setCursor(bombcursor)
            end
        end,
        Gbuttons
    )

end

function BattlefieldUI:update(dt)
    Settings.bx = 32
    Settings.by = wh - 32
    
end

function BattlefieldUI:draw()
    Gbuttons:use()
    
end

--[[function drawtanklist()
    local locationSet = {{ww-192, 128}, {ww-64, 128}, {ww-192, 256}, {ww-64, 256}}
    
    love.graphics.setColor(1, 1, 1, 0.7)
    love.graphics.rectangle("fill", ww-256, 64, 256, wh-128)
    love.graphics.setColor(1, 1, 1)
    TLButtons = buttons.new()
    for i, pic in pairs(TankList) do
        --love.graphics.draw(pic, unpack(locationSet[i]))
        local TankButton = buttons.newToolButton(
            pic,
            function ()
                
            end,
            TLButtons,
            unpack(locationSet[i])
        )
        TLButtons:use()
    end
end]]