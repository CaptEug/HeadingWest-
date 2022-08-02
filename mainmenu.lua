MainMenu = {}
MainMenu = Gamestate.new()
require 'chapters/Berlin'
require 'buttons'



function MainMenu:init()
    Rtitlefont = love.graphics.newFont('Russian.ttf', 100)
    Rbuttonfont = love.graphics.newFont('Russian.ttf', 50)
    Europe = love.graphics.newImage('Europe.png')
    EUw, EUh = Europe:getDimensions()
    BandWshader = love.graphics.newShader(BandWshader_code)
    
    ww, wh = love.graphics.getDimensions()
    
    MMbuttons = buttons.new()
    Start = buttons.newButton(
        "Путь!",
        function()
            Gamestate.switch(testmap)
        end,
        MMbuttons,
        ww / 2,
        wh / 2
    )
    Quit = buttons.newButton(
        "Покидать",
        function()
            love.event.quit(0)   
        end,
        MMbuttons,
        ww / 2,
        wh * 3 / 5
    )
end



function MainMenu:update(dt)
    
end



function MainMenu:draw()
    cam:attach()
        love.graphics.setShader(BandWshader)
        love.graphics.draw(Europe, ww / 2 - EUw / 2, wh / 2 - EUh / 2)
        love.graphics.setShader(nil)
    cam:detach()
    love.graphics.setFont(Rtitlefont)
    love.graphics.print("НА ЗАПАД!", ww / 2 - Rtitlefont:getWidth("НА ЗАПАД!") / 2, wh / 5)
    
    MMbuttons:use()
end