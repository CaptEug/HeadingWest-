Bombs = {}
Explosions = {}

function Bomb(unit, x, y)
    local bomb = unit.ammorack[1]
    local ux, uy = unit.image_location.x, unit.image_location.y
    local distance = math.sqrt((x-ux)^2 + (y-uy)^2)
    bomb.timer = distance/(bomb.velocity/2)
    bomb.x, bomb.y = x, y

    table.insert(Bombs, bomb)
end

function Bombs:update(dt)
    for i, bomb in ipairs(self) do
        bomb.timer = bomb.timer - dt
        if bomb.timer <= 0 then
            Expolde(bomb, i)
        end
    end
end

function Expolde(bomb, i)
    local n = 0
    while n < 5 do
        local explode = world:newCircleCollider(bomb.x, bomb.y, math.random(10,50))
        explode:setCollisionClass('Explosion')
        explode:applyLinearImpulse(math.random(-2000,2000),math.random(-2000,2000))
        explode.life = 1
        explode.pen = bomb.pen
        explode.pentype = bomb.pentype
        explode.isoccur = true
        table.insert(Explosions, explode)
        n = n + 1
    end
    table.remove(Bombs, i)
end

function Explosions:update(dt)
    for i, explode in ipairs(self) do
        explode.life = explode.life - dt
        if explode:enter('tankhull') then
            local collision_data = explode:getEnterCollisionData('tankhull')
            local Target = collision_data.collider:getObject()
            
        end
        if explode.life <= 0 and explode.isoccur then
            explode.isoccur = false
            explode:destroy()
            table.remove(Explosion, i)
        end
    end
end

function OverPressureCheck()
    local hitvalue = math.random()
    local hitPart = 'none'
    local hitArmorside = 'none'
end