SetColliders={}
Size=1

function SetColliders:get(layersname,type,zoom)
    Collider_data={}
    Collider_data.collision={}
    Collider_data.width={}
    Collider_data.height={}

if zoom then
    Size=zoom
end

    if gamemap.layers[layersname] then
        for i, j in pairs(gamemap.layers[layersname].objects) do
            Collider_data.collision[i] = world:newRectangleCollider(j.x, j.y, j.width*Size, j.height*Size)
            Collider_data.width[i]=j.width
            Collider_data.height[i]=j.height
            
            if  type then
                Collider_data.collision[i]:setType(type)
            end
        end
    end

end
    
function SetColliders:draw(Filelocation)
    local Collider_image=love.graphics.newImage(Filelocation)

    for i in pairs(Collider_data.collision)do
        local collider_x,collider_y=Collider_data.collision[i]:getPosition()
        local collider_angle=Collider_data.collision[i]:getAngle()
        local collider_width=Collider_data.width[i]
        local collider_height=Collider_data.height[i]

        love.graphics.draw(Collider_image,collider_x,collider_y,collider_angle,Size/2,Size/2,collider_width,collider_height)
    end
end
