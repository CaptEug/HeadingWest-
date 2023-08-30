MapInfo = {};
MapInfo.type = {}
MapInfo.size = {x = 1; y = 1;};
MapInfo.chunks = {}

function MapInfo:Init()
    for i, layer in ipairs(CurrentPlace.map.layers) do
        if layer.type =="tilelayer" then
            table.insert(self.type, layer.name)
        elseif layer.name == "Boundary" then
            self.size.x, self.size.y = layer.object.width, layer.object.height
        end
    end
    local num_x = self.size.x / 32
    local num_y = self.size.y /32
    for i = 1, num_x, 1 do
        local row = {}
        local a = 
        {
            type = "resource";
            used = false;
            name = "oil"
        }
        for j = 1, num_y, 1 do
            table.insert(row, a)
        end
        table.insert(self.chunks, row)
    end
    return self
end
