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

function buttons.newCamButton(picture, fn, buttons, bx, by)
    local instance = {
        type = 3,
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

function buttons.newStateButton(picture1, picture2, picture3, fn, buttons, bx, by)
    local instance = {
        type = 4,
        state = 'Off',
        picture1 = picture1,
        picture2 = picture2,
        picture3 = picture3,
        fn = fn,
        w = picture1:getWidth(),
        h = picture1:getHeight(),
        bx = bx or picture1:getWidth() / 2,
        by = by or picture1:getHeight() / 2,
        now = true,
        last = true
    }
    table.insert(buttons, instance)
    return instance
end

function buttons:use()
    local ratio = love.graphics.getWidth() / 1536
    local mx, my = love.mouse.getPosition()
    local cmx, cmy = cam:mousePosition()

    for i, button in ipairs(self) do
        local ButtonColor = {1, 1, 1, 0.7}
        local CButtonColor = {1, 1, 1, 1}

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

        if button.type == 3 then
            local x, y = button.bx - button.w, button.by - button.h
            local scale = 1
            local Hot = cmx>=x-button.w/(2*cam.scale) and cmx<=x+button.w/(2*cam.scale) and cmy>=y-button.h/(2*cam.scale) and cmy<=y+button.h/(2*cam.scale)
            button.last = button.now
            if Hot then
                scale = 1.2
            end
            button.now = love.mouse.isDown(1)
            if button.now and not button.last and Hot then
                button.fn()
            end
            love.graphics.setColor(unpack(CButtonColor))
            love.graphics.draw(button.picture, x, y, 0, scale/cam.scale, scale/cam.scale, button.w/2, button.h/2)
        end

        if button.type == 4 then
            local x, y = button.bx - button.w / 2, button.by - button.h / 2
            local Hot = mx>=x and mx<=x+button.w and my>=y and my<=y+button.h
            button.last = button.now
            if Hot then
                love.graphics.draw(button.picture3, x, y)
            end
            button.now = love.mouse.isDown(1)
            if button.now and not button.last and Hot then
                button.fn()
                button.state = 'On'
            end
            if button.state == 'Off' then
                love.graphics.draw(button.picture1, x, y)
            elseif button.state == 'On' then
                love.graphics.draw(button.picture2, x, y)
            end
        end
    end
    love.graphics.setColor(1, 1, 1)
end