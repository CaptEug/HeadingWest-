ConstructMenu = {}
ConstructionQueue = {}
ConstructMenu.PreBuild = {}
ConstructMenu.canBuild = false

function ConstructMenu:load()
    CMscreen = love.graphics.newCanvas(640, 480)
    CurrentPlace.ConstructMenuWindow = {x = 0, y = 64, w = 640, h = 64, dragging = false}
    ConstructMenu.buildActive = false
    ConstructMenu.build = false
    CurrentPlace.openConstructMenu = false
    CurrentPlace.ConstructMenuButtons = buttons.new()
    ConstructurePicked = false
    ConstructureSelected = {}

    Close = buttons.newWindowToolButton(
            Close_icon,
            function ()
                CurrentPlace.openConstructMenu = false
            end,
            CurrentPlace.ConstructMenuWindow,
            CurrentPlace.ConstructMenuButtons,
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
                if self.PreBuild[1] ~= nil then
                    self.PreBuild[1]:destroy()
                    self.PreBuild = {}
                end
                local preBuild = CurrentPlace.world:newRectangleCollider(IntX,IntY, ConstructureSelected.width,ConstructureSelected.length)
                preBuild:setCollisionClass('PreBuild')
                table.insert(self.PreBuild,preBuild)
            end,
            CurrentPlace.ConstructMenuWindow,
            CurrentPlace.ConstructMenuButtons,
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
        self.PreBuild[1]:destroy()
        ConstructureSelected = {}
    end
    for i, constructure in ipairs(ConstructionQueue) do
        constructure.buildtime = constructure.buildtime - dt
        if constructure.buildtime <= 0 then
            BuildConstructure(CurrentPlace, table.remove(ConstructionQueue, i), 'friendly', constructure.x, constructure.y)
        end
    end
    if ConstructurePicked and self.PreBuild ~= {} then
        self.PreBuild[1]:setPosition(IntX + ConstructureSelected.width/2,IntY + ConstructureSelected.length/2)
    end
end

function ConstructMenu:draw()
    if CurrentPlace.openConstructMenu then
        love.graphics.setCanvas(CMscreen)
        love.graphics.draw(ConstructMenu_screen)
        CurrentPlace.ConstructMenuButtons:use()
        for i, constructure in ipairs(CurrentPlace.constructurelist) do
            love.graphics.draw(contructure_box, 128 + 156*((i-1)%3), 72 + 118*math.floor((i-1)/3))
            love.graphics.setColor(0,179/255,0)
            love.graphics.print(constructure.name,128 + 156*((i-1)%3) + 4, 72 + 118*math.floor((i-1)/3) + 4)
            love.graphics.print(constructure.steel_cost, 240 + 156*((i-1)%3), 141 + 118*math.floor((i-1)/3))
            love.graphics.print(constructure.oil_cost, 240 + 156*((i-1)%3), 161 + 118*math.floor((i-1)/3))
            love.graphics.setColor(1,1,1)
        end
        love.graphics.setCanvas()
        love.graphics.draw(CMscreen, CurrentPlace.ConstructMenuWindow.x, CurrentPlace.ConstructMenuWindow.y)
    end
-- draw cusor building
    if ConstructurePicked then
        local x, y = cam:cameraCoords(IntX, IntY)
        local odd = false
        local imagewidth, imagelength = ConstructureSelected.image:getWidth(), ConstructureSelected.image:getHeight()
        Cursormode = 'Constructing'
        love.graphics.draw(ConstructureSelected.image, x + ConstructureSelected.width/(2/cam.scale), y + ConstructureSelected.length/(2/cam.scale), 0, cam.scale, cam.scale, imagewidth/2, imagelength/2)
    end
--draw green building preview
    for i, building in ipairs(ConstructionQueue) do
        local x, y = cam:cameraCoords(building.x, building.y)
        local imagewidth, imagelength = building.image:getWidth(), building.image:getHeight()
        love.graphics.setColor(0,179/255,0)
        love.graphics.draw(building.image, x + building.width/(2/cam.scale), y + building.length/(2/cam.scale), 0, cam.scale, cam.scale, imagewidth/2, imagelength/2)
        love.graphics.rectangle('line', x + building.width/(2/cam.scale) - 68, y + building.length/(2/cam.scale), 136, 8)
        love.graphics.rectangle('fill', x + building.width/(2/cam.scale) - 66, y + building.length/(2/cam.scale) + 2, 132 - (132*building.buildtime/building.fixedbuildtime), 4)
        love.graphics.setColor(1,1,1)
    end
end

function BuildDetact(button)
    if button == 1 and ConstructMenu.build == true then
        ConstructMenu.build = false
        local building = copytable(ConstructureSelected)
        local x, y = IntX, IntY
        local imagewidth = ConstructureSelected.image:getWidth()
        building.x, building.y = x, y
        table.insert(ConstructionQueue, building)
    end
end

--TDscreen.window draggie
function CMmousepressed(x, y, button)
    -- Check if the mouse is inside the TDscreen.window
    if x >= CurrentPlace.ConstructMenuWindow.x and x <= CurrentPlace.ConstructMenuWindow.x + CurrentPlace.ConstructMenuWindow.w and
     y >= CurrentPlace.ConstructMenuWindow.y and y <= CurrentPlace.ConstructMenuWindow.y + CurrentPlace.ConstructMenuWindow.h then
        Cursormode = 'dragging'
        CurrentPlace.ConstructMenuWindow.dragging = true
       -- Calculate the offset between the mouse position and the TDscreen.window position
       ConstructMenu.offsetX = x - CurrentPlace.ConstructMenuWindow.x
       ConstructMenu.offsetY = y - CurrentPlace.ConstructMenuWindow.y
    end
end
 
function CMmousereleased(x, y, button)
    -- Stop dragging when the mouse is released
    CurrentPlace.ConstructMenuWindow.dragging = false
end
 
function CMmousemoved(x, y, dx, dy)
    -- Update the TDscreen.window position if the user is dragging it
    if CurrentPlace.ConstructMenuWindow.dragging then
        CurrentPlace.ConstructMenuWindow.x = x - ConstructMenu.offsetX
        CurrentPlace.ConstructMenuWindow.y = y - ConstructMenu.offsetY
    end
end