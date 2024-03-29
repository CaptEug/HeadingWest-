Explosives = {}
Explosions = {}
Fragments = {}

function Bomb(unit, x, y)
    local bomb = unit.ammorack[1]
    if unit.gun_location then
        local ix, iy = math.cos(math.atan2(y - unit.gun_location.y, x - unit.gun_location.x)),
                   math.sin(math.atan2(y - unit.gun_location.y, x - unit.gun_location.x))
        local distance = math.sqrt((x - unit.gun_location.x)^2 + (y - unit.gun_location.y)^2)
        local explosive = {}
        explosive.collider = particleworld:newCircleCollider(unit.gun_location.x, unit.gun_location.y, 2)
        explosive.collider:setMass(bomb.mass)
        explosive.collider:setBullet(true)
        explosive.collider:setLinearVelocity(ix*bomb.velocity, iy*bomb.velocity)
        explosive.timer = distance/bomb.velocity
        explosive.type = bomb.type
        explosive.pen = bomb.pen
        explosive.pentype = bomb.pentype
        explosive.TNT_eq = bomb.TNT_eq
        explosive.fusee = true
        table.insert(Explosives, explosive)
    end

    if unit.gun then
        for i, gun in ipairs(unit.gun) do
            local explosive = {}
            explosive.collider = particleworld:newCircleCollider(unit.gun[i].x, unit.gun[i].y, 5)
            local angle = math.random(0, 2 * math.pi)
            local radius = math.random(0, 100)
            local randomX = x + radius * math.cos(angle)
            local randomY = y + radius * math.sin(angle)
            local x2,y2 = 0, 0
            if unit.battery_location ~= nil then
                x2, y2 = unit.battery_location.x, unit.battery_location.y
            end
            local ix1, iy1 = math.cos(math.atan2(randomY - y2, randomX - x2)),
                   math.sin(math.atan2(randomY - y2, randomX - x2)) 
            local distance1 = math.sqrt((randomX - unit.gun[i].x)^2 + (randomY - unit.gun[i].y)^2)
            local angle = 0.5*math.pi + math.atan2(randomY - y2, randomX - x2)
            explosive.collider:setMass(bomb.mass)
            explosive.collider:setBullet(true)
            explosive.collider:setLinearVelocity(ix1*bomb.velocity, iy1*bomb.velocity)
            explosive.timer = distance1/bomb.velocity
            explosive.type = bomb.type
            explosive.pen = bomb.pen
            explosive.pentype = bomb.pentype
            explosive.TNT_eq = bomb.TNT_eq
            explosive.x, explosive.y = explosive.collider:getPosition()
            explosive.angle = angle
            explosive.pic = bomb.shells or nil
            explosive.trail = {}
            explosive.fusee = true
            explosive.x, explosive.y = x, y
            table.insert(Explosives, explosive)
        end
    end


    unit.firing_timer = unit.firing_time
    unit.reload_timer = unit.reload_time
end

function Explosives:update(dt)
    for i, explosive in ipairs(self) do
        if explosive.pic then
            local sx, sy = explosive.collider:getPosition()
            table.insert(explosive.trail, {x = sx, y = sy})
        elseif explosive.trail ~= nil then
            table.remove(explosive.trail, 1)
        end
        explosive.timer = explosive.timer - dt
        if explosive.timer <= 0 and explosive.fusee == true then
            Explode(explosive)
            explosive.collider:destroy()
            explosive.pic = false
        end
        if explosive.trail ~= nil then
            if #explosive.trail == 0 then
                table.remove(self, i)
            end
            if #explosive.trail > 300 then
                table.remove(explosive.trail, 1)
            end
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

function Explosives:draw()
    for i, explosion in ipairs(Explosions) do
        explosion.anime:draw(Explosion_sheet, explosion.x, explosion.y, 0, 1, 1, 50, 50)
    end
    for i, explosive in ipairs(self) do 
        if explosive.pic then
            local x, y = explosive.collider:getPosition()
            local width1 = explosive.pic:getWidth()
            local height1 = explosive.pic:getHeight()
            love.graphics.draw(explosive.pic,x,y,explosive.angle,1,1,width1/2,height1)
            love.graphics.setColor(1, 0, 0, 0.1)
            love.graphics.circle("fill", explosive.x, explosive.y, 100)
            love.graphics.setColor(1 ,1 ,1)
        end
        if explosive.trail ~= nil then
            for i = 1, #explosive.trail - 1 do
                local p1, p2 = explosive.trail[i], explosive.trail[i+1]
                love.graphics.setColor(1, 0, 0, i / #explosive.trail) -- Set the color of the line
                love.graphics.setLineWidth(8)
                love.graphics.line(p1.x, p1.y, p2.x, p2.y) 
                love.graphics.setColor(1, 1, 1)-- Draw the line segment
            end
        end
        love.graphics.setLineWidth(1)
    end
end

function Explode(explosive)
    local n = 0
    local x, y = explosive.collider:getPosition()
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
    explosive.fusee = false
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

    Datapool.hitPart = hitPart
    Datapool.hitArmorside = hitArmorside

    return hitPart, hitArmorside
end