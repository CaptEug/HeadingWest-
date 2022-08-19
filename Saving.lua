Saving={}
Data={}

function Saving:createsave(filenum)
    local number=filenum
    local file={"file1.lua","file2.lua","file3.lua"}
    local filedata={}
    filedata.filenumber=filenum
    filedata.stage=1
    filedata.ax=200
    filedata.ay=1600
    filedata.angle=0
   
    love.filesystem.write(file[number], table.show(filedata,'Data'))
end

function Saving:filesave (filenum)
    local number=filenum
    local file={"file1.lua","file2.lua","file3.lua"}
    local filedata={}
    local ax, ay, angle = tanks_table:getdata(tank1)
    filedata.filenumber=Filenumber
    filedata.stage=MapNumber
    filedata.ax=ax
    filedata.ay=ay
    filedata.angle=angle

    love.filesystem.write(file[number], table.show(filedata,'Data'))
end

function Saving:fileload ()
    
    local file={"file1.lua","file2.lua","file3.lua"}
    if love.filesystem.getInfo(file[Filenumber])==nil then
        Saving:createsave(Filenumber)
    end
    ingame:init()
    Gamestate.switch(Maps[MapNumber])
end

function Saving:getdata(filenum)
    local file={"file1.lua","file2.lua","file3.lua"}
    if love.filesystem.getInfo(file[filenum])==nil then
        Saving:createsave(filenum)
    end
    Data=love.filesystem.load(file[filenum])
end