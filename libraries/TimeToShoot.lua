TankProjectiles = {}

Shoot = function (tank)
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
    table.insert(TankProjectiles, shell)
end