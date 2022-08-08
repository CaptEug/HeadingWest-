Saving={}
require 'libraries/show'

function Saving:createsave(filenum)
    
end

function Saving:filesave (filenum)
    local number=filenum
    local file={"file1.lua","file2.lua","file3.lua"}
    local Data={}
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
    love.filesystem.getInfo(file[number])
    local Data=love.filesystem.load("file1.lua")
    Data = {
        ["y"] = 1511.861328125;
        ["x"] = 518.98992919922;
        ["tank_name"] = "mause";
        ["turret_angle"] = 0;
        ["turret_path"] = "tanks/german/MAUS/MAUS turret.png";
        ["bodywork_path"] = "tanks/german/MAUS/MAUS hull.png";
        ["turret_offset"] = 27;
        ["maxspeed"] = 200;
        ["back_maxspeed"] = 40;
        ["acceleration"] = 30;
        ["back_acceleration"] = 20;
        ["stop_acceleration"] = 150;
        ["max_Rotation_speed"] = 0.8;
        ["filenumber"] = 1;
        ["stage"] = "testmap";
        ["turret_max_Rotation_speed"] = 0.5;
        ["turret_Rotational_acceleration"] = 0.4;
        ["turret_stop_rotation_ac"] = 0.8;
        ["angle"] = 2.8486363887787;
        ["Rotational_acceleration"] = 0.3;
        ["stop_rotation_ac"] = 0.7;
     };
    d=Data.stage
    Gamestate.switch(testmap)
    return Data
end

function Saving:getdata()

end