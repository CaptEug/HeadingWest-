Pause = {}
Pause = Gamestate.new()

function Pause:enter(from)
    self.from = from -- record previous state
end

function Pause:init()
    Pbuttons = buttons.new()
    Continue = buttons.newButton(
        "Continue",
        function()
            Gamestate.pop()
        end,
        Pbuttons
    )

    BacktoMMenu = buttons.newButton(
        "MainMenu",
        function()
            Gamestate.switch(MainMenu)
        end,
        Pbuttons
    )

    Save = buttons.newButton(
        "Save",
        function()
            if self.from~= Euromap then
                Saving:filesave(Filenumber)
            end
        end,
        Pbuttons
    )
    Settings_button = buttons.newButton(
        "Settings",
        function()
            Gamestate.push(SettingMenu)
        end,
        Pbuttons
    )

end

function Pause:update(dt)
    local ww, wh = love.graphics.getDimensions()
    Continue.bx = ww / 2
    Continue.by = wh / 2
    BacktoMMenu.bx = ww / 2
    BacktoMMenu.by = wh * 3 / 5
    Save.bx=ww/2
    Save.by=wh* 7 / 10
    Settings_button.bx=ww/2
    Settings_button.by=wh*4/5
end

function Pause:draw()
    love.graphics.setColor(0.3, 0.3, 0.3, 1)
    self.from:drawWithoutUI()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(Rtitlefont)
    love.graphics.print("PAUSE", love.graphics.getWidth() /2 - Rtitlefont:getWidth("PAUSE") / 2, love.graphics.getHeight() / 13)
    Pbuttons:use()
end

function love.keypressed(key)
    if Gamestate.current() == ingame and key == 'escape' then
        return Gamestate.push(Pause)
    end
end

function Pause:keypressed(key)
    if key == 'escape' then
        return Gamestate.pop() -- return to previous state
    end
end