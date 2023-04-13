TankInfoPanel = {}


function TankInfoPanel:load()
    --add tankinfopanel button
    TPscreen = love.graphics.newCanvas(288, 576)
    TankInfoPanel.window = {x = ww - 288, y = wh/2 - 288, w = 288, h = 576}
    TankInfoPanel.dragging = false
    TankPanelopen = false
    TankChoosen = {}
    Rounds = {}
    PanelButtons = buttons.new()
    ClosePanel = buttons.newWindowToolButton(
        ClosePanel_icon,
        function ()
            TankPanelopen = false
        end,
        TankInfoPanel.window,
        PanelButtons,
        271,
        16
    )

    ManulControl = buttons.newWindowToolButton(
        ManulControl_icon,
        function ()
            for i, tank in ipairs(CurrentPlace.exsist_tank) do
                if tank ~= TankChoosen and tank.functions.move == ManualControlfunction then
                    tank.functions.move = AutoControlfunction
                end
            end
            if TankChoosen.functions.move ~= ManualControlfunction then
                TankChoosen.functions.move = ManualControlfunction
            else
                TankChoosen.functions.move = AutoControlfunction
            end
        end,
        TankInfoPanel.window,
        PanelButtons,
        0 + 40,
        0 + 542
    )

    SetCommander = buttons.newWindowToolButton(
        SetCommander_icon,
        function ()
            TankChoosen.compCom = true
            for i, tank in ipairs(CurrentPlace.exsist_tank) do
                if tank ~= TankChoosen and tank.compCom then
                    tank.compCom = false
                end
            end
        end,
        TankInfoPanel.window,
        PanelButtons,
        0 + 40,
        0 + 488
    )

    Fortify = buttons.newWindowToolButton(
        Fortify_icon,
        function ()
            if TankChoosen.functions.move ~= SetFortified then
                TankChoosen.functions.move = SetFortified
            else
                TankChoosen.functions.move = AutoControlfunction
            end
        end,
        TankInfoPanel.window,
        PanelButtons,
        0 + 108,
        0 + 488
    )
end

function TankInfoPanel:update(dt)
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
        if tank.type == 'Friendly' then
            tank.Infobuttons:use()
        end
    end
    cam:detach()
    --tankinfo on map UI
    for i, tank in ipairs(CurrentPlace.exsist_tank) do
        if tank.compCom then
            local x,y = cam:cameraCoords(tank.location.x, tank.location.y)
            love.graphics.draw(Coms_icon, x - 10, y - 16*cam.scale)
        end
        if tank.picked then
            local x,y = cam:cameraCoords(tank.location.x, tank.location.y)
            love.graphics.draw(Picked_icon, x - 10, y  + 32*cam.scale)
        end
    end
    if TankPanelopen then
        local a=TankChoosen.collider:getAngle()
        local x,y = cam:cameraCoords(TankChoosen.location.x, TankChoosen.location.y)
        love.graphics.draw(Choosen_icon, x - 10, y + 32*cam.scale)
        love.graphics.setCanvas(TPscreen)
        love.graphics.draw(tank_info_panel, 0, 0)
        love.graphics.draw(TankChoosen.hull_image_line, 144, 144, a, 1, 1, 144, 144)
        love.graphics.draw(TankChoosen.armor.hull_image_line, 144, 144, a, 1, 1, 144, 144)
        love.graphics.draw(TankChoosen.turret_image_line, 144, 144, a+TankChoosen.turret_angle, 1, 1, 144, 144)
        love.graphics.draw(TankChoosen.aim.line_image, 144, 144, a+TankChoosen.turret_angle, 1, 1, 144, 144)
        love.graphics.draw(TankChoosen.armor.turret_image_line, 144, 144, a+TankChoosen.turret_angle, 1, 1, 144, 144)
        love.graphics.setFont(Rtextfont)
        love.graphics.setColor(0,179/255,0)
        love.graphics.print(TankChoosen.name..' No.'..TankChoosen.number, 0 + 4, 0 + 4)
        love.graphics.print('Speed: '..string.format("%.1f", TankChoosen.velocity.v/5)..' km/h', 0 + 4, 0 + 268)
        if TankChoosen.reload_timer >= 0 then
            love.graphics.print('Reloading '..string.format("%.1f", TankChoosen.reload_timer)..' s', 0 + 144, 0 + 268)
        end
        love.graphics.setColor(1,1,1)

        PanelButtons:use()
        TankCrewDraw()
        TankAmmoDraw()
        TankStateDraw()
        love.graphics.setCanvas()
        love.graphics.draw(TPscreen, TankInfoPanel.window.x, TankInfoPanel.window.y)
    end
