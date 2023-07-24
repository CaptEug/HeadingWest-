CityInfoPenal = {}

function CityInfoPenal:load()
    AEscreen = love.graphics.newCanvas(432, 560)
    CityInfoPenal.window = {x = 32, y = 32, w = 400, h = 560}
    CityInfoPenal.dragging = false
    CurrentPlace.openCityInfoPenal = false
    CurrentPlace.cityinfopenalmode = false
    CityInfoPenal.Buttons = Buttons.new()
    CurrentPlace.Army.AButtons = Buttons.new()
    DivisionNum = 1
    
    --load Buttons
    EditArmy = Buttons.newWindowToolButton(
        Edit_button,
        function ()
            if CurrentPlace.cityinfopenalmode then
                CurrentPlace.cityinfopenalmode = false
            else
                CurrentPlace.cityinfopenalmode = true
            end
        end,
        CityInfoPenal.window,
        CityInfoPenal.Buttons,
        0 + 363,
        0 + 53,
        Edit_button,
        Edit_button,
        Done_button
    )

    New_Division = Buttons.newWindowToolButton(
        greyplus_icon,
        function ()
            NewDivision('division#'..tostring(DivisionNum))
            DivisionNum = DivisionNum + 1
        end,
        CityInfoPenal.window,
        CurrentPlace.Army.AButtons
    )
end

function CityInfoPenal:update(dt)
    for i, division in ipairs(CurrentPlace.Army) do
        if division.remove then
            table.remove(CurrentPlace.Army, i)
        end
        for m, regiment in ipairs(division) do
            if regiment.remove then
                table.remove(division, m)
            end
            for n, company in ipairs(regiment) do
                if company.remove then
                    table.remove(regiment, n)
                end
            end
        end
    end
end

