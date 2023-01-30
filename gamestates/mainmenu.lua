MainMenu = {}
MainMenu = Gamestate.new()



function MainMenu:init()
    love.audio.play(Letsgo)

    cam:lookAt(EUw * 2 / 5, EUh * 3/5)
    cam:zoomTo(0.7)
    
    MMbuttons = buttons.new()
    MMbuttons.isopen = true
    Lbuttons = buttons.new()
    Lbuttons.isopen = false
    Start = buttons.newButton(
        "Start!",
        function()
            Lbuttons.isopen = true
            MMbuttons.isopen = false
        end,
        MMbuttons
    )
    
    Quit = buttons.newButton(
        "Exit",
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

    FILE1 = buttons.newPicButton(
        Stalin,
        function()
            Filenumber=1
            Gamestate.switch(Worldmap)
        end,
        Lbuttons
    )

    FILE2 = buttons.newPicButton(
        Khrushchev,
        function()
            Filenumber=2
            Gamestate.switch(Worldmap)
        end,
        Lbuttons
    )

    FILE3 = buttons.newPicButton(
        Brezhnev,
        function()
            Filenumber=3
            Gamestate.switch(Worldmap)
        end,
        Lbuttons
    )

    Back = buttons.newButton(
        "Back",
        function()
            Lbuttons.isopen = false
            MMbuttons.isopen = true
        end,
        Lbuttons
    )
end



function MainMenu:update(dt)
    Start.bx = ww / 2
    Start.by = wh / 2
    Quit.bx = ww / 2
    Quit.by = wh * 3 / 5
    Settings.bx = 16
    Settings.by = wh - 16
    FILE1.bx = ww / 5
    FILE2.bx = ww / 2
    FILE3.bx = ww *(4 / 5)
    FILE1.by = wh *(1 / 2)
    FILE2.by = wh *(1 / 2)
    FILE3.by = wh *(1 / 2)
    Back.bx = ww / 2
    Back.by = wh *(12 / 13)

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

    if MMbuttons.isopen then
        love.graphics.setFont(Rtitlefont)
        love.graphics.print("НА ЗАПАД!", love.graphics.getWidth() / 2 - Rtitlefont:getWidth("НА ЗАПАД!") / 2, love.graphics.getHeight() / 5)
        MMbuttons:use()
    end

    if Lbuttons.isopen then
        love.graphics.setFont(Rtitlefont)
        love.graphics.print("SAVED FILES", love.graphics.getWidth() / 2 - Rtitlefont:getWidth("SAVED FILES") / 2, 0)
        Lbuttons:use()
    end
end