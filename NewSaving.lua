require "ExampleSaving"

NewSaving = {
    
}

function NewSaving:CreateFile(Number)

    love.filesystem.write("file"..tostring(Number)..".lua",TableToString(FileData))

end

function NewSaving:LoadFile(Number)
    
    local filename = "file"..tostring(Number)..".lua"

    if love.filesystem.getInfo(filename)==nil then
        NewSaving:CreateFile(Number)
    end

    LoadedData = love.filesystem.load(Number)

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
        resizable=false,
        centered=true,
        highdpi=false,
        usedpiscale=true,
        x=560,
        y=140,
        minwidth=1,
        minheight=1
    }
    
    love.filesystem.write("SettingData.lua", table.show(filedata,'SettingData'))
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
    love.filesystem.write("SettingData.lua", table.show(filedata,'SettingData'))
end

function NewSaving:LoadSettings()

    if love.filesystem.getInfo("SettingData.lua")==nil then
        Saving:CreateSettings()
    end
    SettingData=love.filesystem.load("SettingData.lua")
    SettingData()
    love.audio.setVolume(SettingData.volume)
    love.window.setFullscreen(SettingData.resolution)
    if SettingData.resolution==false then
        love.window.setMode(SettingData.ww,SettingData.wh,SettingData.flags)
    end

end

---test convert
---@param table table
---@param tableName string
---@return string
function TableToString(table,tableName) --convert table to string (prototype)

    local str = tableName.." = {\n"..Convert(table,0).."};\n"
    return str

end

function Convert(table,layer)

    local str = ""
    for key, value in pairs(table) do
        
        local keyName = tostring(key)
        local keyValue 
        local convertedKey
        if type(value) ~= "table" then
            keyValue = tostring(value)
            convertedKey = keyName.." = "..keyValue..";\n"
        else
            layer = layer+1
            keyValue,layer = Convert(value,layer)
            convertedKey = keyName.." = {\n"..keyValue
            for i = 0, layer, 1 do
                convertedKey = convertedKey.."    "
            end
            convertedKey = convertedKey.."};\n"
        end
        for i = 0, layer, 1 do
            convertedKey = "    "..convertedKey
        end
        str = str..convertedKey
    end
    layer = layer - 1
    return str,layer
end




