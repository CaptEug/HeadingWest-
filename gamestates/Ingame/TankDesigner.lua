TankDesigner = {}

function TankDesigner:load()
    TDscreen = love.graphics.newCanvas(640, 480)
    TankDesigner.window = {x = 0, y = 32, w = 640, h = 64}
    TankDesigner.dragging = false
    TankDesigner.Buttons = buttons.new()
    TankDesigner.tankindex = 1
    TankDesigner.PageShown = 'Armor'
    TankDesigner.tank_steel_cost = 0
    TankDesigner.tank_oil_cost = 0
    CurrentPlace.openTankDesigner = false
    CurrentPlace.ProductionQueue = {}
    CurrentPlace.ProductionNumber = 0

    --load buttons
    Close = buttons.newWindowToolButton(
        Close_icon,
        function ()
            CurrentPlace.openTankDesigner = false
        end,
        TankDesigner.window,
        TankDesigner.Buttons,
        0 + 625,
        0 + 18
    )

    Next = buttons.newWindowToolButton(
        rightArrow,
        function ()
            if TankDesigner.tankindex < #CurrentPlace.tanklist then
                TankDesigner.tankindex = TankDesigner.tankindex + 1
            else
                TankDesigner.tankindex = 1
            end
        end,
        TankDesigner.window,
        TankDesigner.Buttons,
        0 + 311,
        0 + 331
    )

    Previous = buttons.newWindowToolButton(
        leftArrow,
        function ()
            if TankDesigner.tankindex > 1 then
                TankDesigner.tankindex = TankDesigner.tankindex - 1
            else
                TankDesigner.tankindex = #CurrentPlace.tanklist
            end
        end,
        TankDesigner.window,
        TankDesigner.Buttons,
        0 + 56,
        0 + 331
    )

    for i, tank in ipairs(CurrentPlace.tanklist) do
        tank.armor_num = 1
        tank.aim_num = 1
        tank.mob_num = 1

        tank.ammorack = {}
        tank.ammunition.Abuttons = buttons.new()
        tank.ammunition.isopen = false
        if tank.accessories then
            for n, accessory in ipairs(tank.accessories) do
                accessory.Abuttons = buttons.new()
                accessory.isopen = false
                for i, equipment in ipairs(accessory) do
                    local Equip = buttons.newWindowToolButton(
                    EquipmentSelect,
                    function ()
                        if equipment.tag == 'Armor' then
                            tank.armor_num = i
                        end
                        if equipment.tag == 'Aim' then
                            tank.aim_num = i
                        end
                        if equipment.tag == 'Mob' then
                            tank.mob_num = i
                        end
                    end,
                    TankDesigner.window,
                    accessory.Abuttons,
                    0 + 386,
                    0 + 46 + 46*i,
                    EquipmentSelectHot
                )
                end
            end
        end
        --ammo system
        for i, ammo in ipairs(tank.ammunition) do
            ammo.add = buttons.newWindowToolButton(
                plus_icon,
                function ()
                    if #tank.ammorack < tank.ammorack_size then
                        table.insert(tank.ammorack, ammo)
                    end
                end,
                TankDesigner.window,
                tank.ammunition.Abuttons,
                0 + 429,
                0 + 56 + 46*i
            )
            ammo.remove = buttons.newWindowToolButton(
                minus_icon,
                function ()
                    for i, bullet in ipairs(tank.ammorack) do
                        if bullet.name == ammo.name then
                            table.remove(tank.ammorack, i)
                            break
                        end
                    end
                end,
                TankDesigner.window,
                tank.ammunition.Abuttons,
                0 + 407,
                0 + 56 + 46*i
            )
        end
    end

    Armor = buttons.newWindowToolButton(
        Armor_icon,
        function ()
            TankDesigner.PageShown = 'Armor'
        end,
        TankDesigner.window,
        TankDesigner.Buttons,
        0 + 72,
        0 + 391
    )

    Aiming = buttons.newWindowToolButton(
        Aiming_icon,
        function ()
            TankDesigner.PageShown = 'Aim'
        end,
        TankDesigner.window,
        TankDesigner.Buttons,
        0 + 126,
        0 + 391
    )

    Mobility = buttons.newWindowToolButton(
        Mobility_icon,
        function ()
            TankDesigner.PageShown = 'Mob'
        end,
        TankDesigner.window,
        TankDesigner.Buttons,
        0 + 180,
        0 + 391
    )

    Ammunition = buttons.newWindowToolButton(
        Ammo_icon,
        function ()
            TankDesigner.PageShown = 'Ammo'
        end,
        TankDesigner.window,
        TankDesigner.Buttons,
        0 + 234,
        0 + 391
    )

    Build = buttons.newWindowToolButton(
        Build_icon,
        function ()
            local tank = copytable(TankPresent)
            tank.selected_slot = TankDesigner:slot_distribution(CurrentPlace)
            table.insert(CurrentPlace.ProductionQueue, 1, tank)
            CurrentPlace.ProductionNumber = CurrentPlace.ProductionNumber + 1
        end,
        TankDesigner.window,
        TankDesigner.Buttons,
        0 + 405,
        0 + 391,
        Build_icon,
        Build_Hot
    )

    Delete = buttons.newWindowToolButton(
        Delete_icon,
        function ()
            table.remove(CurrentPlace.ProductionQueue, 1)
        end,
        TankDesigner.window,
        TankDesigner.Buttons,
        0 + 567,
        0 + 79
    )

