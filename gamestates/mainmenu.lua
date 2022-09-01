MainMenu = {}
MainMenu = Gamestate.new()



function MainMenu:init()
    Letsgo = love.audio.newSource('Assets/music/俄罗斯军队模范亚历山德罗夫红旗歌舞团 - В путь.mp3', 'stream')
    love.audio.play(Letsgo)

    cam:lookAt(EUw * 2 / 5, EUh * 3/5)
    cam:zoomTo(0.7)
    
    MMbuttons = buttons.new()
    Start = buttons.newButton(
        "В путь!",
        function()
            Gamestate.switch(Loadmenu)
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

    Settings = buttons.newToolButton(
        Gear,
        function()
            Gamestate.push(SettingMenu)
        end,
        MMbuttons
    )
end



function MainMenu:update(dt)
    Start.bx = ww / 2
    Start.by = wh / 2
    Quit.bx = ww / 2
    Quit.by = wh * 3 / 5
    Settings.bx = 32
    Settings.by = wh - 32

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
        DrawCountries()
    cam:detach()
    love.graphics.setFont(Rtitlefont)
    love.graphics.print("НА ЗАПАД!", love.graphics.getWidth() / 2 - Rtitlefont:getWidth("НА ЗАПАД!") / 2, love.graphics.getHeight() / 5)
    
    MMbuttons:use()
end