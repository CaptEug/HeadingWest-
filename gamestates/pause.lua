Pause = {}
Pause = Gamestate.new()

function Pause:enter(from)
    self.from = from -- record previous state
end

function Pause:init()
    PButtons = Buttons.new()
    PButtonsforcity = Buttons.new()
    Continue = Buttons.newButton(
        "Continue",
        function()
            Gamestate.pop()
        end,
        PButtons
    )

    BacktoMMenu = Buttons.newButton(
        "MainMenu",
        function()
            if self.from ~= Worldmap then
                NewSaving:Save(Filenumber)
            end
            Gamestate.switch(MainMenu)
        end,
        PButtons
    )

    BacktoWMap = Buttons.newButton(
        "Worldmap",
        function()
            Gamestate.switch(Worldmap)
        end,
        PButtonsforcity
    )

    Settings_button = Buttons.newButton(
        "Settings",
        function()
            Gamestate.push(SettingMenu)
        end,
        PButtons
    )

end

function Pause:update(dt)
    local ww, wh = love.graphics.getDimensions()
    Continue.bx = ww/2
    Continue.by = wh * 3/8
    BacktoMMenu.bx = ww/2
    BacktoMMenu.by = wh * 4/8
    Settings_button.bx=ww/2
    Settings_button.by=wh* 5/8
    BacktoWMap.bx = ww / 2
    BacktoWMap.by = wh * 6/8
end

function Pause:draw()
    love.graphics.setColor(0.3, 0.3, 0.3, 1)
    self.from:drawWithoutUI()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(Rtitlefont)
    love.graphics.print("PAUSE", love.graphics.getWidth() /2 - Rtitlefont:getWidth("PAUSE") / 2, love.graphics.getHeight() / 13)
    PButtons:use()
    if self.from == CurrentPlace then
        PButtonsforcity:use()
    end
    love.graphics.setFont(Rtextfont)
end


function Pause:keypressed(key)
    if key == 'escape' then
        return Gamestate.pop() -- return to previous state
    end
end