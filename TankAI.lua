TankAI={}

function TankAI:spawn()
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
    local AIdata={
    alive,
    agent,
    ammo,
    controller,
    enemy,
    health,
    maxHealth
    }
    
end

function TankAI:find()
    local playerx=MAUS1.x
    local playery=MAUS1.y
    if playerx^2+playery^2>20 then
        self.move(player)
    end

end

function TankAI:move(player)
    
end

function TankAI:update()
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