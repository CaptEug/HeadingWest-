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


function buttons.newCampicButton(picture, fn, buttons, bx, by)
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

function buttons.newToolButton(picture, fn, buttons, bx, by, pictureHot, picturepressed, pictureOn)
    local instance = {
        type = 2,
        state = 'Off',
        pic = picture,
        picture = picture,
        pictureHot = pictureHot or picture,
        picturepressed = picturepressed or picture,
        pictureOn = pictureOn or picture,
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

function buttons.newWindowToolButton(picture, fn, window, buttons, bx, by, pictureHot, picturepressed, pictureOn)
    local instance = {
        type = 3,
        state = 'Off',
        pic = picture,
        picture = picture,
        pictureHot = pictureHot or picture,
        picturepressed = picturepressed or picture,
        pictureOn = pictureOn or picture,
        fn = fn,
        window = window,
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

function buttons.newCamButton(picture, fn, buttons, bx, by, pictureHot)
    local instance = {
        type = 4,
        pic = picture,
        picture = picture,
        fn = fn,
        w = picture:getWidth(),
        h = picture:getHeight(),
        bx = bx or picture:getWidth() / 2,
        by = by or picture:getHeight() / 2,
        now = true,
        last = true,
        pictureHot = pictureHot
    }
    table.insert(buttons, instance)
    return instance
end

function buttons.newCamBoxButton(w, h, fn, buttons, bx, by)
    local instance = {
        type = 5,
        fn = fn,
        w = w,
        h = h,
        bx = bx or w / 2,
        by = by or h / 2,
        now = true,
        last = true,
    }
    table.insert(buttons, instance)
    return instance
end

function buttons:use()
    local ratio = love.graphics.getWidth() / 1890
    local mx, my = love.mouse.getPosition()
    local cmx, cmy = cam:mousePosition()

    for i, button in ipairs(self) do
        local ButtonColor = {1, 1, 1, 1}
        if button.type == 0 then
            love.graphics.setFont(Rbuttonfont)
            local x, y = button.bx - button.w / 2, button.by - button.h / 2
            button.Hot = mx>=x and mx<=x+button.w and my>=y and my<=y+button.h
            button.last = button.now
            if button.Hot then
                ButtonColor ={1, 0.1, 0.1, 1}
                Cursormode = 'button'
            end
            button.now = love.mouse.isDown(1)
            if button.now and not button.last and button.Hot then
                button.fn()
            end
            love.graphics.setColor(unpack(ButtonColor))
            love.graphics.print(button.text, x, y)
        end

        if button.type == 1 then
            local x, y = button.bx - button.w * ratio / 2, button.by - button.h * ratio / 2
            button.Hot = cmx>=x and cmx<=x+button.w * ratio and cmy>=y and cmy<=y+button.h * ratio
            button.last = button.now
            if button.Hot then
                ButtonColor ={1, 0.1, 0.1, 1}
                Cursormode = 'button'
            end
            button.now = love.mouse.isDown(1)
            if button.now and not button.last and button.Hot then
                button.fn()
            end
            love.graphics.setColor(unpack(ButtonColor))
            love.graphics.draw(button.picture, x, y, 0, ratio)
        end
        
        if button.type == 2 then
            local x, y = button.bx - button.w / 2, button.by - button.h / 2
            button.Hot = mx>=x and mx<=x+button.w and my>=y and my<=y+button.h
            button.last = button.now
            button.now = love.mouse.isDown(1)
            if button.Hot then
                Cursormode = 'button'
                button.pic = button.pictureHot
            else
                button.pic = button.picture
            end
            if button.now and button.Hot then
                button.pic = button.picturepressed
            end
            if button.now and not button.last and button.Hot then
                button.fn()
                if button.state == 'On' then
                    button.state = 'Off'
                else
                    button.state = 'On'
                end
            end
            if button.state == 'Off' and not button.Hot then
                button.pic = button.picture
            elseif button.state == 'On' and not button.Hot then
                button.pic = button.pictureOn
            end
            love.graphics.setColor(unpack(ButtonColor))
            love.graphics.draw(button.pic, x, y)
        end

        if button.type == 3 then
            local x, y = button.bx - button.w / 2 + button.window.x, button.by - button.h / 2 + button.window.y
            button.Hot = mx>=x and mx<=x+button.w and my>=y and my<=y+button.h
            button.last = button.now
            button.now = love.mouse.isDown(1)
            if button.Hot then
                Cursormode = 'button'
                button.pic = button.pictureHot
            else
                button.pic = button.picture
            end
            if button.now and button.Hot then
                button.pic = button.picturepressed
            end
            if button.now and not button.last and button.Hot then
                button.fn()
                if button.state == 'On' then
                    button.state = 'Off'
                else
                    button.state = 'On'
                end
            end
            if button.state == 'Off' and not button.Hot then
                button.pic = button.picture
            elseif button.state == 'On' and not button.Hot then
                button.pic = button.pictureOn
            end
            love.graphics.setColor(unpack(ButtonColor))
            love.graphics.draw(button.pic, x - button.window.x, y - button.window.y)
        end

        if button.type == 4 then
            local x, y = button.bx - button.w, button.by - button.h
            local scale = 1
            button.Hot = cmx>=x-button.w/(2*cam.scale) and cmx<=x+button.w/(2*cam.scale) and cmy>=y-button.h/(2*cam.scale) and cmy<=y+button.h/(2*cam.scale)
            button.last = button.now
            if button.Hot then
                Cursormode = 'button'
                button.pic = button.pictureHot
            else
                button.pic = button.picture
            end
            button.now = love.mouse.isDown(1)
            if button.now and not button.last and button.Hot then
                button.fn()
            end
            love.graphics.setColor(unpack(ButtonColor))
            love.graphics.draw(button.pic, x, y, 0, scale/cam.scale, scale/cam.scale, button.w/2, button.h/2)
        end

        if button.type == 5 then
            local x, y = button.bx - button.w, button.by - button.h
            local scale = 1
            button.Hot = cmx>=x-button.w/(2*cam.scale) and cmx<=x+button.w/(2*cam.scale) and cmy>=y-button.h/(2*cam.scale) and cmy<=y+button.h/(2*cam.scale)
            button.last = button.now
            if button.Hot then
                Cursormode = 'button'
            else
            end
            button.now = love.mouse.isDown(1)
            if button.now and not button.last and button.Hot then
                button.fn()
            end
        end
    end
    love.graphics.setColor(1, 1, 1)
end

function Buttonclicked(buttons)
    for i, button in ipairs(buttons) do
        if button.now and not button.last and button.Hot then
            return button
        end
    end
end
