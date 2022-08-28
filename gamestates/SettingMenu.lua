SettingMenu = {}
SettingMenu = Gamestate.new()

function SettingMenu:init()
    Sbuttons=buttons.new()
    Apply=buttons.newButton(
        "Apply",
        function ()
            Gamestate.pop()
        end,
        Sbuttons
    )
    Back=buttons.newButton(
        "Back",
        function ()
            Gamestate.switch(ingame)
        end,
        Sbuttons
    )
    Volume=buttons.newButton(
        "Volume",
        function ()
            love.audio.setVolume(1)
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
end

function SettingMenu:update()
    local ww, wh = love.graphics.getDimensions()
    local button_rightlimit=ww*8/9
    local button_leftlimit=ww*1/9

    Apply.bx=button_rightlimit-150
    Apply.by=wh*9/10
    Back.bx=button_rightlimit
    Back.by=wh*9/10
    Volume.bx=button_leftlimit
    Volume.by=wh/10
    Volume_high.bx=button_leftlimit+100
    Volume_high.by=wh/10
    Volume_low.bx=button_leftlimit+150
    Volume_low.by=wh/10
end

function SettingMenu:draw()
    Sbuttons:use()
    local ww, wh = love.graphics.getDimensions()
    local button_leftlimit=ww*1/9
    local volume=tostring(love.audio.getVolume())
    love.graphics.print(volume,button_leftlimit+200,wh/11)
end