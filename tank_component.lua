return{
    new = function{id}
        assert(id)
        local component = {_id = id}
        return component
    end
}