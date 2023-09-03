MapInfo = {};

function MapInfo:Init()
    local dots = {}
    dots.type = {}
    dots.size = {}
    dots.chunks = {}
    if CurrentPlace.map.layers['Boundary'] then
        NoBoundary = false
        local place = CurrentPlace.map.layers['Boundary']
        dots.size.x, dots.size.y = place.objects[1].width, place.objects[1].height
        local num_x = dots.size.x / 32
        local num_y = dots.size.y / 32
        dots.name = place.name
        for i = 1, num_x, 1 do
            local row = {}
            local chunkData = 
            {
                type = 'ground';
                occupied = false;
                name = 'grass';
            }
            for j = 1, num_y, 1 do
                table.insert(row, chunkData)
            end
            table.insert(dots.chunks, row)
        end    
    else
        NoBoundary = true
    end
    return dots
end

function MapInfo:FindChunk(x, y)
    local numX = x / 32
    local numY = y / 32
    return MAP[numX][numY]
end

function MapInfo:getInfo(x, y)
    local chunk = self:FindChunk(x, y)
    return chunk
end

function MapInfo:Occupy(x, y, object)
    local numX = x / 32
    local numY = y / 32
    local width = object.w / 32
    local height = object.h / 32
    if object.type == 'Rectangle' then
        for i = 0, width - 1, 1 do
            for j = 0, height - 1, 1 do
                MAP[numX + i][numY + j].occupied = true
            end
        end 
    end
end