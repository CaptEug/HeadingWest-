Airstrike = {}

function Bombing(dt)
    local mx, my = cam:mousePosition()
    local r = 0
    r = r + dt
    local explosion = world:newCircleCollider(mx, my, r)
    if r >= 300 then
        explosion:destroy()
    end
end