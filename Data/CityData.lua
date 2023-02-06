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
        x = 1000,
        y = 500,
        name = 'Uralvagonzavod',
        icon = UVZ_Icon,
        state ='Captured',
        map = 3,
        tanklist = {},
        tankstock = {},
        building_slot = 16,
        songlist = TestSonglist
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
