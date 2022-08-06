Saving={}
Data={}

function Saving:createsave(filenum)
    Data.stage=0
    Data.tankx=0
    Data.tanky=0
    Data.tankangle=0
    Data.filenumber=filenum
end

function Saving:filesave (filenum)
    local number=filenum
    Data.stage="testmap"
    Data.tankx=tanks.x
    Data.tanky=tanks.y
    Data.tankangle=tanks.angle

    if number ==1 then
        love.filesystem.write("file1.lua", table.show(Data,"data"))
    elseif number ==2 then 
        love.filesystem.write("file2.lua", table.show(Data,"data"))
    elseif number ==3 then
        love.filesystem.write("file3.lua", table.show(Data,"data"))
    end
end

function Saving:fileload (filenum)
    local number=filenum

    if number ==1 then
        love.filesystem.load("file1.lua")
        Saving:getdata()
    elseif number ==2 then 
        love.filesystem.load("file2.lua")
        Saving:getdata()
    elseif number ==3 then
        love.filesystem.load("file3.lua")
        Saving:getdata()
    end
end

function Saving:getdata()
    
end