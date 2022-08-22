require  "entity_test.common_componet"
local System = require "entity_test.tank_system"

return{
    new_renderer_system = function()
        local render = System.new {"location", "hull", "move", "rotation_data", "move_data", "turret", "tankammo", "turret_rdata"}
    
        function render:load(entity)
            local hull = entity:get "hull"
            local location = entity:get "location"
            local move = entity:get "move"
        end
    
        function render:update(dt, entity)
            local hull = entity:get "hull"
            local location = entity:get "location"
            local move = entity:get "move"
            local turret = entity:get "turret"
            local cos = math.cos(move.angle)
            local sin = math.sin(move.angle)
            location.x = hull.hitbox:getX() 
            location.y = hull.hitbox:getY() 
            move.angle = hull.hitbox:getAngle() 
         
        end
    
        function render:draw(entity) 
            local hull = entity:get "hull"
            local turret = entity:get "turret"
            local location = entity:get "location"
            local move = entity:get "move"
            local tur = entity:get "turret_rdata"
            love.graphics.draw(hull.picture, location.x, location.y, move.angle, 0.2, 0.2, hull.weight/2, hull.height/2)
            love.graphics.draw(turret.picture, turret.x, turret.y, tur.angle, 0.2, 0.2, turret.weight/2, turret.height/2)
        end
        return render
    end,

    new_functional_system = function()
        local system = System.new {"functional"}
        
        function system:update(dt, entity) 
            local fn = entity:get ("functional").fn
            fn(entity, dt)
        end
        return system
    end
}