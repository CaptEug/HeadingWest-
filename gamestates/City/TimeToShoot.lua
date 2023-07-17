TankProjectiles = {}
Datapool = {
    hitPart = 'none',
    hitArmorside = 'none',
    impact_angle = 0,
    ricochet = false,
    effective_thickness = 0,
    penetration = false,
    hitmodule = {},
    crewknockout = 0
}
GunParticles = {}

function Shoot(unit,...)
    --shell collider
    local round = unit.ammorack[1]
    if unit.location ~= nil then
        local ix, iy = math.cos(unit.location.hull_angle+unit.turret_angle-math.pi/2),
                   math.sin(unit.location.hull_angle+unit.turret_angle-math.pi/2)
        local shell = {}
        shell.shell = CurrentPlace.world:newCircleCollider(unit.gun_location.x, unit.gun_location.y, 1)
        shell.shell:setCollisionClass(round.type)
        shell.shell:setBullet(true)
        shell.shell:setRestitution(0.5)
        shell.shell:setLinearDamping(0.01)
        shell.shell:setMass(round.mass)
        shell.shell:applyLinearImpulse(ix*round.velocity/2, iy*round.velocity/2)
        shell.from = tank
        shell.life = 10
        shell.type = round.type
        shell.pen = round.pen
        shell.pentype = round.pentype
        shell.TNT_eq = round.TNT_eq or nil
        shell.trail = {}
        table.insert(TankProjectiles, shell)
        table.remove(unit.ammorack, 1)
        unit.firing_timer = unit.firing_time
        unit.reload_timer = unit.reload_time

        unit.gun_sound:play()
    elseif unit.battery_location then
        for i, gun in ipairs(unit.gun) do
            local x, y = ...
            local ix, iy = math.cos(math.atan2(y - unit.battery_location.y, x - unit.battery_location.x)),
            math.sin(math.atan2(y - unit.battery_location.y, x - unit.battery_location.x))
            local shell = {}
            shell.shell = CurrentPlace.world:newCircleCollider(unit.gun[i].x, unit.gun[i].y, 1)
            shell.shell:setCollisionClass(round.type)
            shell.shell:setBullet(true)
            shell.shell:setRestitution(0.5)
            shell.shell:setLinearDamping(0.01)
            shell.shell:setMass(round.mass)
            shell.shell:applyLinearImpulse(ix*round.velocity/2, iy*round.velocity/2)
            shell.from = tank
            shell.life = 10
            shell.type = round.type
            shell.pen = round.pen
            shell.pentype = round.pentype
            shell.TNT_eq = round.TNT_eq or nil
            shell.trail = {}
            table.insert(TankProjectiles, shell)
            unit.firing_timer = unit.firing_time
            unit.reload_timer = unit.reload_time

        end
    end
end

function TankProjectiles:update(dt)
    for i, shell in ipairs(self) do
        shell.life = shell.life - dt
        local sx, sy = shell.shell:getPosition()
        table.insert(shell.trail, {x = sx, y = sy})

        if shell.shell:enter('Wall') then
            if shell.type == 'HE' then
                Explode(shell, shell.shell)
            end
            shell.shell:destroy()
            table.remove(self, i)
        end

        if shell.shell:enter('TankHull') then
            local collision_data = shell.shell:getEnterCollisionData('TankHull')
            local Target = collision_data.collider:getObject()

            if Target == shell.from and shell.life > 9 then
                break
            end

            if shell.type == 'HE' then
                Explode(shell,shell.shell)
                shell.shell:destroy()
                table.remove(self, i)
            else
                local ricochet, hitPart, hitArmorside, angle = RicochetCheck(shell, Target)
                local ispen = false
                if not ricochet then
                    ispen = PenCheck(shell, Target, hitPart, hitArmorside, angle)
                    shell.shell:destroy()
                    table.remove(self, i)
                end
                if ispen then
                    Target.status.penetrated = true
                    DamageCheck(Target, hitPart)
                else
                    Clang:clone():play()
                end
                if Target.status.era then
                    Target.armor.life = Target.armor.life - 1
                end
            end
        end

        if #shell.trail > 10 then
            table.remove(shell.trail, 1)
        end

        if shell.life <= 0 then
            shell.shell:destroy()
            table.remove(self, i)
        end
    end
end

