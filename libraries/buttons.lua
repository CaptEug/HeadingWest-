buttons = {}
buttons.__index = buttons

function buttons.new()
    local instance = setmetatable({}, buttons)
    return instance
end

function buttons.newButton(text, fn, buttons, bx, by)
    local instance = {
        type = 0,
        text = text,
        fn = fn,
        w = Rbuttonfont:getWidth(text),
        h = Rbuttonfont:getHeight(text),
        bx = bx or Rbuttonfont:getWidth(text) / 2,
        by = by or Rbuttonfont:getHeight(text) / 2,
        now = true,
        last = true
    }
    table.insert(buttons, instance)
    return instance
end

function buttons.newPicButton(picture, fn, buttons, bx, by)
    local instance = {
        type = 1,
        picture = picture,
        fn = fn,
        w = picture:getWidth(),
        h = picture:getHeight(),
        bx = bx or picture:getWidth() / 2,
        by = by or picture:getHeight() / 2,
        now = true,
        last = true
    }
    table.insert(buttons, instance)
    return instance
end

function buttons.newToolButton(picture, fn, buttons, bx, by)
    local instance = {
        type = 2,
        picture = picture,
        fn = fn,
        w = picture:getWidth(),
        h = picture:getHeight(),
        bx = bx or picture:getWidth() / 2,
        by = by or picture:getHeight() / 2,
        now = true,
        last = true
    }
    table.insert(buttons, instance)
    return instance
end

function buttons:use()
    local ratio = love.graphics.getWidth() / 1536
    local mx, my = love.mouse.getPosition()
    
    for i, button in ipairs(self) do
        local ButtonColor = {1, 1, 1, 0.7}
        
        if button.type == 0 then
            love.graphics.setFont(Rbuttonfont)
            local x, y = button.bx - button.w / 2, button.by - button.h / 2
            local Hot = mx>=x and mx<=x+button.w and my>=y and my<=y+button.h
            button.last = button.now
            if Hot then
                ButtonColor ={1, 0.1, 0.1, 1}
            end
            button.now = love.mouse.isDown(1)
            if button.now and not button.last and Hot then
                button.fn()
            end
            love.graphics.setColor(unpack(ButtonColor))
            love.graphics.print(button.text, x, y)
        end
        
        if button.type == 1 then
            local x, y = button.bx - button.w * ratio / 2, button.by - button.h * ratio / 2
            local Hot = mx>=x and mx<=x+button.w * ratio and my>=y and my<=y+button.h * ratio
            button.last = button.now
            if Hot then
                ButtonColor ={1, 0.1, 0.1, 1}
            end
            button.now = love.mouse.isDown(1)
            if button.now and not button.last and Hot then
                button.fn()
            end
            love.graphics.setColor(unpack(ButtonColor))
            love.graphics.draw(button.picture, x, y, 0, ratio)
        end    
        
        if button.type == 2 then
            local x, y = button.bx - button.w / 2, button.by - button.h / 2
            local Hot = mx>=x and mx<=x+button.w and my>=y and my<=y+button.h
            button.last = button.now
            if Hot then
                ButtonColor ={1, 0.1, 0.1, 1}
            end
            button.now = love.mouse.isDown(1)
            if button.now and not button.last and Hot then
                button.fn()
            end
            love.graphics.setColor(unpack(ButtonColor))
            love.graphics.draw(button.picture, x, y)
        end
    end
    love.graphics.setColor(1, 1, 1)
end