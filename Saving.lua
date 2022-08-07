Saving={}
Data={}
require 'libraries/show'

function Saving:createsave(filenum)
    Data.filenumber=filenum
    Data.stage=0
    Data.tankdata={}
    
end

function Saving:filesave (filenum)
    local number=filenum
    local file={"file1.lua","file2.lua","file3.lua"}
    Data.stage="testmap"
    Data.tankx=tanks.x
    Data.tanky=tanks.y
    Data.tankangle=tanks.angle

    love.filesystem.write(file[number], Data)
end

function Saving:fileload (filenum)
    local number=filenum
    local file={"file1.lua","file2.lua","file3.lua"}
    --love.filesystem.getInfo()
    love.filesystem.load(file[number])
    Saving:getdata()
end

function Saving:getdata()
    
end