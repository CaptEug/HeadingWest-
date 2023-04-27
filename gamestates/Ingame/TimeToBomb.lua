Explosions = {}

function Bomb(unit, x, y)
    local bomb = unit.ammorack[1]
    local ux, uy = unit.image_location.x, unit.image_location.y
    local distance = math.sqrt((x-ux)^2 + (y-uy)^2)
    bomb.timer = distance/(bomb.velocity/2)
    

    table.insert(Explosions, bomb)
end

function Explosions:update(dt)
    for i, bomb in ipairs(self) do
        bomb.timer = bomb.timer - dt
        if bomb.timer <= 0 then
            local n = 0
            while n < 5 do
                local explode = world:newCircleCollider(mx, my, math.random(10,50))
                explode:setCollisionClass('Explosion')
                explode:applyLinearImpulse(math.random(-2000,2000),math.random(-2000,2000))
                explode.damage = 800
                explode.life = 1
                explode.isoccur = true
                table.insert(Explosion, explode)
                count = count + 1
            end
        end
    end
end
function Expolde()
    
end