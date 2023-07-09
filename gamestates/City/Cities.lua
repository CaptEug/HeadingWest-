Cities = {}
City = {}
City.__index = City

--Cities
--USSR
Moskva = {}
Moskva = Gamestate.new()
Moskva.x = 1160
Moskva.y = 580
Moskva.country = {}
Moskva.name = 'Moskva'
Moskva.type = 'Capital'
Moskva.factory = false
Moskva.labtory = true
Moskva.state = 'Peace'
Moskva.map = sti("Assets/maps/Testmap.lua")
Moskva.world = wf.newWorld(0, 0)
Moskva.Structure = {}
Moskva.Obstacles = {}
Moskva.constructurelist = {}
Moskva.exsist_tank = {}
Moskva.exsist_ship = {}
Moskva.exsist_building = {}
Moskva.Army = {}
Moskva.broken_tank={}


Nizhny_Tagil = {}
Nizhny_Tagil = Gamestate.new()
Nizhny_Tagil.x = 1280
Nizhny_Tagil.y = 555
Nizhny_Tagil.country = {}
Nizhny_Tagil.name = 'Nizhny Tagil'
Nizhny_Tagil.type = 'Normal'
Nizhny_Tagil.factory = 'UVZ'
Nizhny_Tagil.labtory = false
Nizhny_Tagil.state = 'Peace'
Nizhny_Tagil.map = sti("Assets/maps/UVZfac.lua")
Nizhny_Tagil.world = wf.newWorld(0, 0)
Nizhny_Tagil.Structure = {}
Nizhny_Tagil.Obstacles = {}
Nizhny_Tagil.tanklist = {}
Nizhny_Tagil.constructurelist = {}
Nizhny_Tagil.Army = {}
Nizhny_Tagil.exsist_tank = {}
Nizhny_Tagil.exsist_ship = {}
Nizhny_Tagil.broken_tank = {}
Nizhny_Tagil.exsist_building = {}
Nizhny_Tagil.building_slot = 16
Nizhny_Tagil.songlist = {}
Nizhny_Tagil.slot_info = {
    {x=112,y=48,available=true},
    {x=112,y=48+256*1,available=true},
    {x=112,y=48+256*2,available=true},
    {x=112,y=48+256*3,available=true},
    {x=112,y=48+256*4,available=true},
    {x=112,y=48+256*5,available=true},
    {x=112,y=48+256*6,available=true},
    {x=112,y=48+256*7,available=true},
    {x=112+544,y=48,available=true},
    {x=112+544,y=48+256*1,available=true},
    {x=112+544,y=48+256*2,available=true},
    {x=112+544,y=48+256*3,available=true},
    {x=112+544,y=48+256*4,available=true},
    {x=112+544,y=48+256*5,available=true},
    {x=112+544,y=48+256*6,available=true},
    {x=112+544,y=48+256*7,available=true},
}

--[[Baku = {
    x = 1220,
    y = 700,
    country = {USSR_flag},
    name = 'Baku',
    type = 'Normal',
    factory = false,
    labtory = true,
    state ='Peace',
    map = 2,
    constructurelist = {},
    exsist_tank={},
    Army = {},
    broken_tank={}
}
table.insert(Cities, Baku)]]

--German
Berlin = {}
Berlin = Gamestate.new()
Berlin.x = 1035
Berlin.y = 605
Berlin.country = {}
Berlin.name = 'Berlin'
Berlin.type = 'Capital'
Berlin.factory = false
Berlin.labtory = true
Berlin.state ='Battlefield'
Berlin.map = sti("Assets/maps/checkpointC.lua")
Berlin.world = wf.newWorld(0, 0)
Berlin.Structure = {}
Berlin.Obstacles = {}
Berlin.exsist_tank = {}
Berlin.exsist_ship = {}
Berlin.Army = {}
Berlin.broken_tank = {}
Berlin.exsist_building = {}


--RadioList
TestSonglist = {
    {love.audio.newSource('Assets/audio/music/KINO/Кино - Кукушка.mp3', 'stream')},
    {love.audio.newSource('Assets/audio/music/KINO/Кино - Кончится лето.mp3', 'stream')},
    {love.audio.newSource('Assets/audio/music/KINO/Кино - Красно-желтые дни.mp3', 'stream')}
}

function Cities:load()
    Moskva.country = {USSR_flag}
    setmetatable(Moskva, City)
    table.insert(Cities, Moskva)
    
    Nizhny_Tagil.country = {USSR_flag}
    Nizhny_Tagil.songlist = TestSonglist
    setmetatable(Nizhny_Tagil, City)
    table.insert(Cities, Nizhny_Tagil)
    
    table.insert(Cities, Berlin)
    setmetatable(Berlin, City)
    Berlin.country = {USSR_flag, US_flag, UK_flag, FR_flag}
end

