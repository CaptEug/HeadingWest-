Constructure = {}

function BuildConstructure(place, constructure, x, y)
    local building = {
        name = constructure.name,
        type = constructure.type,
        requirement = constructure.requirement,
        width = constructure.width,
        length = constructure.length,
        oil_productioon = constructure.oil_productioon,
        hitpoint = constructure.hitpoint,
        image = constructure.image,
        anime_sheet = constructure.anime_sheet,
        buildtime = constructure.buildtime,
        fixedbuildtime = constructure.buildtime,
        location = {x = x, y = y},
    }
    setmetatable(building, Constructure)
    Constructure.__index = Constructure
    table.insert(place.exsist_building, building)
    ConstructureSpawner:loadBuilding(building, place)
end

function Constructure:Update(dt)
    
end

function Constructure:Draw()
    local x, y = self.location.x, self.location.y
    love.graphics.draw(self.image, x, y)
end

