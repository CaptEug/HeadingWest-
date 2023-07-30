ConstructMenu = {}
ConstructionQueue = {}
ConstructMenu.PreBuild = {}
ConstructMenu.canBuild = false
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
        ConstructureSelected = {}
    end
    for i, constructure in ipairs(CurrentPlace.exsist_building) do
        constructure.buildtime = constructure.buildtime - dt
        if constructure.buildtime <= 0 and constructure.finished == false then
            constructure.finished = true
        end
    end
    if ConstructurePicked == true then
        self.canBuild =  ConstructManager:query(ConstructureSelected)
    end
end

function ConstructMenu:draw()
    CurrentPlace.ConstructMenuWindow:use(
        function ()
            love.graphics.draw(ConstructMenu_screen)
            for i, constructure in ipairs(CurrentPlace.constructurelist) do
                love.graphics.draw(constructure_box, 128 + 156*((i-1)%3), 72 + 118*math.floor((i-1)/3))
                love.graphics.setColor(0,179/255,0)
                love.graphics.print(constructure.name, 128 + 156*((i-1)%3) + 4, 72 + 118*math.floor((i-1)/3) + 4)
                love.graphics.print(constructure.steel_cost, 240 + 156*((i-1)%3), 141 + 118*math.floor((i-1)/3))
                love.graphics.print(constructure.oil_cost, 240 + 156*((i-1)%3), 161 + 118*math.floor((i-1)/3))
                love.graphics.setColor(1,1,1)
            end
        end
    )

    if  ConstructurePicked  then
        local x, y = cam:cameraCoords(IntX, IntY)
        if self.canBuild then
            love.graphics.setColor(0, 1, 0, 0.6)
        else
            love.graphics.setColor(1, 0, 0, 0.6)
        end
        love.graphics.rectangle('fill', x-(ConstructureSelected.preBuild.width-ConstructureSelected.width)/2*cam.scale, y-(ConstructureSelected.preBuild.length-ConstructureSelected.length)/2*cam.scale, ConstructureSelected.preBuild.width*cam.scale,ConstructureSelected.preBuild.length*cam.scale)
        love.graphics.setColor(1, 1, 1, 1)
        local ver = {
            {
                IntX-32,IntY-32,
                0,0,
                255,255,255,255
            },
            {
                IntX-32,IntY-64,
                0,0,
                255,255,255,255
            },           
            {
                IntX-64,IntY-64,
                0,0,
                255,255,255,255
            },           
            {
                IntX-64,IntY-32,
                0,0,
                255,255,255,255
            },

        }
        local mesh = love.graphics.newMesh(ver,'fan','dynamic')
        mesh:setTexture(love.graphics.newImage('Assets/constructures/ConstructArea.png'))
        love.graphics.draw(mesh,IntX,IntY)
        love.graphics.print(tostring(self.canBuild),0,200)
    end
-- draw cusor building
    if ConstructurePicked then
        local x, y = cam:cameraCoords(IntX, IntY)
        local imagewidth, imagelength = ConstructureSelected.image:getWidth(), ConstructureSelected.image:getHeight()
        Cursormode = 'Constructing'
        love.graphics.draw(ConstructureSelected.image, x + ConstructureSelected.width/(2/cam.scale), y + ConstructureSelected.length/(2/cam.scale), 0, cam.scale, cam.scale, imagewidth/2, imagelength/2)
        ConstructManager:drawPreBuild()
    end
--draw green building preview
    for i, building in ipairs(CurrentPlace.exsist_building) do
        if building.finished == false then
            local x, y = cam:cameraCoords(building.location.x, building.location.y)
            local imagewidth, imagelength = building.image:getWidth(), building.image:getHeight()
            love.graphics.setColor(0,179/255,0)
            love.graphics.draw(building.image, x + building.width/(2/cam.scale), y + building.length/(2/cam.scale), 0, cam.scale, cam.scale, imagewidth/2, imagelength/2)
            love.graphics.rectangle('line', x + building.width/(2/cam.scale) - 68, y + building.length/(2/cam.scale), 136, 8)
            love.graphics.rectangle('fill', x + building.width/(2/cam.scale) - 66, y + building.length/(2/cam.scale) + 2, 132 - (132*building.buildtime/building.fixedbuildtime), 4)
            love.graphics.setColor(1,1,1)
        end
    end
end

function BuildDetact(button)
    if button == 1 and ConstructMenu.build == true and ConstructMenu.canBuild ==true then
        ConstructMenu.build = false
        local building = copytable(ConstructureSelected)
        local x, y = IntX, IntY
        local imagewidth = ConstructureSelected.image:getWidth()
        building.x, building.y = x, y
        BuildConstructure(CurrentPlace, building, 'friendly', building.x, building.y)
    end
end