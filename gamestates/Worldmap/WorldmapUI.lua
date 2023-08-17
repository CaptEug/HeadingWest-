WorldmapUI = {}
WorldmapButtons = {}

function WorldmapUI:load()
    WorldmapButtons.WButtons = Buttons.new()
    Settings = Buttons.newToolButton(
        Gear,
        function()
            Gamestate.push(Pause)
        end,
        WorldmapButtons.WButtons
    )

    WorldmapButtons.CButtons = Buttons.new()
    for i, city in ipairs(Cities) do
        city.isopen = false
        city.GoButtons = Buttons.new()
        local pic = City_normal
        local pic_Hot = City_normal_Hot
        if city.type == 'Capital' then
             pic = City_capital
             pic_Hot = City_capital_Hot
        end

        local City = Buttons.newCamButton(
            pic,
            function ()
                if city.isopen then
                    city.isopen = false
                else
                    city.isopen = true
                end
            end,
            WorldmapButtons.CButtons,
            city.x,
            city.y,
            pic_Hot
        )

        city.Go = Buttons.newToolButton(
            Go,
            function ()
                CurrentPlace = city
                Gamestate.push(city)
            end,
            city.GoButtons,
            city.x + 208,
            city.y + 328,
            Go_Hot
        )
    end
end

function WorldmapUI:update(dt)
    Year = Year + dt / 10
    Settings.bx, Settings.by = 16, wh - 16
end

function WorldmapUI:draw()
    cam:attach()
    if cam.scale >= 1.5 then
        WorldmapButtons.CButtons:use()
    end
    cam:detach()

    WorldmapButtons.WButtons:use()

    love.graphics.setFont(Rtextfont)
    love.graphics.draw(Steel_icon, ww-128)
    love.graphics.print(tostring(math.floor(Steel)), ww-96)
    love.graphics.print('+'..SteelProduction, ww-96, 16)
    love.graphics.draw(Oil_icon, ww-128, 32)
    love.graphics.print(tostring(math.floor(Oil)), ww-96, 32)
    love.graphics.print('+'..OilProduction, ww-96, 48)

    if cam.scale >= 1.5 then
        for i, city in ipairs(Cities) do
            if city.isopen then
                local x, y = cam:cameraCoords(city.x , city.y)
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
                love.graphics.print(tostring(#city.exsist_tank), tankx, tanky)
                love.graphics.setColor(1,1,1)
                city.GoButtons:use()
            end
        end
    end
end