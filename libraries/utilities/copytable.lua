function copytable(t)
    local instance = {}
    for k, v in pairs(t) do
        instance[k] = v
    end
    return instance
end

function add3dmatrix(t1, t2)
    local instance = {}
    for i = 1, #t1 do
        instance[i] = {}
        for j = 1, #t1[1] do
            instance[i][j] = {}
            for k = 1, #t1[1][1] do
                instance[i][j][k] = t1[i][j][k] + t2[i][j][k]
            end
        end
    end
    return instance
    
end