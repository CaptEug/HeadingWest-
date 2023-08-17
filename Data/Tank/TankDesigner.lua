TankDesigner = {}

function TankDesigner:load()
    CurrentPlace.TankDesignerWindow = Window.new(64, 64, 640, 480)
    CurrentPlace.TankDesignerBuildButtons = Buttons.new()
    TankDesigner.tankindex = 1
    TankDesigner.PageShown = 'Armor'
    TankDesigner.tank_steel_cost = 0
    TankDesigner.tank_oil_cost = 0
    TankDesigner.lack_resource = false
    CurrentPlace.ProductionQueue = {}
    CurrentPlace.ProductionNumber = 0
    CurrentPlace.AssemblerAvailable = true

    --load Buttons
    Close = Buttons.newWindowToolButton(
        Close_icon,
        function ()
            CurrentPlace.TankDesignerWindow.open = false
        end,
        CurrentPlace.TankDesignerWindow,
        CurrentPlace.TankDesignerWindow.buttons,
        0 + 625,
        0 + 18
    )

    Next = Buttons.newWindowToolButton(
        rightArrow,
        function ()
            if TankDesigner.tankindex < #CurrentPlace.tankfactory.tanklist then
                TankDesigner.tankindex = TankDesigner.tankindex + 1
            else
                TankDesigner.tankindex = 1
            end
        end,
        CurrentPlace.TankDesignerWindow,
        CurrentPlace.TankDesignerWindow.buttons,
        0 + 311,
        0 + 331
    )

    Previous = Buttons.newWindowToolButton(
        leftArrow,
        function ()
            if TankDesigner.tankindex > 1 then
                TankDesigner.tankindex = TankDesigner.tankindex - 1
            else
                TankDesigner.tankindex = #CurrentPlace.tankfactory.tanklist
            end
        end,
        CurrentPlace.TankDesignerWindow,
        CurrentPlace.TankDesignerWindow.buttons,
        0 + 56,
        0 + 331
    )

    for i, tank in ipairs(CurrentPlace.tankfactory.tanklist) do
        tank.armor_num = 1
        tank.aim_num = 1
        tank.mob_num = 1

        tank.ammorack = {}
        if tank.missilerack_size then
            tank.missilerack = {}
        end
        tank.ammunition.AButtons = Buttons.new()
        tank.ammunition.isopen = false
        if tank.accessories then
            for n, accessory in ipairs(tank.accessories) do
                accessory.AButtons = Buttons.new()
                accessory.isopen = false
                for i, equipment in ipairs(accessory) do
                    local Equip = Buttons.newWindowToolButton(
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
                    CurrentPlace.TankDesignerWindow,
                    accessory.AButtons,
                    0 + 386,
                    0 + 46 + 46*i,
                    EquipmentSelectHot
                )
                end
            end
        end
        --ammo system
        for i, ammo in ipairs(tank.ammunition) do
            if ammo.type == 'ATGM' then
                ammo.add = Buttons.newWindowToolButton(
                    plus_icon,
                    function ()
                        while #tank.missilerack < tank.missilerack_size do
                            table.insert(tank.missilerack, ammo)
                        end
                    end,
                    CurrentPlace.TankDesignerWindow,
                    tank.ammunition.AButtons,
                    0 + 429,
                    0 + 56 + 46*i
                )
                ammo.remove = Buttons.newWindowToolButton(
                    minus_icon,
                    function ()
                        for n, missile in ipairs(tank.missilerack) do
                            if missile.name == ammo.name then
                                table.remove(tank.missilerack, n)
                                break
                            end
                        end
                    end,
                    CurrentPlace.TankDesignerWindow,
                    tank.ammunition.AButtons,
                    0 + 407,
                    0 + 56 + 46*i
                )
            else
                ammo.add = Buttons.newWindowToolButton(
                    plus_icon,
                    function ()
                        while #tank.ammorack < tank.ammorack_size do
                            table.insert(tank.ammorack, ammo)
                        end
                    end,
                    CurrentPlace.TankDesignerWindow,
                    tank.ammunition.AButtons,
                    0 + 429,
                    0 + 56 + 46*i
                )
                ammo.remove = Buttons.newWindowToolButton(
                    minus_icon,
                    function ()
                        for n, bullet in ipairs(tank.ammorack) do
                            if bullet.name == ammo.name then
                                table.remove(tank.ammorack, n)
                                break
                            end
                        end
                    end,
                    CurrentPlace.TankDesignerWindow,
                    tank.ammunition.AButtons,
                    0 + 407,
                    0 + 56 + 46*i
                )
            end
        end
    end

    Armor = Buttons.newWindowToolButton(
        Armor_icon,
        function ()
            TankDesigner.PageShown = 'Armor'
        end,
        CurrentPlace.TankDesignerWindow,
        CurrentPlace.TankDesignerWindow.buttons,
        0 + 72,
        0 + 391
    )

    Aiming = Buttons.newWindowToolButton(
        Aiming_icon,
        function ()
            TankDesigner.PageShown = 'Aim'
        end,
        CurrentPlace.TankDesignerWindow,
        CurrentPlace.TankDesignerWindow.buttons,
        0 + 126,
        0 + 391
    )

    Mobility = Buttons.newWindowToolButton(
        Mobility_icon,
        function ()
            TankDesigner.PageShown = 'Mob'
        end,
        CurrentPlace.TankDesignerWindow,
        CurrentPlace.TankDesignerWindow.buttons,
        0 + 180,
        0 + 391
    )

    Ammunition = Buttons.newWindowToolButton(
        Ammo_icon,
        function ()
            TankDesigner.PageShown = 'Ammo'
        end,
        CurrentPlace.TankDesignerWindow,
        CurrentPlace.TankDesignerWindow.buttons,
        0 + 234,
        0 + 391
    )

    Build = Buttons.newWindowToolButton(
        Build_icon,
        function ()
            local tank = copytable(TankPresent)
            TankDesigner:slot_distribution(CurrentPlace, tank)
            table.insert(CurrentPlace.ProductionQueue, 1, tank)
            CurrentPlace.ProductionNumber = CurrentPlace.ProductionNumber + 1
            CostResource(TankDesigner.tank_steel_cost, TankDesigner.tank_oil_cost)
        end,
        CurrentPlace.TankDesignerWindow,
        CurrentPlace.TankDesignerBuildButtons,
        405,
        391,
        Build_icon,
        Build_Hot
    )

    Delete = Buttons.newWindowToolButton(
        Delete_icon,
        function ()
            table.remove(CurrentPlace.ProductionQueue, 1)
        end,
        CurrentPlace.TankDesignerWindow,
        CurrentPlace.TankDesignerWindow.buttons,
        0 + 567,
        0 + 79
    )

