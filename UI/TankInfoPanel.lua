TankInfoPanel = {}


function TankInfoPanel:load()
    --add tankinfopanel button
    TankPanelopen = false
    PanelButtons = buttons.new()
    ClosePanel = buttons.newToolButton(
        ClosePanel_icon,
        function ()
            TankPanelopen = false
        end,
        PanelButtons
    )

end

function TankInfoPanel:update(dt)
    ClosePanel.x, ClosePanel.y = ww - 17, wh/2 - 279
    --tankbutton pos update
    for i, tank in ipairs(CurrentPlace.exsist_tank) do
        for i, button in ipairs(tank.Infobuttons) do
            button.x, button.y = tank.collider:getPosition()
        end
    end
end

function TankInfoPanel:draw()
    cam:attach()
    for i,tank in ipairs(CurrentPlace.exsist_tank) do
        tank.Infobuttons:use()
    end
    cam:detach()
    if TankPanelopen then
        love.graphics.draw(tank_info_panel, ww-288, wh/2 - 286)
        PanelButtons:use()
    end
end

function TankChoosen(tank)
    
end