end


function TankDesigner:update(dt)
    --pageshown detection
    if TankDesigner.PageShown == 'Armor' then
        CurrentPlace.tanklist[TankDesigner.tankindex].ammunition.isopen = false
        for i, accessory in ipairs(CurrentPlace.tanklist[TankDesigner.tankindex].accessories) do
            if i == 1 then
                accessory.isopen = true
            else
                accessory.isopen = false
            end
        end
    end
    if TankDesigner.PageShown == 'Aim' then
        CurrentPlace.tanklist[TankDesigner.tankindex].ammunition.isopen = false
        for i, accessory in ipairs(CurrentPlace.tanklist[TankDesigner.tankindex].accessories) do
            if i == 2 then
                accessory.isopen = true
            else
                accessory.isopen = false
            end
        end
    end
    if TankDesigner.PageShown == 'Mob' then
        CurrentPlace.tanklist[TankDesigner.tankindex].ammunition.isopen = false
        for i, accessory in ipairs(CurrentPlace.tanklist[TankDesigner.tankindex].accessories) do
            if i == 3 then
                accessory.isopen = true
            else
                accessory.isopen = false
            end
        end
    end
    if TankDesigner.PageShown == 'Ammo' then
        for i, accessory in ipairs(CurrentPlace.tanklist[TankDesigner.tankindex].accessories) do
            accessory.isopen = false
        end
        CurrentPlace.tanklist[TankDesigner.tankindex].ammunition.isopen = true
    end
    --tank production process
    for i, tank in ipairs(CurrentPlace.ProductionQueue) do
        if tank.selected_slot ~= 0 then
            tank.buildtime = tank.buildtime - dt
        else
            tank.selected_slot = TankDesigner:slot_distribution(CurrentPlace)
        end
        if tank.buildtime <= 0 then
            Buildtank(CurrentPlace, table.remove(CurrentPlace.ProductionQueue, i), 'friendly', CurrentPlace.slot_info[tank.selected_slot].x, CurrentPlace.slot_info[tank.selected_slot].y)
            CurrentPlace.ProductionNumber = CurrentPlace.ProductionNumber - 1
            CurrentPlace.slot_info[tank.selected_slot].available = true
            tank.selected_slot = nil
        end
    end
end