function CityInfoPenal:draw()
    if CurrentPlace.openCityInfoPenal then
    love.graphics.setCanvas(AEscreen)
        love.graphics.draw(CityInfoPenal_screen)
        love.graphics.setColor(0,0,0)
        love.graphics.setFont(Rheadfont)
        love.graphics.print(CurrentPlace.name, 0 + 32, 0 + 24)
        love.graphics.setFont(Rtextfont)
        love.graphics.print(CurrentPlace.oil_stored, 100, 40)
        love.graphics.print(CurrentPlace.steel_stored, 100, 60)
        CityInfoPenal.Buttons:use()
        
        DivisionHight = 72
        for i, division in ipairs(CurrentPlace.Army) do
            love.graphics.setColor(0,0,0)
            love.graphics.setFont(Rheadfont)
            love.graphics.print(division.name, 0 + 48, 0 + DivisionHight)
            love.graphics.setFont(Rtextfont)

            division.rgtHight = 10
            division.delete.bx = 0 + 38
            division.delete.by = 0 + 14 + DivisionHight

            for n, regiment in ipairs(division) do
                love.graphics.setColor(0,0,0)
                love.graphics.print(regiment.name, 0 + 54, 0 + DivisionHight + 20*n + division.rgtHight)
                
                regiment.compHight = 0
                regiment.delete.bx = 0 + 44
                regiment.delete.by = 0 + 6 + DivisionHight + 20*n + division.rgtHight

                for m, company in ipairs(regiment) do
                    love.graphics.setColor(0,0,0)
                    love.graphics.print(company.name, 0 + 154, 0 - 20 + DivisionHight + 20*n + division.rgtHight + 20*m + regiment.compHight)
                    if CurrentPlace.cityinfopenalmode then
                        company.CButtons:use()
                        love.graphics.setColor(0,0,0)
                        love.graphics.rectangle("line", 0 + 236, 0 - 20 + DivisionHight + 20*n + division.rgtHight + 20*m + regiment.compHight, 133, 20*#company + 20)
                    end
                    
                    company.delete.bx = 0 + 144
                    company.delete.by = 0 - 20 + 6 + DivisionHight + 20*n + division.rgtHight + 20*m + regiment.compHight
                    
                    for i, unit in ipairs(company) do
                        if unit.class == 'tank' then
                            love.graphics.draw(Tank_icon, 0 + 236, 0 - 20 + DivisionHight + 20*n + division.rgtHight + 20*m + regiment.compHight)
                        end
                        love.graphics.print(unit.name..' No.'..unit.number, 0 + 256, 0 - 40 + DivisionHight + 20*n + division.rgtHight + 20*m + regiment.compHight + 20*i)
                    end

                    regiment.compHight = regiment.compHight + 4 + 20 * #company
                end

                if CurrentPlace.cityinfopenalmode then
                    love.graphics.setColor(0.5,0.5,0.5)
                    love.graphics.print('comp.', 0 + 148, 0 + DivisionHight + 20*n + division.rgtHight + 20*#regiment + regiment.compHight)
                    regiment.New_Company.bx = 0 + 189
                    regiment.New_Company.by = 0 + 6 + DivisionHight + 20*n + division.rgtHight + 20*#regiment + regiment.compHight
                    regiment.RButtons:use()
                end

                division.rgtHight = division.rgtHight + 6 + 20 * #regiment + regiment.compHight
            end

            love.graphics.setColor(0,0,0)
            love.graphics.rectangle("fill", 0 + 32, 0 + 40 + DivisionHight + 20*#division + division.rgtHight, 338, 2)

            if CurrentPlace.cityinfopenalmode then
                love.graphics.setColor(0.5,0.5,0.5)
                love.graphics.print('rgt.', 0 + 48, 0 + 20 + DivisionHight + 20*#division + division.rgtHight)
                division.New_Regiment.bx = 0 + 80
                division.New_Regiment.by = 0 + 26 + DivisionHight + 20*#division + division.rgtHight
                love.graphics.setColor(0,0,0)
                division.DButtons:use()
            end
            
            DivisionHight = DivisionHight + 44 + 20 * #division + division.rgtHight
        end

        if CurrentPlace.cityinfopenalmode then
            love.graphics.setColor(0.5,0.5,0.5)
            love.graphics.setFont(Rheadfont)
            love.graphics.print('div.', 0 + 32, 0 + DivisionHight)
            love.graphics.setFont(Rtextfont)
            New_Division.bx = 0 + 76
            New_Division.by = 0 + 14 + DivisionHight
            CurrentPlace.Army.AButtons:use()
        end
        love.graphics.setColor(1,1,1)
    love.graphics.setCanvas()
        love.graphics.draw(AEscreen, CityInfoPenal.window.x, CityInfoPenal.window.y)
        if CurrentPlace.cityinfopenalmode then
            love.graphics.setColor(1,1,1)
            love.graphics.draw(CityInfoPenal_list, CityInfoPenal.window.x, CityInfoPenal.window.y)
            for i, tank in ipairs(CurrentPlace.exsist_tank) do
                if not tank.incomp then
                    love.graphics.setColor(0,0,0)
                    love.graphics.draw(Tank_icon,  CityInfoPenal.window.x + 393, CityInfoPenal.window.y + 24 + 20*i)
                    love.graphics.print(tank.name..' No.'..tank.number, CityInfoPenal.window.x + 415, CityInfoPenal.window.y + 24 + 20*i)
                    love.graphics.setColor(1,1,1)
                end
            end
        end
    end
end

function NewDivision(name)
    local instance = {}
    instance.name = name
    instance.remove = false
    instance.DButtons = Buttons.new()
    instance.delete = Buttons.newWindowToolButton(
        greyminus_icon,
        function ()
            instance.remove = true
        end,
        CityInfoPenal.window,
        instance.DButtons
    )
    instance.New_Regiment = Buttons.newWindowToolButton(
        greyplus_icon,
        function ()
            NewRegiment(instance)
        end,
        CityInfoPenal.window,
        instance.DButtons
    )
    table.insert(CurrentPlace.Army, instance)
end

function NewRegiment(division)
    local instance = {}
    instance.name = 'regiment#'
    instance.type = 'tank'
    instance.remove = false
    instance.RButtons = Buttons.new()
    instance.delete = Buttons.newWindowToolButton(
        greyminus_icon,
        function ()
            instance.remove = true
        end,
        CityInfoPenal.window,
        instance.RButtons
    )
    instance.New_Company = Buttons.newWindowToolButton(
        greyplus_icon,
        function ()
            NewCompany(instance)
        end,
        CityInfoPenal.window,
        instance.RButtons
    )
    table.insert(division, instance)
end

function NewCompany(regiment)
    local instance = {}
    instance.name = 'company#'
    instance.remove = false
    instance.CButtons = Buttons.new()
    instance.delete = Buttons.newWindowToolButton(
        greyminus_icon,
        function ()
            instance.remove = true
        end,
        CityInfoPenal.window,
        instance.CButtons
    )
    table.insert(regiment, instance)
end