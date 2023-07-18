Missiles = {}

function LaunchMissile(unit, target)
    local instance = unit.missilerack[1]
    local missile = {}
    missile.collider = CurrentPlace.world:newCircleCollider(unit.luncher_location.x, unit.luncher_location.y, 2)
    missile.collider:setCollisionClass('ATGM')
    missile.collider:setBullet(true)
    missile.collider:setRestitution(0.5)
    missile.collider:setAngularDamping(5)
    missile.collider:setMass(instance.mass)
    missile.collider:setInertia(10)
    missile.from = unit
    missile.face = unit.location.hull_angle + unit.turret_angle - math.pi/2
    missile.collider:applyLinearImpulse(100*math.cos(missile.face), 100*math.sin(missile.face))
    missile.target = target or nil
    missile.velocity = instance.velocity
    missile.turningtorque = instance.turningtorque
    missile.type = instance.type
    missile.pen = instance.pen
    missile.pentype = instance.pentype
    missile.TNT_eq = instance.TNT_eq
    missile.pic = instance.pic
    missile.life = 30

    missile.smoke = love.graphics.newParticleSystem(Smoke)
    missile.smoke:setParticleLifetime(0.5)
	missile.smoke:setEmissionRate(50)
	missile.smoke:setSizeVariation(0.5)
    missile.smoke:setSizes(0.8, 0.2)
    missile.smoke:setLinearDamping(5)
	missile.smoke:setColors(1, 0.5, 0, 1, 1, 0, 0, 0.5)
    
    table.insert(Missiles, missile)
    unit.m_reload_timer = unit.m_reload_time
end

function Missiles:update(dt)
    for i, missile in ipairs(self) do
        missile.life = missile.life - dt
        missile.smoke:update(dt) 

        Tracking(missile, missile.collider)

        if missile:enter('Wall') then
            Explode(missile, missile.collider)
            missile.collider:destroy()
            table.remove(self, i)
        end

        if missile:enter('TankHull') then
            local collision_data = missile.collider:getEnterCollisionData('TankHull')
            local Target = collision_data.collider:getObject()

            if Target == missile.from and missile.life > 29 then
                break
            end

            local ricochet, hitPart, hitArmorside, angle = RicochetCheck(missile, Target)
            local ispen = PenCheck(missile, Target, hitPart, hitArmorside, angle)
            Explode(missile, missile.collider)
            missile.collider:destroy()
            table.remove(self, i)

            if ispen then
                DamageCheck(Target, hitPart)
            end
            if Target.status.era[1] then
                Target.armor.life = Target.armor.life - 1
            end
        end

        if missile.life <= 0 then
            Explode(missile, missile.collider)
            missile.collider:destroy()
            table.remove(self, i)
        end
    end
end

function Missiles:draw()
    for i, missile in ipairs(self) do
        local missile_angle = missile:getAngle() + missile.face
        local x, y = missile:getPosition()
        local w, h = missile.pic:getDimensions()
        love.graphics.draw(missile.pic, x, y, missile_angle + math.pi/2, 1, 1, w/2, h/2)
        missile.smoke:setPosition(x - math.sin(missile_angle + math.pi/2)*h/2, y + math.cos(missile_angle + math.pi/2)*h/2)
        missile.smoke:setLinearAcceleration(1000*math.cos(missile_angle - math.pi),1000*math.sin(missile_angle - math.pi))
        love.graphics.draw(missile.smoke)
    end
end

function Tracking(missile)
    local missile_angle = missile:getAngle() + missile.face
    local x, y = missile:getPosition()
    local tx, ty
    if missile.target then
        tx, ty = missile.target.location.x, missile.target.location.y
    else
        tx, ty = cam:mousePosition()
    end
    local angle_to_target = math.atan2(y - ty, x - tx)

    if angle_to_target <= 0 then
        angle_to_target = angle_to_target + math.pi*2
    end
    while missile_angle > 2*math.pi do
        missile_angle = missile_angle - 2*math.pi
    end
    while missile_angle < 0 do
        missile_angle = missile_angle + 2*math.pi
    end

    if missile_angle > angle_to_target then
        if missile_angle - angle_to_target <= math.pi then
            missile:applyTorque(missile.turningtorque)
        else
            missile:applyTorque(-missile.turningtorque)
        end
    end
    if missile_angle < angle_to_target then
        if angle_to_target - missile_angle <= math.pi then
            missile:applyTorque(-missile.turningtorque)
        else
            missile:applyTorque(missile.turningtorque)
        end
    end
    missile:setLinearVelocity(math.cos(missile_angle)*missile.velocity, math.sin(missile_angle)*missile.velocity)
end