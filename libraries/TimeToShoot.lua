TankProjectiles = {}
Datapool = {
    absAngle = 0,
    diagonal = 0,
    hitArmorside = 'none',
    impact_angle = 0,
    ricochet = false
}

function Shoot(tank)
    local round = tank.data.ammorack[1]
    local ix, iy = math.cos(tank.location.hull_angle+tank.data.turret_angle-math.pi/2) * round.velocity,
                   math.sin(tank.location.hull_angle+tank.data.turret_angle-math.pi/2) * round.velocity
    local shell = world:newCircleCollider(tank.gun_location.x, tank.gun_location.y, 5)
    shell:setCollisionClass(round.type)
    shell:setBullet(true)
    shell:setRestitution(0.5)
    shell:setLinearDamping(0.01)
    shell:setMass(round.mass)
    shell:applyLinearImpulse(ix, iy)
    shell.life = 10
    shell.pen = round.pen
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
            local x, y = shell:getPosition()
            local absAngle = Target.location.hull_angle-math.atan2(y-Target.location.y, x-Target.location.x)
            local diagonal = math.atan2(Target.data.length, Target.data.width)
            local hitArmorside = 'none'
            if absAngle < 0 then
                absAngle = absAngle + 2*math.pi
            end
            if absAngle > 2*math.pi then
                absAngle = absAngle - 2*math.pi
            end
            Datapool.diagonal = diagonal
            Datapool.absAngle = absAngle
            if absAngle > 2*math.pi-diagonal or absAngle < diagonal then
                hitArmorside = 'right'
            elseif absAngle > diagonal and absAngle < math.pi-diagonal then
                hitArmorside = 'front'
            elseif absAngle > math.pi-diagonal and absAngle < math.pi+diagonal then
                hitArmorside = 'left'
            else
                hitArmorside = 'back'
            end
            Datapool.hitArmorside = hitArmorside

            local ricochet = false
            local ra = 80*0.017
            local vx, vy = shell:getLinearVelocity()
            local vangle = math.atan2(vy, vx)
            local impact_angle = 0
            local dangle = Target.location.hull_angle - vangle

            if hitArmorside == 'front' then
                impact_angle = dangle
            elseif hitArmorside == 'right' then
                impact_angle = math.pi/2-dangle
            elseif hitArmorside == 'back' then
                impact_angle = dangle-math.pi/2
            elseif hitArmorside == 'left' then
                impact_angle = -dangle
            end
            Datapool.impact_angle = impact_angle

            if impact_angle < ra then
                shell:destroy()
                table.remove(self, i)
            else
                ricochet = true
                Datapool.ricochet = ricochet
                return ricochet
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
    love.graphics.print('diagonal = '..string.format("%.1f",Datapool.diagonal),0,30)
    love.graphics.print('absangle = '..string.format("%.1f",Datapool.absAngle),0,50)
    love.graphics.print('hitArmorside = '..Datapool.hitArmorside,0,70)
    love.graphics.print('impact angle = '..string.format("%.1f",Datapool.impact_angle),0,90)
    if Datapool.ricochet then
        love.graphics.print('Ricochet!',0,110)
    end
end