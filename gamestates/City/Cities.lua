Cities = {}
City = {}
City = Gamestate.new()
City.__index = City

--Cities
--USSR
--[[Moskva = {
    x = 1160,
    y = 580,
    country = {},
    name = 'Moskva',
    type = 'Capital',
    factory = false,
    labtory = true,
    state = 'Peace',
    map = 2,
    constructurelist = {},
    exsist_tank = {},
    exsist_building = {},
    Army = {},
    broken_tank={}
}]]

Nizhny_Tagil = {}
Nizhny_Tagil.x = 1280
Nizhny_Tagil.y = 555
Nizhny_Tagil.country = {}
Nizhny_Tagil.name = 'Nizhny Tagil'
Nizhny_Tagil.type = 'Normal'
Nizhny_Tagil.factory = 'UralVagonZavod'
Nizhny_Tagil.labtory = false
Nizhny_Tagil.state = 'Peace'
Nizhny_Tagil.map = 3
Nizhny_Tagil.tanklist = {}
Nizhny_Tagil.constructurelist = {}
Nizhny_Tagil.Army = {}
Nizhny_Tagil.exsist_tank = {}
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
Berlin.x = 1035
Berlin.y = 605
Berlin.country = {}
Berlin.name = 'Berlin'
Berlin.type = 'Capital'
Berlin.factory = false
Berlin.labtory = true
Berlin.state ='Battlefield'
Berlin.map = 1
Berlin.exsist_tank={}
Berlin.Army = {}
Berlin.broken_tank={}
Berlin.exsist_building = {}


--RadioList
TestSonglist = {
    {love.audio.newSource('Assets/audio/music/KINO/Кино - Кукушка.mp3', 'stream')},
    {love.audio.newSource('Assets/audio/music/KINO/Кино - Кончится лето.mp3', 'stream')},
    {love.audio.newSource('Assets/audio/music/KINO/Кино - Красно-желтые дни.mp3', 'stream')}
}

function Cities:load()
    --table.insert(Cities, Moskva)
    --Moskva.country = {USSR_flag}
    
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
    loadMap(Maps[self.map])
    cityUI:load()
end

function City:update(dt)
    world:update(dt)
    particleworld:update(dt)
    TankSpawner:update(dt)
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
        DrawMapDown()
        TankSpawner:drawtank()
        ConstructureSpawner:drawbuilding()
        DrawMapUp()
        world:draw()
        particleworld:draw()
        TankProjectiles:draw()
        Missiles:draw()
    cam:detach()

    cityUI:draw()
end

function City:drawWithoutUI()
    cam:attach()
        DrawMapDown()
        TankSpawner:drawtank()
        DrawMapUp()
        world:draw()
        particleworld:draw()
        TankProjectiles:draw()
        Missiles:draw()
    cam:detach()
end


