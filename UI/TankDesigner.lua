TankDesigner = {}

function TankDesigner:load()

    for i, factory in ipairs(TankDesigner) do
        factory.isopen = false
        factory.Fbuttons = buttons.new()
        factory.tankindex = 1
        
        Close = buttons.newToolButton(
            Close,
            function ()
                factory.isopen = false
            end,
            factory.Fbuttons,
            ww/2 + 320 - 15,
            wh/2 - 240 + 18
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
            factory.Fbuttons,
            wh/2 - 240 + 331,
            wh/2 - 240 + 331
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
            factory.Fbuttons,
            ww/2 - 320 + 56,
            wh/2 - 240 + 331
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
            factory.Fbuttons,
            ww/2 - 320 + 80,
            wh/2 - 240 + 390
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
            factory.Fbuttons,
            ww/2 - 320 + 128,
            wh/2 - 240 + 390
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
            factory.Fbuttons,
            ww/2 - 320 + 176,
            wh/2 - 240 + 390
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
            factory.Fbuttons,
            ww/2 - 320 + 224,
            wh/2 - 240 + 390
        )

    end
end


function TankDesigner:update()
    
end


function TankDesigner:draw()
    for i, factory in ipairs(TankDesigner) do

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
                    
                    if accessory.draw then
                        love.graphics.draw(accessory.line_image, ww/2 - 320 + 40, wh/2 - 240 + 64)
                    end
                end
            end

            factory.Fbuttons:use()

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