WorldmapUI = {}

function WorldmapUI:load()
    Year = 1946

    Ebuttons = buttons.new()
    Settings = buttons.newToolButton(
        Gear,
        function()
            Gamestate.push(Pause)
        end,
        Ebuttons
    )

    Cbuttons = buttons.new()
    Cbuttons.ison = true

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
                Map_type=city.type
                if city.type == 'Factory' then
                    Factory = city
                end
                
                Saving:fileload()
            end,
            city.Gobuttons
        )
    end

    --[[Berlin = buttons.newCamButton(
        Berlin_Bear,
        function ()
            MapNumber=1
            Saving:fileload()
        end,
        Cbuttons
    )

    UVZ = buttons.newCamButton(
        UVZ_Icon,
        function ()
            if KMDB.isopen then
                KMDB.isopen = false
            else
                KMDB.isopen = true
            end
            Cbuttons.ison = false
        end,
        Cbuttons
    )]]
end

function WorldmapUI:update(dt)
    Year = Year + dt / 10
    Settings.bx = 32
    Settings.by = wh - 32

    

    --[[Berlin.bx = 1835
    Berlin.by = 1345
    UVZ.bx = 3100
    UVZ.by = 1200]]
    
end

function WorldmapUI:draw()
    Ebuttons:use()

    cam:attach()
        if Cbuttons.ison then
            Cbuttons:use()
        end

        
    cam:detach()
    
    love.graphics.setFont(Rtitlefont)
    love.graphics.print(tostring(math.floor(Year)), love.graphics.getWidth() / 2 - Rtitlefont:getWidth(tostring(math.floor(Year))) / 2, 0)
    
    for i, city in ipairs(Cities) do
        if city.isopen then
            local x, y = cam:cameraCoords(city.x, city.y)
            city.Go.bx = x + 208
            city.Go.by = y + 146
            pagex = x
            pagey = y - 176
            headx = x + 16
            heady = y - 160

            love.graphics.draw(city_page, pagex, pagey)
            love.graphics.setFont(Rheadfont)
            love.graphics.print(city.name, headx, heady)
            city.Gobuttons:use()

        end
    end
end