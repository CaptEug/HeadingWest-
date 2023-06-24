Pause = {}
Pause = Gamestate.new()

function Pause:enter(from)
    self.from = from -- record previous state
end

function Pause:init()
    Pbuttons = buttons.new()
    Pbuttonsforcity = buttons.new()
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
            if self.from ~= Worldmap then
                NewSaving:Save(Filenumber)
            end
            Gamestate.switch(MainMenu)
        end,
        Pbuttons
    )

    BacktoWMap = buttons.newButton(
        "Worldmap",
        function()
            Gamestate.switch(Worldmap)
        end,
        Pbuttonsforcity
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
    Pbuttons:use()
    if self.from == CurrentPlace then
        Pbuttonsforcity:use()
    end
    love.graphics.setFont(Rtextfont)
end

function love.keypressed(key)
    if key == 'escape' and (Gamestate.current() == CurrentPlace or Gamestate.current()== Worldmap) then
        return Gamestate.push(Pause)
    end
end

function Pause:keypressed(key)
    if key == 'escape' then
        return Gamestate.pop() -- return to previous state
    end
end