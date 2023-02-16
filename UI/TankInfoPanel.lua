TankInfoPanel = {}

function TankInfoPanel:load()
    --add tankinfopanel button
    for i,tank in ipairs(CurrentPlace.exsist_tank) do
        tank.Infobutton = buttons.new()
        local button = buttons.newCamButton(
            invisible_button,
            function ()
                TankPanelopen = true
                TankInfoPanel(tank)
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

function TankInfoPanel:draw()
    
end