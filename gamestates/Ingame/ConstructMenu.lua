ConstructMenu = {}
ConstructionQueue = {}

function ConstructMenu:load()
    CMscreen = love.graphics.newCanvas(640, 480)
    ConstructMenu.window = {x = 0, y = 64, w = 640, h = 64}
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
            204 + 156*((i-1)%3), 129 + 118*math.floor((i-1)/3)
        )
    end
end

function ConstructMenu:update(dt)
    if love.mouse.isDown(2) and ConstructurePicked then
        ConstructurePicked = false
        ConstructureSelected = {}
    end
    for i, constructure in ipairs(ConstructionQueue) do
        constructure.buildtime = constructure.buildtime - dt
        if constructure.buildtime <= 0 then
            BuildConstructure(CurrentPlace, table.remove(ConstructionQueue, i), constructure.x, constructure.y)
        end
    end
end

function ConstructMenu:draw()
    if CurrentPlace.openConstructMenu then
        love.graphics.setCanvas(CMscreen)
        love.graphics.draw(ConstructMenu_screen)
        CurrentPlace.CMbuttons:use()
        for i, constructure in ipairs(CurrentPlace.constructurelist) do
            love.graphics.draw(contructure_box, 128 + 156*((i-1)%3), 72 + 118*math.floor((i-1)/3))
            love.graphics.setColor(0,179/255,0)
            love.graphics.print(constructure.steel_cost, 240 + 156*((i-1)%3), 141 + 118*math.floor((i-1)/3))
            love.graphics.print(constructure.oil_cost, 240 + 156*((i-1)%3), 161 + 118*math.floor((i-1)/3))
            love.graphics.setColor(1,1,1)
        end
        love.graphics.setCanvas()
        love.graphics.draw(CMscreen, ConstructMenu.window.x, ConstructMenu.window.y)
    end

    if ConstructurePicked then
        local x, y = love.mouse.getPosition()
        love.mouse.setCursor(hammercursor)
        Cursormode = 'Constructing'
        love.graphics.draw(ConstructureSelected.image, x, y, 0, cam.scale)
    end

    for i, building in ipairs(ConstructionQueue) do
        local x, y = cam:cameraCoords(building.x, building.y)
        love.graphics.setColor(0,179/255,0)
        love.graphics.draw(building.image, x, y, 0, cam.scale)
        love.graphics.rectangle('line', x + (building.width/2)*cam.scale - 68, y + (building.length)*cam.scale, 136, 8)
        love.graphics.rectangle('fill', x + (building.width/2)*cam.scale - 66, y + (building.length)*cam.scale + 2, 132 - (132*building.buildtime/building.fixedbuildtime), 4)
        love.graphics.setColor(1,1,1)
    end
end

function BuildDetact(button)
    if button == 1 and ConstructurePicked then
        local building = copytable(ConstructureSelected)
        local x, y = cam:mousePosition()
        building.x, building.y = x, y
        table.insert(ConstructionQueue, building)
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