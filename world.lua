local Enitity = require "tank_entity"

local tworld = {
    entitis = {},
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
    for i = #self.entitis, 1, -1 do
        local entity = self.entitis[i]
        if entity.remove then
            for i system in ipairs(self.system) do
                if system:match(entity) then
                    system:destroy(entity)
                end
            end
        end
        table.remove(self.entitis, i)
        else
            for i system in ipairs(self.system) do
                if system:match(entity) then
                    if entity.loaded = false then
                        system:load(entity)
                    end
                    system:update(dt, entity)
                end
            end
            entity.loaded = true
        end
    end
end

function tworld:draw()
    for i = 1, #self.entitis do
        for i system in ipairs(self.system) do
            if system:match(entity) then
                system:draw(entity)
            end
        end
    end

end
