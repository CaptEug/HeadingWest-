Pause = {}
Pause = Gamestate.new()

function Pause:enter(from)
    self.from = from -- record previous state
end

function Pause:init()
    Pbuttons = buttons.new()
    
    Continue = buttons.newButton(
        1,
        "Continue",
        function()
            Gamestate.pop()
        end,
        Pbuttons
    )

    BacktoMMenu = buttons.newButton(
        1,
        "MainMenu",
        function()
            Gamestate.switch(MainMenu)
        end,
        Pbuttons
    )

    Save = buttons.newButton(
        1,
        "Save",
        function()
            Saving:filesave(Filenumber)
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
    Save.by=wh*7/10
end

function Pause:draw()
    self.from:draw()
    love.graphics.setFont(Rtitlefont)
    love.graphics.print("PAUSE", love.graphics.getWidth() /2 - Rtitlefont:getWidth("PAUSE") / 2, love.graphics.getHeight() / 13)
    Pbuttons:use()
end

function love.keypressed(key)
    if Gamestate.current() == testmap and key == 'p' then
        return Gamestate.push(Pause)
    end
end

function Pause:keypressed(key)
    if key == 'p' then
        return Gamestate.pop() -- return to previous state
    end
end