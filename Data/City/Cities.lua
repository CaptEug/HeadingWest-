Cities = {}
City = {}
City.__index = City

--Cities
--USSR
--[[Moskva = {}
Moskva = Gamestate.new()
Moskva.x = 1160
Moskva.y = 580
Moskva.country = {}
Moskva.name = 'Moskva'
Moskva.type = 'Capital'
Moskva.state = 'Peace'
Moskva.oil_stored = 0
Moskva.steel_stored = 0
Moskva.oil_production = 0
Moskva.steel_production = 0
Moskva.researchinstitude = {}
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
Nizhny_Tagil.state = 'Peace'
Nizhny_Tagil.oil_stored = 0
Nizhny_Tagil.steel_stored = 0
Nizhny_Tagil.oil_production = 0
Nizhny_Tagil.steel_production = 0
Nizhny_Tagil.tankfactory = {
    name = 'UVZ',
    tanklist = {}
}
Nizhny_Tagil.map = sti("Assets/maps/UVZfac.lua")
Nizhny_Tagil.world = wf.newWorld(0, 0)
--map collider
Nizhny_Tagil.Structure = {}
Nizhny_Tagil.Obstacles = {}
Nizhny_Tagil.Coast = {}
Nizhny_Tagil.Ocean = {}
Nizhny_Tagil.Oil = {}
Nizhny_Tagil.constructurelist = {}
Nizhny_Tagil.Army = {}
Nizhny_Tagil.exsist_tank = {}
Nizhny_Tagil.exsist_ship = {}
Nizhny_Tagil.broken_tank = {}
Nizhny_Tagil.exsist_building = {}
Nizhny_Tagil.songlist = {}]]

TestField = {}
TestField = Gamestate.new()
TestField.x = 1467
TestField.y = 884
TestField.country = {}
TestField.name = 'Test Field'
TestField.type = 'Normal'
TestField.state = 'Peace'
TestField.oil_stored = 0
TestField.steel_stored = 0
TestField.oil_production = 0
TestField.steel_production = 0
TestField.tankfactory = {
    name = 'Test Factory',
    tanklist = {}
}
TestField.map = sti("Assets/maps/TestField.lua")
TestField.world = wf.newWorld(0, 0)
--map collider
TestField.Structure = {}
TestField.Obstacles = {}
TestField.Coast = {}
TestField.Ocean = {}
TestField.Oil = {}
TestField.constructurelist = {}
TestField.Army = {}
TestField.exsist_tank = {}
TestField.exsist_ship = {}
TestField.broken_tank = {}
TestField.exsist_building = {}
TestField.songlist = {}


--RadioList
TestSonglist = {
    {love.audio.newSource('Assets/audio/music/KINO/Кино - Кукушка.mp3', 'stream')},
    {love.audio.newSource('Assets/audio/music/KINO/Кино - Кончится лето.mp3', 'stream')},
    {love.audio.newSource('Assets/audio/music/KINO/Кино - Красно-желтые дни.mp3', 'stream')}
}

