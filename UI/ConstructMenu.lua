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
    if CurrentPlace.openConstructMenu then
    love.graphics.setCanvas(TDscreen)
        
    love.graphics.setCanvas()
    end
end

--TDscreen.window draggie
function CMmousepressed(x, y, button)
    -- Check if the mouse is inside the TDscreen.window
    if x >= ConstructMenu.window.x and x <= ConstructMenu.window.x + ConstructMenu.window.w and
     y >= ConstructMenu.window.y and y <= ConstructMenu.window.y + ConstructMenu.window.h then
        Cursormode = 'dragging'
        ConstructMenu.dragging = true
       -- Calculate the offset between the mouse position and the TDscreen.window position
       ConstructMenu.offsetX = x - ConstructMenu.window.x
       ConstructMenu.offsetY = y - ConstructMenu.window.y
    end
end
 
function CMmousereleased(x, y, button)
    -- Stop dragging when the mouse is released
    ConstructMenu.dragging = false
end
 
function CMmousemoved(x, y, dx, dy)
    -- Update the TDscreen.window position if the user is dragging it
    if ConstructMenu.dragging then
        ConstructMenu.window.x = x - ConstructMenu.offsetX
        ConstructMenu.window.y = y - ConstructMenu.offsetY
    end
end