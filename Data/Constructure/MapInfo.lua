MapInfo = {};

function MapInfo:Init()
    local dots = {}
    dots.type = {}
    dots.size = {}
    dots.chunks = {}
    if CurrentPlace.map.layers['Boundary'] then
        local place = CurrentPlace.map.layers['Boundary']
        dots.size.x, dots.size.y = place.objects[1].width, place.objects[1].height
        local num_x = dots.size.x / 32
        local num_y = dots.size.y / 32
        dots.name = place.name
        for i = 1, num_x, 1 do
            local row = {}
            local chunkData = 
            {
                type = 'ground'
            }
            for j = 1, num_y, 1 do
                table.insert(row, chunkData)
            end
            table.insert(dots.chunks, row)
        end
    end
    return dots
end


