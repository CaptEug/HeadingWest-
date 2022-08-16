Ammo = {}
Ammo.__index = Ammo

APCBC = {}
HEAT = {}
APDS = {}

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

function Ammo:shoot(shell_name,shell_type)
    local mx, my = cam:mousePosition()
    local angle = math.atan2(my - MAUS1.y, mx - MAUS1.x)
    local vx, vy = math.cos(angle) * shell_name.speed,
                   math.sin(angle) * shell_name.speed
    local shell = world:newRectangleCollider(MAUS1.x, MAUS1.y - 100, 10, 10)
    local shell_type = shell_type
    shell:setCollisionClass('' .. shell_type .. '')
    shell:setRestitution(0.8)
    shell:setLinearVelocity(vx, vy)
    table.insert(shell_type, shell)
end

function Ammo.draw()
    for i, shell in ipairs(APCBC) do
        local sx, sy = shell:getPosition()
        love.graphics.rectangle("fill", sx, sy, 100, 100)
        
    end
    for i, shell in ipairs(HEAT) do
        local sx, sy = shell:getPosition()
        love.graphics.rectangle("fill", sx, sy, 100, 100)
        
    end
    for i, shell in ipairs(APDS) do
        local sx, sy = shell:getPosition()
        love.graphics.rectangle("fill", sx, sy, 100, 100)
        
    end
end

function Ammo.update(dt)
    for i, shell in ipairs(APCBC) do
        if shell:enter() then
            
        end
    end
    for i, shell in ipairs(HEAT) do
        if shell:enter() then
            
        end
    end
    for i, shell in ipairs(APDS) do
        if shell:enter() then
            
        end
    end
end