ConstructManager = {}

function ConstructManager:query(object)
    local canBuild = true
    local width, length = object.preBuild.width - 2, object.preBuild.length - 2
    local x = IntX + 1
    local y = IntY + 1
    for i, obj in ipairs(CurrentPlace.exsist_building) do
        local objX = obj.location.x
        local objY = obj.location.y
        if x >= objX and x <= objX + obj.preBuild.width and y >= objY and y <= objY + obj.preBuild.length then
            canBuild = false
        end
        if  x + width >= objX and x + width <= objX + obj.preBuild.width and y >= objY and y <= objY + obj.preBuild.length then
            canBuild = false
        end
        if x + width >= objX and x + width <= objX + obj.preBuild.width and y + length >= objY and y + length <= objY + obj.preBuild.length then
            canBuild = false
        end
        if  x >= objX and x <= objX + obj.preBuild.width and y + length >= objY and y + length <= objY + obj.preBuild.length then
            canBuild = false
        end
        if canBuild ==false then
            break
        end
    end
    return canBuild
end