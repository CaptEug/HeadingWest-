Shell = {}

function createshell()
    local speed = 2560
    local mx, my = cam:mousePosition(ox,oy,w,h)
    local angle = math.atan2(my - MAUS1.y, mx - MAUS1.x)
    local vx, vy = math.cos(angle) * speed,
                   math.sin(angle) * speed
    local shell = world:newRectangleCollider(MAUS1.x, MAUS1.y, 10, 10)
    shell:setCollisionClass('MAUS1shell')
    shell:setLinearVelocity(vx, vy)
end