function Cities:playRadio(songlist)
    local songindex = math.random(0, #songlist-1)
    if love.audio.getActiveSourceCount( ) then
        love.audio.stop()
    end
    if love.audio.getActiveSourceCount( ) == 0 then
        if songindex < #songlist then 
            songindex = songindex + 1
            love.audio.play(songlist[songindex])
        end
    end
end

function City:init()
    self.world:addCollisionClass('APCBC')
    self.world:addCollisionClass('HE')
    self.world:addCollisionClass('HEAT')
    self.world:addCollisionClass('APDS')
    self.world:addCollisionClass('APFSDS')
    self.world:addCollisionClass('ATGM')
    self.world:addCollisionClass('Wall')
    self.world:addCollisionClass('Fregment', {ignores = {'Fregment'}})
    self.world:addCollisionClass('Hull')
    self:loadmap()
    cityUI:load()
    Buildtank(CurrentPlace, Tanks.M1, 'enemy', 1000, 1000)
    Buildship(CurrentPlace, Ships.Atlanta,'enemy', 1000, 1500)
    NewSaving:LoadTanks()
end

function City:update(dt)
    self.world:update(dt)
    particleworld:update(dt)
    TankSpawner:update(dt)
    ShipSpawner:update(dt)
    ConstructureSpawner:update(dt)
    TankProjectiles:update(dt)
    Missiles:update(dt)
    Explosives:update(dt)
    Fragments:update(dt)
    cityUI:update(dt)
    --cam contral
    if cam.scale > 2 then
        cam:zoomTo(2)
    end
    if cam.scale < 0.2 then
        cam:zoomTo(0.2)
    end
    --mouse input
    function love.mousepressed(x, y, button)
        SelectionMousePressed(x, y, button)
        if CurrentPlace.openTankDesigner then
            TDmousepressed(x, y, button)
        end
        if CurrentPlace.openCityInfoPenal then
            AEmousepressed(x, y, button)
        end
        if CurrentPlace.openConstructMenu then
            CMmousepressed(x, y, button)
        end
        if TankPanelopen then
            TPmousepressed(x, y, button)
        end
    end
    function love.mousereleased(x, y, button)
        SelectionMouseReleased(x, y, button)
        if CurrentPlace.openTankDesigner then
            TDmousereleased(x, y, button)
        end
        if CurrentPlace.openCityInfoPenal then
            AEmousereleased(x, y, button)
        end
        if CurrentPlace.openConstructMenu then
            CMmousereleased(x, y, button)
        end
        if TankPanelopen then
            TPmousereleased(x, y, button)
        end
        BuildDetact(button)
    end
    function love.mousemoved(x, y, dx, dy)
        if CurrentPlace.openTankDesigner then
            TDmousemoved(x, y, dx, dy)
        end
        if CurrentPlace.openCityInfoPenal then
            AEmousemoved(x, y, dx, dy)
        end
        if CurrentPlace.openConstructMenu then
            CMmousemoved(x, y, dx, dy)
        end
        if TankPanelopen then
            TPmousemoved(x, y, dx, dy)
        end
    end
end

function City:draw()
    cam:attach()
        self:DrawMapDown()
        TankSpawner:drawtank()
        ShipSpawner:drawship()
        ConstructureSpawner:drawbuilding()
        self:DrawMapUp()
        self.world:draw()
        particleworld:draw()
        TankProjectiles:draw()
        Missiles:draw()
    cam:detach()

    cityUI:draw()
end

function City:drawWithoutUI()
    cam:attach()
        self:DrawMapDown()
        TankSpawner:drawtank()
        ShipSpawner:drawship()
        self:DrawMapUp()
        self.world:draw()
        particleworld:draw()
        TankProjectiles:draw()
        Missiles:draw()
    cam:detach()
end

function City:loadmap()
    if self.map.layers['Structure'] then
        for i, j in pairs(self.map.layers['Structure'].objects) do
            local Collider = self.world:newRectangleCollider(j.x, j.y, j.width, j.height)
            Collider.width = j.width
            Collider.height = j.height
            Collider:setType('static')
            Collider:setCollisionClass('Wall')
            table.insert(self.Structure, Collider)
        end
    end

    if self.map.layers['Obstacles'] then
        for i, j in pairs(self.map.layers['Obstacles'].objects) do
            local Collider = self.world:newRectangleCollider(j.x, j.y, j.width, j.height)
            Collider.width = j.width
            Collider.height = j.height
            table.insert(self.Obstacles, Collider)
        end
    end
end

function City:DrawMapDown()
    if self.map.layers["Ground"] then
        self.map:drawLayer(self.map.layers["Ground"])
    end

    if self.map.layers["Objects"] then
        self.map:drawLayer(self.map.layers["Objects"])
    end

    if self.map.layers["Buildings"] then
        self.map:drawLayer(self.map.layers["Buildings"])
    end

    for i, j in pairs(self.Obstacles) do
        local collider_x,collider_y = j:getPosition()
        local collider_angle = j:getAngle()
        love.graphics.draw(love.graphics.newImage("Assets/objects/Spike1.png"), collider_x,collider_y, collider_angle, 1, 1, j.width/2, j.height/2)
    end
end

function City:DrawMapUp()
    if self.map.layers["Ceiling"] then
        self.map:drawLayer(self.map.layers["Ceiling"])
    end

    if self.map.layers["Roof"] and cam.scale < 1 then
        love.graphics.setColor(1,1,1,0.5/cam.scale)
        self.map:drawLayer(self.map.layers["Roof"])
        love.graphics.setColor(1,1,1)
    end

    if self.map.layers["Sky"] then
        self.map:drawLayer(self.map.layers["Sky"])
    end
end