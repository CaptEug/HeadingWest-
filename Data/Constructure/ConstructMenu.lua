ConstructMenu = {}
ConstructionQueue = {}
ConstructMenu.PreBuild = {}
ConstructMenu.canBuild = false
ConstructMenu.query = false
ConstructMenu.queryArea = {}

function ConstructMenu:load()
    CurrentPlace.ConstructMenuWindow = Window.new(64, 64, 640, 480)
    ConstructMenu.buildActive = false
    ConstructMenu.build = false
    ConstructurePicked = false
    ConstructureSelected = {}

    Close = Buttons.newWindowToolButton(
            Close_icon,
            function ()
                CurrentPlace.ConstructMenuWindow.open = false
            end,
            CurrentPlace.ConstructMenuWindow,
            CurrentPlace.ConstructMenuWindow.buttons,
            625,
            18
        )

    for i, constructure in ipairs(CurrentPlace.constructurelist) do
        Buttons.newWindowToolButton(
            constructure.icon,
            function ()
                ConstructMenu.build = false
                ConstructurePicked = true
                ConstructureSelected = constructure
                self.query = true
            end,
            CurrentPlace.ConstructMenuWindow,
            CurrentPlace.ConstructMenuWindow.buttons,
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
        self.query = false
        ConstructureSelected = {}
    end
    for i, constructure in ipairs(ConstructionQueue) do
        constructure.buildtime = constructure.buildtime - dt
        if constructure.buildtime <= 0 then
            BuildConstructure(CurrentPlace, table.remove(ConstructionQueue, i), 'friendly', constructure.x, constructure.y)
        end
    end

    if self.query == true then
        local x, y = cam:cameraCoords(IntX, IntY)
        self.queryArea = CurrentPlace.world:queryRectangleArea(x,y, ConstructureSelected.width,ConstructureSelected.length,{'Wall'})
        if self.queryArea ~= {} then
            self.canBuild = false
        else
            self.canBuild =true
        end
    end
    --[[if ConstructurePicked and self.PreBuild ~= {} then
        self.PreBuild[1]:setPosition(IntX + ConstructureSelected.width/2,IntY + ConstructureSelected.length/2)
        if self.PreBuild[1]:stay('Wall') then
            ConstructMenu.canBuild = false
        else
            ConstructMenu.canBuild = true
        end
    end]]
end

function ConstructMenu:draw()
    CurrentPlace.ConstructMenuWindow:start()
        love.graphics.draw(ConstructMenu_screen)
        for i, constructure in ipairs(CurrentPlace.constructurelist) do
            love.graphics.draw(constructure_box, 128 + 156*((i-1)%3), 72 + 118*math.floor((i-1)/3))
            love.graphics.setColor(0,179/255,0)
            love.graphics.print(constructure.name, 128 + 156*((i-1)%3) + 4, 72 + 118*math.floor((i-1)/3) + 4)
            love.graphics.print(constructure.steel_cost, 240 + 156*((i-1)%3), 141 + 118*math.floor((i-1)/3))
            love.graphics.print(constructure.oil_cost, 240 + 156*((i-1)%3), 161 + 118*math.floor((i-1)/3))
            love.graphics.setColor(1,1,1)
        end
    CurrentPlace.ConstructMenuWindow:use()


    if self.query == true then
        local x, y = cam:cameraCoords(IntX, IntY)
        love.graphics.rectangle('fill', x, y, ConstructureSelected.width*cam.scale,ConstructureSelected.length*cam.scale)
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
    if button == 1 and ConstructMenu.build == true and ConstructMenu.canBuild ==true then
        ConstructMenu.build = false
        local building = copytable(ConstructureSelected)
        local x, y = IntX, IntY
        local imagewidth = ConstructureSelected.image:getWidth()
        building.x, building.y = x, y
        table.insert(ConstructionQueue, building)
    end
end