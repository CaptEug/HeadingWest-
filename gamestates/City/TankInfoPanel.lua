TankInfoPanel = {}


function TankInfoPanel:load()
    --add tankinfopanel button
    TPscreen = love.graphics.newCanvas(288, 352)
    TankInfoPanel.window = {x = 0, y = 256, w = 288, h = 352}
    TankInfoPanel.dragging = false
    TankPanelopen = false
    TankChoosen = {}
    TankInfoPanel.Buttons = buttons.new()
    TankInfoPanel.SPGButtons = buttons.new()
    TankInfoPanel.blinkTimer = 0
    TankInfoPanel.blinkInterval = 0.2
    TankInfoPanel.iconVisible = true


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
        TankInfoPanel.Buttons,
        256,
        256+64
    )


    Deploy = buttons.newWindowToolButton(
        Deploy_icon,
        function ()
            TankChoosen:Setdeployed()
        end,
        TankInfoPanel.window,
        TankInfoPanel.SPGButtons,
        256,
        208+64
    )
end

function TankInfoPanel:update(dt)
    --tankbutton pos update
    for i, tank in ipairs(CurrentPlace.exsist_tank) do
        for n, button in ipairs(tank.Infobuttons) do
            button.bx, button.by = tank.image_location.x, tank.image_location.y
        end
    end
    --blinkTimer update
    TankInfoPanel.blinkTimer = TankInfoPanel.blinkTimer + dt
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
        if tank.picked then
            local x,y = cam:cameraCoords(tank.location.x, tank.location.y)
            love.graphics.draw(Picked_icon, x - 10, y  + 32*cam.scale)
        end
    end
    if TankPanelopen then
        local a = TankChoosen.collider:getAngle()
        local x,y = cam:cameraCoords(TankChoosen.location.x, TankChoosen.location.y)
        local tx, ty = TankChoosen.turret_offset*math.sin(a), TankChoosen.turret_offset*math.cos(a)
        love.graphics.draw(Choosen_icon, x - 10, y + 32*cam.scale)

    love.graphics.setCanvas(TPscreen)
        love.graphics.draw(tank_info_panel, 0, 0)
        love.graphics.draw(TankChoosen.hull_image_line, 144, 144, a, 1, 1, 144, 144)
        love.graphics.draw(TankChoosen.armor.hull_image_line, 144, 144, a, 1, 1, 144, 144)
        love.graphics.draw(TankChoosen.turret_image_line, 144 - tx, 144 + ty, a+TankChoosen.turret_angle, 1, 1, 144, 144+TankChoosen.turret_offset)
        love.graphics.draw(TankChoosen.aim.line_image, 144 - tx, 144 + ty, a+TankChoosen.turret_angle, 1, 1, 144, 144+TankChoosen.turret_offset)
        love.graphics.draw(TankChoosen.armor.turret_image_line, 144 - tx, 144 + ty, a+TankChoosen.turret_angle, 1, 1, 144, 144+TankChoosen.turret_offset)
        love.graphics.draw(Fuel_icon, 259, 8)
        love.graphics.setColor(0,179/255,0)
        love.graphics.rectangle("fill", 259, 32, 24, -24*TankChoosen.fuel/TankChoosen.fuel_capacity)
        love.graphics.setColor(1,1,1)
        love.graphics.draw(Fuel_mask, 259, 8)
        love.graphics.setFont(Rtextfont)
        love.graphics.setColor(0,179/255,0)
        love.graphics.print(TankChoosen.name..' No.'..TankChoosen.number, 0 + 4, 0 + 4)
        love.graphics.print('Speed: '..string.format("%.1f", TankChoosen.velocity.v/5)..' km/h', 0 + 4, 0 + 332)
        if TankChoosen.reload_timer >= 0 then
            love.graphics.print('Reloading '..string.format("%.1f", TankChoosen.reload_timer)..' s',  144 - Rtextfont:getWidth('Reloading '..string.format("%.1f", TankChoosen.reload_timer)..' s')/2, 0 + 240)
        end
        if TankChoosen.deploy_timer >= 0 then
            love.graphics.print('Deploying '..string.format("%.1f", TankChoosen.deploy_timer)..' s', 0 + 128, 0 + 332)
        end
        love.graphics.setColor(1,1,1)

        TankInfoPanel.Buttons:use()
        if TankChoosen.class == 'spg' then
            TankInfoPanel.SPGButtons:use()
        end
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

    if TankInfoPanel.iconVisible then
        while n < TankChoosen.crew do
            love.graphics.draw(injured_crew_icon, 144 - 28*TankChoosen.crew/2 + 28*n, 255)
            n = n + 1
        end
        while m < TankChoosen.survivor do
            love.graphics.draw(crew_icon, 144 - 28*TankChoosen.crew/2 + 28*m, 255)
            m = m + 1
        end
    end
    
end

function TankAmmoDraw()
    love.graphics.setColor(0,179/255,0)
    if #TankChoosen.ammorack == 0 then
        love.graphics.print('NO AMMO', 0 + 4, 0 + 318)
    else
        love.graphics.print('AMMO '..#TankChoosen.ammorack..'/'..TankChoosen.ammorack_size, 0 + 4, 0 + 318)
    end
    love.graphics.setColor(1,1,1)
end

function TankStateDraw()
    --tank status update
    local s = 1
    if TankChoosen.status.era then
        love.graphics.draw(ERA_icon, 0 + 16, 0 + 48*s)
        s = s + 1
    end
    if TankChoosen.status.onfire then
        love.graphics.draw(Onfire_icon, 0 + 16, 0 + 48*s)
        s = s + 1
    end
    if TankChoosen.status.immobilized then
        love.graphics.draw(Immobilized_icon, 0 + 16, 0 + 48*s)
        s = s + 1
    end
    -- Check if it's time to toggle the icon's visibility
    if TankChoosen.status.penetrated then
        if TankInfoPanel.blinkTimer >= TankInfoPanel.blinkInterval and TankChoosen.status.penetrated then
            TankInfoPanel.blinkTimer = 0
            TankInfoPanel.iconVisible = not TankInfoPanel.iconVisible
        end
    else
        TankInfoPanel.iconVisible = true
    end

    if TankChoosen.functions.move == ManualControlfunction then
        love.graphics.draw(ManualControlOn_icon, 0 + 232, 0 + 232+64)
    end

    if TankChoosen.deployed then
        love.graphics.draw(DeployOn_icon, 0 + 232, 0 + 184+64)
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