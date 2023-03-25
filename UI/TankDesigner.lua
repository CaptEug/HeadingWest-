TankDesigner = {}

function TankDesigner:load()
    CurrentPlace.opendesigner = false
    CurrentPlace.Fbuttons = buttons.new()
    CurrentPlace.tankindex = 1
    CurrentPlace.Pageshown = 'Armor'
    CurrentPlace.ProductionQueue = {}
    CurrentPlace.ProductionNumber = 0
    --load buttons
        Close = buttons.newToolButton(
            Close_icon,
            function ()
                CurrentPlace.opendesigner = false
            end,
            CurrentPlace.Fbuttons,
            ww/2 + 320 - 15,
            wh/2 - 240 + 18
        )

        Next = buttons.newToolButton(
            rightArrow,
            function ()
                if CurrentPlace.tankindex < #CurrentPlace.tanklist then
                    CurrentPlace.tankindex = CurrentPlace.tankindex + 1
                else
                    CurrentPlace.tankindex = 1
                end
            end,
            CurrentPlace.Fbuttons,
            ww/2 - 320 + 311,
            wh/2 - 240 + 331
        )

        Previous = buttons.newToolButton(
            leftArrow,
            function ()
                if CurrentPlace.tankindex > 1 then
                    CurrentPlace.tankindex = CurrentPlace.tankindex - 1
                else
                    CurrentPlace.tankindex = table.getn(CurrentPlace.tanklist)
                end
            end,
            CurrentPlace.Fbuttons,
            ww/2 - 320 + 56,
            wh/2 - 240 + 331
        )

        for i, tank in ipairs(CurrentPlace.tanklist) do
            tank.equipment = {}
            tank.equipment.armor = tank.accessories[1][1] or Blank_Gear
            tank.equipment.aim = tank.accessories[2][1] or Blank_Gear
            tank.equipment.mob = tank.accessories[3][1] or Blank_Gear
            tank.ammorack = {}
            tank.ammunition.Abuttons = buttons.new()
            tank.ammunition.isopen = false
            if tank.accessories then
                for i, accessory in ipairs(tank.accessories) do
                    accessory.Abuttons = buttons.new()
                    accessory.isopen = false
                    for i, equipment in ipairs(accessory) do
                        local Equip = buttons.newToolButton(
                        EquipmentSelect,
                        function ()
                            if equipment.tag == 'Armor' then
                                tank.equipment.armor = equipment
                            end
                            if equipment.tag == 'Aim' then
                                tank.equipment.aim = equipment
                            end
                            if equipment.tag == 'Mob' then
                                tank.equipment.mob = equipment
                            end
                        end,
                        accessory.Abuttons,
                        ww/2 - 320 + 386,
                        wh/2 - 240 + 46 + 46*i,
                        EquipmentSelectHot
                    )
                    end
                end
            end
            --ammo system
            for i, ammo in ipairs(tank.ammunition) do
               ammo.add = buttons.newToolButton(
                    plus_icon,
                    function ()
                        if table.getn(tank.ammorack) < tank.ammorack_size then
                            table.insert(tank.ammorack, ammo)
                        end
                    end,
                    tank.ammunition.Abuttons,
                    ww/2 - 320 + 429,
                    wh/2 - 240 + 56 + 46*i
               )
               ammo.remove = buttons.newToolButton(
                    minus_icon,
                    function ()
                        for i, bullet in ipairs(tank.ammorack) do
                            if bullet.name == ammo.name then
                                table.remove(tank.ammorack, i)
                                break
                            end
                        end
                    end,
                    tank.ammunition.Abuttons,
                    ww/2 - 320 + 407,
                    wh/2 - 240 + 56 + 46*i
               )
            end
        end

        Armor = buttons.newToolButton(
            Armor_icon,
            function ()
                CurrentPlace.Pageshown = 'Armor'
            end,
            CurrentPlace.Fbuttons,
            ww/2 - 320 + 80,
            wh/2 - 240 + 390
        )

        Aiming = buttons.newToolButton(
            Aiming_icon,
            function ()
                CurrentPlace.Pageshown = 'Aim'
            end,
            CurrentPlace.Fbuttons,
            ww/2 - 320 + 128,
            wh/2 - 240 + 390
        )

        Mobility = buttons.newToolButton(
            Mobility_icon,
            function ()
                CurrentPlace.Pageshown = 'Mob'
            end,
            CurrentPlace.Fbuttons,
            ww/2 - 320 + 176,
            wh/2 - 240 + 390
        )

        Ammunition = buttons.newToolButton(
            Ammo_icon,
            function ()
                CurrentPlace.Pageshown = 'Ammo'
            end,
            CurrentPlace.Fbuttons,
            ww/2 - 320 + 224,
            wh/2 - 240 + 390
        )

    Build = buttons.newToolButton(
        Build_icon,
        function ()
            Buildtank()
        end,
        CurrentPlace.Fbuttons,
        ww/2 - 320 + 405,
        wh/2 - 240 + 390,
        Build_icon,
        Build_Hot
    )

    Delete = buttons.newToolButton(
        Delete_icon,
        function ()
            table.remove(CurrentPlace.ProductionQueue, 1)
        end,
        CurrentPlace.Fbuttons,
        ww/2 - 320 + 567,
        wh/2 - 240 + 79
    )

