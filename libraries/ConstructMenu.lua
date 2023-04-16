ConstructMenu = {}

function ConstructMenu:load()
    CMscreen = love.graphics.newCanvas(640, 480)
    ConstructMenu.window = {x = 0, y = 32, w = 640, h = 64}
    ConstructMenu.dragging = false
    CurrentPlace.openConstructMenu = false
    CurrentPlace.CMbuttons = buttons.new()
end

function ConstructMenu:update(dt)

end

function ConstructMenu:draw()
    
end