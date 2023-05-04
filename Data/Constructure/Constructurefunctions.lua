Constructure = {}

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
        gun_offset = constructure.gun_offset or nil,
        gun_offset2 = constructure.gun_offset2 or nil,
        gun_offset3 = constructure.gun_offset3 or nil,
        turret_offset = constructure.turret_offset or nil,
        turret_angle = 0,
        turret_t_speed = constructure.turret_t_speed or nil,
        steel_production = constructure.steel_production,
        oil_production = constructure.oil_productioon,
        hitpoint = constructure.hitpoint,
        armorthickness = constructure.armorthickness,
        ammorack = constructure.ammorack or nil,
        reload_time = constructure.reload_time or nil,
        reload_timer = constructure.reload_time or nil,
        firing_time = constructure.firing_time or nil,
        firing_timer = 0,
        image = constructure.image,
        base_image = constructure.base_image,
        anime_sheet = constructure.anime_sheet,
        turret_anime = anim8.newAnimation(constructure.anime_grid('1-10', 1), 0.1) or nil,
        location = {x = x, y = y},
        turret_location = {},
        gun_location = {},
        gun_location2 = {},
        gun_location3 = {},
        functions = {}
    }
    Steel = Steel - constructure.steel_cost
    Oil = Oil - constructure.oil_cost
    setmetatable(building, Constructure)
    Constructure.__index = Constructure
    table.insert(place.exsist_building, building)
    ConstructureSpawner:loadBuilding(building, place)
end

function Constructure:Update(dt)
    local x, y = self.location.x, self.location.y
    if self.class == 'defence' then
        --location update
        self.turret_location.x, self.turret_location.y = x - self.turret_offset, y + self.turret_offset
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
end

function Constructure:Draw()
    local x, y = self.location.x, self.location.y
    local center = self.image:getWidth()/2
    if self.base_image then
        love.graphics.draw(self.base_image, x, y, 0, 1, 1, center, center)
    end
    self.turret_anime:draw(self.anime_sheet, x, y, self.turret_angle, 1, 1, center, center)
end

AutoDefenceMode = function (building, dt)
    local alert = false
    --enemy confirmation
    local enemy = {}
    for i, target in ipairs(CurrentPlace.exsist_tank) do
        if math.sqrt((target.location.x - building.location.x)^2 + (target.location.y - building.location.y)^2) < building.vision then
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