end


function TankDesigner:update(dt)
    --button pos update
    Close.bx = ww/2 + 320 - 15
    Close.by = wh/2 - 240 + 18
    Next.bx = ww/2 - 320 + 311
    Next.by = wh/2 - 240 + 331
    Previous.bx = ww/2 - 320 + 56
    Previous.by = wh/2 - 240 + 331
    Armor.bx = ww/2 - 320 + 72
    Armor.by = wh/2 - 240 + 390
    Aiming.bx = ww/2 - 320 + 126
    Aiming.by = wh/2 - 240 + 390
    Mobility.bx = ww/2 - 320 + 180
    Mobility.by = wh/2 - 240 + 390
    Ammunition.bx = ww/2 - 320 + 234
    Ammunition.by = wh/2 - 240 + 390
    Build.bx = ww/2 - 320 + 405
    Build.by = wh/2 - 240 + 390
    Delete.bx = ww/2 - 320 + 567
    Delete.by = wh/2 - 240 + 79
    for i, tank in ipairs(CurrentPlace.tanklist) do
        if tank.accessories then
            for i, accessory in ipairs(tank.accessories) do
                for i, button in ipairs(accessory.Abuttons) do
                    button.bx = ww/2 - 320 + 386
                    button.by = wh/2 - 240 + 46 + 46*i
                end
            end
        end
    end
    --pageshown detection
    local n = 0
    n = math.floor(n + 0.1*dt)
    if CurrentPlace.Pageshown == 'Armor' then
        CurrentPlace.tanklist[CurrentPlace.tankindex].ammunition.isopen = false
        for i, accessory in ipairs(CurrentPlace.tanklist[CurrentPlace.tankindex].accessories) do
            if i == 1 then
                accessory.isopen = true
            else
                accessory.isopen = false
            end
        end
    end
    if CurrentPlace.Pageshown == 'Aim' then
        CurrentPlace.tanklist[CurrentPlace.tankindex].ammunition.isopen = false
        for i, accessory in ipairs(CurrentPlace.tanklist[CurrentPlace.tankindex].accessories) do
            if i == 2 then
                accessory.isopen = true
            else
                accessory.isopen = false
            end
        end
    end
    if CurrentPlace.Pageshown == 'Mob' then
        CurrentPlace.tanklist[CurrentPlace.tankindex].ammunition.isopen = false
        for i, accessory in ipairs(CurrentPlace.tanklist[CurrentPlace.tankindex].accessories) do
            if i == 3 then
                accessory.isopen = true
            else
                accessory.isopen = false
            end
        end
    end
    if CurrentPlace.Pageshown == 'Ammo' then
        for i, accessory in ipairs(CurrentPlace.tanklist[CurrentPlace.tankindex].accessories) do
            accessory.isopen = false
        end
        CurrentPlace.tanklist[CurrentPlace.tankindex].ammunition.isopen = true
    end
    --tank production process
    for i, tank in ipairs(CurrentPlace.ProductionQueue) do
        if tank.selected_slot~=0 then
            tank.buildtime = tank.buildtime - dt
        else
            tank.selected_slot=TankSpawner:slot_distribution(CurrentPlace)
        end
        if tank.buildtime <= 0 then
            TankSpawner:new_tank(CurrentPlace, table.remove(CurrentPlace.ProductionQueue,i))
            CurrentPlace.ProductionNumber = CurrentPlace.ProductionNumber - 1
        else
  
        end
    end
