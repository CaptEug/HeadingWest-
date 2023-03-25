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
    --USSR
    Moskva = {
        x = 1160,
        y = 580,
        country = {USSR_flag},
        name = 'Moskva',
        type = 'Capital',
        factory = false,
        labtory = true,
        state ='Peace',
        map = 2,
        exsist_tank={},
        broken_tank={}
    }
    table.insert(Cities, Moskva)
    Nizhny_Tagil = {
        x = 1280,
        y = 555,
        country = {USSR_flag},
        name = 'Nizhny Tagil',
        type = 'Normal',
        factory = true,
        labtory = false,
        state ='Peace',
        map = 3,
        tanklist = {},
        exsist_tank={},
        broken_tank={},
        building_slot = 16,
        songlist = TestSonglist,
        slot_info={
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
    }
    table.insert(Cities, Nizhny_Tagil)

    --German
    Berlin = {
        x = 1035,
        y = 605,
        country = {USSR_flag, US_flag, UK_flag, FR_flag},
        name = 'Berlin',
        type = 'Capital',
        factory = false,
        labtory = true,
        state ='Battlefield',
        map = 1,
        exsist_tank={},
        broken_tank={}
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
