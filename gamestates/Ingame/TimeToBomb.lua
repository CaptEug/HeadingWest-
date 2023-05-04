Explosives = {}
Explosions = {}

function Bomb(unit, x, y)
    local bomb = unit.ammorack[1]
    local ix, iy = math.cos(math.atan2(y - unit.gun_location.y, x - unit.gun_location.x)),
                   math.sin(math.atan2(y - unit.gun_location.y, x - unit.gun_location.x))
    local distance = math.sqrt((x - unit.gun_location.x)^2 + (y - unit.gun_location.y)^2)
    local explosive = particleworld:newCircleCollider(unit.gun_location.x, unit.gun_location.y, 3)
    explosive:setMass(bomb.mass)
    explosive:setLinearVelocity(ix*bomb.velocity, iy*bomb.velocity)
    explosive.timer = distance/bomb.velocity
    explosive.type = bomb.type
    explosive.pen = bomb.pen
    explosive.pentype = bomb.pentype
    explosive.TNT_eq = bomb.TNT_eq
    table.insert(Explosives, explosive)
    --[[if unit.gun_location2 then
        local explosive2 = particleworld:newCircleCollider(unit.gun_location2.x, unit.gun_location2.y, 3)
        explosive2:setMass(bomb.mass)
        explosive2:setLinearVelocity(ix*bomb.velocity, iy*bomb.velocity)
        explosive2.timer = distance/bomb.velocity
        explosive2.type = bomb.type
        explosive2.pen = bomb.pen
        explosive2.pentype = bomb.pentype
        explosive2.TNT_eq = bomb.TNT_eq
        table.insert(Explosives, explosive2)
    end]]
    --[[if unit.gun_location3 then
        local explosive3 = particleworld:newCircleCollider(unit.gun_location3.x, unit.gun_location3.y, 3)
        explosive3:setMass(bomb.mass)
        explosive3:setLinearVelocity(ix*bomb.velocity, iy*bomb.velocity)
        explosive3.timer = distance/bomb.velocity
        explosive3.type = bomb.type
        explosive3.pen = bomb.pen
        explosive3.pentype = bomb.pentype
        explosive3.TNT_eq = bomb.TNT_eq
        table.insert(Explosives, explosive3)
    end]]

    unit.firing_timer = unit.firing_time
    unit.reload_timer = unit.reload_time
end

function Explosives:update(dt)
    for i, explosive in ipairs(self) do
        explosive.timer = explosive.timer - dt
        if explosive.timer <= 0 then
            table.remove(self, i)
            Explode(explosive)
        end
    end
end

function Explode(explosive)
    local n = 0
    while n < explosive.TNT_eq do
        local x, y = explosive:getPosition()
        local explode = world:newCircleCollider(x, y, 2)
        explode:setCollisionClass('Explosion')
        explode:setBullet(true)
        explode:setRestitution(0.5)
        explode:setLinearDamping(1)
        explode:applyLinearImpulse(math.random(-explosive.TNT_eq, explosive.TNT_eq), math.random(-explosive.TNT_eq, explosive.TNT_eq))
        explode.life = 1
        explode.pen = explosive.pen
        explode.pentype = explosive.pentype
        table.insert(Explosions, explode)
        n = n + 1
    end
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