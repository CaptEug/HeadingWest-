Explosives = {}
Explosions = {}
Fragments = {}

function Bomb(unit, x, y)
    local bomb = unit.ammorack[1]
    if unit.gun_location then
        local ix, iy = math.cos(math.atan2(y - unit.gun_location.y, x - unit.gun_location.x)),
                   math.sin(math.atan2(y - unit.gun_location.y, x - unit.gun_location.x))
        local distance = math.sqrt((x - unit.gun_location.x)^2 + (y - unit.gun_location.y)^2)
        local explosive = particleworld:newCircleCollider(unit.gun_location.x, unit.gun_location.y, 2)
        explosive:setMass(bomb.mass)
        explosive:setBullet(true)
        explosive:setLinearVelocity(ix*bomb.velocity, iy*bomb.velocity)
        explosive.timer = distance/bomb.velocity
        explosive.type = bomb.type
        explosive.pen = bomb.pen
        explosive.pentype = bomb.pentype
        explosive.TNT_eq = bomb.TNT_eq
        table.insert(Explosives, explosive)
    end
    if unit.gun_location2 then
        local explosive2 = particleworld:newCircleCollider(unit.gun_location2.x, unit.gun_location2.y, 2)
        explosive2:setMass(bomb.mass)
        explosive2:setBullet(true)
        explosive2:setLinearVelocity(ix*bomb.velocity, iy*bomb.velocity)
        explosive2.timer = distance/bomb.velocity
        explosive2.type = bomb.type
        explosive2.pen = bomb.pen
        explosive2.pentype = bomb.pentype
        explosive2.TNT_eq = bomb.TNT_eq
        table.insert(Explosives, explosive2)
    end
    if unit.gun_location3 then
        local explosive3 = particleworld:newCircleCollider(unit.gun_location3.x, unit.gun_location3.y, 2)
        explosive3:setMass(bomb.mass)
        explosive3:setBullet(true)
        explosive3:setLinearVelocity(ix*bomb.velocity, iy*bomb.velocity)
        explosive3.timer = distance/bomb.velocity
        explosive3.type = bomb.type
        explosive3.pen = bomb.pen
        explosive3.pentype = bomb.pentype
        explosive3.TNT_eq = bomb.TNT_eq
        table.insert(Explosives, explosive3)
    end
    if unit.gun then
        for i, gun in ipairs(unit.gun) do
            local explosive3 = particleworld:newCircleCollider(unit.gun[i].x, unit.gun[i].y, 2)
            local ix1, iy1 = math.cos(math.atan2(y - unit.battery_location.y, x - unit.battery_location.x)),
                   math.sin(math.atan2(y - unit.battery_location.y, x - unit.battery_location.x))
            local distance1 = math.sqrt((x - unit.gun[i].x)^2 + (y - unit.gun[i].y)^2)
            explosive3:setMass(bomb.mass)
            explosive3:setBullet(true)
            explosive3:setLinearVelocity(ix1*bomb.velocity, iy1*bomb.velocity)
            explosive3.timer = distance1/bomb.velocity
            explosive3.type = bomb.type
            explosive3.pen = bomb.pen
            explosive3.pentype = bomb.pentype
            explosive3.TNT_eq = bomb.TNT_eq
            local x, y = explosive3:getPosition()
            table.insert(Explosives, explosive3)
            love.graphics.setColor(255, 0, 0)
            love.graphics.circle(x, y)
        end
    end


    unit.firing_timer = unit.firing_time
    unit.reload_timer = unit.reload_time
end

function Explosives:update(dt)
    for i, explosive in ipairs(self) do
        explosive.timer = explosive.timer - dt
        if explosive.timer <= 0 then
            Explode(explosive)
            explosive:destroy()
            table.remove(self, i)
        end
    end
    for i, explosion in ipairs(Explosions) do
        explosion.anime:update(dt)
        explosion.timer = explosion.timer - dt
        if explosion.timer <= 0 then
            table.remove(Explosions, i)
        end
    end
end

function Explosions:draw()
    for i, explosion in ipairs(self) do
        explosion.anime:draw(Explosion_sheet, explosion.x, explosion.y, 0, 1, 1, 50, 50)
    end
end

function Explode(explosive)
    local n = 0
    local x, y = explosive:getPosition()
    local explosion = {}
    explosion.anime = anim8.newAnimation(Explosion_Grid('1-9','1-9'), 0.05)
    explosion.x, explosion.y = x, y
    explosion.timer = 4.05
    table.insert(Explosions, explosion)
    while n < explosive.TNT_eq do
        local fragment = CurrentPlace.world:newCircleCollider(x, y, 1)
        fragment:setCollisionClass('Fregment')
        fragment:setBullet(true)
        fragment:setRestitution(0.5)
        fragment:setLinearDamping(1)
        fragment:applyLinearImpulse(math.random(-explosive.TNT_eq/10, explosive.TNT_eq/10), math.random(-explosive.TNT_eq/10, explosive.TNT_eq/10))
        fragment.life = 1
        if explosive.type == 'ATGM' then
            fragment.pen = explosive.TNT_eq * 10
        else
            fragment.pen = explosive.pen
        end
        fragment.pentype = 'CE'
        table.insert(Fragments, fragment)
        n = n + 1
    end
end

function Fragments:update(dt)
    for i, fragment in ipairs(self) do
        fragment.life = fragment.life - dt

        if fragment:enter('Wall') then
            fragment:destroy()
            table.remove(self, i)
        end

        if fragment:enter('TankHull') then
            local collision_data = fragment:getEnterCollisionData('TankHull')
            local Target = collision_data.collider:getObject()
            local hitPart, hitArmorside = OverPressureCheck(fragment, Target)
            local ispen = PenCheck(fragment, Target, hitPart, hitArmorside, 0)

            if ispen then
                fragment:destroy()
                table.remove(self, i)
                DamageCheck(Target, hitPart)
            end

            if Target.status.era then
                Target.armor.life = Target.armor.life - 1
            end
        end

        if fragment.life <= 0 then
            fragment:destroy()
            table.remove(self, i)
        end
    end
end

function OverPressureCheck(fragment, Target)
    local x, y = fragment:getPosition()
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
        local vx, vy = fragment:getLinearVelocity()
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