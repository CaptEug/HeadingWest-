require "ExampleSaving"

NewSaving = {
    
}

function NewSaving:CreateFile(Number)

    love.filesystem.write("file"..tostring(Number)..".lua",TableToString(FileData,"SaveData"))

end

function NewSaving:LoadFile(Number)
    
    local filename = "file"..tostring(Number)..".lua"

    if love.filesystem.getInfo(filename)==nil then
        NewSaving:CreateFile(Number)
    end

    SaveData = love.filesystem.load(filename)
    SaveData()
end

function NewSaving:LoadResource() --use this after LoadFile()

    local Resources = SaveData.Resources
    Oil = Resources.Oil
    Steel = Resources.Steel

end

function NewSaving:SaveTanks()
    
    local tankData = {}

    for i, city in ipairs(Cities) do
        local cityTanks = city.exsist_tank
        local cityName = city.name
        local tanks = {}
        for i, tank in ipairs(cityTanks) do
            local tankInfo = {}
            tankInfo.location = {}
            tankInfo.location.x, tankInfo.location.y = tank.location.x-tank.width/2, tank.location.y-tank.length/2
            tankInfo.location.hull_angle = tank.location.hull_angle
            tankInfo.status = tank.status
            tankInfo.name = tank.name
            tankInfo.type = tank.type
            tankInfo.number = tank.number
            tankInfo.armor = tank.armor.name
            tankInfo.aim = tank.aim.name
            tankInfo.mob = tank.mob.name
            tankInfo.crew = tank.crew
            tankInfo.ammorack = self:ScanAmmo(tank.ammorack)
            table.insert(tanks,tankInfo)
        end

        local city = {}
        city.cityName = cityName
        city.tankData = tanks
        table.insert(tankData,city)

    end
    return tankData
end

function NewSaving:Save(Number)

    local filename = "file"..tostring(Number)..".lua"

    local filedata ={}

    filedata.Resources={
        Oil = Oil;
        Steel = Steel;
    }

    filedata.FileNumber = Filenumber

    filedata.EventProgress = {
        Progress = 1 
    }

    filedata.ExistTanks = self:SaveTanks()

    love.filesystem.write(filename,TableToString(filedata,"SaveData"))
end

function NewSaving:CreateSettings()
    local filedata={}
    filedata.resolution=false
    filedata.volume=1
    filedata.ww=800
    filedata.wh=600
    filedata.flags={
        fullscreen=false,
        fullscreentype="desktop",
        display=1,
        stencil=true,
        depth=0,
        refreshrate=144,
        vsync=1,
        msaa=0,
        borderless=false,
        resizable=true,
        centered=true,
        highdpi=false,
        usedpiscale=true,
        x=560,
        y=140,
        minwidth=1,
        minheight=1
    }
    
    love.filesystem.write("SettingData.lua", TableToString(filedata,'SettingData'))
end

function NewSaving:SaveSettings()
    local filedata={}
    filedata.resolution=love.window.getFullscreen()
    filedata.volume=love.audio.getVolume()
    if filedata.resolution==false then
        local ww,wh,flags =love.window.getMode()
        filedata.ww=ww
        filedata.wh=wh
        filedata.flags=flags
    end
    love.filesystem.write("SettingData.lua", TableToString(filedata,'SettingData'))
end

function NewSaving:LoadSettings()

    if love.filesystem.getInfo("SettingData.lua")==nil then
        NewSaving:CreateSettings()
    end
    SettingData=love.filesystem.load("SettingData.lua")
    SettingData()
    love.audio.setVolume(SettingData.volume)
    love.window.setFullscreen(SettingData.resolution)
    if SettingData.resolution==false then
        love.window.setMode(SettingData.ww,SettingData.wh,SettingData.flags)
    end

end

---TableToString
---@param table table
---@param tableName string
---@return string
function TableToString(table,tableName) --convert table to string

    local function Convert(input,layer)

        local str = ""
        for key, value in pairs(input) do
            
            local keyValue = ""
            local convertedKey = ""
            local keyName = tostring(key)      
            if type(key) == "number" then
                keyName = "["..tostring(key).."]"
            end
            if type(value) ~= "table" then
                if type(value) ~= "string" then
                    keyValue = tostring(value)
                else
                    keyValue = "\""..value.."\""
                end
                convertedKey = keyName.." = "..keyValue..";\n"
            else if type(value)~= "function" then
                layer = layer+1
                keyValue,layer = Convert(value,layer)
                convertedKey = keyName.." = {\n"..keyValue
                for i = 0, layer, 1 do
                    convertedKey = convertedKey.."    "
                end
                convertedKey = convertedKey.."};\n"
                else
    
                end
            end
            for i = 0, layer, 1 do
                convertedKey = "    "..convertedKey
            end
            str = str..convertedKey
        end
        layer = layer - 1
        return str,layer
    end
    local str = tableName.." = {\n"..Convert(table,0).."};\n"
    return str
end

