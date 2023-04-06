Saving={}
Loading=true

function Saving:createsave(filenum)
    local file={"file1.lua","file2.lua","file3.lua"}
    SteelProduction=0
    OilProduction=0
    local filedata={}
    filedata.filenumber=filenum
    filedata.ax=200
    filedata.ay=1600
    filedata.angle=0
    filedata.Steel = 10000
    filedata.SteelProduction = 0
    filedata.Oil = 10000
    filedata.OilProduction = 0
   
    love.filesystem.write(file[filenum], table.show(filedata,'Data'))
end

function Saving:filesave (filenum)
    local file={"file1.lua","file2.lua","file3.lua"}
    local filedata={}
    filedata.filenumber=Filenumber
    filedata.MapNumber=MapNumber
    
    filedata.Steel = Steel
    filedata.SteelProduction = SteelProduction
    filedata.Oil = Oil
    filedata.OilProduction = OilProduction

    love.filesystem.write(file[filenum], table.show(filedata,'Data'))
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
    filedata.resolution=false
    filedata.volume=1
    filedata.ww=800
    filedata.wh=600
    filedata.flags={
        fullscreen=false,
        fullscreentype="desktop",
        display=1,
        stencil=true,
        depth=0,
        refreshrate=144,
        vsync=1,
        msaa=0,
        borderless=false,
        resizable=false,
        centered=true,
        highdpi=false,
        usedpiscale=true,
        x=560,
        y=140,
        minwidth=1,
        minheight=1
    }
    
    love.filesystem.write("Setting_data.lua", table.show(filedata,'Setting_data'))
end

function Saving:save_settings()
    local filedata={}
    filedata.resolution=love.window.getFullscreen()
    filedata.volume=love.audio.getVolume()
    if filedata.resolution==false then
        local ww,wh,flags =love.window.getMode()
        filedata.ww=ww
        filedata.wh=wh
        filedata.flags=flags
    end
    love.filesystem.write("Setting_data.lua", table.show(filedata,'Setting_data'))
end

function Saving:load_settings()

    if love.filesystem.getInfo("Setting_data.lua")==nil then
        Saving:create_settings()
    end
    Setting_data=love.filesystem.load("Setting_data.lua")
    Setting_data()
    love.audio.setVolume(Setting_data.volume)
    love.window.setFullscreen(Setting_data.resolution)
    if Setting_data.resolution==false then
        love.window.setMode(Setting_data.ww,Setting_data.wh,Setting_data.flags)
    end
end

--[[
    file1=
    {
        AllExistTanks={
            UVZ={};
            Berlin={};
            ...
        };
        Resources={};

    }

]]