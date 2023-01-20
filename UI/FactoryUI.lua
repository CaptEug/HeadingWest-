FactoryUI={}
require 'UI/TankDesigner'

function FactoryUI:load()
    Factory.ProductionQueue = {}
    Factory.ProductionNumber = 0

    Facbutton = buttons.new()
    FacDesigner = buttons.newToolButton(
        Tankdesigner_icon,
        function ()
            if Factory.isopen then
                Factory.isopen = false
            else
                Factory.isopen = true
            end
        end,
        Facbutton
    )

    TankDesigner:load()
end

function FactoryUI:update(dt)
    TankDesigner:update()
    --tank production process
    for i, tank in ipairs(Factory.ProductionQueue) do
        tank.buildtime = tank.buildtime - dt
        if tank.buildtime <= 0 then
            table.remove(Factory.ProductionQueue, i)
        end
    end

end

function FactoryUI:draw()
    
    Facbutton:use()
    TankDesigner:draw()
end