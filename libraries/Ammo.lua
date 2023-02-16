Ammo = {}
Ammo.__index = Ammo

APCBC = {}
APCBCtrails = {}
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
    shell.ax = ix
    shell.ay = iy
    shell.angle = tur.angle
    shell.isflying = true
    shell.life = 10
    shell.hitTimes = 0
    shell.trail = {}
    
    table.insert(APCBCtrails, shell.trail)
end

function Ammo.update(dt)
    for i, shell in ipairs(APCBC) do
        shell.life = shell.life - dt

        local sx, sy = shell:getPosition()
        table.insert (shell.trail, 1, sy)
	    table.insert (shell.trail, 1, sx)
       
        if shell:enter('Wall') then
            shell.hitTimes = shell.hitTimes + 1
            if shell.hitTimes == 3 then
                    shell.isflying = false
                    shell:destroy()
                    table.remove(APCBC, i)
                    table.remove(APCBCtrails, i)
            end
        end
            
        if shell:enter('Amour') then
            local collision_data = shell:getEnterCollisionData('Amour')
            local Target = collision_data.collider:getObject()
            Target.hp = Target.hp - shell.damage
            shell.isflying = false
            shell:destroy()
            table.remove(APCBC, i)
            table.remove(APCBCtrails, i)
        end
        
        if shell.life <= 0 and shell.isflying then
            shell.isflying = false
            shell:destroy()
            table.remove(APCBC, i)
            table.remove(APCBCtrails, i)
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

    for i, trail in ipairs(APCBCtrails) do
        local trailTimer = 0
        if #trail > 2 then
            trailTimer = trailTimer + dt
            while trailTimer > 0.03 do
                trailTimer = trailTimer - 0.03
                -- remove two last coordinates:
                trail[#trail] = nil
                trail[#trail] = nil
            end
        end
        if #trail > 20*2 then
            for i = #trail, 20*2+1, -1 do -- backwards
                trail[i] = nil
            end
        end
    end
end

function Ammo.draw()
    for i, shell in ipairs(APCBC) do
        if shell.isflying then
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

    for i, trail in ipairs(APCBCtrails) do
        for i = #trail-1, 3, -2 do -- backwards for color trail
            local c = (#trail-(i+1))/#trail -- value of color
            local w = 20 * c
            love.graphics.setLineWidth (w)
            love.graphics.setColor (1,1,1,c)
            love.graphics.line (trail[i-2], trail[i-1], trail[i], trail[i+1])
            love.graphics.circle ('fill', trail[i], trail[i+1], w/2)
            love.graphics.setLineWidth (1)
            love.graphics.setColor (1,1,1)
        end
    end
end