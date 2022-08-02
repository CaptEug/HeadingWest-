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
    
    if cam.scale > 1.5 then
        cam:zoomTo(1.5)
    end
    if cam.scale < 0.52 then
        cam:zoomTo(0.52)
    end

    local camx_max, camy_max = love.graphics.getDimensions()
    local x1,y1 = Europe:getDimensions()
    cam:lockcamera(0, 0, x1, y1, 0, camx_max, 0, camy_max)
end



function MainMenu:draw()
    cam:attach()
        love.graphics.setShader(BandWshader)
        love.graphics.draw(Europe, 0, 0)
        love.graphics.setShader(nil)
    cam:detach()
    
    love.graphics.setFont(Rtitlefont)
    love.graphics.print("НА ЗАПАД!", ww / 2 - Rtitlefont:getWidth("НА ЗАПАД!") / 2, wh / 5)
    
    MMbuttons:use()
end