function TankProjectiles:draw()
    for i, shell in ipairs(self) do
        for i = 1, #shell.trail - 1 do
            local p1, p2 = shell.trail[i], shell.trail[i+1]
            love.graphics.setColor(1, 0.2, 0.2, i / #shell.trail) -- Set the color of the line
            love.graphics.setLineWidth(2)
            love.graphics.line(p1.x, p1.y, p2.x, p2.y) -- Draw the line segment
        end
        love.graphics.setLineWidth(1)
    end
    love.graphics.setColor(1, 1, 1)
end

function PenetrateLog()
        --log
        love.graphics.setColor(1,1,0)
        love.graphics.setFont(Rtextfont)
        love.graphics.print('hitPart = '..Datapool.hitPart,0,50)
        love.graphics.print('hitArmorside = '..Datapool.hitArmorside,0,70)
        love.graphics.print('impact angle = '..string.format("%.2f",Datapool.impact_angle*180/math.pi)..' Degree',0,90)
        love.graphics.print('X='..tostring(IntX),100,200)
        love.graphics.print('Y='..tostring(IntY),100,210)

        if Datapool.ricochet then
            love.graphics.print('Ricochet!',0,110)
        else
            love.graphics.print('effective_thickness = '..string.format("%.2f",Datapool.effective_thickness)..'mm',0,110)
            if Datapool.penetration then
                love.graphics.print('Penetrate!',0,130)
                for i, m in ipairs(Datapool.hitmodule) do
                    love.graphics.print('Hit '..m,-100+100*i,150)
                end
                love.graphics.print(Datapool.crewknockout..' crews were konckout',0,170)
            else
                love.graphics.print('NONE Penetration!',0,130)
            end
        end
        love.graphics.setColor(1,1,1)
end

function RicochetCheck(shell, Target)
    --position_angle acquire and armor side check
    local x, y = shell.shell:getPosition()
    local vx, vy = shell.shell:getLinearVelocity()
    local hitvalue = math.random()
    local hitPart = 'none'
    local hitArmorside = 'none'
    local ricochet = false
    local ra = 65 * math.pi/180
    local vangle = math.atan2(vy, vx)
    local impact_angle = 0

    if shell.type == 'HEAT' or shell.type == 'ATGM' then
        ra = 90 * math.pi/180
    elseif shell.type == 'APFSDS' then
        ra = 80 * math.pi/180
    elseif shell.type == 'APDS' then
        ra = 70 * math.pi/180
    end
    if shell.type == 'ATGM' then
        vangle = shell:getAngle() + shell.face + math.pi
    end

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
        local dangle = Target.location.hull_angle - vangle
        while dangle < 0 do
            dangle = dangle + 2*math.pi
        end
        while dangle > 2*math.pi do
            dangle = dangle - 2*math.pi
        end

        if position_angle > 2*math.pi-diagonal or position_angle < diagonal then
            hitArmorside = 'Right'
            if dangle < math.pi then
                impact_angle = dangle
            else
                impact_angle = 2*math.pi - dangle
            end
        elseif position_angle > diagonal and position_angle < math.pi-diagonal then
            hitArmorside = 'Front'
            if dangle < math.pi/2 then
                impact_angle = math.pi/2 - dangle
            else
                impact_angle = dangle - math.pi/2
            end
        elseif position_angle > math.pi-diagonal and position_angle < math.pi+diagonal then
            hitArmorside = 'Left'
            if dangle < math.pi then
                impact_angle = math.pi - dangle
            else
                impact_angle = dangle - math.pi
            end
        else
            hitArmorside = 'Back'
            if dangle > math.pi*3/2 then
                impact_angle = dangle - math.pi*3/2
            else
                impact_angle = math.pi*3/2 - dangle
            end
        end
    else
        hitPart = 'Turret'
        local dangle = Target.location.hull_angle + Target.turret_angle - vangle
        while dangle < 0 do
            dangle = dangle + 2*math.pi
        end
        while dangle > 2*math.pi do
            dangle = dangle - 2*math.pi
        end
        if dangle > math.pi*7/4 or dangle < math.pi/4 then
            hitArmorside = 'Right'
            if dangle < math.pi then
                impact_angle = dangle
            else
                impact_angle = 2*math.pi - dangle
            end
        elseif dangle > math.pi/4 and dangle < math.pi*3/4 then
            hitArmorside = 'Front'
            if dangle < math.pi/2 then
                impact_angle = math.pi/2 - dangle
            else
                impact_angle = dangle - math.pi/2
            end
        elseif dangle > math.pi*3/4 and dangle < math.pi*5/4 then
            hitArmorside = 'Left'
            if dangle < math.pi then
                impact_angle = math.pi - dangle
            else
                impact_angle = dangle - math.pi
            end
        else
            hitArmorside = 'Back'
            if dangle > math.pi*3/2 then
                impact_angle = dangle - math.pi*3/2
            else
                impact_angle = math.pi*3/2 - dangle
            end
        end
    end

    while impact_angle < 0 do
        impact_angle = impact_angle + 2*math.pi
    end
    while impact_angle > 2*math.pi do
        impact_angle = impact_angle - 2*math.pi
    end

    --impact_angle acquire and ricochet check
    if impact_angle < ra then
        ricochet = false
    else
        ricochet = true
    end

    Datapool.hitPart = hitPart
    Datapool.hitArmorside = hitArmorside
    Datapool.impact_angle = impact_angle
    Datapool.ricochet = ricochet

    return ricochet, hitPart, hitArmorside, impact_angle
end

function PenCheck(shell, Target, hitPart, hitArmorside, angle)
    local penetration = false
    local pen = shell.pen
    local pentype = shell.pentype
    local armorpart = {}
    local erapart = {}
    local armorthickness = 0
    local erathickness = 0
    local cosFi = math.cos(angle)

    if hitPart == 'Hull' then
        if hitArmorside == 'Front' then
            armorpart = Target.armorthickness.hull.front
            if Target.status.era then
                erapart = Target.armor.armorthickness.hull.front
            end
        elseif hitArmorside == 'Left' or hitArmorside == 'Right' then
            armorpart = Target.armorthickness.hull.side
                if Target.status.era then
                    erapart = Target.armor.armorthickness.hull.side
                end
        elseif hitArmorside == 'Back' then
            armorpart = Target.armorthickness.hull.back
                if Target.status.era then
                    erapart = Target.armor.armorthickness.hull.back
                end
        end
    elseif hitPart == 'Turret' then
        if hitArmorside == 'Front' then
            armorpart = Target.armorthickness.turret.front
            if Target.status.era then
                erapart = Target.armor.armorthickness.turret.front
            end
        elseif hitArmorside == 'Left' or hitArmorside == 'Right' then
            armorpart = Target.armorthickness.turret.side
                if Target.status.era then
                    erapart = Target.armor.armorthickness.turret.side
                end
        elseif hitArmorside == 'Back' then
            armorpart = Target.armorthickness.turret.back
                if Target.status.era then
                    erapart = Target.armor.armorthickness.turret.back
                end
        end
    end

    if pentype == 'KE' then
        armorthickness = armorpart[1]
        if Target.status.era then
            erathickness = erapart[1]
        end
    elseif pentype == 'CE' then
        armorthickness = armorpart[2]
        if Target.status.era then
            erathickness = erapart[2]
        end
    end

    local effective_thickness = armorthickness/cosFi + erathickness

    if pen > effective_thickness then
        penetration = true
    else
        penetration = false
    end

    Datapool.effective_thickness = effective_thickness
    Datapool.penetration = penetration

    return penetration
end

function DamageCheck(Target, penpart)
    local crew, ammo, engine, fuel = 0, 0, 0, 0
    while #Datapool.hitmodule > 0 do
        table.remove(Datapool.hitmodule, 1)
    end
    Datapool.crewknockout = 0

    Target.survivor = Target.survivor - 1
    Datapool.crewknockout = Datapool.crewknockout + 1

    if penpart == 'Hull' then
        crew = Target.innerstructure.hull.crew
        ammo = Target.innerstructure.hull.ammo
        engine = Target.innerstructure.hull.engine
        fuel = Target.innerstructure.hull.fuel
    elseif penpart == 'Turret' then
        crew = Target.innerstructure.turret.crew
        ammo = Target.innerstructure.turret.ammo
        engine = Target.innerstructure.turret.engine
        fuel = Target.innerstructure.turret.fuel
    end

    if math.random() <= ammo then
        Target.survivor = 0
        Target:Detonate()
        table.insert(Datapool.hitmodule, 'ammorack')
    else
        Killcrew(Target, crew)
        if math.random() <= engine then
            Target.status.immobilized = true
            table.insert(Datapool.hitmodule, 'engine')
        end
        if math.random() <= fuel then
            Target.status.onfire = true
            table.insert(Datapool.hitmodule, 'fuel tank')
        end
    end
end

function Killcrew(tank, rate)
    if math.random() <= rate and tank.survivor > 0 then
        tank.survivor = tank.survivor - 1
        Datapool.crewknockout = Datapool.crewknockout + 1
        Killcrew(tank, rate)
    end
end