end


function TankDesigner:draw()

    TankPresent = CurrentPlace.tanklist[CurrentPlace.tankindex]

        if CurrentPlace.opendesigner then
            local steel_cost = TankPresent.steel_cost + TankPresent.equipment.armor.steel_cost + TankPresent.equipment.aim.steel_cost + TankPresent.equipment.mob.steel_cost
            local oil_cost = TankPresent.oil_cost + TankPresent.equipment.armor.oil_cost + TankPresent.equipment.aim.oil_cost + TankPresent.equipment.mob.oil_cost
            love.graphics.draw(factory_screen, ww/2 - 320, wh/2 - 240)
            love.graphics.setFont(Rbuttonfont)
            love.graphics.print(CurrentPlace.name, ww/2 - 320 + 40, wh/2 - 240)
            love.graphics.setFont(Rtextfont)
            love.graphics.setColor(0,179/255,0)
            love.graphics.print(TankPresent.name, ww/2 - 320 + 40 + 6, wh/2 - 240 + 64 + 6)
            love.graphics.print(steel_cost, ww/2 - 320 + 40 + 246, wh/2 - 240 + 64 + 6)
            love.graphics.print(oil_cost, ww/2 - 320 + 40 + 246, wh/2 - 240 + 64 + 26)
            love.graphics.setColor(1,1,1)
            love.graphics.draw(TankPresent.hull_image_line, ww/2 - 320 + 40, wh/2 - 240 + 64)
            love.graphics.draw(TankPresent.turret_image_line, ww/2 - 320 + 40, wh/2 - 240 + 64)

            if TankPresent.accessories then
                for i, accessory in ipairs(TankPresent.accessories) do
                    if accessory.isopen then
                        accessory.Abuttons:use()
                        for i, equipment in ipairs(accessory) do
                            love.graphics.setFont(Rtextfont)
                            love.graphics.setColor(0,179/255,0)
                            love.graphics.print(equipment.name, ww/2 - 320 + 336, wh/2 - 240 + 24 + 46*i)
                            if equipment == TankPresent.equipment.armor or equipment == TankPresent.equipment.aim or equipment == TankPresent.equipment.mob then
                                love.graphics.setColor(0,179/255,0)
                                love.graphics.rectangle("fill", ww/2 - 320 + 332, wh/2 - 240 + 24 + 46*i, 108, 44)
                                love.graphics.setColor(34/255,32/255,52/255)
                                love.graphics.print(equipment.name, ww/2 - 320 + 336, wh/2 - 240 + 24 + 46*i)
                            end
                            love.graphics.setColor(1,1,1)
                        end
                    end
                end
            end

            if TankPresent.ammunition.isopen then
                TankPresent.ammunition.Abuttons:use()
                love.graphics.setColor(0,179/255,0)
                love.graphics.print('Rounds:'..table.getn(TankPresent.ammorack)..'/'..TankPresent.ammorack_size, ww/2 - 320 + 328 + 6, wh/2 - 240 + 64 + 6)
                
                for i, ammo in ipairs(TankPresent.ammunition) do
                    local n = 0
                    for i, bullet in ipairs(TankPresent.ammorack) do
                        if bullet.name == ammo.name then
                            n = n + 1
                        end
                    end
                    love.graphics.print(ammo.name, ww/2 - 320 + 328 + 6, wh/2 - 240 + 46 + 46*i)
                    love.graphics.print(n, ww/2 - 320 + 328 + 6, wh/2 - 240 + 56 + 46*i)
                end
                love.graphics.setColor(1,1,1)
            end

            

            love.graphics.draw(TankPresent.equipment.armor.hull_image_line, ww/2 - 320 + 40, wh/2 - 240 + 64)
            love.graphics.draw(TankPresent.equipment.armor.turret_image_line, ww/2 - 320 + 40, wh/2 - 240 + 64)
            love.graphics.draw(TankPresent.equipment.aim.line_image, ww/2 - 320 + 40, wh/2 - 240 + 64)
            love.graphics.draw(TankPresent.equipment.mob.line_image, ww/2 - 320 + 40, wh/2 - 240 + 64)

            for i, tank in ipairs(CurrentPlace.ProductionQueue) do
                love.graphics.draw(production_box,ww/2 - 320 + 452, wh/2 - 240 + 62 + 28*i)
                love.graphics.setColor(0,179/255,0)
                love.graphics.print(tank.name, ww/2 - 320 + 456, wh/2 - 240 + 66 + 28*i)
                love.graphics.rectangle('fill', ww/2 - 320 + 456, wh/2 - 240 + 80 + 28*i, 132 - (132*tank.buildtime/tank.fixedbuildtime), 4)
                love.graphics.setColor(1,1,1)
            end

            CurrentPlace.Fbuttons:use()
            if CurrentPlace.Pageshown == 'Armor' then
                love.graphics.draw(Armor_Hot, ww/2 - 320 + 46, wh/2 - 240 + 356)
            end
            if CurrentPlace.Pageshown == 'Aim' then
                love.graphics.draw(Aiming_Hot, ww/2 - 320 + 100, wh/2 - 240 + 356)
            end
            if CurrentPlace.Pageshown == 'Mob' then
                love.graphics.draw(Mobility_Hot, ww/2 - 320 + 154, wh/2 - 240 + 356)
            end
            if CurrentPlace.Pageshown == 'Ammo' then
                love.graphics.draw(Ammo_Hot, ww/2 - 320 + 208, wh/2 - 240 + 356)
            end
        end
