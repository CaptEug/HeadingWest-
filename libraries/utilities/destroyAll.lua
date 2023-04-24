function DestroyAll()
    ColliderTableDestroy(Structure)
    ColliderTableDestroy(Obstacles)
    EmptyTable(Ingamebuttons)
end

-- Used for tables of colliders
function ColliderTableDestroy(tableList)
    local i = #tableList
    while i > 0 do
        if tableList[i] ~= nil then
            tableList[i]:destroy()
        end
        table.remove(tableList, i)
        i = i - 1
    end
end

-- Used for tables of standard non-collider tables
function EmptyTable(tableList)
    local i = #tableList
    while i > 0 do
        table.remove(tableList, i)
        i = i - 1
    end
end
