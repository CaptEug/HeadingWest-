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

        local citydata = {}
        citydata.cityName = cityName
        citydata.tankData = tanks
        table.insert(tankData,citydata)

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