local t_world = require 'entity_test.world'
local Component = require "entity_test.tank_component"
local coms = require  "entity_test.common_componet"
local syfn = require  "entity_test.tank_sy_fn"
wf = require 'entity_test.windfield'
location_t = coms.new_location
bodywork_t = coms.new_bodywork
move_t = coms.move
rotation_data_t = coms.rotation_data
move_data_t = coms.move_data
turret_t = coms.new_turret
turret_rdata_t = coms.turret_rdata
keybroadcontrol = coms.movetype




world = wf.newWorld(0, 0)

Tanks = {}
Tanks.__index = Tanks

local qun = {}


function stringToTable(str)
    local ret = loadstring("return "..str)()
    return ret
end

function isInArray(t, val)
	for _, v in ipairs(t) do
		if v == val then
			return v
		end
	end
	return false
end

function Tanks.new()
    local instance = setmetatable({}, Tanks)
    return instance
end

function Tanks:newtank(data, x, y)
    t_world:register(syfn.new_renderer_system())
    t_world:register(syfn.new_functional_system())
    local a,b = love.filesystem.read( data, all )
    local h = stringToTable(a)
    local entity = t_world:assemble(h)
    table.insert(qun, entity)
    local body = entity:get "bodywork"
    body.hitbox:setX(x)
    body.hitbox:setY(y)
    return entity
end

function Tanks:addai(entity, ai)
    local test = isInArray(qun, entity)
    test:add(coms.functional(ai))
end

function Tanks:gettank(entity)
    for _, v in ipairs(qun) do
        if v == entity then
            return true
        end
    end
    return false
end

function Tanks:destroytank(entity)
    for _, v in ipairs(qun) do
        if v == entity then
            table.remove(qun, 1)
        end
    end
end

function Tanks:getdata(entity)
    local location = entity:get "location"
    local move = entity:get "move"
    return location.x, location.y, move.anlge
end

     
function Tanks:update(dt)
    t_world:update(dt)
    world:update(dt)
end

function Tanks:draw()
    t_world:draw()
    
end