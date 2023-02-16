TankInfoPanel = {}


function TankInfoPanel:load()
    --add tankinfopanel button
    TankPanelopen = false
    TankChoosen = {}
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
    ClosePanel.bx = ww - 17
    ClosePanel.by = wh/2 - 269
    --tankbutton pos update
    for i, tank in ipairs(CurrentPlace.exsist_tank) do
        for i, button in ipairs(tank.Infobuttons) do
            button.bx, button.by = tank.collider:getPosition()
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
        local a=TankChoosen.collider:getAngle()
        local offset_x=TankChoosen.data.hull_image:getWidth()/2
        local offset_y=TankChoosen.data.hull_image:getHeight()/2+TankChoosen.data.turret_offset
        local n = 0
        love.graphics.draw(tank_info_panel, ww - 288, wh/2 - 286)
        love.graphics.draw(TankChoosen.data.hull_image_line, ww - 144, wh/2 - 142, a, 1, 1, offset_x, offset_y)
        love.graphics.draw(TankChoosen.data.armor.hull_image_line, ww - 144, wh/2 - 142, a, 1, 1, offset_x, offset_y)
        love.graphics.draw(TankChoosen.data.turret_image_line, ww - 144, wh/2 - 142, a, 1, 1, offset_x, offset_y)
        love.graphics.draw(TankChoosen.data.aim.line_image, ww - 144, wh/2 - 142, a, 1, 1, offset_x, offset_y)
        love.graphics.draw(TankChoosen.data.armor.turret_image_line, ww - 144, wh/2 - 142, a, 1, 1, offset_x, offset_y)
        love.graphics.setFont(Rtextfont)
        love.graphics.setColor(0,179/255,0)
        love.graphics.print(TankChoosen.data.name, ww - 288 + 4, wh/2 - 286 + 4)
        love.graphics.setColor(1,1,1)
        while n < TankChoosen.data.crew do
            love.graphics.draw(crew_icon, ww - 144 - 28*TankChoosen.data.crew/2 + 28*n, wh/2)
            n = n + 1
        end
        PanelButtons:use()
    end
end