end

function TankCrewDraw()
    local n = 0
    local m = 0

    while n < TankChoosen.crew do
        love.graphics.draw(injured_crew_icon, 144 - 28*TankChoosen.crew/2 + 28*n, 288)
        n = n + 1
    end
    while m < TankChoosen.survivor do
        love.graphics.draw(crew_icon, 144 - 28*TankChoosen.crew/2 + 28*m, 288)
        m = m + 1
    end
end

function TankAmmoDraw()
    local i = 0
    local apfsds = 0
    local he = 0
    local heat = 0
    for i, ammo in ipairs(TankChoosen.ammorack) do
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
    love.graphics.setColor(0,179/255,0)
    if #TankChoosen.ammorack == 0 then
        love.graphics.print('NO AMMO', 0 + 4, 0 + 390)
    end
    if apfsds ~= 0 then
        i = i + 1
        love.graphics.draw(APFSDS_icon, 0 + 36*i - 20, 0 + 390)
        love.graphics.print(apfsds, 0 + 36*i - 8, 0 + 411)
    end
    if he ~= 0 then
        i = i + 1
        love.graphics.draw(HE_icon, 0 + 36*i - 20, 0 + 390)
        love.graphics.print(he, 0 + 36*i - 8, 0 + 411)
    end
    if heat ~= 0 then
        i = i + 1
        love.graphics.draw(HEAT_icon, 0 + 36*i - 20, 0 + 390)
        love.graphics.print(heat, 0 + 36*i - 8, 0 + 411)
    end
    love.graphics.setColor(1,1,1)
end

function TankStateDraw()
    --tank status update
    local s = 1
    if TankChoosen.status.era[1] then
        love.graphics.draw(TankChoosen.status.era[2], 0 + 16, 0 + 48*s)
        s = s + 1
    end
    if TankChoosen.status.onfire[1] then
        love.graphics.draw(TankChoosen.status.onfire[2], 0 + 16, 0 + 48*s)
        s = s + 1
    end
    if TankChoosen.status.immobilized[1] then
        love.graphics.draw(TankChoosen.status.immobilized[2], 0 + 16, 0 + 48*s)
        s = s + 1
    end
    
    if TankChoosen.functions.move == ManualControlfunction then
        love.graphics.draw(ManulControlOn_icon, 0 + 10, 0 + 519)
    end
    if TankChoosen.functions.move == SetFortified then
        love.graphics.draw(FortifyOn_icon, 0 + 78, 0 + 465)
    end
    if TankChoosen.compCom then
        love.graphics.draw(SetCommanderOn_icon, 0 + 10, 0 + 465)
    end
end

--TPscreen.window draggie
function TPmousepressed(x, y, button)
    -- Check if the mouse is inside the TDscreen.window
    if x >= TankInfoPanel.window.x and x <= TankInfoPanel.window.x + TankInfoPanel.window.w and
     y >= TankInfoPanel.window.y and y <= TankInfoPanel.window.y + TankInfoPanel.window.h then
        Cursormode = 'dragging'
        TankInfoPanel.dragging = true
       -- Calculate the offset between the mouse position and the TDscreen.window position
       TankInfoPanel.offsetX = x - TankInfoPanel.window.x
       TankInfoPanel.offsetY = y - TankInfoPanel.window.y
    end
end
 
function TPmousereleased(x, y, button)
    -- Stop dragging when the mouse is released
    TankInfoPanel.dragging = false
end
 
function TPmousemoved(x, y, dx, dy)
    -- Update the TDscreen.window position if the user is dragging it
    if TankInfoPanel.dragging then
        TankInfoPanel.window.x = x - TankInfoPanel.offsetX
        TankInfoPanel.window.y = y - TankInfoPanel.offsetY
    end
end