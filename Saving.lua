Saving={}

function Saving:createsave(filenum)
    data={}
    data.stage=0
    data.tankx=0
    data.tanky=0
    data.tankangle=0
    data.filenumber=filenum
end

function Saving:filesave (filenum)
    local number=filenum
    data.stage="testmap"
    data.tankx=tanks.x
    data.tanky=tanks.y
    data.tankangle=tanks.angle

    if number ==1 then
        love.filesystem.write("file1.lua", table.show(data,"data"))
    elseif number ==2 then 
        love.filesystem.write("file2.lua", table.show(data,"data"))
    elseif number ==3 then
        love.filesystem.write("file3.lua", table.show(data,"data"))
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