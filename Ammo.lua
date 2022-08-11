Ammo = {}
Ammo.__index = Ammo

function Ammo.new()
    local instance = setmetatable({}, Ammo)
    return instance
end

function Ammo.newShell(speed,damege,ammo)
    local instance = {
        speed = speed,
        damege = damege
    }
    table.insert(ammo, instance)
    return instance
end

function Ammo:shoot(shell_type)
    local mx, my = cam:mousePosition(ox,oy,w,h)
    local angle = math.atan2(my - MAUS1.y, mx - MAUS1.x)
    local vx, vy = math.cos(angle) * shell_type.speed,
                   math.sin(angle) * shell_type.speed
    
    local shell = world:newRectangleCollider(MAUS1.x, MAUS1.y - 100, 10, 10)
    shell:setLinearVelocity(vx, vy)
end