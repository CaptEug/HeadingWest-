require  "common_componet"
local System = require "tank_system"

return{
    new_renderer_system = function()
        local render = System.new {"location", "bodywork"}
    
        function render:load(entity)
            local bodywork = entity:get "bodywork"
            local location = entity:get "location"
            bodywork.hitbox:setX(location.x)
            bodywork.hitbox:setY(location.y)
        end
    
        function render:update(dt, entity)
            local bodywork = entity:get "bodywork"
            local location = entity:get "location"
            location.x = bodywork.hitbox:getX() 
            location.y = bodywork.hitbox:getY() 
        end
    
        function render:draw(entity) 
            local bodywork = entity:get "bodywork"
            local location = entity:get "location"
            love.graphics.draw(bodywork.picture, location.x, location.y, 0, 0.2, 0.2, bodywork.weight/2, bodywork.height/2)
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
    end,

    aaaa = function(self, dt)
        local bodywork = self:get "bodywork"
        bodywork.hitbox:setLinearVelocity(100, 0)
    end
}