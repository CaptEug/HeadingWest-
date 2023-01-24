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
                if city.type == 'Factory' then
                    Factory = city
                    else if city.type == 'Battlefield' then
                        Battlefield = city
                    end
                end
                CurrentPlace = city
                Saving:fileload()
            end,
            city.Gobuttons
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
            city.Go.bx = x + 205
            city.Go.by = y + 226
            pagex = x
            pagey = y - 100
            headx = x + 16
            heady = y - 84

            love.graphics.draw(city_page, pagex, pagey)
            love.graphics.setFont(Rheadfont)
            love.graphics.print(city.name, headx, heady)
            city.Gobuttons:use()

        end
    end
end