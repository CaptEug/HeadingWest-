Saving={}
require 'libraries/show'

function Saving:createsave(filenum)
    
end

function Saving:filesave (filenum)
    local number=filenum
    local file={"file1.lua","file2.lua","file3.lua"}
    Data={}
    Data.filenumber=1
    Data.stage="testmap"

    Data.tank_name,
    Data.x,
    Data.y,
    Data.angle,
    Data.turret_angle,
    Data.turret_path,
    Data.bodywork_path,
    Data.turret_offset,
    Data.maxspeed,
    Data.back_maxspeed,
    Data.acceleration,
    Data.back_acceleration,
    Data.stop_acceleration,
    Data.max_Rotation_speed,
    Data.Rotational_acceleration,
    Data.stop_rotation_ac,
    Data.turret_max_Rotation_speed,
    Data.turret_Rotational_acceleration,
    Data.turret_stop_rotation_ac=MAUS1:getdata()

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