Airstrike = {}
Explosion = {}

function Bombing(dt)
    local mx, my = cam:mousePosition()
   
    local count = 1
    
    while count < 4 do
        local explode = world:newCircleCollider(mx, my, math.random(100,300))
        explode:setCollisionClass('Explosion')
        explode.damage = 800
        explode.life = 1
        table.insert(Explosion, explode)
        count = count + 1
    end
    

    
end

function Airstrike:update(dt)
    for i, explode in ipairs(Explosion) do
        explode.life = explode.life - dt
        if explode:enter('Amour') then
            local collision_data = explode:getEnterCollisionData('Amour')
            local Target = collision_data.collider:getObject()
            Target.hp = Target.hp - explode.damage
        end
        if explode.life <= 0 then
            explode:destroy()
        end
    end
end