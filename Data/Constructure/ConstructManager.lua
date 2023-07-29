ConstructManager = {}

function ConstructManager:query(object)
    local canBuild = true
    local width, length = object.preBuild.width - 2, object.preBuild.length - 2
    local x = IntX - (object.preBuild.width-object.width)/2 + 1
    local y = IntY - (object.preBuild.length-object.length)/2 + 1
    for i, obj in ipairs(CurrentPlace.exsist_building) do
        local objX = obj.location.x - (obj.preBuild.length-obj.length)/2
        local objY = obj.location.y - (obj.preBuild.length-obj.length)/2
        if x >= objX and x <= objX + obj.preBuild.width and y >= objY and y <= objY + obj.preBuild.length then
            canBuild = false
            break
        end
        if  x + width >= objX and x + width <= objX + obj.preBuild.width and y >= objY and y <= objY + obj.preBuild.length then
            canBuild = false
            break
        end
        if x + width >= objX and x + width <= objX + obj.preBuild.width and y + length >= objY and y + length <= objY + obj.preBuild.length then
            canBuild = false
            break
        end
        if  x >= objX and x <= objX + obj.preBuild.width and y + length >= objY and y + length <= objY + obj.preBuild.length then
            canBuild = false
            break
        end
        if objX >= x and objX <= x + width and objY >= y and objY <= y + length then
            canBuild = false
            break
        end
        if  objX + obj.preBuild.width >= x and objX + obj.preBuild.width <= x + width and objY >= y and objY <= y + length then
            canBuild = false
            break
        end
        if objX + obj.preBuild.width >= x and objX + obj.preBuild.width <= x + obj.width and objY + obj.preBuild.length >= y and objY + obj.preBuild.length <= y + length then
            canBuild = false
            break
        end
        if  objX >= x and objX <= x + width and objY + obj.preBuild.length >= y and objY + obj.preBuild.length <= y + length then
            canBuild = false
            break
        end
    end
    return canBuild
end

function ConstructManager:drawPreBuild()
    for i, obj in ipairs(CurrentPlace.exsist_building) do
        local x, y = cam:cameraCoords(obj.location.x, obj.location.y)
        if ConstructMenu.canBuild then
            love.graphics.setColor(0, 1, 0, 0.6)
        else
            love.graphics.setColor(1, 0, 0, 0.6)
        end
        love.graphics.rectangle('fill', x - (obj.preBuild.width-obj.width)/2*cam.scale, y - (obj.preBuild.length-obj.length)/2*cam.scale, obj.preBuild.width*cam.scale,obj.preBuild.length*cam.scale)
        love.graphics.setColor(1, 1, 1, 1)
    end
end