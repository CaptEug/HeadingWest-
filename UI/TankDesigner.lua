TankDesigner = {}

function TankDesigner:load()

    Factory.isopen = false
    Factory.Fbuttons = buttons.new()
    Factory.tankindex = 1

    TankPresent.armor = {line_image = Blank_line}
    TankPresent.aim = {line_image = Blank_line}
    TankPresent.ammo = {line_image = Blank_line}
    TankPresent.mob = {line_image = Blank_line}
    
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
            end,
            Factory.Fbuttons,
            wh/2 - 240 + 331,
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
                    
                    Equip = buttons.newToolButton(
                        leftArrow,
                        function ()
                            if accessory.tag == 'Armor' then
                                TankPresent.armor = accessory
                            end
                            if accessory.tag == 'Aim' then
                                TankPresent.aim = accessory
                            end
                            if accessory.tag == 'Ammo' then
                                TankPresent.ammo = accessory
                            end
                            if accessory.tag == 'Mob' then
                                TankPresent.mob = accessory
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
    
    
end


function TankDesigner:update()
    
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
            end

            love.graphics.draw(TankPresent.line_image, ww/2 - 320 + 40, wh/2 - 240 + 64)
            love.graphics.draw(TankPresent.armor.line_image, ww/2 - 320 + 40, wh/2 - 240 + 64)
            love.graphics.draw(TankPresent.aim.line_image, ww/2 - 320 + 40, wh/2 - 240 + 64)
            love.graphics.draw(TankPresent.ammo.line_image, ww/2 - 320 + 40, wh/2 - 240 + 64)
            love.graphics.draw(TankPresent.mob.line_image, ww/2 - 320 + 40, wh/2 - 240 + 64)
            
            Factory.Fbuttons:use()

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