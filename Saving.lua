Saving={}
require 'libraries/show'
Data={}

function Saving:createsave(filenum)
    local number=filenum
    local file={"file1.lua","file2.lua","file3.lua"}
    local filedata={}
    filedata.filenumber=filenum
    filedata.stage=1
    filedata.tank_name="mause"
    filedata.x=0
    filedata.y=0
    filedata.angle=0
    filedata.turret_angle=0
    filedata.turret_path="tanks/german/MAUS/MAUS turret.png"
    filedata.bodywork_path="tanks/german/MAUS/MAUS hull.png"
    filedata.turret_offset=27
    filedata.maxspeed=200
    filedata.back_maxspeed=40
    filedata.acceleration=30
    filedata.back_acceleration=20
    filedata.stop_acceleration=150
    filedata.max_Rotation_speed=0.8
    filedata.Rotational_acceleration=0.3
    filedata.stop_rotation_ac=0.7
    filedata.turret_max_Rotation_speed=0.5
    filedata.turret_Rotational_acceleration=0.4
    filedata.turret_stop_rotation_ac=0.8

    love.filesystem.write(file[number], table.show(filedata,'Data'))
end

function Saving:filesave (filenum)
    local number=filenum
    local file={"file1.lua","file2.lua","file3.lua"}
    local filedata={}
    filedata.filenumber=1
    filedata.stage=MapNumber
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
    Filenumber=filenum
    local file={"file1.lua","file2.lua","file3.lua"}
    if love.filesystem.getInfo(file[filenum])==nil then
        Saving:createsave(filenum)
    end
    Gamestate.switch(Maps[1])
end

function Saving:getdata(filenum)
    local file={"file1.lua","file2.lua","file3.lua"}
    if love.filesystem.getInfo(file[filenum])==nil then
        Saving:createsave(filenum)
    end
    Data=love.filesystem.load(file[filenum])
end