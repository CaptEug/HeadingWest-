local Enitity = require "entity_test.tank_entity"

local tworld = {
    entitis = {},
    systems = {}
}

function tworld:register(system)
    table.insert(self.systems, system)
    return system
end


function tworld:getallwith(requires)
    local entitis = {}
    for i = 1, #self.entitis do
        local ent = self.entitis[i]
        local matches = true
        for j = 1, #requires do
            if ent:get(j) == nil then
                matches = false
            end
        end 
        if matches then table.insert(matched, ent) end
    end
    return matches
end

function tworld:assemble(components)
    local ent = self:create_tank()
    for i, v in ipairs(components) do 
        assert(type(v) == "table", "World:: assemble require a table of tables")
        assert(#v > 0)
        local fn = v[1]
        assert(type(fn) == "function")
        if #v == 1 then
            ent:add(fn())
        else
            local args ={}
            for i = 2, #v do
                table.insert(args, v[i])
            end
            ent:add(fn(unpack(args)))
        end
    end
    return ent
end

function tworld:create_tank()
    local entity = Enitity.new()
    table.insert(self.entitis, entity)
    return entity
end
player = {}

function tworld:update(dt)
    for i = #self.entitis, 1, -1 do
        local entity = self.entitis[i]
        if entity.remove then
            for i, system in ipairs(self.systems) do
                if system:match(entity) then
                    system:destroy(entity)
                end
            end
            table.remove(self.entitis, i)
        else
            for i, system in ipairs(self.systems) do
                if system:match(entity) then
                    if entity.loaded == false then
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
        local entity = self.entitis[i]
        for i, system in ipairs(self.systems) do
            if system:match(entity) then
                system:draw(entity)
            end
        end
    end

end

return tworld