end

function Buildtank()
    local instance = {
        name = TankPresent.name,
        width = TankPresent.width,
        length = TankPresent.length,
        weight = TankPresent.weight,
        crew = TankPresent.crew,
        survivor = TankPresent.crew,
        reload_time = TankPresent.reload_time,
        reload_timer = TankPresent.reload_time,
        ammorack_size = TankPresent.ammorack_size,
        ammorack = copytable(TankPresent.ammorack),
        armorthickness = TankPresent.armorthickness,
        innerstructure = TankPresent.innerstructure,
        max_f_speed = TankPresent.max_f_speed,
        max_r_speed = TankPresent.max_r_speed,
        hull_image = TankPresent.hull_image,
        hull_image_line = TankPresent.hull_image_line,
        turret_image = TankPresent.turret_image,
        turret_image_line = TankPresent.turret_image_line,
        hull_offset = TankPresent.hull_offset,
        gun_offset = TankPresent.gun_offset,
        turret_angle = 0,
        armor = copytable(TankPresent.equipment.armor),
        aim = TankPresent.equipment.aim,
        mob = TankPresent.equipment.mob,
        buildtime = TankPresent.buildtime,
        fixedbuildtime = TankPresent.buildtime,
        selected_slot=TankSpawner:slot_distribution(CurrentPlace)
    }
    table.insert(CurrentPlace.ProductionQueue, 1, instance)
    CurrentPlace.ProductionNumber = CurrentPlace.ProductionNumber + 1
end