function TankDesigner:draw()

    TankPresent = CurrentPlace.tanklist[TankDesigner.tankindex]

    if CurrentPlace.openTankDesigner then
    love.graphics.setCanvas(TDscreen)
        TankDesigner.tank_steel_cost = TankPresent.steel_cost + TankPresent.accessories[1][TankPresent.armor_num].steel_cost + TankPresent.accessories[2][TankPresent.aim_num].steel_cost + TankPresent.accessories[3][TankPresent.mob_num].steel_cost
        TankDesigner.tank_oil_cost = TankPresent.oil_cost + TankPresent.accessories[1][TankPresent.armor_num].oil_cost + TankPresent.accessories[2][TankPresent.aim_num].oil_cost + TankPresent.accessories[3][TankPresent.mob_num].oil_cost
        love.graphics.draw(TankDesigner_screen, 0, 0)
        love.graphics.setFont(Rbuttonfont)
        love.graphics.print(CurrentPlace.factory, 0 + 40, 0)
        love.graphics.setFont(Rtextfont)
        love.graphics.setColor(0,179/255,0)
        love.graphics.print(TankPresent.name, 0 + 40 + 6, 0 + 64 + 6)
        love.graphics.print(tostring(TankDesigner.tank_steel_cost), 0 + 40 + 246, 0 + 64 + 6)
        love.graphics.print(tostring(TankDesigner.tank_oil_cost), 0 + 40 + 246, 0 + 64 + 26)
        love.graphics.setColor(1,1,1)

        if TankPresent.accessories then
            for i, accessory in ipairs(TankPresent.accessories) do
                if accessory.isopen then
                    accessory.Abuttons:use()
                    for i, equipment in ipairs(accessory) do
                        love.graphics.setFont(Rtextfont)
                        love.graphics.setColor(0,179/255,0)
                        love.graphics.print(equipment.name, 0 + 336, 0 + 24 + 46*i)
                        if equipment == TankPresent.accessories[1][TankPresent.armor_num] or equipment == TankPresent.accessories[2][TankPresent.aim_num] or equipment == TankPresent.accessories[3][TankPresent.mob_num] then
                            love.graphics.setColor(0,179/255,0)
                            love.graphics.rectangle("fill", 0 + 332, 0 + 24 + 46*i, 108, 44)
                            love.graphics.setColor(34/255,32/255,52/255)
                            love.graphics.print(equipment.name, 0 + 336, 0 + 24 + 46*i)
                        end
                        love.graphics.setColor(1,1,1)
                    end
                end
            end
        end

        if TankPresent.ammunition.isopen then
            TankPresent.ammunition.Abuttons:use()
            love.graphics.setColor(0,179/255,0)
            love.graphics.print('Rounds:'..#TankPresent.ammorack..'/'..TankPresent.ammorack_size, 0 + 328 + 6, 0 + 64 + 6)
            
            for i, ammo in ipairs(TankPresent.ammunition) do
                local n = 0
                for i, bullet in ipairs(TankPresent.ammorack) do
                    if bullet.name == ammo.name then
                        n = n + 1
                    end
                end
                love.graphics.print(ammo.name, 0 + 328 + 6, 0 + 46 + 46*i)
                love.graphics.print(n, 0 + 328 + 6, 0 + 56 + 46*i)
            end
            love.graphics.setColor(1,1,1)
        end

        love.graphics.draw(TankPresent.hull_image_line, 0 + 40, 0 + 64)
        love.graphics.draw(TankPresent.accessories[1][TankPresent.armor_num].hull_image_line, 0 + 40, 0 + 64)
        love.graphics.draw(TankPresent.turret_image_line, 0 + 40, 0 + 64)
        love.graphics.draw(TankPresent.accessories[1][TankPresent.armor_num].turret_image_line, 0 + 40, 0 + 64)
        love.graphics.draw(TankPresent.accessories[2][TankPresent.aim_num].line_image, 0 + 40, 0 + 64)
        love.graphics.draw(TankPresent.accessories[3][TankPresent.mob_num].line_image, 0 + 40, 0 + 64)

        for i, tank in ipairs(CurrentPlace.ProductionQueue) do
            love.graphics.draw(production_box,0 + 452, 0 + 62 + 28*i)
            love.graphics.setColor(0,179/255,0)
            love.graphics.print(tank.name, 0 + 456, 0 + 66 + 28*i)
            love.graphics.rectangle('fill', 0 + 456, 0 + 80 + 28*i, 132 - (132*tank.buildtime/tank.fixedbuildtime), 4)
            love.graphics.setColor(1,1,1)
        end

        TankDesigner.Buttons:use()
        if TankDesigner.PageShown == 'Armor' then
            love.graphics.draw(Armor_Hot, 0 + 46, 0 + 356)
        end
        if TankDesigner.PageShown == 'Aim' then
            love.graphics.draw(Aiming_Hot, 0 + 100, 0 + 356)
        end
        if TankDesigner.PageShown == 'Mob' then
            love.graphics.draw(Mobility_Hot, 0 + 154, 0 + 356)
        end
        if TankDesigner.PageShown == 'Ammo' then
            love.graphics.draw(Ammo_Hot, 0 + 208, 0 + 356)
        end
    love.graphics.setCanvas()
        love.graphics.draw(TDscreen, TankDesigner.window.x, TankDesigner.window.y)
    end
end

function TankDesigner:slot_distribution(place)
    local slot_full = true
    local selected_slot
    for i, slot in ipairs(place.slot_info) do
        if slot.available==true then
            slot.available=false
            selected_slot=i
            slot_full=false
            break
        end
    end
    if slot_full==true then
        selected_slot=0
    end
    return selected_slot
end

--TDscreen.window draggie
function TDmousepressed(x, y, button)
    -- Check if the mouse is inside the TDscreen.window
    if x >= TankDesigner.window.x and x <= TankDesigner.window.x + TankDesigner.window.w and
     y >= TankDesigner.window.y and y <= TankDesigner.window.y + TankDesigner.window.h then
        Cursormode = 'dragging'
        TankDesigner.dragging = true
       -- Calculate the offset between the mouse position and the TDscreen.window position
       TankDesigner.offsetX = x - TankDesigner.window.x
       TankDesigner.offsetY = y - TankDesigner.window.y
    end
end
 
function TDmousereleased(x, y, button)
    -- Stop dragging when the mouse is released
    TankDesigner.dragging = false
end
 
function TDmousemoved(x, y, dx, dy)
    -- Update the TDscreen.window position if the user is dragging it
    if TankDesigner.dragging then
        TankDesigner.window.x = x - TankDesigner.offsetX
        TankDesigner.window.y = y - TankDesigner.offsetY
    end
end