TankDesigner = {}

function TankDesigner:load()
    Factory.isopen = false
    Factory.Fbuttons = buttons.new()
    Factory.tankindex = 1
    Factory.ProductionQueue = {}
    Factory.ProductionNumber = 0
    TankGear = {
        armor = Blank_Gear,
        aim = Blank_Gear,
        ammo = Blank_Gear,
        mob = Blank_Gear
    }
    
        Close = buttons.newToolButton(
            Close_icon,
            function ()
                Factory.isopen = false
            end,
            Factory.Fbuttons,
            ww/2 + 320 - 15,
            wh/2 - 240 + 18
        )

        Next = buttons.newToolButton(
            rightArrow,
            function ()
                if Factory.tankindex < table.getn(Factory.tanklist) then
                    Factory.tankindex = Factory.tankindex + 1
                else
                    Factory.tankindex = 1
                end
                TankGear = {
                    armor = Blank_Gear,
                    aim = Blank_Gear,
                    ammo = Blank_Gear,
                    mob = Blank_Gear
                }
            end,
            Factory.Fbuttons,
            ww/2 - 320 + 311,
            wh/2 - 240 + 331
        )

        Previous = buttons.newToolButton(
            leftArrow,
            function ()
                if Factory.tankindex > 1 then
                    Factory.tankindex = Factory.tankindex - 1
                else
                    Factory.tankindex = table.getn(Factory.tanklist)
                end
                TankGear = {
                    armor = Blank_Gear,
                    aim = Blank_Gear,
                    ammo = Blank_Gear,
                    mob = Blank_Gear
                }
            end,
            Factory.Fbuttons,
            ww/2 - 320 + 56,
            wh/2 - 240 + 331
        )

        for i, tank in ipairs(Factory.tanklist) do
            if tank.accessories then
                for i, accessory in ipairs(tank.accessories) do
                    accessory.use = false
                    accessory.Abuttons = buttons.new()
                    
                    local Equip = buttons.newToolButton(
                        leftArrow,
                        function ()
                            if accessory.tag == 'Armor' then
                                TankGear.armor = accessory
                            end
                            if accessory.tag == 'Aim' then
                                TankGear.aim = accessory
                            end
                            if accessory.tag == 'Ammo' then
                                TankGear.ammo = accessory
                            end
                            if accessory.tag == 'Mob' then
                                TankGear.mob = accessory
                            end
                        end,
                        accessory.Abuttons,
                        ww/2 - 320 + 416,
                        wh/2 - 240  + 11 + 70*i
                    )
                end
            end
        end

        Armor = buttons.newToolButton(
            Armor_icon,
            function ()
                for i, accessory in ipairs(Factory.tanklist[Factory.tankindex].accessories) do
                    if accessory.tag == 'Armor' then
                        accessory.use = true
                    else
                        accessory.use = false
                    end
                end
            end,
            Factory.Fbuttons,
            ww/2 - 320 + 80,
            wh/2 - 240 + 390
        )

        Aiming = buttons.newToolButton(
            Aiming_icon,
            function ()
                for i, accessory in ipairs(Factory.tanklist[Factory.tankindex].accessories) do
                    if accessory.tag == 'Aim' then
                        accessory.use = true
                    else
                        accessory.use = false
                    end
                end
            end,
            Factory.Fbuttons,
            ww/2 - 320 + 128,
            wh/2 - 240 + 390
        )

        Ammunition = buttons.newToolButton(
            Ammo_icon,
            function ()
                for i, accessory in ipairs(Factory.tanklist[Factory.tankindex].accessories) do
                    if accessory.tag == 'Ammo' then
                        accessory.use = true
                    else
                        accessory.use = false
                    end
                end
            end,
            Factory.Fbuttons,
            ww/2 - 320 + 176,
            wh/2 - 240 + 390
        )

        Mobility = buttons.newToolButton(
            Mobility_icon,
            function ()
                for i, accessory in ipairs(Factory.tanklist[Factory.tankindex].accessories) do
                    if accessory.tag == 'Mob' then
                        accessory.use = true
                    else
                        accessory.use = false
                    end
                end
            end,
            Factory.Fbuttons,
            ww/2 - 320 + 224,
            wh/2 - 240 + 390
        )
    
    Build = buttons.newToolButton(
        Build_icon,
        function ()
            Buildtank()
        end,
        Factory.Fbuttons,
        ww/2 - 320 + 405,
        wh/2 - 240 + 390
    )

    Delete = buttons.newToolButton(
        Delete_icon,
        function ()
            table.remove(Factory.ProductionQueue, 1)
        end,
        Factory.Fbuttons,
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
    for i, tank in ipairs(Factory.tanklist) do
        if tank.accessories then
            for i, accessory in ipairs(tank.accessories) do
                for n, button in ipairs(accessory.Abuttons) do
                    button.bx = ww/2 - 320 + 416
                    button.by = wh/2 - 240  + 11 + 70*i
                end
            end
        end
    end

    --tank production process
    for i, tank in ipairs(Factory.ProductionQueue) do
        tank.buildtime = tank.buildtime - dt
        if tank.buildtime <= 0 then
            ADDtank()
            table.insert(Factory.tankstock, table.remove(Factory.ProductionQueue, i))
            TankSpawner:spawn()
            Factory.ProductionNumber = Factory.ProductionNumber - 1
        end
    end
end


function TankDesigner:draw()

    TankPresent = Factory.tanklist[Factory.tankindex]

        if Factory.isopen then
            love.graphics.draw(factory_screen, ww/2 - 320, wh/2 - 240)
            love.graphics.setFont(Rbuttonfont)
            love.graphics.print(Factory.name, ww/2 - 320 + 40, wh/2 - 240)
            love.graphics.setFont(Rtextfont)
            love.graphics.setColor(0,179/255,0)
            love.graphics.print(TankPresent.name, ww/2 - 320 + 40 + 6, wh/2 - 240 + 64 + 6)
            love.graphics.setColor(1,1,1)
            love.graphics.draw(TankPresent.line_image, ww/2 - 320 + 40, wh/2 - 240 + 64)

            if TankPresent.accessories then
                for i, accessory in ipairs(TankPresent.accessories) do
                    if accessory.use then
                        love.graphics.setFont(Rtextfont)
                        love.graphics.setColor(0,179/255,0)
                        love.graphics.print(accessory.name, ww/2 - 320 + 336, wh/2 - 240 + 70*i)
                        love.graphics.setColor(1,1,1)
                        accessory.Abuttons:use()
                    end
                end
            end

            love.graphics.draw(TankGear.armor.line_image, ww/2 - 320 + 40, wh/2 - 240 + 64)
            love.graphics.draw(TankGear.aim.line_image, ww/2 - 320 + 40, wh/2 - 240 + 64)
            love.graphics.draw(TankGear.ammo.line_image, ww/2 - 320 + 40, wh/2 - 240 + 64)
            love.graphics.draw(TankGear.mob.line_image, ww/2 - 320 + 40, wh/2 - 240 + 64)
            
            for i, tank in ipairs(Factory.ProductionQueue) do
                love.graphics.draw(production_box,ww/2 - 320 + 452, wh/2 - 240 + 62 + 28*i)
                love.graphics.setColor(0,179/255,0)
                love.graphics.print(tank.name, ww/2 - 320 + 456, wh/2 - 240 + 66 + 28*i)
                love.graphics.rectangle('fill', ww/2 - 320 + 456, wh/2 - 240 + 80 + 28*i, 132 - (132*tank.buildtime/tank.fixedbuildtime), 4)
                love.graphics.setColor(1,1,1)
            end
            
            Factory.Fbuttons:use()

        end
end

function Buildtank()
    local instance = {
        name = TankPresent.name,
        hull_image = TankPresent.hull_image,
        turret_image = TankPresent.turret_image,
        armor = TankGear.armor,
        aim = TankGear.aim,
        ammo = TankGear.ammo,
        mob = TankGear.mob,
        buildtime = TankPresent.buildtime,
        fixedbuildtime = TankPresent.buildtime
    }
    table.insert(Factory.ProductionQueue, 1, instance)
    
    Factory.ProductionNumber = Factory.ProductionNumber + 1
end