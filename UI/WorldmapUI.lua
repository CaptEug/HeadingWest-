WorldmapUI = {}

function WorldmapUI:load()
    Wbuttons = buttons.new()
    Settings = buttons.newToolButton(
        Gear,
        function()
            Gamestate.push(Pause)
        end,
        Wbuttons,
        16,
        wh - 16
    )

    Cbuttons = buttons.new()
    for i, city in ipairs(Cities) do
        city.isopen = false
        city.Gobuttons = buttons.new()
        local pic = City_normal
        local pic_Hot = City_normal_Hot
        if city.type == 'Capital' then
             pic = City_capital
             pic_Hot = City_capital_Hot
        end

        local City = buttons.newCamButton(
            pic,
            function ()
                if city.isopen then
                    city.isopen = false
                else
                    city.isopen = true
                end
            end,
            Cbuttons,
            city.x,
            city.y,
            pic_Hot
        )

        city.Go = buttons.newToolButton(
            Go,
            function ()
                MapNumber = city.map
                Map_type = city.type
                CurrentPlace = city
                Saving:fileload()
            end,
            city.Gobuttons,
            city.x + 208,
            city.y + 328,
            Go,
            Go_Hot
        )
    end
end

function WorldmapUI:update(dt)
    Year = Year + dt / 10 
end

function WorldmapUI:draw()
    cam:attach()
    if cam.scale >= 1.5 then
        Cbuttons:use()
    end
        
    cam:detach()

    Wbuttons:use()
    
    love.graphics.setFont(Rtitlefont)
    love.graphics.print(tostring(math.floor(Year)), love.graphics.getWidth() / 2 - Rtitlefont:getWidth(tostring(math.floor(Year))) / 2, 0)

    if cam.scale >= 1.5 then
        for i, city in ipairs(Cities) do
            if city.isopen then
                local x, y = cam:cameraCoords(city.x - 25, city.y - 25)
                city.Go.bx = x + 208
                city.Go.by = y + 328
                local headx = x + 16
                local heady = y + 16
                local tankx = x + 34
                local tanky = y + 323
                love.graphics.draw(city_page, x, y)
                for i, flag in ipairs(city.country) do
                    love.graphics.draw(flag, x + 210 + 28 - 28*i , y + 9)
                end
                love.graphics.setColor(0,0,0)
                love.graphics.setFont(Rheadfont)
                love.graphics.print(city.name, headx, heady)
                love.graphics.setFont(Rtextfont)
                love.graphics.print(tostring(table.getn(city.exsist_tank)), tankx, tanky)
                love.graphics.setColor(1,1,1)
                city.Gobuttons:use()
            end
        end
    end
end