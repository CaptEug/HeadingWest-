SettingMenu = {}
SettingMenu = Gamestate.new()

function SettingMenu:init()
    SButtons=Buttons.new()

    Back=Buttons.newButton(
        "Back",
        function ()
            NewSaving:SaveSettings()
            Gamestate.pop()
        end,
        SButtons
    )
    Volume_high=Buttons.newButton(
        "+",
        function ()
            local volume=math.floor(love.audio.getVolume())
            love.audio.setVolume(volume+1)
        end,
        SButtons
    )
    Volume_low=Buttons.newButton(
        "-",
        function ()
            local volume=math.floor(love.audio.getVolume())
            love.audio.setVolume(volume-1)
        end,
        SButtons
    )
    
    Resolution=Buttons.newButton(
        "Windowed",
        function ()
            SettingMenu:change_resolution()
        end,
        SButtons
    )

end

function SettingMenu:update()
    local ww, wh = love.graphics.getDimensions()
    local button_rightlimit=ww*8/9
    local button_leftlimit=ww*1/9

    Back.bx = ww / 2
    Back.by = wh *(12 / 13)
    Volume_high.bx=button_leftlimit+280
    Volume_high.by=wh/10
    Volume_low.bx=button_leftlimit+330
    Volume_low.by=wh/10
    Resolution.bx=button_leftlimit+400
    Resolution.by=wh*3/20+30
end

function SettingMenu:draw()
    SButtons:use()
    local ww, wh = love.graphics.getDimensions()
    local button_leftlimit=ww*1/9
    local volume=tostring(love.audio.getVolume())
    love.graphics.print(volume,button_leftlimit+400,wh/10-37)
    love.graphics.print("Volume",button_leftlimit-75,wh/10-37)
    love.graphics.print("Resolution",button_leftlimit-75,wh*3/20)
end

function SettingMenu:change_resolution()
    local screen_type,x=love.window.getFullscreen()
    if screen_type==true then
        love.window.setFullscreen(false)
        SButtons[4].text="Windowed"
    elseif screen_type==false then
        love.window.setFullscreen(true)
        SButtons[4].text="Fullscreen"
    end
end