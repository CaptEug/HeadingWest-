return{
    new = function{}
        local entity = {
            components = {},
            tag = {},
            remove = true,
            loaded = false,
        }
        return entity

        function entity:add(component)
            assert(component.__id)
            self.components[component.__id] = component
        end

        function entity:get(id)
            return components[id]
        end

        function entity:destroy()
            self.remove = true
        end
    end
}