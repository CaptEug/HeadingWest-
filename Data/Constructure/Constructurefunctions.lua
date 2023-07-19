Constructure = {}
Constructure.__index = Constructure

function BuildConstructure(place, constructure, type, x, y)
    local building = {
        name = constructure.name,
        type = type,
        class = constructure.class,
        mode = constructure.mode or nil,
        requirement = constructure.requirement,
        width = constructure.width,
        length = constructure.length,
        vision = constructure.vision,
        image = constructure.image,
        base_image = constructure.base_image,
        anime_sheet = constructure.anime_sheet,
        location = {x = x, y = y},
        functions = {}
    }
    if building.class == 'defence' then
        building.gun_offset = constructure.gun_offset or nil
        building.gun_offset2 = constructure.gun_offset2 or nil
        building.gun_offset3 = constructure.gun_offset3 or nil
        building.turret_offset = constructure.turret_offset or nil
        building.turret_angle = 0
        building.turret_t_speed = constructure.turret_t_speed or nil
        building.ammorack = constructure.ammorack or nil
        building.reload_time = constructure.reload_time or nil
        building.reload_timer = constructure.reload_time or nil
        building.firing_time = constructure.firing_time or nil
        building.firing_timer = 0
        building.turret_anime = anim8.newAnimation(constructure.anime_grid('1-10', 1), 0.1) or nil
        building.turret_location = {}
        building.gun_location = {}
        building.gun_location2 = {}
        building.gun_location3 = {}
    elseif building.class == 'resource' then
        building.steel_production = constructure.steel_production
        building.oil_production = constructure.oil_production
        building.steel_storage = constructure.steel_storage
        building.oil_storage = constructure.oil_storage
        building.steel_stored = constructure.steel_stored
        building.oil_stored = constructure.oil_stored
        building.hitpoint = constructure.hitpoint
        building.armorthickness = constructure.armorthickness
    end
    Steel = Steel - constructure.steel_cost
    Oil = Oil - constructure.oil_cost
    setmetatable(building, Constructure)
    table.insert(place.exsist_building, building)
    ConstructureSpawner:loadBuilding(building, place)
end

function Constructure:Update(dt)
    local x, y = self.location.x, self.location.y
    --button update
    for n, button in ipairs(self.Infobuttons) do
        button.bx, button.by = x + self.width/2, y + self.length/2
    end
    if self.class == 'defence' then
        --location update
        self.turret_location.x, self.turret_location.y = x + self.turret_offset.x, y + self.turret_offset.y
        self.gun_location.x, self.gun_location.y = self.turret_location.x + self.gun_offset.y*math.sin(self.turret_angle) + self.gun_offset.x*math.cos(self.turret_angle),
                                                   self.turret_location.y - self.gun_offset.y*math.cos(self.turret_angle) + self.gun_offset.x*math.sin(self.turret_angle)
        if self.gun_offset2 then
            self.gun_location2.x, self.gun_location2.y = self.turret_location.x + self.gun_offset2.y*math.sin(self.turret_angle) + self.gun_offset2.x*math.cos(self.turret_angle),
                                                         self.turret_location.y - self.gun_offset2.y*math.cos(self.turret_angle) + self.gun_offset2.x*math.sin(self.turret_angle)
        end
        if self.gun_offset3 then
            self.gun_location3.x, self.gun_location3.y = self.turret_location.x + self.gun_offset3.y*math.sin(self.turret_angle) + self.gun_offset3.x*math.cos(self.turret_angle),
                                                         self.turret_location.y - self.gun_offset3.y*math.cos(self.turret_angle) + self.gun_offset3.x*math.sin(self.turret_angle)
        end
        --timer update
        self.reload_timer = self.reload_timer - dt
        self.firing_timer = self.firing_timer - dt
        --functions update
        self.functions.defence(self, dt)
        --anime update
        if self.firing_timer <= 0 then
            self.turret_anime:gotoFrame(1)
        end
        self.turret_anime:update(dt)
    end
    if self.class == 'resource' then
        if self.steel_production and (self.steel_stored < self.steel_storage)then
            self.steel_stored = self.steel_stored + self.steel_production
        end
        if self.oil_production and (self.oil_stored < self.oil_storage)then
            self.oil_stored = self.oil_stored + self.oil_production
        end
    end
end

function Constructure:Draw()
    local x, y = self.location.x + self.width/2, self.location.y + self.length/2
    local imagewidth, imagelength = self.image:getWidth(), self.image:getHeight()
    if self.base_image then
        love.graphics.draw(self.base_image, x, y, 0, 1, 1, imagewidth/2, imagelength/2)
    end
    if self.class == 'defence' then
        self.turret_anime:draw(self.anime_sheet, x, y, self.turret_angle, 1, 1, imagewidth/2, imagelength/2)
    else
        love.graphics.draw(self.anime_sheet, x, y, 0, 1, 1, imagewidth/2, imagelength/2)
    end
    --button use
    if self.type == 'friendly' then
        self.Infobuttons:use()
    end
end

AutoDefenceMode = function (building, dt)
    local alert = false
    local buildingx, buildingy = building.location.x + building.width/2,  building.location.y + building.length/2
    --enemy confirmation
    local enemy = {}
    for i, target in ipairs(CurrentPlace.exsist_tank) do
        if math.sqrt((target.location.x - buildingx)^2 + (target.location.y - buildingy)^2) < building.vision then
            if target.type ~= building.type then
                enemy = target
                alert = true
                break
            end
        end
    end
    if alert then
        local isaim = building:AimCheck(enemy.location.x, enemy.location.y, dt)
        if isaim and building.reload_timer <= 0 then
            if building.mode == 'bomb' then
                Bomb(building, enemy.location.x, enemy.location.y)
            else
                Shoot(building)
            end
        end
    end
end

function Constructure:AimCheck(x, y, dt)
    local isaim = false
    local tx, ty = self.turret_location.x, self.turret_location.y
    local angle_to_target = math.atan2(y - ty, x - tx)
    local ta = self.turret_angle - 0.5*math.pi
    local tspeed = self.turret_t_speed * math.pi/180

    if angle_to_target <= 0 then
        angle_to_target = angle_to_target + math.pi*2
    end
    while ta > 2*math.pi do
        ta = ta - 2*math.pi
    end
    while ta < 0 do
        ta = ta + 2*math.pi
    end

    if ta > angle_to_target then
        if ta - angle_to_target <= math.pi then
            self.turret_angle = self.turret_angle - tspeed*dt
        else
            self.turret_angle = self.turret_angle + tspeed*dt
        end
    end
    if ta < angle_to_target then
        if angle_to_target - ta <= math.pi then
            self.turret_angle = self.turret_angle + tspeed*dt
        else
            self.turret_angle = self.turret_angle - tspeed*dt
        end
    end
    if self.turret_t_angle then
        local l, r = self.turret_t_angle.l/180*math.pi, self.turret_t_angle.r/180*math.pi
        if self.turret_angle > l then
            self.turret_angle = l
        end
        if self.turret_angle < -r then
            self.turret_angle = -r
        end
    end
    if ta < angle_to_target + math.pi/36 and ta > angle_to_target - math.pi/36 then
        isaim = true
    end
    return isaim
end

