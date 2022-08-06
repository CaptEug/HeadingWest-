buttons = {}
buttons.__index = buttons

function buttons.new()
    local instance = setmetatable({}, buttons)
    return instance
end

function buttons.newButton(type,text, fn, buttons, bx, by)
    local instance = {
            type = type,
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

function buttons.newPicButton(type,picture, fn, buttons, bx, by)
    local instance = {
        type = type,
            picture = picture,
            fn = fn,
            w = picture:getWidth(),
            h = picture:getHeight(),
            bx = bx or picture:getWidth() / 2,
            by = by or picture:getHeight() / 2
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

        if button.type == 1 then
            love.graphics.print(button.text, x, y)
            else if button.type == 0 then
                love.graphics.draw(button.picture, x, y)
            end
        end
    end
    love.graphics.setColor(1, 1, 1)
end