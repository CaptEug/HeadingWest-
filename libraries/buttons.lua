buttons = {}
buttons.__index = buttons

function buttons.new()
    local instance = setmetatable({}, buttons)
    return instance
end

function buttons.newButton(text, fn, buttons, bx, by)
    local instance = {
            text = text,
            fn = fn,
            w = Rbuttonfont:getWidth(text),
            h = Rbuttonfont:getHeight(text),
            bx = bx or Rbuttonfont:getWidth(text) / 2,
            by = by or Rbuttonfont:getHeight(text) / 2
    }
    table.insert(buttons, instance)
    return instance
end

function buttons:use()
    for i, button in ipairs(self) do
        local ButtonColor = {1, 1, 1, 0.5}
        local mx, my = love.mouse.getPosition()
        local x, y = button.bx - button.w / 2, button.by - button.h / 2
        local Hot = mx>=x and mx<=x+button.w and my>=y and my<=y+button.h
        
        love.graphics.setFont(Rbuttonfont)
        
        if Hot then
            ButtonColor ={1, 0.1, 0.1, 1}
        end
        
        if love.mouse.isDown(1) and Hot then
            button.fn()
        end
        
        love.graphics.setColor(unpack(ButtonColor))
        love.graphics.print(button.text, x, y)
    end
    love.graphics.setColor(1, 1, 1)
end