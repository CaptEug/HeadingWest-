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
        local offset_x=TankChoosen.data.hull_image:getWidth()/2
        local offset_y=TankChoosen.data.hull_image:getHeight()/2+TankChoosen.data.turret_offset
        local n = 0
        love.graphics.draw(tank_info_panel, ww - 288, wh/2 - 286)
        love.graphics.draw(TankChoosen.data.hull_image_line, ww - 144, wh/2 - 142, a, 1, 1, offset_x, offset_y)
        love.graphics.draw(TankChoosen.data.armor.hull_image_line, ww - 144, wh/2 - 142, a, 1, 1, offset_x, offset_y)
        love.graphics.draw(TankChoosen.data.turret_image_line, ww - 144, wh/2 - 142, a+TankChoosen.data.turret_angle, 1, 1, offset_x, offset_y)
        love.graphics.draw(TankChoosen.data.aim.line_image, ww - 144, wh/2 - 142, a+TankChoosen.data.turret_angle, 1, 1, offset_x, offset_y)
        love.graphics.draw(TankChoosen.data.armor.turret_image_line, ww - 144, wh/2 - 142, a+TankChoosen.data.turret_angle, 1, 1, offset_x, offset_y)
        love.graphics.setFont(Rtextfont)
        love.graphics.setColor(0,179/255,0)
        love.graphics.print(TankChoosen.data.name, ww - 288 + 4, wh/2 - 286 + 4)
        love.graphics.print('Speed: '..string.format("%.1f", TankChoosen.collider:getLinearVelocity()/math.cos(a - 0.5*math.pi)/5)..' km/h', ww - 288 + 4, wh/2 - 286 + 268)
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

AutoControlfunction = function (i,dt)
    
end

ManulControlfunction = function (i,dt)
    local hp = 50*CurrentPlace.exsist_tank[i].data.mob.hp*0.745
    local fx = hp*math.cos(CurrentPlace.exsist_tank[i].collider:getAngle() - 0.5*math.pi)
    local fy = hp*math.sin(CurrentPlace.exsist_tank[i].collider:getAngle() - 0.5*math.pi)
    local max_f = CurrentPlace.exsist_tank[i].data.max_f_speed
    local max_r = CurrentPlace.exsist_tank[i].data.max_r_speed
    local speed = CurrentPlace.exsist_tank[i].collider:getLinearVelocity()/math.cos(CurrentPlace.exsist_tank[i].collider:getAngle() - 0.5*math.pi)/5
    local ta = CurrentPlace.exsist_tank[i].data.turret_angle + CurrentPlace.exsist_tank[i].collider:getAngle() - 0.5*math.pi
    local mx, my = cam:mousePosition()
    local tx, ty = CurrentPlace.exsist_tank[i].collider:getPosition()
    local angle_to_mouse = math.atan2(my - ty, mx - tx)

    if love.keyboard.isDown('up') and speed <= max_f then
        CurrentPlace.exsist_tank[i].collider:applyForce(fx, fy)
    end
    if love.keyboard.isDown('down') and speed >= max_r then
        CurrentPlace.exsist_tank[i].collider:applyForce(-fx, -fy)
    end
    if love.keyboard.isDown('left') then
        CurrentPlace.exsist_tank[i].collider:applyTorque(-5*hp)
    end
    if love.keyboard.isDown('right') then
        CurrentPlace.exsist_tank[i].collider:applyTorque(5*hp)
    end

    if angle_to_mouse <= 0 then
        angle_to_mouse = angle_to_mouse + math.pi*2
    end
    while ta > 2*math.pi do
        ta = ta - 2*math.pi
    end
    while ta < 0 do
        ta = ta + 2*math.pi
    end
    if ta > angle_to_mouse then
        if ta - angle_to_mouse <= math.pi then
            CurrentPlace.exsist_tank[i].data.turret_angle = CurrentPlace.exsist_tank[i].data.turret_angle - 0.5*dt
        else
            CurrentPlace.exsist_tank[i].data.turret_angle = CurrentPlace.exsist_tank[i].data.turret_angle + 0.5*dt
        end
    end
    if ta < angle_to_mouse then
        if angle_to_mouse - ta <= math.pi then
            CurrentPlace.exsist_tank[i].data.turret_angle = CurrentPlace.exsist_tank[i].data.turret_angle + 0.5*dt
        else
            CurrentPlace.exsist_tank[i].data.turret_angle = CurrentPlace.exsist_tank[i].data.turret_angle - 0.5*dt
        end
    end
end