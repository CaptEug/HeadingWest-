SettingMenu = {}
SettingMenu = Gamestate.new()

function SettingMenu:init()
    Sbuttons=buttons.new()

    Back=buttons.newButton(
        "Back",
        function ()
            Saving:save_settings()
            Gamestate.pop()
        end,
        Sbuttons
    )
    Volume_high=buttons.newButton(
        "+",
        function ()
            local volume=math.floor(love.audio.getVolume())
            love.audio.setVolume(volume+1)
        end,
        Sbuttons
    )
    Volume_low=buttons.newButton(
        "-",
        function ()
            local volume=math.floor(love.audio.getVolume())
            love.audio.setVolume(volume-1)
        end,
        Sbuttons
    )
    
    Resolution=buttons.newButton(
        "Window",
        function ()
            SettingMenu:change_resolution()
        end,
        Sbuttons
    )

end

function SettingMenu:update()
    local ww, wh = love.graphics.getDimensions()
    local button_rightlimit=ww*8/9
    local button_leftlimit=ww*1/9

    Back.bx=button_rightlimit
    Back.by=wh*9/10
    Volume_high.bx=button_leftlimit+100
    Volume_high.by=wh/10
    Volume_low.bx=button_leftlimit+150
    Volume_low.by=wh/10
    Resolution.bx=button_leftlimit+250
    Resolution.by=wh*3/20+37
end

function SettingMenu:draw()
    Sbuttons:use()
    local ww, wh = love.graphics.getDimensions()
    local button_leftlimit=ww*1/9
    local volume=tostring(love.audio.getVolume())
    love.graphics.print(volume,button_leftlimit+200,wh/10-37)
    love.graphics.print("Volume",button_leftlimit-75,wh/10-37)
    love.graphics.print("Resolution",button_leftlimit-75,wh*3/20)
end

function SettingMenu:change_resolution()
    local screen_type,x=love.window.getFullscreen()
    if screen_type==true then
        love.window.setFullscreen(false)
        Sbuttons[4].text="Window"
    elseif screen_type==false then
        love.window.setFullscreen(true)
        Sbuttons[4].text="Fullscreen"
    end

end