MapInfo = {};
MapInfo.type = {}
MapInfo.size = {x = 0; y = 0;};
MapInfo.chunks = {}

function MapInfo:Init()
    for i, layer in ipairs(CurrentPlace.layers) do
        if layer.type =="tilelayer" then
            table.insert(self.type, layer.name)
        elseif layer.name == "Boundary" then
            self.size.x, self.size.y = layer.objects.width, layer.objects.height
        end
    end
    local num_x = self.size.x / 32
    local num_y = self.size.y /32
    for i = 1, num_x, 1 do
        for j = 1, num_y, 1 do
            self.chunks[i][j] = {1}
        end
    end
    
end
