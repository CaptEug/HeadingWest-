WorldmapUI = {}

function WorldmapUI:load()
    Year = 1946

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

        local City = buttons.newCamButton(
            city.icon,
            function ()
                if city.isopen then
                    city.isopen = false
                else
                    city.isopen = true
                end
            end,
            Cbuttons,
            city.x,
            city.y
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
            city.y + 228,
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
        Cbuttons:use()
    cam:detach()

    Wbuttons:use()
    
    love.graphics.setFont(Rtitlefont)
    love.graphics.print(tostring(math.floor(Year)), love.graphics.getWidth() / 2 - Rtitlefont:getWidth(tostring(math.floor(Year))) / 2, 0)
    
    for i, city in ipairs(Cities) do
        if city.isopen then
            local x, y = cam:cameraCoords(city.x, city.y)
            city.Go.bx = x + 208
            city.Go.by = y + 228
            pagex = x
            pagey = y - 100
            headx = x + 16
            heady = y - 84
            tankx = x + 34
            tanky = y + 223

            love.graphics.draw(city_page, pagex, pagey)
            love.graphics.setColor(0,0,0)
            love.graphics.setFont(Rheadfont)
            love.graphics.print(city.name, headx, heady)
            love.graphics.setFont(Rtextfont)
            love.graphics.print(tostring(table.getn(city.tankstock)), tankx, tanky)
            love.graphics.setColor(1,1,1)
            city.Gobuttons:use()

        end
    end
end