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
   
    love.filesystem.write(file[number], table.show(filedata,'Data'))
end

function Saving:filesave (filenum)
    local number=filenum
    local file={"file1.lua","file2.lua","file3.lua"}
    local filedata={}
    filedata.filenumber=Filenumber
    filedata.stage=MapNumber
    local ax, ay, anlge = tanks_table:getdata(tank1)
    filedata.ax=ax
    filedata.ay=ay

    love.filesystem.write(file[number], table.show(filedata,'Data'))
end

function Saving:fileload (filenum)
    Filenumber=filenum
    local file={"file1.lua","file2.lua","file3.lua"}
    if love.filesystem.getInfo(file[filenum])==nil then
        Saving:createsave(filenum)
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