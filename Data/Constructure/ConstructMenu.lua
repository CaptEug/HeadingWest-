ConstructMenu = {}
ConstructionQueue = {}

function ConstructMenu:load()
    CMscreen = love.graphics.newCanvas(640, 480)
    ConstructMenu.window = {x = 0, y = 64, w = 640, h = 64}
    ConstructMenu.dragging = false
    ConstructMenu.buildActive = false
    ConstructMenu.build = false
    CurrentPlace.openConstructMenu = false
    ConstructMenu.Buttons = buttons.new()
    ConstructurePicked = false
    ConstructureSelected = {}

    Close = buttons.newWindowToolButton(
            Close_icon,
            function ()
                CurrentPlace.openConstructMenu = false
            end,
            ConstructMenu.window,
            ConstructMenu.Buttons,
            625,
            18
        )

    for i, constructure in ipairs(CurrentPlace.constructurelist) do
        buttons.newWindowToolButton(
            constructure.icon,
            function ()
                ConstructMenu.build = false
                ConstructurePicked = true
                ConstructureSelected = constructure
            end,
            ConstructMenu.window,
            ConstructMenu.Buttons,
            204 + 156*((i-1)%3),
            129 + 118*math.floor((i-1)/3)
        )
    end
end

function ConstructMenu:update(dt)
    if love.mouse.isDown(1) and ConstructurePicked then
        ConstructMenu.buildActive = true
    end
    if ConstructMenu.buildActive and not love.mouse.isDown(1) then
        ConstructMenu.build = true
        ConstructMenu.buildActive = false
    end
    if love.mouse.isDown(2) and ConstructurePicked then
        ConstructurePicked = false
        ConstructMenu.build = false
        ConstructureSelected = {}
    end
    for i, constructure in ipairs(ConstructionQueue) do
        constructure.buildtime = constructure.buildtime - dt
        if constructure.buildtime <= 0 then
            BuildConstructure(CurrentPlace, table.remove(ConstructionQueue, i), 'friendly', constructure.x, constructure.y)
        end
    end
end

function ConstructMenu:draw()
    if CurrentPlace.openConstructMenu then
        love.graphics.setCanvas(CMscreen)
        love.graphics.draw(ConstructMenu_screen)
        ConstructMenu.Buttons:use()
        for i, constructure in ipairs(CurrentPlace.constructurelist) do
            love.graphics.draw(contructure_box, 128 + 156*((i-1)%3), 72 + 118*math.floor((i-1)/3))
            love.graphics.setColor(0,179/255,0)
            love.graphics.print(constructure.name,128 + 156*((i-1)%3) + 4, 72 + 118*math.floor((i-1)/3) + 4)
            love.graphics.print(constructure.steel_cost, 240 + 156*((i-1)%3), 141 + 118*math.floor((i-1)/3))
            love.graphics.print(constructure.oil_cost, 240 + 156*((i-1)%3), 161 + 118*math.floor((i-1)/3))
            love.graphics.setColor(1,1,1)
        end
        love.graphics.setCanvas()
        love.graphics.draw(CMscreen, ConstructMenu.window.x, ConstructMenu.window.y)
    end

    if ConstructurePicked then
        local x, y = cam:cameraCoords(IntX, IntY)
        local odd = false
        local imagewidth = ConstructureSelected.image:getWidth()
        local center = ConstructureSelected.image:getWidth()/2
        if math.fmod(imagewidth/32,2)==1 then
            x = x + 16
            y = y + 16
        end
        Cursormode = 'Constructing'
        love.graphics.draw(ConstructureSelected.image, x, y, 0, cam.scale, cam.scale, center, center)
    end

    for i, building in ipairs(ConstructionQueue) do
        local x, y = cam:cameraCoords(building.x, building.y)
        local center = building.image:getWidth()/2
        love.graphics.setColor(0,179/255,0)
        love.graphics.draw(building.image, x, y, 0, cam.scale, cam.scale, center, center)
        love.graphics.rectangle('line', x - 68, y, 136, 8)
        love.graphics.rectangle('fill', x - 66, y + 2, 132 - (132*building.buildtime/building.fixedbuildtime), 4)
        love.graphics.setColor(1,1,1)
    end
end

function BuildDetact(button)
    if button == 1 and ConstructMenu.build == true then
        ConstructMenu.build = false
        local building = copytable(ConstructureSelected)
        local x, y = IntX, IntY
        local imagewidth = ConstructureSelected.image:getWidth()
        if math.fmod(imagewidth/32,2) == 1 then
            x = x + 16
            y = y + 16
        end
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