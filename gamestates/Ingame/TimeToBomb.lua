Bombs = {}
Explosions = {}

function Bomb(unit, x, y)
    local bomb = unit.ammorack[1]
    local ux, uy = unit.gun_location.x, unit.gun_location.y
    local distance = math.sqrt((x-ux)^2 + (y-uy)^2)
    bomb.timer = distance/(bomb.velocity/2)
    bomb.x, bomb.y = x, y
    table.insert(Bombs, bomb)
    unit.firing_timer = 0.7
    unit.reload_timer = unit.reload_time
end

function Bombs:update(dt)
    for i, bomb in ipairs(self) do
        bomb.timer = bomb.timer - dt
        if bomb.timer <= 0 then
            Expolde(bomb, i)
        end
    end
end

function Expolde(bomb, i)
    local n = 0
    while n < bomb.TNT_eq do
        local explode = world:newCircleCollider(bomb.x, bomb.y, 3)
        explode:setCollisionClass('Explosion')
        explode:setBullet(true)
        explode:setRestitution(0.5)
        explode:setLinearDamping(1)
        explode:applyLinearImpulse(math.random(-1000,1000),math.random(-1000,1000))
        explode.life = 1
        explode.pen = bomb.pen
        explode.pentype = bomb.pentype
        table.insert(Explosions, explode)
        n = n + 1
    end
    table.remove(Bombs, i)
end

function Explosions:update(dt)
    for i, explode in ipairs(self) do
        explode.life = explode.life - dt

        if explode:enter('Wall') then
            explode:destroy()
            table.remove(self, i)
        end

        if explode:enter('tankhull') then
            local collision_data = explode:getEnterCollisionData('tankhull')
            local Target = collision_data.collider:getObject()
            local hitPart, hitArmorside = OverPressureCheck(explode, Target)
            local ispen = PenCheck(explode, Target, hitPart, hitArmorside, 0)

            if ispen then
                explode:destroy()
                table.remove(self, i)
                DamageCheck(Target, hitPart)
            end

            if Target.status.era[1] then
                Target.armor.life = Target.armor.life - 1
            end
        end

        if explode.life <= 0 then
            explode:destroy()
            table.remove(self, i)
        end
    end
end

function OverPressureCheck(explode, Target)
    local x, y = explode:getPosition()
    local hitvalue = math.random()
    local hitPart = 'none'
    local hitArmorside = 'none'
    if hitvalue < Target.innerstructure.htl then
        hitPart = 'Hull'
        local position_angle = Target.location.hull_angle - math.atan2(y-Target.location.y, x-Target.location.x)
        local diagonal = math.atan2(Target.length, Target.width)

        while position_angle < 0 do
            position_angle = position_angle + 2*math.pi
        end
        while position_angle > 2*math.pi do
            position_angle = position_angle - 2*math.pi
        end
        
        if position_angle > 2*math.pi-diagonal or position_angle < diagonal then
            hitArmorside = 'Right'
        elseif position_angle > diagonal and position_angle < math.pi-diagonal then
            hitArmorside = 'Front'
        elseif position_angle > math.pi-diagonal and position_angle < math.pi+diagonal then
            hitArmorside = 'Left'
        else
            hitArmorside = 'Back'
        end
    else
        hitPart = 'Turret'
        local vx, vy = explode:getLinearVelocity()
        local vangle = math.atan2(vy, vx)
        local dangle = Target.location.hull_angle + Target.turret_angle - vangle
        while dangle < 0 do
            dangle = dangle + 2*math.pi
        end
        while dangle > 2*math.pi do
            dangle = dangle - 2*math.pi
        end
        if dangle > math.pi*7/4 or dangle < math.pi/4 then
            hitArmorside = 'Right'
        elseif dangle > math.pi/4 and dangle < math.pi*3/4 then
            hitArmorside = 'Front'
        elseif dangle > math.pi*3/4 and dangle < math.pi*5/4 then
            hitArmorside = 'Left'
        else
            hitArmorside = 'Back'
        end
    end

    if hitPart == 'Hull' then
        
    end

    Datapool.hitPart = hitPart
    Datapool.hitArmorside = hitArmorside

    return hitPart, hitArmorside
end