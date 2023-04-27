MainMenu = {}
MainMenu = Gamestate.new()



function MainMenu:init()
    --love.audio.play(Letsgo)

    cam:lookAt(Worldw * 2 / 5, Worldh * 3/5)
    
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

    FILE1 = buttons.newToolButton(
        Stalin,
        function()
            MMbuttons.isopen = true
            Lbuttons.isopen = false
            Filenumber=1
            
            Gamestate.switch(Worldmap)
        end,
        Lbuttons,
        0,0,
        StalinRed
    )

    FILE2 = buttons.newToolButton(
        Khrushchev,
        function()
            MMbuttons.isopen = true
            Lbuttons.isopen = false
            Filenumber=2
            
            Gamestate.switch(Worldmap)
        end,
        Lbuttons,
        0,0,
        KhrushchevRed
    )

    FILE3 = buttons.newToolButton(
        Brezhnev,
        function()
            MMbuttons.isopen = true
            Lbuttons.isopen = false
            Filenumber=3
            
            Gamestate.switch(Worldmap)
        end,
        Lbuttons,
        0,0,
        BrezhnevRed
    )

    BackL = buttons.newButton(
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
    BackL.bx = ww / 2
    BackL.by = wh *(12 / 13)

    if cam.scale > 4 then
        cam:zoomTo(4)
    end
    if cam.scale < wh / Worldh then
        cam:zoomTo(wh / Worldh)
    end
    cam:lockcamera(0, 0, Worldw, Worldh, 0, ww, 0, wh)
end



function MainMenu:draw()
    cam:attach()
        if Lbuttons.isopen then
            love.graphics.setColor(0.3,0.3,0.3)
        end
        DrawEarth()
        DrawCountries()
    cam:detach()

    if MMbuttons.isopen then
        love.graphics.setFont(Rtitlefont)
        love.graphics.print("НА ЗАПАД!", love.graphics.getWidth() / 2 - Rtitlefont:getWidth("НА ЗАПАД!") / 2, love.graphics.getHeight() / 5)
        MMbuttons:use()
    end

    if Lbuttons.isopen then
        love.graphics.setColor(1,1,1)
        love.graphics.setFont(Rtitlefont)
        love.graphics.print("SAVED FILES", love.graphics.getWidth() / 2 - Rtitlefont:getWidth("SAVED FILES") / 2, 0)
        Lbuttons:use()
    end
end