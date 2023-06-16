return{
    new = function(requires)
        assert(type(requires) == "table")
        local system = {
            requires = requires
        }

        function system:load(entity)
        end
        function system:update(dt, entity)
        end
        function system:draw(entity)       
        end 
        function system:destroy(entity)    
        end 

        function system:match(entity)
            for i = 1, #self.requires do
                if entity:get(self.requires[i]) == nil then
                    return false
                end
            end
            return true
        end

        return system
    end
}