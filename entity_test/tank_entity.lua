return{
    new = function()
        local entity = {
            components = {},
            tag = {},
            remove = false,
            loaded = false,
        }

        function entity:add(component)
            assert(component.__id)
            self.components[component.__id] = component
        end

        function entity:get(id)
            return self.components[id]
        end

        function entity:destroy()
            self.remove = true
        end

        return entity
    end
}