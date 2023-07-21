Window = {}
Window.__index = Window

function Window.new()
    local instance = {
        x = 0,
        y = 64,
        w = 640,
        h = 64,
        dragging = false,
        active = false
    }

    instance = setmetatable({}, Window)
    return instance
end

function Window:use()
    
end