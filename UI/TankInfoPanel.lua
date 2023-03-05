TankInfoPanel = {}


function TankInfoPanel:load()
    --add tankinfopanel button
    TankPanelopen = false
    TankChoosen = {}
    Rounds = {}
    PanelButtons = buttons.new()
    ClosePanel = buttons.newToolButton(
        ClosePanel_icon,
        function ()
            TankPanelopen = false
        end,
        PanelButtons
    )

    ManulControl = buttons.newToolButton(
        ManulControl_icon,
        function ()
            if TankChoosen.functions.move ~= ManulControlfunction then
                TankChoosen.functions.move = ManulControlfunction
            else
                TankChoosen.functions.move = AutoControlfunction
            end 
        end,
        PanelButtons,
        ww - 288 + 40,
        wh/2 - 286 + 538
    )

    SetCommander = buttons.newToolButton(
        SetCommander_icon,
        function ()
            
        end,
        PanelButtons,
        ww - 288 + 40,
        wh/2 - 286 + 484
    )

end

function TankInfoPanel:update(dt)
    ClosePanel.bx = ww - 17
    ClosePanel.by = wh/2 - 269
    ManulControl.bx = ww - 288 + 40
    ManulControl.by = wh/2 - 286 + 538
    SetCommander.bx = ww - 288 + 40
    SetCommander.by = wh/2 - 286 + 484
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
        local n = 0
        local i = 0
        local apfsds = 0
        local he = 0
        local heat = 0
        for i, ammo in ipairs(TankChoosen.data.ammorack) do
            if ammo.type == 'APFSDS' then
                apfsds = apfsds + 1
            end
            if ammo.type == 'HE' then
                he = he + 1
            end
            if ammo.type == 'HEAT' then
                heat = heat + 1
            end
        end

        love.graphics.draw(tank_info_panel, ww - 288, wh/2 - 286)
        love.graphics.draw(TankChoosen.data.hull_image_line, ww - 144, wh/2 - 142, a, 1, 1, 144, 144)
        love.graphics.draw(TankChoosen.data.armor.hull_image_line, ww - 144, wh/2 - 142, a, 1, 1, 144, 144)
        love.graphics.draw(TankChoosen.data.turret_image_line, ww - 144, wh/2 - 142, a+TankChoosen.data.turret_angle, 1, 1, 144, 144)
        love.graphics.draw(TankChoosen.data.aim.line_image, ww - 144, wh/2 - 142, a+TankChoosen.data.turret_angle, 1, 1, 144, 144)
        love.graphics.draw(TankChoosen.data.armor.turret_image_line, ww - 144, wh/2 - 142, a+TankChoosen.data.turret_angle, 1, 1, 144, 144)
        love.graphics.setFont(Rtextfont)
        love.graphics.setColor(0,179/255,0)
        love.graphics.print(TankChoosen.data.name, ww - 288 + 4, wh/2 - 286 + 4)
        love.graphics.print('Speed: '..string.format("%.1f", TankChoosen.collider:getLinearVelocity()/math.cos(a - 0.5*math.pi)/5)..' km/h', ww - 288 + 4, wh/2 - 286 + 268)
        if apfsds ~= 0 then
            i = i + 1
            love.graphics.draw(APFSDS_icon, ww - 288 + 36*i - 20, wh/2 - 286 + 390)
            love.graphics.print(apfsds, ww - 288 + 36*i - 8, wh/2 - 286 + 411)
        end
        if he ~= 0 then
            i = i + 1
            love.graphics.draw(HE_icon, ww - 288 + 36*i - 20, wh/2 - 286 + 390)
            love.graphics.print(he, ww - 288 + 36*i - 8, wh/2 - 286 + 411)
        end
        love.graphics.setColor(1,1,1)

        while n < TankChoosen.data.crew do
            love.graphics.draw(crew_icon, ww - 144 - 28*TankChoosen.data.crew/2 + 28*n, wh/2)
            n = n + 1
        end

        PanelButtons:use()
        --tank status update
        for i, pic in ipairs(TankChoosen.status) do
            love.graphics.draw(pic, ww - 288 + 16, wh/2 - 286 + 48*i)
        end
        if TankChoosen.functions.move == ManulControlfunction then
            love.graphics.draw(ManulControlOn_icon, ww - 288 + 10, wh/2 - 286 + 515)
        end
    end
end