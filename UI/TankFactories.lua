TankFactories = {}

function TankFactories:load()
    --test factory
    KMDB = {
        x = 3100,
        y = 1200,
        name = 'TEST FACTORY',
        tanklist = {}
    }
    table.insert(TankFactories, KMDB)

    --test tanklist
    T72A = {
        name = 'T-72a',
        line_image = T72A_line,
        accessories = {}
    }
    table.insert(KMDB.tanklist, T72A)
    T72B = {
        name = 'T-72b',
        line_image = T72B_line,
        accessories = { 
            {name = 'Kontakt_1', line_image = T72B_kontakt1_line, tag = 'Armor'},
            {name = 'Kontakt_5', line_image = T72B_kontakt5_line, tag = 'Armor'}
        }
    }
    table.insert(KMDB.tanklist, T72B)

    
    for i, factory in ipairs(TankFactories) do
        factory.isopen = false
        factory.Fbuttons = buttons.new()
        factory.tankindex = 1
        
        Close = buttons.newToolButton(
            Close,
            function ()
                factory.isopen = false
                Cbuttons.ison = true
            end,
            factory.Fbuttons
        )

        Next = buttons.newToolButton(
            rightArrow,
            function ()
                if factory.tankindex < table.getn(factory.tanklist) then
                    factory.tankindex = factory.tankindex + 1
                else
                    factory.tankindex = 1
                end
                
            end,
            factory.Fbuttons
        )

        Previous = buttons.newToolButton(
            leftArrow,
            function ()
                if factory.tankindex > 1 then
                    factory.tankindex = factory.tankindex - 1
                else
                    factory.tankindex = table.getn(factory.tanklist)
                end
            end,
            factory.Fbuttons
        )


        for i, tank in ipairs(factory.tanklist) do
            if tank.accessories then
                for i, accessory in ipairs(tank.accessories) do
                    accessory.draw = false
                    accessory.use = false
                    accessory.Abuttons = buttons.new()

                    Draw = buttons.newToolButton(
                        leftArrow,
                        function ()
                            if accessory.draw then
                                accessory.draw = false
                            else
                                accessory.draw = true
                            end
                        end,
                        accessory.Abuttons,
                        ww/6 + 370,
                        wh/8 + 70*i
                    )
                end
            end
        end

        Armor = buttons.newToolButton(
            Armor_icon,
            function ()
                for i, accessory in ipairs(factory.tanklist[factory.tankindex].accessories) do
                    if accessory.tag == 'Armor' then
                        accessory.use = true
                    else
                        accessory.use = false
                    end
                end
            end,
            factory.Fbuttons
        )

        Aiming = buttons.newToolButton(
            Aiming_icon,
            function ()
                for i, accessory in ipairs(factory.tanklist[factory.tankindex].accessories) do
                    if accessory.tag == 'Aim' then
                        accessory.use = true
                    else
                        accessory.use = false
                    end
                end
            end,
            factory.Fbuttons
        )

        Ammunition = buttons.newToolButton(
            Ammo_icon,
            function ()
                for i, accessory in ipairs(factory.tanklist[factory.tankindex].accessories) do
                    if accessory.tag == 'Ammo' then
                        accessory.use = true
                    else
                        accessory.use = false
                    end
                end
            end,
            factory.Fbuttons
        )

        Mobility = buttons.newToolButton(
            Mobility_icon,
            function ()
                for i, accessory in ipairs(factory.tanklist[factory.tankindex].accessories) do
                    if accessory.tag == 'Mob' then
                        accessory.use = true
                    else
                        accessory.use = false
                    end
                end
            end,
            factory.Fbuttons
        )

    end
end


function TankFactories:update()

end


function TankFactories:draw()
    for i, factory in ipairs(TankFactories) do

        local TankPresent = factory.tanklist[factory.tankindex]
        if factory.isopen then
            love.graphics.draw(factory_screen, ww/2 - 320, wh/2 - 240)
            love.graphics.setFont(Rbuttonfont)
            love.graphics.print(factory.name, ww/2 - 320 + 40, wh/2 - 240)
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
                        love.graphics.print(accessory.name, ww/20 + 390, wh/10 + 70*i)
                        love.graphics.setColor(1,1,1)
                        accessory.Abuttons:use()
                    end   
                end

                for i, accessory in ipairs(TankPresent.accessories) do
                    if accessory.draw then
                        love.graphics.draw(accessory.line_image, ww/2 - 320 + 40, wh/2 - 240 + 64)
                    end
                end
            end

            factory.Fbuttons:use()
            Close.bx = ww/2 + 320 - 15
            Close.by = wh/2 - 240 + 18
            Next.bx = wh/2 - 240 + 331
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

        end
    end
end

--[[function newtank(tankname,factoryname)
    local instance = {
        tankname = tankname,
        productionQueue = 0,
        stock = 0,
    }
    table.insert(factoryname.tanklists, instance)
end]]