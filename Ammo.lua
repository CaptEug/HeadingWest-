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

function Ammo:shoot(shell_name,shell_type,shell_table)
    local mx, my = cam:mousePosition()
    local tur = tank1:get "turret_rdata"
    local body = tank1:get "turret"
    local vx, vy = math.sin(tur.angle) * shell_name.speed,
                   -math.cos(tur.angle) * shell_name.speed
    local shell = world:newCircleCollider(body.AMx-5, body.AMy-5, 10)
    shell:setCollisionClass(shell_type)
    shell:setRestitution(0.8)
    shell:setLinearVelocity(vx, vy)
    shell.damage = shell_name.damege
    table.insert(shell_table, shell)
end

function Ammo.draw()
    for i, shell in ipairs(APCBC) do
        local sx, sy = shell:getPosition()
        --love.graphics.rectangle("fill", sx, sy, 100, 100)
        
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
        if shell:enter('Amour') then
            if shell:enter('Amour') then
                local collision_data = shell:getEnterCollisionData('Amour')
                local Target = collision_data.collider:getObject()
                Target.hp = Target.hp - shell.damage
            end
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