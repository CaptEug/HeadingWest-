RadioStation = {}

function RadioStation:init()
    
end

function RadioStation:use(Songlist)
    love.audio.play(Songlist[math.random(1,table.getn(Songlist))])
end