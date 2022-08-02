SetColliders={}

function SetColliders:get(layersname,type)
    Collider_data={}
    Collider_data.collision={}
    Collider_data.width=128
    Collider_data.height=128

    if gamemap.layers[layersname] then
        for i, j in pairs(gamemap.layers[layersname].objects) do
            Collider_data.collision[i] = world:newRectangleCollider(j.x, j.y, j.width, j.height)
            if  type then
                Collider_data.collision[i]:setType(type)
            end
        end
    end

end
    
function SetColliders:draw(Filelocation)
    local Collider_image=love.graphics.newImage(Filelocation)

    for i in pairs(Collider_data.collision)do
        local spike_x,spike_y=Collider_data.collision[i]:getPosition()
        local spike_angle=Collider_data.collision[i]:getAngle()
        love.graphics.draw(Collider_image,spike_x,spike_y,spike_angle,0.5,0.5,Collider_data.width,Collider_data.height)
    end
end
