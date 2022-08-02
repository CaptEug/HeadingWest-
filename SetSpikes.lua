SetSpikes={}
local spike_image=love.graphics.newImage('objects/Spike1.png')

function SetSpikes:get(layersname,type)
    Spike_data={}
    
    Spike_data.collision={}
    Spike_data.width=128
    Spike_data.height=128

    if gamemap.layers[layersname] then
        for i, j in pairs(gamemap.layers[layersname].objects) do
            Spike_data.collision[i] = world:newRectangleCollider(j.x, j.y, j.width, j.height)
        end
    end

end
    
function SetSpikes:draw()
    for i in pairs(Spike_data.collision)do
        local spike_x,spike_y=Spike_data.collision[i]:getPosition()
        local spike_angle=Spike_data.collision[i]:getAngle()
        love.graphics.draw(spike_image,spike_x,spike_y,spike_angle,0.5,0.5,Spike_data.width,Spike_data.height)
    end
end
