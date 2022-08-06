local Enitity = require "tank_entity"

local tworld = {
    entity = {},
    system = {}
}

function tworld:register(system)
    table.insert(self.system, system)
end

function tworld:creat_tank()
    local entity = Enitity.new()
    table.insert(self.entity, entity)
    return entity
end

function tworld:update(dt)

end

function tworld:draw()

end