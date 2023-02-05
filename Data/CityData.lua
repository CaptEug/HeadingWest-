CityData = {}
Cities = {}
Alltanks = {}


function CityData:load()
    --Cities
    UVZ = {
        x = 1000,
        y = 500,
        name = 'Uralvagonzavod',
        icon = UVZ_Icon,
        state ='Captured',
        map = 3,
        tanklist = {},
        tankstock = {},
        building_slot = 16,
        songlist = {
            Cuckoo_Bird = love.audio.newSource('Assets/audio/music/KINO/Кино - Кукушка.mp3', 'stream'),
            Summer = love.audio.newSource('Assets/audio/music/KINO/Кино - Кончится лето.mp3', 'stream')
        }
    }
    table.insert(Cities, UVZ)

    Berlin = {
        x = 500,
        y = 500,
        name = 'Berlin',
        icon = Berlin_icon,
        state ='Battlefield',
        map = 1,
        tankstock = {}
    }
    table.insert(Cities, Berlin)

end