function NewSaving:LoadTanks()

    local tankdata = {}
    for citynumber, city in ipairs(SaveData.ExistTanks) do
        if city.cityName == CurrentPlace.name then
            tankdata = city.tankData
            break
        end
    end
    for tankNumber, data in ipairs(tankdata) do     --select tank

        local name = data.name
        local tank = {}
        local ammorack = {}
        for i, t in pairs(Tanks) do                 --match default tank 
            if t.name == name and t.accessories ~= nil then               --match accessories
                tank = Tanks[i]
                for i, armor in pairs(tank.accessories[1]) do
                    if  data.armor==armor.name then
                        tank.armor = copytable(armor)
                        break
                    end
                end
                for i, aim in pairs(tank.accessories[2]) do
                    if  data.aim==aim.name then
                        tank.aim = copytable(aim)
                        break
                    else

                    end
                end
                for i, mob in pairs(tank.accessories[3]) do
                    if  data.mob==mob.name then
                        tank.mob = copytable(mob)
                        break
                    end
                end
            end
        end
        for i, ammo in pairs(data.ammorack) do
            for j = 1, ammo.number, 1 do
                local a = copytable(ammo)
                a.number = nil
                table.insert(ammorack,a)
            end
        end
        tank.ammorack = ammorack
        tank.crew = data.crew
        tank.number = data.number
        tank.status = data.status
        tank.location = data.location
        tank.type = data.type
        Buildtank(CurrentPlace, tank)
    end
end

function NewSaving:ScanAmmo(ammorack)
    local ammos = {}
    for i, ammo in pairs(ammorack) do
        local match = false
        for j, a in pairs(ammos) do      --search name, match
            if ammo.name == a.name then
                match = true
                a.number = a.number +1
            end
        end
        if match == false and ammo ~= nil then
            local amm = copytable(ammo)
            amm.number = 1
            table.insert(ammos,amm)
        end
    end
    return ammos
end

--[[function NewSaving:Loadtank(place, tank, data, type, x, y)
    local tanky = {
        type = type,
        number = data.number,
        name = tank.name,
        class = tank.class,
        width = tank.width,
        length = tank.length,
        weight = tank.weight,
        crew = tank.crew,
        survivor = tank.crew,
        reload_time = tank.reload_time,
        reload_timer = tank.reload_time,
        m_reload_time = tank.m_reload_time or nil,
        m_reload_timer = tank.m_reload_time or nil,
        deploy_time = tank.deploy_time or nil,
        deploy_timer = -1,
        fuel = tank.fuel_capacity,
        fuel_capacity = tank.fuel_capacity,
        fuel_cosumption = tank.fuel_cosumption,
        ammorack_size = tank.ammorack_size,
        ammorack = copytable(tank.ammorack or {}),
        missilerack_size = tank.missilerack_size,
        missilerack = copytable(tank.missilerack or {}),
        armorthickness = tank.armorthickness,
        innerstructure = tank.innerstructure,
        max_f_speed = tank.max_f_speed,
        max_r_speed = tank.max_r_speed,
        turret_t_speed = tank.turret_t_speed,
        turret_t_angle = tank.turret_t_angle or nil,
        vision = tank.vision,
        hull_image = tank.hull_image,
        hull_image_line = tank.hull_image_line,
        hull_image_broken = tank.hull_image_broken,
        turret_image = tank.turret_image,
        turret_image_line = tank.turret_image_line,
        turret_image_broken = tank.turret_image_broken,
        anime_sheet = tank.anime_sheet,
        turret_anime = anim8.newAnimation(Tank_Grid('1-7', 1), 0.1),
        firing_anime = anim8.newAnimation(Tank_Grid('1-7', 1), 0.1),
        deploy_anime = anim8.newAnimation(Tank_Grid('1-7', 2), 0.2),
        gun_sound = tank.gun_sound:clone(),
        image_offset = tank.image_offset,
        turret_offset = tank.turret_offset,
        gun_offset = tank.gun_offset,
        engine_offset = tank.engine_offset,
        exhaust_offset = tank.exhaust_offset,
        exhaust_offset2 = tank.exhaust_offset2 or nil,
        exhaust_angle = tank.exhaust_angle,
        exhaust_angle2 = tank.exhaust_angle2 or nil,
        turret_angle = 0,
        armor = data.armor,
        aim = copytable(tank.accessories[2][tank.aim_num or 1] or Blank_Gear),
        mob = data.mob,
        velocity = {vx = 0, vy = 0, v = 0},
        location = {x = x, y = y, hull_angle = data.location.hull_angle},
        image_location = {},
        turret_location = {},
        gun_location = {},
        engine_location = {},
        exhaust_location = {},
        exhaust_location2 = {},
        functions = {},
        Infobuttons = {},
        status = {
            dead = {false},
            onfire = {false, Onfire_icon},
            immobilized = {false, Immobilized_icon},
            era = {false, ERA_icon}
        },
        firing_time = tank.firing_time,
        firing_timer = 0,
        picked = false,
        incomp = false,
        deployed = false
    }
    if type == 'enemy' then
        while #tanky.ammorack < tanky.ammorack_size do
            table.insert(tanky.ammorack, tank.ammunition[1])
        end
        if tank.missilerack_size then
            while #tanky.missilerack < tanky.missilerack_size do
                for i, ammo in ipairs(tank.ammunition) do
                    if ammo.type == 'ATGM' then
                        table.insert(tanky.missilerack, ammo)
                    end
                end
            end
        end
    end
    setmetatable(tanky, Tank)
    table.insert(place.exsist_tank, tanky)
    TankSpawner:loadtank(place, tanky)
end]]