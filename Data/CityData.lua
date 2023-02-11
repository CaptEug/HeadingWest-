CityData = {}
Cities = {}
Alltanks = {}


function CityData:load()
    --RadioList
    TestSonglist = {
        {love.audio.newSource('Assets/audio/music/KINO/Кино - Кукушка.mp3', 'stream')},
        {love.audio.newSource('Assets/audio/music/KINO/Кино - Кончится лето.mp3', 'stream')},
        {love.audio.newSource('Assets/audio/music/KINO/Кино - Красно-желтые дни.mp3', 'stream')}
    }
    --Cities
    UVZ = {
        x = 1280,
        y = 555,
        name = 'Uralvagonzavod',
        icon = City_normal,
        state ='Captured',
        map = 3,
        tanklist = {},
        tankstock = {},
        building_slot = 16,
        songlist = TestSonglist
    }
    table.insert(Cities, UVZ)

    Berlin = {
        x = 1035,
        y = 605,
        name = 'Berlin',
        icon = City_capital,
        state ='Battlefield',
        map = 1,
        tankstock = {}
    }
    table.insert(Cities, Berlin)

end

function CityData:playRadio(songlist)
    local songindex = math.random(0, table.getn(songlist)-1)
    if love.audio.getActiveSourceCount( ) then
        love.audio.stop()
    end
    if love.audio.getActiveSourceCount( ) == 0 then
        if songindex < table.getn(songlist) then 
            songindex = songindex + 1
            love.audio.play(songlist[songindex])
        end
    end
    
end
