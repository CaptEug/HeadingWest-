local Component = require "tank_component"


return{
    

    new_location = function(x, y)
        local location = Component.new "location"
        location.x = x
        location.y = y
        return location
    end,

    new_bodywork = function(bodywork_path)
        local bodywork = Component.new "bodywork"
        bodywork.picture = love.graphics.newImage(bodywork_path)
        bodywork.weight, bodywork.height = bodywork.picture:getDimensions()
        bodywork.hitbox = world:newRectangleCollider(0, 0, bodywork.weight*0.2, bodywork.height*0.2)
        return bodywork
    end,

    functional = function(fn)
        local functional = Component.new "functional"
        functional.fn = fn
        return functional
    end

}