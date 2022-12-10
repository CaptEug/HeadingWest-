TankFactories = {}

function TankFactories:load()
    KMDB = {
        x = 3100,
        y = 1200,
        name = 'TEST FACTORY'
    }
    table.insert(TankFactories, KMDB)

    for i, factory in ipairs(TankFactories) do
        factory.isopen = false
        factory.tanklists = {}
        factory.Fbuttons = buttons.new()
        Close = buttons.newToolButton(
            Gear,
            function ()
                factory.isopen = false
                Cbuttons.ison = true
            end,
            factory.Fbuttons
        )
    end

end


function TankFactories:update()

end


function TankFactories:draw()
    for i, factory in ipairs(TankFactories) do

        if factory.isopen then
            love.graphics.setColor(0.7, 0.7, 0.7, 0.8)
            love.graphics.rectangle("fill", ww/6, wh/8, 4*ww/6, 6*wh/8)
            love.graphics.setColor(1,1,1)
            love.graphics.setFont(Rbuttonfont)
            love.graphics.print(factory.name, ww/6, wh/8)

            factory.Fbuttons:use()
            Close.bx = ww*5/6 - Close.w/2
            Close.by = wh/8 + Close.h/2
        end
    end
end

function newtanklist(tankname,factoryname)
    local instance = {
        tankname = tankname,
        productionQueue = 0,
        stock = 0,
    }
    table.insert(factoryname.tanklists, instance)
end