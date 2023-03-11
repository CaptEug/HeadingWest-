TankProjectiles = {}
Datapool = {
    position_angle = 0,
    hitArmorside = 'none',
    impact_angle = 0,
    ricochet = false,
    hitpos = 0,
    hitpart = 'none',
    effective_thickness = 0,
    penetration = false
}

function Shoot(tank)
    local round = tank.data.ammorack[1]
    local ix, iy = math.cos(tank.location.hull_angle+tank.data.turret_angle-math.pi/2) * round.velocity,
                   math.sin(tank.location.hull_angle+tank.data.turret_angle-math.pi/2) * round.velocity
    local shell = world:newCircleCollider(tank.gun_location.x, tank.gun_location.y, 1)
    shell:setCollisionClass(round.type)
    shell:setBullet(true)
    shell:setRestitution(0.5)
    shell:setLinearDamping(0.01)
    shell:setMass(round.mass)
    shell:applyLinearImpulse(ix, iy)
    shell.life = 5
    shell.type = round.type
    shell.pen = round.pen
    shell.pentype = round.pentype
    table.insert(TankProjectiles, shell)
    table.remove(tank.data.ammorack, 1)
end

function TankProjectiles:update(dt)
    for i, shell in ipairs(self) do
        shell.life = shell.life - dt

        if shell:enter('Wall') then
            shell:destroy()
            table.remove(self, i)
        end

        if shell:enter('tankhull') then
            local collision_data = shell:getEnterCollisionData('tankhull')
            local Target = collision_data.collider:getObject()
            local ricochet, hitArmorside, angle = RicochetCheck(shell, Target)
            local ispen = false
            
            if not ricochet then
                ispen = PenCheck(shell, Target, hitArmorside, angle)
                shell:destroy()
                table.remove(self, i)
            end
            
            
        end

        if shell.life <= 0 then
            shell:destroy()
            table.remove(self, i)
        end
    end
end

function TankProjectiles:draw()
    --log
    love.graphics.setColor(1,1,0)
    love.graphics.print('position angle = '..string.format("%.2f",Datapool.position_angle),0,50)
    love.graphics.print('hitArmorside = '..Datapool.hitArmorside,0,70)
    love.graphics.print('impact angle = '..string.format("%.2f",Datapool.impact_angle),0,90)
    if Datapool.ricochet then
        love.graphics.print('Ricochet!',0,110)
    else
        love.graphics.print('hitpos = '..string.format("%.2f",Datapool.hitpos),0,130)
        love.graphics.print('hitpart = '..Datapool.hitpart,0,150)
        love.graphics.print('effective_thickness = '..string.format("%.2f",Datapool.effective_thickness)..'mm',0,170)
        if Datapool.penetration then
            love.graphics.print('Penetrate!',0,190)
        else
            love.graphics.print('NONE Penetration!',0,190)
        end
    end
    
    love.graphics.setColor(1,1,1)
end

function RicochetCheck(shell, Target)
    --position_angle acquire and armor side check
    local x, y = shell:getPosition()
    local position_angle = Target.location.hull_angle-math.atan2(y-Target.location.y, x-Target.location.x)
    local diagonal = math.atan2(Target.data.length, Target.data.width)
    local hitArmorside = 'none'

    if position_angle < 0 then
        position_angle = position_angle + 2*math.pi
    end
    if position_angle > 2*math.pi then
        position_angle = position_angle - 2*math.pi
    end
    
    if position_angle > 2*math.pi-diagonal or position_angle < diagonal then
        hitArmorside = 'right'
    elseif position_angle > diagonal and position_angle < math.pi-diagonal then
        hitArmorside = 'front'
    elseif position_angle > math.pi-diagonal and position_angle < math.pi+diagonal then
        hitArmorside = 'left'
    else
        hitArmorside = 'back'
    end

    Datapool.position_angle = position_angle
    Datapool.hitArmorside = hitArmorside

    --impact_angle acquire and ricochet check
    local ricochet = false
    local ra = 80*0.0174533
    local vx, vy = shell:getLinearVelocity()
    local vangle = math.atan2(vy, vx)
    local impact_angle = 0
    local dangle = Target.location.hull_angle - vangle

    if dangle < 0 then
        dangle = dangle + 2*math.pi
    end
    if dangle > 2*math.pi then
        dangle = dangle - 2*math.pi
    end
    
    if hitArmorside == 'front' then
        if dangle < math.pi/2 then
            impact_angle = math.pi/2 - dangle
        else
            impact_angle = dangle - math.pi/2
        end
    elseif hitArmorside == 'right' then
        if dangle < math.pi then
            impact_angle = dangle
        else
            impact_angle = 2*math.pi - dangle
        end
    elseif hitArmorside == 'back' then
        if dangle > math.pi*3/2 then
            impact_angle = dangle - math.pi*3/2
        else
            impact_angle = math.pi*3/2 - dangle
        end
    elseif hitArmorside == 'left' then
        if dangle < math.pi then
            impact_angle = math.pi - dangle
        else
            impact_angle = dangle - math.pi
        end
    end
    
    if impact_angle < ra then
        ricochet = false
    else
        ricochet = true
    end

    Datapool.impact_angle = impact_angle
    Datapool.ricochet = ricochet

    return ricochet, hitArmorside, impact_angle
end

function PenCheck(shell, Target, hitArmorside, angle)
    local penetration = false
    local pen = shell.pen
    local pentype = shell.pentype
    local armorpart = {}
    local armorthickness = 0
    local cosFi = math.cos(angle)
    local hitpos = math.random()
    local hitpart = 'none'
    
    if hitArmorside == 'front' then
        if hitpos < Target.data.innerstructure.front.htl then
            armorpart = Target.data.armorthickness.front.hull
            hitpart = 'Hull'
        else
            armorpart = Target.data.armorthickness.front.turret
            hitpart = 'Turret'
        end
    elseif hitArmorside == 'Left' or 'Right' then
        if hitpos < Target.data.innerstructure.side.htl then
            armorpart = Target.data.armorthickness.side.hull
            hitpart = 'Hull'
        else
            armorpart = Target.data.armorthickness.side.turret
            hitpart = 'Turret'
        end
    else
        if hitpos < Target.data.innerstructure.front.htl then
            armorpart = Target.data.armorthickness.back.hull
            hitpart = 'Hull'
        else
            armorpart = Target.data.armorthickness.back.turret
            hitpart = 'Turret'
        end
    end

    if pentype == 'KE' then
        armorthickness = armorpart[1]
    elseif pentype == 'CE' then
        armorthickness = armorpart[2]
    end

    local effective_thickness = armorthickness/cosFi

    if pen > effective_thickness then
        penetration = true
    else
        penetration = false
    end

    Datapool.hitpos = hitpos
    Datapool.hitpart = hitpart
    Datapool.effective_thickness = effective_thickness
    Datapool.penetration = penetration

    return penetration
end