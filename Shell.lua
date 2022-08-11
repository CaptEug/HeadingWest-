shells = {}
shells.__index = shells

function shells.new()
    local instance = setmetatable({}, shells)
    return instance
end

function shells.newShell(speed,damege)
    local instance = {
        speed = speed,
        damege = damege
    }
    table.insert(shells, instance)
    return instance
end

function shells:shoot()
    local mx, my = cam:mousePosition(ox,oy,w,h)
    local angle = math.atan2(my - MAUS1.y, mx - MAUS1.x)
    local vx, vy = math.cos(angle) * self.speed,
                   math.sin(angle) * self.speed
    
    local shell = world:newRectangleCollider(MAUS1.x, MAUS1.y - 100, 10, 10)
    shell:setLinearVelocity(vx, vy)
end