TankInfoPanel = {}


function TankInfoPanel:load()
    --add tankinfopanel button
    TPscreen = love.graphics.newCanvas(288, 288)
    TankInfoPanel.window = {x = ww - 288, y = wh - 320, w = 288, h = 288}
    TankInfoPanel.dragging = false
    TankPanelopen = false
    TankChoosen = {}
    TankInfoPanel.Pbuttons = buttons.new()
    ClosePanel = buttons.newWindowToolButton(
        ClosePanel_icon,
        function ()
            TankPanelopen = false
        end,
        TankInfoPanel.window,
        TankInfoPanel.Pbuttons,
        271,
        16
    )

    ManulControl = buttons.newWindowToolButton(
        ManualControl_icon,
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
        TankInfoPanel.Pbuttons,
        0 + 256,
        0 + 256
    )
end

function TankInfoPanel:update(dt)
    --tankbutton pos update
    for i, tank in ipairs(CurrentPlace.exsist_tank) do
        for n, button in ipairs(tank.Infobuttons) do
            button.bx, button.by = tank.image_location.x, tank.image_location.y
        end
    end
end

function TankInfoPanel:draw()
    cam:attach()
    for i,tank in ipairs(CurrentPlace.exsist_tank) do
        if tank.type == 'friendly' then
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
            love.graphics.print('Reloading '..string.format("%.1f", TankChoosen.reload_timer)..' s', 0 + 128, 0 + 268)
        end
        if TankChoosen.deploy_timer >= 0 then
            love.graphics.print('Deploying '..string.format("%.1f", TankChoosen.deploy_timer)..' s', 0 + 128, 0 + 254)
        end
        love.graphics.setColor(1,1,1)

        TankInfoPanel.Pbuttons:use()
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
        love.graphics.draw(injured_crew_icon, 144 - 28*TankChoosen.crew/2 + 28*n, 224)
        n = n + 1
    end
    while m < TankChoosen.survivor do
        love.graphics.draw(crew_icon, 144 - 28*TankChoosen.crew/2 + 28*m, 224)
        m = m + 1
    end
end

function TankAmmoDraw()
    love.graphics.setColor(0,179/255,0)
    if #TankChoosen.ammorack == 0 then
        love.graphics.print('NO AMMO', 0 + 4, 0 + 254)
    else
        love.graphics.print('AMMO '..#TankChoosen.ammorack..'/'..TankChoosen.ammorack_size, 0 + 4, 0 + 254)
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
        love.graphics.draw(ManualControlOn_icon, 0 + 232, 0 + 232)
    end
    if TankChoosen.fortified then
        love.graphics.draw(FortifyOn_icon, 0 + 78, 0 + 465)
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