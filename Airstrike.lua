Airstrike = {}

function Bombing(dt)
    local mx, my = cam:mousePosition()
    local r = 0
    r = r + dt
    world:newCircleCollider(mx, my, r)
end