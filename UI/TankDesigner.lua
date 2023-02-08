TankDesigner = {}

function TankDesigner:load()
    CurrentPlace.opendesigner = false
    CurrentPlace.Fbuttons = buttons.new()
    CurrentPlace.tankindex = 1
    CurrentPlace.ProductionQueue = {}
    CurrentPlace.ProductionNumber = 0
    TankGear = {
        armor = Blank_Gear,
        aim = Blank_Gear,
        ammo = Blank_Gear,
        mob = Blank_Gear
    }
    
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
                if CurrentPlace.tankindex < table.getn(CurrentPlace.tanklist) then
                    CurrentPlace.tankindex = CurrentPlace.tankindex + 1
                else
                    CurrentPlace.tankindex = 1
                end
                TankGear = {
                    armor = Blank_Gear,
                    aim = Blank_Gear,
                    ammo = Blank_Gear,
                    mob = Blank_Gear
                }
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
                TankGear = {
                    armor = Blank_Gear,
                    aim = Blank_Gear,
                    ammo = Blank_Gear,
                    mob = Blank_Gear
                }
            end,
            CurrentPlace.Fbuttons,
            ww/2 - 320 + 56,
            wh/2 - 240 + 331
        )

        for i, tank in ipairs(CurrentPlace.tanklist) do
            if tank.accessories then
                for i, accessory in ipairs(tank.accessories) do
                    accessory.Abuttons = buttons.new()
                    accessory.isopen = false
                    for i, equipment in ipairs(accessory) do
                        local Equip = buttons.newToolButton(
                        EquipmentSelect,
                        function ()
                            if equipment.tag == 'Armor' then
                                TankGear.armor = equipment
                            end
                            if equipment.tag == 'Aim' then
                                TankGear.aim = equipment
                            end
                            if equipment.tag == 'Ammo' then
                                TankGear.ammo = equipment
                            end
                            if equipment.tag == 'Mob' then
                                TankGear.mob = equipment
                            end
                        end,
                        accessory.Abuttons,
                        ww/2 - 320 + 386,
                        wh/2 - 240 + 46 + 46*i,
                        EquipmentSelectHot,
                        EquipmentSelectHot
                    )
                    equipment.use = false
                    end
                end
            end
        end

        Armor = buttons.newToolButton(
            Armor_icon,
            function ()
                for i, accessory in ipairs(CurrentPlace.tanklist[CurrentPlace.tankindex].accessories) do
                    if i == 1 and accessory.isopen == false then
                        accessory.isopen = true
                    else
                        accessory.isopen = false
                    end
                end
            end,
            CurrentPlace.Fbuttons,
            ww/2 - 320 + 80,
            wh/2 - 240 + 390
        )

        Aiming = buttons.newToolButton(
            Aiming_icon,
            function ()
                for i, accessory in ipairs(CurrentPlace.tanklist[CurrentPlace.tankindex].accessories) do
                    if i == 2 and accessory.isopen == false then
                        accessory.isopen = true
                    else
                        accessory.isopen = false
                    end
                end
            end,
            CurrentPlace.Fbuttons,
            ww/2 - 320 + 128,
            wh/2 - 240 + 390
        )

        Ammunition = buttons.newToolButton(
            Ammo_icon,
            function ()
                for i, accessory in ipairs(CurrentPlace.tanklist[CurrentPlace.tankindex].accessories) do
                    if i == 3 and accessory.isopen == false then
                        accessory.isopen = true
                    else
                        accessory.isopen = false
                    end
                end
            end,
            CurrentPlace.Fbuttons,
            ww/2 - 320 + 176,
            wh/2 - 240 + 390
        )

        Mobility = buttons.newToolButton(
            Mobility_icon,
            function ()
                for i, accessory in ipairs(CurrentPlace.tanklist[CurrentPlace.tankindex].accessories) do
                    if i == 4 and accessory.isopen == false then
                        accessory.isopen = true
                    else
                        accessory.isopen = false
                    end
                end
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
    Armor.bx = ww/2 - 320 + 80
    Armor.by = wh/2 - 240 + 390
    Aiming.bx = ww/2 - 320 + 128
    Aiming.by = wh/2 - 240 + 390
    Ammunition.bx = ww/2 - 320 + 176
    Ammunition.by = wh/2 - 240 + 390
    Mobility.bx = ww/2 - 320 + 224
    Mobility.by = wh/2 - 240 + 390
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

    --tank production process
    for i, tank in ipairs(CurrentPlace.ProductionQueue) do
        tank.buildtime = tank.buildtime - dt
        if tank.buildtime <= 0 and Port_isavailable then
            --ADDtank()
            table.insert(CurrentPlace.tankstock, table.remove(CurrentPlace.ProductionQueue, i))
            --TankSpawner:spawn()
            TankSpawner:testspawn(CurrentPlace)
            CurrentPlace.ProductionNumber = CurrentPlace.ProductionNumber - 1
        else
            
        end
    end
end


function TankDesigner:draw()

    TankPresent = CurrentPlace.tanklist[CurrentPlace.tankindex]

        if CurrentPlace.opendesigner then
            love.graphics.draw(factory_screen, ww/2 - 320, wh/2 - 240)
            love.graphics.setFont(Rbuttonfont)
            love.graphics.print(CurrentPlace.name, ww/2 - 320 + 40, wh/2 - 240)
            love.graphics.setFont(Rtextfont)
            love.graphics.setColor(0,179/255,0)
            love.graphics.print(TankPresent.name, ww/2 - 320 + 40 + 6, wh/2 - 240 + 64 + 6)
            love.graphics.setColor(1,1,1)
            love.graphics.draw(TankPresent.line_image, ww/2 - 320 + 40, wh/2 - 240 + 64)

            if TankPresent.accessories then
                for i, accessory in ipairs(TankPresent.accessories) do
                    if accessory.isopen then
                        accessory.Abuttons:use()
                        for i, equipment in ipairs(accessory) do
                            love.graphics.setFont(Rtextfont)
                            love.graphics.setColor(0,179/255,0)
                            love.graphics.print(equipment.name, ww/2 - 320 + 336, wh/2 - 240 + 24 + 46*i)
                            if equipment == TankGear.armor or equipment == TankGear.aim or equipment == TankGear.ammo or equipment == TankGear.mob then
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

            love.graphics.draw(TankGear.armor.line_image, ww/2 - 320 + 40, wh/2 - 240 + 64)
            love.graphics.draw(TankGear.aim.line_image, ww/2 - 320 + 40, wh/2 - 240 + 64)
            love.graphics.draw(TankGear.ammo.line_image, ww/2 - 320 + 40, wh/2 - 240 + 64)
            love.graphics.draw(TankGear.mob.line_image, ww/2 - 320 + 40, wh/2 - 240 + 64)
                  
            for i, tank in ipairs(CurrentPlace.ProductionQueue) do
                love.graphics.draw(production_box,ww/2 - 320 + 452, wh/2 - 240 + 62 + 28*i)
                love.graphics.setColor(0,179/255,0)
                love.graphics.print(tank.name, ww/2 - 320 + 456, wh/2 - 240 + 66 + 28*i)
                love.graphics.rectangle('fill', ww/2 - 320 + 456, wh/2 - 240 + 80 + 28*i, 132 - (132*tank.buildtime/tank.fixedbuildtime), 4)
                love.graphics.setColor(1,1,1)
            end
            
            CurrentPlace.Fbuttons:use()

        end
end

function Buildtank()
    local instance = {
        name = TankPresent.name,
        width=TankPresent.width,
        length=TankPresent.length,
        hull_image = TankPresent.hull_image,
        turret_image = TankPresent.turret_image,
        armor = TankGear.armor,
        aim = TankGear.aim,
        ammo = TankGear.ammo,
        mob = TankGear.mob,
        buildtime = TankPresent.buildtime,
        fixedbuildtime = TankPresent.buildtime
    }
    table.insert(CurrentPlace.ProductionQueue, 1, instance)
    TankSpawner:slotOperate()
    CurrentPlace.ProductionNumber = CurrentPlace.ProductionNumber + 1
end