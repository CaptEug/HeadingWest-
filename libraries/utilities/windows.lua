Window = {}
Windows = {}
Window.__index = Window

function Window.new(x, y, w, h)
    local instance = {
        x = x,
        y = y,
        w = w,
        h = h,
        open = false,
        dragging = false,
        active = false,
        canvas = love.graphics.newCanvas(w, h),
        buttons = Buttons.new()
    }

    setmetatable(instance, Window)
    table.insert(Windows, instance)
    return instance
end

function Window:start()
    love.graphics.setCanvas(self.canvas)
end

function Window:use()
    if self.open then
        self.buttons:use()
    end
    love.graphics.setCanvas()
    if self.open then
        love.graphics.draw(self.canvas, self.x, self.y)
    end
end

function Windows:mousepressed(x, y, button)
    -- Check if the mouse is inside the screen.window
    for i, window in ipairs(self) do
        if window.open then
            if x >= window.x and x <= window.x + window.w and y >= window.y and y <= window.y + window.h then
                Cursormode = 'dragging'
                window.dragging = true
                -- Calculate the offset between the mouse position and the screen.window position
                window.offsetX = x - window.x
                window.offsetY = y - window.y
            end
        end
    end
end

function Windows:mousereleased(x, y, button)
    -- Stop dragging when the mouse is released
    for i, window in ipairs(self) do
        if window.open then
            window.dragging = false
        end
    end
end

function Windows:mousemoved(x, y)
    -- Update the screen.window position if the user is dragging it
    for i, window in ipairs(self) do
        if window.open then
            if window.dragging then
                window.x = x - window.offsetX
                window.y = y - window.offsetY
            end
        end
    end
end