MainMenu = {}
MainMenu = Gamestate.new()



function MainMenu:init()
    --love.audio.play(Letsgo)

    cam:lookAt(Worldw * 2 / 5, Worldh * 3/5)
    
    MMButtons = Buttons.new()
    MMButtons.isopen = true
    LButtons = Buttons.new()
    LButtons.isopen = false
    Start = Buttons.newButton(
        "Start!",
        function()
            LButtons.isopen = true
            MMButtons.isopen = false
        end,
        MMButtons
    )
    
    Quit = Buttons.newButton(
        "Exit",
        function()
            love.event.quit(0)   
        end,
        MMButtons
    )

    Settings = Buttons.newToolButton(
        Gear,
        function()
            Gamestate.push(SettingMenu)
        end,
        MMButtons
    )

    FILE1 = Buttons.newToolButton(
        Stalin,
        function()
            MMButtons.isopen = true
            LButtons.isopen = false
            Filenumber=1
            
            Gamestate.switch(Worldmap)
        end,
        LButtons,
        0,0,
        StalinRed
    )

    FILE2 = Buttons.newToolButton(
        Khrushchev,
        function()
            MMButtons.isopen = true
            LButtons.isopen = false
            Filenumber=2
            
            Gamestate.switch(Worldmap)
        end,
        LButtons,
        0,0,
        KhrushchevRed
    )

    FILE3 = Buttons.newToolButton(
        Brezhnev,
        function()
            MMButtons.isopen = true
            LButtons.isopen = false
            Filenumber=3
            
            Gamestate.switch(Worldmap)
        end,
        LButtons,
        0,0,
        BrezhnevRed
    )

    BackL = Buttons.newButton(
        "Back",
        function()
            LButtons.isopen = false
            MMButtons.isopen = true
        end,
        LButtons
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
    cam:move(-0.2,0)

    camx,camy = cam:position()
    if camx > Worldw then
        cam:move(-Worldw,0)
    end
    if camx < 0 then 
        cam:move(Worldw,0)
    end

    if cam.scale > 4 then
        cam:zoomTo(4)
    end
    if cam.scale < wh / Worldh then
        cam:zoomTo(wh / Worldh)
    end
    if cam.scale < ww / Worldw then
        cam:zoomTo(ww / Worldw)
    end
    cam:lockcamera(0, 0, Worldw, Worldh, 0, ww, 0, wh)
end



function MainMenu:draw()
    cam:attach()
        if LButtons.isopen then
            love.graphics.setColor(0.3,0.3,0.3)
        end
        DrawEarth()
        DrawCountries()
    cam:detach()

    if MMButtons.isopen then
        love.graphics.setFont(Rtitlefont)
        love.graphics.print("НА ЗАПАД!", love.graphics.getWidth() / 2 - Rtitlefont:getWidth("НА ЗАПАД!") / 2, love.graphics.getHeight() / 5)
        MMButtons:use()
    end

    if LButtons.isopen then
        love.graphics.setColor(1,1,1)
        love.graphics.setFont(Rtitlefont)
        love.graphics.print("Choose FILE", love.graphics.getWidth() / 2 - Rtitlefont:getWidth("SAVED FILES") / 2, 0)
        LButtons:use()
    end
end