end


function TankDesigner:update(dt)
    --pageshown detection
    if TankDesigner.PageShown == 'Armor' then
        for i, accessory in ipairs(CurrentPlace.tankfactory.tanklist[TankDesigner.tankindex].accessories) do
            if i == 1 then
                accessory.isopen = true
            else
                accessory.isopen = false
            end
        end
    end
    if TankDesigner.PageShown == 'Aim' then
        for i, accessory in ipairs(CurrentPlace.tankfactory.tanklist[TankDesigner.tankindex].accessories) do
            if i == 2 then
                accessory.isopen = true
            else
                accessory.isopen = false
            end
        end
    end
    if TankDesigner.PageShown == 'Mob' then
        for i, accessory in ipairs(CurrentPlace.tankfactory.tanklist[TankDesigner.tankindex].accessories) do
            if i == 3 then
                accessory.isopen = true
            else
                accessory.isopen = false
            end
        end
    end
    if TankDesigner.PageShown == 'Ammo' then
        for i, accessory in ipairs(CurrentPlace.tankfactory.tanklist[TankDesigner.tankindex].accessories) do
            accessory.isopen = false
        end
    end
    --resource check
    if CurrentPlace.steel_stored < TankDesigner.tank_steel_cost or CurrentPlace.oil_stored < TankDesigner.tank_oil_cost then
        TankDesigner.lack_resource = true
    else
        TankDesigner.lack_resource = false
    end

    --tank production process
    for i, tank in ipairs(CurrentPlace.ProductionQueue) do
        if tank.buildtime <= 0 then
            table.remove(CurrentPlace.ProductionQueue, i)
            CurrentPlace.ProductionNumber = CurrentPlace.ProductionNumber - 1
        end
        if tank.buildtime == tank.fixedbuildtime then
            --if CurrentPlace.AssemblerAvailable then
                TankDesigner:slot_distribution(CurrentPlace, tank)
            --end
        end
    end
