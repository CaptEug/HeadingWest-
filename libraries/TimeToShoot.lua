TankProjectiles = {}

function Shoot(tank)
    local round = tank.data.ammorack[1]
    local ix, iy = math.cos(tank.location.hull_angle+tank.data.turret_angle-math.pi/2) * round.velocity,
                   math.sin(tank.location.hull_angle+tank.data.turret_angle-math.pi/2) * round.velocity
    local shell = world:newCircleCollider(tank.gun_location.x, tank.gun_location.y, 5)
    shell:setCollisionClass(round.type)
    shell:setRestitution(0.5)
    shell:setLinearDamping(0.01)
    shell:setMass(round.mass)
    shell:applyLinearImpulse(ix, iy)
    shell.isflying = true
    shell.life = 10
    shell.pen = round.pen
    table.insert(TankProjectiles, shell)
    table.remove(tank.data.ammorack, 1)
end

function TankProjectiles:update(dt)
    for i, shell in ipairs(self) do
        local sx, sy = shell:getLinearVelocity()
        shell.life = shell.life - dt
        if shell.life <= 0 then
            shell.isflying = false
            shell:destroy()
            table.remove(self, i)
        end
    end
end