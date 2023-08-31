MapInfo = {};
MapInfo.type = {}
MapInfo.size = {}
MapInfo.chunks = {}

function MapInfo:Init()
    if CurrentPlace.map.layers['Boundary'] then

        self.size.x, self.size.y = CurrentPlace.map.layers['Boundary'].objects[1].width, CurrentPlace.map.layers['Boundary'].objects[1].height
        local num_x = self.size.x / 32
        local num_y = self.size.y / 32
        for i = 1, 10, 1 do
            local row = {}
            local a = 1
            for j = 1, 10, 1 do
                table.insert(row, a)
            end
            table.insert(self.chunks, row)
        end
    end
    
    for i = 1, 10, 1 do
        local row = {}
        local a = 1
        for j = 1, 10, 1 do
            table.insert(row, a)
        end
        table.insert(self.chunks, row)
    end
    return self.chunks
end