end


function TankDesigner:draw()

    TankPresent = CurrentPlace.tankfactory.tanklist[TankDesigner.tankindex]
        
    CurrentPlace.TankDesignerWindow:use(
        function ()
            TankDesigner.tank_steel_cost = TankPresent.steel_cost + TankPresent.accessories[1][TankPresent.armor_num].steel_cost + TankPresent.accessories[2][TankPresent.aim_num].steel_cost + TankPresent.accessories[3][TankPresent.mob_num].steel_cost
            TankDesigner.tank_oil_cost = TankPresent.oil_cost + TankPresent.accessories[1][TankPresent.armor_num].oil_cost + TankPresent.accessories[2][TankPresent.aim_num].oil_cost + TankPresent.accessories[3][TankPresent.mob_num].oil_cost
            love.graphics.draw(TankDesigner_screen, 0, 0)
            love.graphics.setFont(Rbuttonfont)
            love.graphics.print(CurrentPlace.tankfactory.name, 0 + 40, 0)
            love.graphics.setFont(Rtextfont)
            love.graphics.setColor(0,179/255,0)
            love.graphics.print(TankPresent.name, 0 + 40 + 6, 0 + 64 + 6)
            love.graphics.print(tostring(TankDesigner.tank_steel_cost), 0 + 40 + 246, 0 + 64 + 6)
            love.graphics.print(tostring(TankDesigner.tank_oil_cost), 0 + 40 + 246, 0 + 64 + 26)
            love.graphics.setColor(1,1,1)

            if TankPresent.accessories then
                for i, accessory in ipairs(TankPresent.accessories) do
                    if accessory.isopen then
                        accessory.AButtons:use()
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

            if TankDesigner.PageShown == 'Ammo' then
                TankPresent.ammunition.AButtons:use()
                love.graphics.setColor(0,179/255,0)
                --[[if TankChoosen.ammorack_size then
                    love.graphics.print('Rounds:'..#TankPresent.ammorack..'/'..TankPresent.ammorack_size, 328 + 6, 64 + 6)
                end
                if TankChoosen.missilerack_size then
                    love.graphics.print('Missiles:'..#TankPresent.missilerack..'/'..TankPresent.missilerack_size, 328 + 6, 84 + 6)
                end]]
            
                for i, ammo in ipairs(TankPresent.ammunition) do
                    local n = 0
                    for i, bullet in ipairs(TankPresent.ammorack) do
                        if bullet.name == ammo.name then
                            n = n + 1
                        end
                    end
                    if TankPresent.missilerack then
                        for i, missile in ipairs(TankPresent.missilerack) do
                            if missile.name == ammo.name then
                                n = n + 1
                            end
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
            --draw production queue
            for i, tank in ipairs(CurrentPlace.ProductionQueue) do
                love.graphics.draw(production_box,0 + 452, 0 + 62 + 28*i)
                love.graphics.setColor(0,179/255,0)
                love.graphics.print(tank.name, 0 + 456, 0 + 66 + 28*i)
                love.graphics.rectangle('fill', 0 + 456, 0 + 80 + 28*i, 132 - (132*tank.buildtime/tank.fixedbuildtime), 4)
                love.graphics.setColor(1,1,1)
            end

            if not TankDesigner.lack_resource then
                CurrentPlace.TankDesignerBuildButtons:use()
            else
                love.graphics.print('Not Enough Resource',405,391)
            end

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
        end
    )
end

function TankDesigner:slot_distribution(place, tank)
    local slot_full = true
    for i, assembler in ipairs(place.exsist_building) do
        if assembler.name == 'Tank Assembler' then
            if assembler.slot then
                assembler.vehicle = tank
                assembler.vehicle.collider = CurrentPlace.world:newRectangleCollider(assembler.location.x + (assembler.width - assembler.vehicle.width)/2, assembler.location.y + (assembler.length - assembler.vehicle.length)/2, assembler.vehicle.width, assembler.vehicle.length)
                assembler.vehicle.collider:setType('static')
                assembler.slot = false
                slot_full = false
                break
            end
        end
    end
    if slot_full then
        place.AssemblerAvailable = false
    end
end