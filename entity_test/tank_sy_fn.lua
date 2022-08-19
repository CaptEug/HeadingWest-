require  "entity_test.common_componet"
local System = require "entity_test.tank_system"

return{
    new_renderer_system = function()
        local render = System.new {"location", "bodywork", "move", "rotation_data", "move_data", "turret","turret_rdata"}
    
        function render:load(entity)
            local bodywork = entity:get "bodywork"
            local location = entity:get "location"
            local move = entity:get "move"
            MAUS_Ammo = Ammo.new()
            APCBC_128mm = Ammo.newShell(25600,0,MAUS_Ammo)
            Reload_time = 1
            Reload_timer = 0
        end
    
        function render:update(dt, entity)
            local bodywork = entity:get "bodywork"
            local location = entity:get "location"
            local move = entity:get "move"
            location.x = bodywork.hitbox:getX() 
            location.y = bodywork.hitbox:getY() 
            move.angle = bodywork.hitbox:getAngle() 
        end
    
        function render:draw(entity) 
            local bodywork = entity:get "bodywork"
            local turret = entity:get "turret"
            local location = entity:get "location"
            local move = entity:get "move"
            local tur = entity:get "turret_rdata"
            love.graphics.draw(bodywork.picture, location.x, location.y, move.angle, 0.2, 0.2, bodywork.weight/2, bodywork.height/2)
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