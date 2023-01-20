TankDesigner = {}

function TankDesigner:load()
    Factory.isopen = false
    Factory.Fbuttons = buttons.new()
    Factory.tankindex = 1
    TankGear = {
        armor = {line_image = Blank_line},
        aim = {line_image = Blank_line},
        ammo = {line_image = Blank_line},
        mob = {line_image = Blank_line}
    }
    
        local Close = buttons.newToolButton(
            Close_icon,
            function ()
                Factory.isopen = false
            end,
            Factory.Fbuttons,
            ww/2 + 320 - 15,
            wh/2 - 240 + 18
        )

        local Next = buttons.newToolButton(
            rightArrow,
            function ()
                if Factory.tankindex < table.getn(Factory.tanklist) then
                    Factory.tankindex = Factory.tankindex + 1
                else
                    Factory.tankindex = 1
                end
                TankGear = {
                    armor = {line_image = Blank_line},
                    aim = {line_image = Blank_line},
                    ammo = {line_image = Blank_line},
                    mob = {line_image = Blank_line}
                }
            end,
            Factory.Fbuttons,
            wh/2 - 240 + 331,
            wh/2 - 240 + 331
        )

        local Previous = buttons.newToolButton(
            leftArrow,
            function ()
                if Factory.tankindex > 1 then
                    Factory.tankindex = Factory.tankindex - 1
                else
                    Factory.tankindex = table.getn(Factory.tanklist)
                end
                TankGear = {
                    armor = {line_image = Blank_line},
                    aim = {line_image = Blank_line},
                    ammo = {line_image = Blank_line},
                    mob = {line_image = Blank_line}
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
                    
                    Equip = buttons.newToolButton(
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
                        ww/6 + 370,
                        wh/8 + 70*i
                    )
                end
            end
        end

        local Armor = buttons.newToolButton(
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

        local Aiming = buttons.newToolButton(
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

        local Ammunition = buttons.newToolButton(
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

        local Mobility = buttons.newToolButton(
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
    
    local Build = buttons.newToolButton(
        Build_icon,
        function ()
            Buildtank()
        end,
        Factory.Fbuttons,
        ww/2 - 320 + 405,
        wh/2 - 240 + 390
    )

    local Delete = buttons.newToolButton(
        Delete_icon,
        function ()
            table.remove(Factory.ProductionQueue, 1)
        end,
        Factory.Fbuttons,
        ww/2 - 320 + 567,
        wh/2 - 240 + 84
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
            end

            love.graphics.draw(TankGear.armor.line_image, ww/2 - 320 + 40, wh/2 - 240 + 64)
            love.graphics.draw(TankGear.aim.line_image, ww/2 - 320 + 40, wh/2 - 240 + 64)
            love.graphics.draw(TankGear.ammo.line_image, ww/2 - 320 + 40, wh/2 - 240 + 64)
            love.graphics.draw(TankGear.mob.line_image, ww/2 - 320 + 40, wh/2 - 240 + 64)
            
            for i, tank in ipairs(Factory.ProductionQueue) do
                love.graphics.print(tank.name, ww/2 - 320 + 452, wh/2 - 240 + 74 + 20*i)
                love.graphics.rectangle('fill', ww/2 - 320 + 452, wh/2 - 240 + 90 + 20*i, 140 - (140*tank.buildtime/tank.fixedbuildtime), 4)
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
    TankAdded=true

end