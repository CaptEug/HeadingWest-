MainMenu = {}
MainMenu = Gamestate.new()





function MainMenu:init()
    Rtitlefont = love.graphics.newFont('Russian.ttf', 100)
    Rbuttonfont = love.graphics.newFont('Russian.ttf', 50)
    Europe = love.graphics.newImage('Europe.png')
    EUw, EUh = Europe:getDimensions()
    BandWshader = love.graphics.newShader(BandWshader_code)
    
    MMbuttons = buttons.new()
    local ww, wh = love.graphics.getDimensions()
    Start = buttons.newButton(
        "Путь!",
        function()
            Gamestate.switch(testmap)
        end,
        MMbuttons
    )
    Quit = buttons.newButton(
        "Покидать",
        function()
            love.event.quit(0)   
        end,
        MMbuttons
    )
end



function MainMenu:update(dt)
    ww, wh = love.graphics.getDimensions()
    Start.bx = ww / 2
    Start.by = wh / 2
    Quit.bx = ww / 2
    Quit.by = wh * 3 / 5
    
    local cx, cy = cam:position()
    if cx < ww - EUw / 2 then
        cam:lockX(ww - EUw / 2)
    end
    if cx > EUw / 2 then
        cam:lockX(EUw / 2)
    end
    if cy < wh - EUh / 2 then
        cam:lockY(wh - EUh / 2)
    end
    if cy > EUh / 2 then
        cam:lockY(EUh / 2)
    end
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