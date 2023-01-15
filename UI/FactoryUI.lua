FactoryUI={}
require 'UI/TankDesigner'

function FactoryUI:load()
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

function FactoryUI:update()
    TankDesigner:update()
end

function FactoryUI:draw()
    Facbutton:use()
    TankDesigner:draw()
end