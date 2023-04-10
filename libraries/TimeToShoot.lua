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
Shelltrails = {}
GunParticles = {}

function Shoot(tank)
    --shell collider
    local round = tank.ammorack[1]
    local ix, iy = math.cos(tank.location.hull_angle+tank.turret_angle-math.pi/2),
                   math.sin(tank.location.hull_angle+tank.turret_angle-math.pi/2)
    local shell = world:newCircleCollider(tank.gun_location.x, tank.gun_location.y, 2)
    shell:setCollisionClass(round.type)
    shell:setBullet(true)
    shell:setRestitution(0.5)
    shell:setLinearDamping(0.01)
    shell:setMass(round.mass)
    shell:applyLinearImpulse(ix*round.velocity, iy*round.velocity)
    shell.life = 5
    shell.type = round.type
    shell.pen = round.pen
    shell.pentype = round.pentype
    shell.trail = {}
    table.insert(Shelltrails, shell.trail)
    table.insert(TankProjectiles, shell)
    table.remove(tank.ammorack, 1)
end

function TankProjectiles:update(dt)
    for i, shell in ipairs(self) do
        shell.life = shell.life - dt
        local sx, sy = shell:getPosition()
        table.insert (shell.trail, 1, sy)
	    table.insert (shell.trail, 1, sx)

        if shell:enter('Wall') then
            shell:destroy()
            table.remove(self, i)
            table.remove(Shelltrails, i)
        end

        if shell:enter('tankhull') then
            local collision_data = shell:getEnterCollisionData('tankhull')
            local Target = collision_data.collider:getObject()
            local ricochet, hitPart, hitArmorside, angle = RicochetCheck(shell, Target)
            local ispen = false

            if Target.status.era[1] then
                Target.armor.life = Target.armor.life - 1
            end
            
            if not ricochet then
                ispen = PenCheck(shell, Target, hitPart, hitArmorside, angle)
                shell:destroy()
                table.remove(self, i)
                table.remove(Shelltrails, i)
            end
            
            if ispen then
                DamageCheck(shell, Target, hitPart)
            end
            
        end

        if shell.life <= 0 then
            shell:destroy()
            table.remove(self, i)
            table.remove(Shelltrails, i)
        end
    end

    --trail
    for i, trail in ipairs(Shelltrails) do
        local trailTimer = 0
        if #trail > 2 then
            trailTimer = trailTimer + dt
            while trailTimer > 0.01 do
                trailTimer = trailTimer - 0.01
                -- remove two last coordinates:
                trail[#trail] = nil
                trail[#trail] = nil
            end
        end
        if #trail > 5*2 then
            for i = #trail, 5*2+1, -1 do -- backwards
                trail[i] = nil
            end
        end
    end
end

function Shelltrails:draw()
    for i, trail in ipairs(self) do
        for i = #trail-1, 3, -2 do -- backwards for color trail
            local c = (#trail-(i+1))/#trail
            local w = 4*c
            love.graphics.setLineWidth (w)
            love.graphics.setColor (1,0,0,c)
            love.graphics.line (trail[i-2], trail[i-1], trail[i], trail[i+1])
            love.graphics.circle ('fill', trail[i], trail[i+1], w/2)
            love.graphics.setLineWidth (1)
            love.graphics.setColor (1,1,1)
        end
    end
end

function PenetrateLog()
        --log
        love.graphics.setColor(1,1,0)
        love.graphics.setFont(Rtextfont)
        love.graphics.print('hitPart = '..Datapool.hitPart,0,50)
        love.graphics.print('hitArmorside = '..Datapool.hitArmorside,0,70)
        love.graphics.print('impact angle = '..string.format("%.2f",Datapool.impact_angle),0,90)
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
    local x, y = shell:getPosition()
    local vx, vy = shell:getLinearVelocity()
    local hitvalue = math.random()
    local hitPart = 'none'
    local hitArmorside = 'none'
    local ricochet = false
    local ra = 80*0.0174533
    local vangle = math.atan2(vy, vx)
    local impact_angle = 0

    if hitvalue < Target.innerstructure.htl then
        local position_angle = Target.location.hull_angle-math.atan2(y-Target.location.y, x-Target.location.x)
        if position_angle < 0 then
            position_angle = position_angle + 2*math.pi
        end
        if position_angle > 2*math.pi then
            position_angle = position_angle - 2*math.pi
        end
        local diagonal = 0
        local dangle = Target.location.hull_angle - vangle
        if dangle < 0 then
            dangle = dangle + 2*math.pi
        end
        if dangle > 2*math.pi then
            dangle = dangle - 2*math.pi
        end
        hitPart = 'Hull'
        diagonal = math.atan2(Target.length, Target.width)
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
        if dangle < 0 then
            dangle = dangle + 2*math.pi
        end
        if dangle > 2*math.pi then
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
            if Target.status.era[1] then
                erapart = Target.armor.armorthickness.hull.front
            end
        elseif hitArmorside == 'Left' or hitArmorside == 'Right' then
            armorpart = Target.armorthickness.hull.side
                if Target.status.era[1] then
                    erapart = Target.armor.armorthickness.hull.side
                end
        elseif hitArmorside == 'Back' then
            armorpart = Target.armorthickness.hull.back
                if Target.status.era[1] then
                    erapart = Target.armor.armorthickness.hull.back
                end
        end
    elseif hitPart == 'Turret' then
        if hitArmorside == 'Front' then
            armorpart = Target.armorthickness.turret.front
            if Target.status.era[1] then
                erapart = Target.armor.armorthickness.turret.front
            end
        elseif hitArmorside == 'Left' or hitArmorside == 'Right' then
            armorpart = Target.armorthickness.turret.side
                if Target.status.era[1] then
                    erapart = Target.armor.armorthickness.turret.side
                end
        elseif hitArmorside == 'Back' then
            armorpart = Target.armorthickness.turret.back
                if Target.status.era[1] then
                    erapart = Target.armor.armorthickness.turret.back
                end
        end
    end
    
    if pentype == 'KE' then
        armorthickness = armorpart[1]
        if Target.status.era[1] then
            erathickness = erapart[1]
        end
    elseif pentype == 'CE' then
        armorthickness = armorpart[2]
        if Target.status.era[1] then
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

function DamageCheck(shell, Target, penpart)
    local crew, ammo, engine, fuel = 0, 0, 0, 0
    while #Datapool.hitmodule > 0 do
        table.remove(Datapool.hitmodule, 1)
    end
    Datapool.crewknockout = 0

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
        table.insert(Datapool.hitmodule, 'ammorack')
    else
        Killcrew(Target, crew)
        if math.random() <= engine then
            Target.status.Immobilized[1] = true
            table.insert(Datapool.hitmodule, 'engine')
        end
        if math.random() <= fuel then
            Target.status.onfire[1] = true
            table.insert(Datapool.hitmodule, 'fuel tank')
        end
    end
end

function Killcrew(tank, rate)
    local crew = tank.crew
    if math.random() <= rate and tank.survivor > 0 then
        tank.survivor = tank.survivor - 1
        Datapool.crewknockout = Datapool.crewknockout + 1
        Killcrew(tank, rate)
    end
end