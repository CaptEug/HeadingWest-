buttonList = {}

function buttonList:load()
    UVZ_list = {}
    UVZ_list.drawlist = false
    UVZ_list.x = 3100
    UVZ_list.y = 1200
    table.insert(buttonList, UVZ_list)
end

function buttonList:draw()
    for i, button in ipairs(buttonList) do
        if button.drawlist then
            love.graphics.setColor(1, 1, 1, 0.7)
            love.graphics.rectangle("fill", button.x, button.y, 500, 500)
            love.graphics.setColor(1,1,1)
        end
    end
end