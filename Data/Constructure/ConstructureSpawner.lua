ConstructureSpawner = {}

function ConstructureSpawner:loadBuilding(building, place)
    local x, y = building.location.x, building.location.y
    building.collider = CurrentPlace.world:newRectangleCollider(x, y, building.width, building.length)
    building.collider:setType('static')
    building.collider:setCollisionClass('Constructure')
    if building.class == 'defence' then
        building.functions.defence = AutoDefenceMode
    end
    if building.type == 'friendly' then
        building.openinfopenal = false
        building.Infobuttons = buttons.new()
        buttons.newCamBoxButton(
            building.width,
            building.length,
            function ()
                
            end,
            function ()
                building.openinfopenal = true
            end,
            function ()
                building.openinfopenal = false
            end,
            building.Infobuttons
        )
    end
end

function ConstructureSpawner:update(dt)
    for i, building in ipairs(CurrentPlace.exsist_building) do
        building:Update(dt)
    end
end

function ConstructureSpawner:drawbuilding()
    for i, building in ipairs(CurrentPlace.exsist_building) do
        building:Draw()
        --draw vision circle
        love.graphics.circle("line", building.location.x + building.width/2, building.location.y + building.length/2, building.vision)
    end
end