ConstructMenu = {}

function ConstructMenu:load()
    CMscreen = love.graphics.newCanvas(640, 480)
    ConstructMenu.window = {x = 0, y = 32, w = 640, h = 64}
    ConstructMenu.dragging = false
    CurrentPlace.openConstructMenu = false
    CurrentPlace.CMbuttons = buttons.new()
    ConstructurePicked = false
    ConstructureSelected = {}

    for i, constructure in ipairs(CurrentPlace.constructurelist) do
        buttons.newWindowToolButton(
            constructure.image,
            function ()
                ConstructurePicked = true
                ConstructureSelected = constructure
            end,
            ConstructMenu.window,
            CurrentPlace.CMbuttons,
            24, 48*i
        )
    end
end

function ConstructMenu:update(dt)
    if love.mouse.isDown(1) and ConstructurePicked then
        local x, y = cam:mousePosition()
        BuildConstructure(CurrentPlace, ConstructureSelected, x, y)
    end
    if love.mouse.isDown(2) and ConstructurePicked then
        ConstructurePicked = false
        ConstructureSelected = {}
    end
end

function ConstructMenu:draw()
    if CurrentPlace.openConstructMenu then
        love.graphics.setCanvas(CMscreen)
        love.graphics.draw(ConstructMenu_screen)
        CurrentPlace.CMbuttons:use()
        love.graphics.setCanvas()
        love.graphics.draw(CMscreen, ConstructMenu.window.x, ConstructMenu.window.y)
    end

    if ConstructurePicked then
        local x, y = love.mouse.getPosition()
        love.mouse.setCursor(hammercursor)
        Cursormode = 'Constructing'
        love.graphics.draw(ConstructureSelected.image, x, y, 0, cam.scale)
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