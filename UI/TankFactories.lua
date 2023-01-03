TankFactories = {}

function TankFactories:load()
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
            {name = 'Kontakt_1',line_image = T72B_kontakt1_line},
            {name = 'Kontakt_5',line_image = T72B_kontakt5_line}
        }
    }
    table.insert(KMDB.tanklist, T72B)

    for i, factory in ipairs(TankFactories) do
        factory.isopen = false
        factory.Fbuttons = buttons.new()
        factory.tankindex = 1
        
        Close = buttons.newToolButton(
            Gear,
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
                tank.Abuttons = buttons.new()

                for i, accessory in ipairs(tank.accessories) do
                    accessory.draw = false
                    
                    Turnon = buttons.newToolButton(
                        leftArrow,
                        function ()
                            if accessory.draw then
                                accessory.draw = false
                            else
                                accessory.draw = true  
                            end
                        end,
                        tank.Abuttons,
                        ww/6 + 370,
                        wh/8 + 70*i
                    )

                end
            end
        end
    end
end


function TankFactories:update()

end


function TankFactories:draw()
    for i, factory in ipairs(TankFactories) do

        local TankPresent = factory.tanklist[factory.tankindex]
        if factory.isopen then
            love.graphics.setColor(0.7, 0.7, 0.7)
            love.graphics.rectangle("fill", ww/6, wh/8, 4*ww/6, 6*wh/8)
            love.graphics.setColor(1,1,1)
            love.graphics.draw(factory_screen, ww/6 + 50, wh/8 + 50)
            love.graphics.setFont(Rbuttonfont)
            love.graphics.print(factory.name, ww/6, wh/8)
            love.graphics.setFont(Rtextfont)
            love.graphics.setColor(0,179/255,0)
            love.graphics.print(TankPresent.name, ww/6 + 56, wh/8 + 52)
            love.graphics.setColor(1,1,1)
            love.graphics.draw(TankPresent.line_image, ww/6 + 50, wh/8 + 50)

            if TankPresent.accessories then
                
                for i, accessory in ipairs(TankPresent.accessories) do
                    love.graphics.setFont(Rtextfont)
                    love.graphics.print(accessory.name, ww/6 + 390, wh/8 + 70*i)
                end

                TankPresent.Abuttons:use()

                for i, accessory in ipairs(TankPresent.accessories) do
                    if accessory.draw then
                        love.graphics.draw(accessory.line_image, ww/6 + 50, wh/8 + 50)
                    end
                end
            end

            factory.Fbuttons:use()
            Close.bx = ww*5/6 - Close.w/2
            Close.by = wh/8 + Close.h/2
            Next.bx = ww/6 + 200
            Next.by = 6*wh/8
            Previous.bx = ww/6 + 100
            Previous.by = 6*wh/8
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