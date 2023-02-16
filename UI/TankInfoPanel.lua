TankInfoPanel = {}
TankPanelopen = false

function TankInfoPanel:load()
    --add tankinfopanel button
    for i,tank in ipairs(CurrentPlace.exsist_tank) do
        tank.Infobutton = buttons.new()
        local button = buttons.newCamButton(
            invisible_button,
            function ()
                TankPanelopen = true
                TankInfoPanel:draw(tank)
            end,
            tank.Infobutton
        )
    end
end

function TankInfoPanel:update()
    --tankbutton pos update
    for i, tank in ipairs(CurrentPlace.exsist_tank) do
        for i, button in ipairs(tank.Infobutton) do
            button.x, button.y = tank.hullcollider:getPosition()
        end
    end
end

function TankInfoPanel:draw(tank)
    if TankPanelopen then
        love.graphics.draw(tank_info_panel, 0, ww - 288)
    end

    for i,tank in ipairs(CurrentPlace.tankstock) do
        tank.Infobutton:use()
    end
end