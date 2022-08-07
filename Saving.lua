Saving={}
require 'libraries/show'

function Saving:createsave(filenum)
    Data.filenumber=1
    Data.stage=0
    Data.tankdata={}
    
end

function Saving:filesave (filenum)
    local number=filenum
    local file={"file1.lua","file2.lua","file3.lua"}
    Data={}
    Data.filenumber=1
    Data.stage="testmap"
    Data.tankx,Data.tanky=MAUS1:location()
    Data.tankangle=MAUS1

    love.filesystem.write(file[number], table.show(Data,'Data'))
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