function copytable(t)
    local instance = {}
    for k, v in pairs(t) do
        instance[k] = v
    end
    return instance
end