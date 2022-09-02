Saving={}
Data={}
Loading=true

function Saving:createsave(filenum)
    local number=filenum
    local file={"file1.lua","file2.lua","file3.lua"}
    local filedata={}
    filedata.filenumber=filenum
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
    filedata.MapNumber=MapNumber
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
    Gamestate.switch(ingame)
end

function Saving:getdata(filenum)
    local file={"file1.lua","file2.lua","file3.lua"}
    if love.filesystem.getInfo(file[filenum])==nil then
        Saving:createsave(filenum)
    end
    Data=love.filesystem.load(file[filenum])
end

function Saving:create_settings()
    local filedata={}
    filedata.ww=800
    filedata.wh=800
    filedata.volume=1
   
    love.filesystem.write("Setting_data.lua", table.show(filedata,'Setting_data'))
end
function Saving:save_settings()
    local ww,wh=love.graphics.getDimensions()
    local filedata={}
    filedata.ww=ww
    filedata.wh=wh
    filedata.volume=love.audio.getVolume()
    love.filesystem.write("Setting_data.lua", table.show(filedata,'Setting_data'))
end

function Saving:load_settings()

    if love.filesystem.getInfo("Setting_data.lua")==nil then
        Saving:create_settings()
    end
    Setting_data=love.filesystem.load("Setting_data.lua")
    Setting_data()
    love.audio.setVolume(Setting_data.volume)
    love.window.setMode(Setting_data.ww,Setting_data.wh)
end