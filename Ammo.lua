Ammo = {}
Ammo.__index = Ammo

APCBC = {}
HEAT = {}
APDS = {}

function Ammo.new()
    local instance = setmetatable({}, Ammo)
    return instance
end

function Ammo.newShell(impulse,damege,mass,ammo)
    local instance = {
        impulse = impulse,
        damege = damege,
        mass = mass
    }
    table.insert(ammo, instance)
    return instance
end

function Ammo:shoot(shell_name,shell_type,shell_table,entity)
    local tur = entity:get "turret_rdata"
    local body = entity:get "turret"
    local ix, iy = math.cos(tur.angle) * shell_name.impulse,
                   math.sin(tur.angle) * shell_name.impulse
    local shell = world:newCircleCollider(body.AMx-5, body.AMy-5, 10)
    table.insert(shell_table, shell)
    shell:setCollisionClass(shell_type)
    shell:setRestitution(0.5)
    shell:setLinearDamping(0.01)
    shell:setMass(shell_name.mass)
    shell:applyLinearImpulse(ix, iy)
    
    shell.damage = shell_name.damege
    shell.angle = tur.angle
    shell.isflying = true
    shell.life = 10
    shell.hitTimes = 0
    
end

function Ammo.update(dt)
    for i, shell in ipairs(APCBC) do
        shell.life = shell.life - dt
        
        if shell:enter('Wall') then
            shell.hitTimes = shell.hitTimes + 1
            if shell.hitTimes == 2 then
                    shell.isflying = false
                    shell:destroy()
            end
        end
            
        if shell:enter('Amour') then
            local collision_data = shell:getEnterCollisionData('Amour')
            local Target = collision_data.collider:getObject()
            Target.hp = Target.hp - shell.damage
            shell.isflying = false
            shell:destroy()
        end
        if shell.life <= 0 and shell.isflying then
            shell.isflying = false
            shell:destroy()
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

function Ammo.draw()
    for i, shell in ipairs(APCBC) do
        if shell.isflying == true then
            local sx, sy = shell:getPosition()
            love.graphics.setColor(1, 0, 0, 10)
            love.graphics.circle("fill", sx, sy, 10)
            love.graphics.setColor(1,1,1)
        end
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