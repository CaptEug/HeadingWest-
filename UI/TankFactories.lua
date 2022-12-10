TankFactories = {}

function TankFactories:load()
    KMDB = {}
    KMDB.isopen = false
    KMDB.x = 3100
    KMDB.y = 1200
    KMDB.tanklists = {}
    
    table.insert(TankFactories, KMDB)
end

function TankFactories:draw()
    for i, factory in ipairs(TankFactories) do
        if factory.isopen then
            love.graphics.setColor(1, 1, 1, 0.7)
            love.graphics.rectangle("fill", factory.x, factory.y, 500, 500)
            love.graphics.setColor(1,1,1)
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