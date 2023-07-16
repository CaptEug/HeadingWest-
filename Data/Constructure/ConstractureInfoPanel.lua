ConstructureInfoPanel = {}

function ConstructureInfoPanel:draw()
    for i, building in ipairs(CurrentPlace.exsist_building) do
        if building.openinfopenal then
            local x, y = love.mouse.getPosition()
            love.graphics.setColor(34/255, 32/255, 52/255)
            love.graphics.rectangle("fill", x, y, 256, 128)
            love.graphics.setColor(0, 179/255, 0)
            love.graphics.setLineWidth(2)
            love.graphics.rectangle("line", x, y, 256, 128)
            love.graphics.setLineWidth(1)

            love.graphics.print(building.name, x + 14, y + 4)
        end
    end
end