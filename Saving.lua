Saving={}
require 'libraries/show'
Data={}
function Saving:createsave(filenum)
    
end

function Saving:filesave (filenum)
    local number=filenum
    local file={"file1.lua","file2.lua","file3.lua"}
    local filedata={}
    filedata.filenumber=1
    filedata.stage="testmap"
    filedata.tank_name,
    filedata.x,
    filedata.y,
    filedata.angle,
    filedata.turret_angle,
    filedata.turret_path,
    filedata.bodywork_path,
    filedata.turret_offset,
    filedata.maxspeed,
    filedata.back_maxspeed,
    filedata.acceleration,
    filedata.back_acceleration,
    filedata.stop_acceleration,
    filedata.max_Rotation_speed,
    filedata.Rotational_acceleration,
    filedata.stop_rotation_ac,
    filedata.turret_max_Rotation_speed,
    filedata.turret_Rotational_acceleration,
    filedata.turret_stop_rotation_ac=MAUS1:getdata()

    love.filesystem.write(file[number], table.show(filedata,'Data'))
end

function Saving:fileload (filenum)
    Gamestate.switch(testmap)
    local number=filenum
    local file={"file1.lua","file2.lua","file3.lua"}
    love.filesystem.getInfo(file[number])
    Data=love.filesystem.load("file1.lua")
end

function Saving:getdata(filenum)
    local number=filenum
    local file={"file1.lua","file2.lua","file3.lua"}
    love.filesystem.getInfo(file[number])
    Data=love.filesystem.load("file1.lua")
end