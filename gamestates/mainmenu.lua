MainMenu = {}
MainMenu = Gamestate.new()



function MainMenu:init()
    Rtitlefont = love.graphics.newFont('Russian.ttf', 100)
    Rbuttonfont = love.graphics.newFont('Russian.ttf', 50)
    
    Letsgo = love.audio.newSource('music/俄罗斯军队模范亚历山德罗夫红旗歌舞团 - В путь.mp3', 'stream')
    love.audio.play(Letsgo)

    cam:lookAt(EUw * 2 / 5, EUh * 3/5)
    cam:zoomTo(0.7)
    MMbuttons = buttons.new()
    local ww, wh = love.graphics.getDimensions()
    
    Start = buttons.newButton(
        1,
        "В путь!",
        function()
            Gamestate.switch(Loadmenu)
        end,
        MMbuttons
    )
    
    Quit = buttons.newButton(
        1,
        "Покидать",
        function()
            love.event.quit(0)   
        end,
        MMbuttons
    )
end



function MainMenu:update(dt)
    local ww, wh = love.graphics.getDimensions()
    Start.bx = ww / 2
    Start.by = wh / 2
    Quit.bx = ww / 2
    Quit.by = wh * 3 / 5

    if cam.scale > 1.5 then
        cam:zoomTo(1.5)
    end
    if cam.scale < wh / EUh then
        cam:zoomTo(wh / EUh)
    end
    cam:lockcamera(0, 0, EUw, EUh, 0, ww, 0, wh)
end



function MainMenu:draw()
    cam:attach()
        DrawEurope()
    cam:detach()
    love.graphics.setFont(Rtitlefont)
    love.graphics.print("НА ЗАПАД!", love.graphics.getWidth() / 2 - Rtitlefont:getWidth("НА ЗАПАД!") / 2, love.graphics.getHeight() / 5)
    
    MMbuttons:use()
end