Missiles = {}

function LaunchMissile(unit, target)
    local instance = unit.missilerack[1]
    local missile = world:newCircleCollider(unit.gun_location.x, unit.gun_location.y, 2)
    missile:setCollisionClass('Missile')
    missile:setBullet(true)
    missile:setRestitution(0.5)
    missile:setAngularDamping(5)
    missile:setMass(instance.mass)
    missile:setInertia(10)
    missile.from = unit
    missile.face = unit.location.hull_angle + unit.turret_angle - math.pi/2
    missile.target = target or nil
    missile.velocity = instance.velocity
    missile.turningspeed = instance.turningspeed
    missile.type = instance.type
    missile.pen = instance.pen
    missile.pentype = instance.pentype
    missile.TNT_eq = instance.TNT_eq
    missile.life = 30

    table.insert(Missiles, missile)
    unit.m_reload_timer = unit.m_reload_time
end

function Missiles:update(dt)
    for i, missile in ipairs(self) do
        missile.life = missile.life - dt

        Tracking(missile)

        if missile:enter('Wall') then
            Explode(missile)
            missile:destroy()
            table.remove(self, i)
        end

        if missile:enter('Hull') then
            local collision_data = missile:getEnterCollisionData('Hull')
            local Target = collision_data.collider:getObject()

            if Target == missile.from and missile.life > 29 then
                break
            end

            local ricochet, hitPart, hitArmorside, angle = RicochetCheck(missile, Target)
            local ispen = PenCheck(missile, Target, hitPart, hitArmorside, angle)
            Explode(missile)
            missile:destroy()
            table.remove(self, i)

            if ispen then
                DamageCheck(Target, hitPart)
            end
            if Target.status.era[1] then
                Target.armor.life = Target.armor.life - 1
            end
        end

        if missile.life <= 0 then
            missile:destroy()
            table.remove(self, i)
        end
    end
end

function Tracking(missile)
    local missile_angle = missile:getAngle() + missile.face
    local x, y = missile:getPosition()
    local tx, ty = cam:mousePosition()
    local angle_to_target = math.atan2(y - ty, x - tx)

    if missile.target then
        tx, ty = missile.target.location.x, missile.target.location.y
    end
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
            missile:applyTorque(missile.turningspeed)
        else
            missile:applyTorque(-missile.turningspeed)
        end
    end
    if missile_angle < angle_to_target then
        if angle_to_target - missile_angle <= math.pi then
            missile:applyTorque(-missile.turningspeed)
        else
            missile:applyTorque(missile.turningspeed)
        end
    end
    missile:setLinearVelocity(math.cos(missile_angle)*missile.velocity, math.sin(missile_angle)*missile.velocity)
end