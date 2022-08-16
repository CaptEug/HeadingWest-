TankAI={}
function TankAI:create(name)
    local tankdata=love.filesystem.load('DefaultTank.lua')
    tankdata()
    local CreatedTanks={}
    local getank=DefaultTank['T_5455']
    local tank=tanks.new(
        getank.tank_name,
        getank.x,
        getank.y,
        getank.angle,
        getank.turret_angle,
        getank.turret_path,
        getank.bodywork_path,
        getank.turret_offset,
        getank.maxspeed,
        getank.back_maxspeed,
        getank.acceleration,
        getank.back_acceleration,
        getank.stop_acceleration,
        getank.max_Rotation_speed,
        getank.Rotational_acceleration,
        getank.stop_rotation_ac,
        getank.turret_max_Rotation_speed,
        getank.turret_Rotational_acceleration,
        getank.turret_stop_rotation_ac
    )
    table.insert(CreatedTanks,tank)
    tank:create()
end
function TankAI:spawn(x,y,type,args)
    MAUS1 = tanks.new(
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
        Data.turret_stop_rotation_ac
    )
    MAUS1:create()

    local AIdata={}

    AIdata.type=type
    AIdata.hp=10
    AIdata.acceleration=30
    
    
end

function TankAI:find()
    local playerx=MAUS1.x
    local playery=MAUS1.y
    if playerx^2+playery^2>20 then
        self.move(player)
    end

end

function TankAI:move(player)
    local playerx=MAUS1.x
    local playery=MAUS1.y

end

function TankAI:update(dt)
    MAUS1:use()
end

function TankAI:destroyDead()
    local i = #enemies
    while i > 0 do
        if enemies[i].dead then
            if enemies[i].physics then
                enemies[i].physics:destroy()
            end
            table.remove(enemies, i)
        end
        i = i - 1
    end
end