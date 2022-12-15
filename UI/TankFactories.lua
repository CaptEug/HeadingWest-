TankFactories = {}

function TankFactories:load()
    KMDB = {
        x = 3100,
        y = 1200,
        name = 'TEST FACTORY',
        tanklist = {}
    }
    table.insert(TankFactories, KMDB)

    for i, factory in ipairs(TankFactories) do
        factory.isopen = false
        factory.Fbuttons = buttons.new()
        factory.tanksequence = 1
        
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
                if factory.tanksequence < table.getn(factory.tanklist) then
                    factory.tanksequence = factory.tanksequence + 1
                else
                    factory.tanksequence = 1
                end
                
            end,
            factory.Fbuttons
        )
        Previous = buttons.newToolButton(
            leftArrow,
            function ()
                if factory.tanksequence > 1 then
                    factory.tanksequence = factory.tanksequence - 1
                else
                    factory.tanksequence = table.getn(factory.tanklist)
                end
            end,
            factory.Fbuttons
        )
    end
    --test tanklist
    T72A = {
        name = 'T-72a',
        line_image = T72A_line,
    }
    table.insert(KMDB.tanklist, T72A)
    T72B = {
        name = 'T-72b',
        line_image = T72B_line,
    }
    table.insert(KMDB.tanklist, T72B)
end


function TankFactories:update()

end


function TankFactories:draw()
    for i, factory in ipairs(TankFactories) do

        local TankPresent = factory.tanklist[factory.tanksequence]
        if factory.isopen then
            love.graphics.setColor(0.7, 0.7, 0.7)
            love.graphics.rectangle("fill", ww/6, wh/8, 4*ww/6, 6*wh/8)
            love.graphics.setColor(34/225, 32/225, 52/225)
            love.graphics.rectangle("fill", ww/6 + 50, wh/8 + 50, ww/6 + 200, wh/8 + 250)
            love.graphics.setColor(1,1,1)

            love.graphics.setFont(Rbuttonfont)
            love.graphics.print(factory.name, ww/6, wh/8)
            love.graphics.setFont(Rtextfont)
            love.graphics.setColor(0,179/255,0)
            love.graphics.print(TankPresent.name, ww/6 + 50, wh/8 + 50)
            love.graphics.setColor(1,1,1)
            love.graphics.draw(TankPresent.line_image,ww/6 + 50 , wh/8 + 50)

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