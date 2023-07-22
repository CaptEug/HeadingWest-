Window = {}
Windows = {}
Window.__index = Window

function Window.new()
    local instance = {
        x = 0,
        y = 64,
        w = 640,
        h = 64,
        dragging = false,
        active = false,
        buttons = Buttons.new()
    }

    instance = setmetatable({}, Window)
    table.insert(Windows, instance)
    return instance
end

function Window:use()
    
end

function Window:mousepressed()
    -- Check if the mouse is inside the TDscreen.window
    if x >= self.x and x <= self.x + self.w and
     y >= self.y and y <= self.y + self.h then
        Cursormode = 'dragging'
        self.dragging = true
       -- Calculate the offset between the mouse position and the TDscreen.window position
       self.offsetX = x - self.x
       self.offsetY = y - self.y
    end
end

function Window:mousereleased()
    -- Stop dragging when the mouse is released
    self.dragging = false
end

function Window:mousemoved()
    -- Update the TDscreen.window position if the user is dragging it
    if self.dragging then
        self.x = x - self.offsetX
        self.y = y - self.offsetY
    end
end