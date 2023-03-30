ArmyEditor = {}

function ArmyEditor:load()
    CurrentPlace.openarmyeditor = false
    CurrentPlace.AEbuttons = buttons.new()
    DivisionNum = 1
    
    --load buttons
    New_Division = buttons.newToolButton(
        greyplus_icon,
        function ()
            NewDivision('division#'..tostring(DivisionNum))
            DivisionNum = DivisionNum + 1
        end,
        CurrentPlace.AEbuttons
    )
    
end

function ArmyEditor:update(dt)
    --button pos update

end

function ArmyEditor:draw()
    if CurrentPlace.openarmyeditor then
        love.graphics.draw(ArmyEditor_screen, ww/2 - 200, wh/2 - 280)
        love.graphics.setColor(0,0,0)
        love.graphics.setFont(Rheadfont)
        love.graphics.print('Army in '..CurrentPlace.name, ww/2 - 200 + 32, wh/2 - 280 + 40)
        love.graphics.setFont(Rtextfont)

        DivisionHight = 72

        for i, division in ipairs(CurrentPlace.Army) do
            love.graphics.setColor(0,0,0)
            love.graphics.setFont(Rheadfont)
            love.graphics.print(division.name, ww/2 - 200 + 48, wh/2 - 280 + DivisionHight)
            love.graphics.setFont(Rtextfont)

            division.rgtHight = 10
            division.delete.bx = ww/2 - 200 + 38
            division.delete.by = wh/2 - 280 + 14 + DivisionHight

            for n, regiment in ipairs(division) do
                love.graphics.setColor(0,0,0)
                love.graphics.print(regiment.name, ww/2 - 200 + 54, wh/2 - 280 + DivisionHight + 20*n + division.rgtHight)
                
                regiment.compHight = 0
                regiment.delete.bx = ww/2 - 200 + 44
                regiment.delete.by = wh/2 - 280 + 6 + DivisionHight + 20*n + division.rgtHight

                for m, company in ipairs(regiment) do
                    love.graphics.setColor(0,0,0)
                    love.graphics.print(company.name, ww/2 - 200 + 154, wh/2 - 280 - 20 + DivisionHight + 20*n + division.rgtHight + 20*m + regiment.compHight)
                    company.CButtons:use()

                    company.delete.bx = ww/2 - 200 + 144
                    company.delete.by = wh/2 - 280 - 20 + 6 + DivisionHight + 20*n + division.rgtHight + 20*m + regiment.compHight
                    
                    --[[for i, unit in ipairs(company) do
                        if unit.type == 'tank' then
                            love.graphics.draw(tank_icon)
                        end
                        love.graphics.print(unit.name..unit.number)
                    end]]

                    regiment.compHight = regiment.compHight + 20 * #company
                end

                love.graphics.setColor(0.5,0.5,0.5)
                love.graphics.print('comp.', ww/2 - 200 + 148, wh/2 - 280 + DivisionHight + 20*n + division.rgtHight + 20*#regiment)
                regiment.New_Company.bx = ww/2 - 200 + 189
                regiment.New_Company.by = wh/2 - 280 + 6 + DivisionHight + 20*n + division.rgtHight + 20*#regiment
                regiment.RButtons:use()

                division.rgtHight = division.rgtHight + 6 + 20 * #regiment + regiment.compHight
            end

            love.graphics.setColor(0.5,0.5,0.5)
            love.graphics.print('rgt.', ww/2 - 200 + 48, wh/2 - 280 + 20 + DivisionHight + 20*#division + division.rgtHight)
            division.New_Regiment.bx = ww/2 - 200 + 80
            division.New_Regiment.by = wh/2 - 280 + 26 + DivisionHight + 20*#division + division.rgtHight
            love.graphics.setColor(0,0,0)
            love.graphics.rectangle("fill", ww/2 - 200 + 32, wh/2 - 280 + 40 + DivisionHight + 20*#division + division.rgtHight, 338, 2)
            division.DButtons:use()
            
            DivisionHight = DivisionHight + 44 + 20 * #division + division.rgtHight
        end

        love.graphics.setColor(0.5,0.5,0.5)
        love.graphics.setFont(Rheadfont)
        love.graphics.print('div.', ww/2 - 200 + 32, wh/2 - 280 + DivisionHight)
        love.graphics.setFont(Rtextfont)
        New_Division.bx = ww/2 - 200 + 76
        New_Division.by = wh/2 - 280 + 14 + DivisionHight
        CurrentPlace.AEbuttons:use()

    end
end

function NewDivision(name)
    local instance = {}
    instance.name = name
    instance.DButtons = buttons.new()
    instance.delete = buttons.newToolButton(
        greyminus_icon,
        function ()
            removeTable(CurrentPlace.Army, instance)
        end,
        instance.DButtons
    )
    instance.New_Regiment = buttons.newToolButton(
        greyplus_icon,
        function ()
            NewRegiment(instance)
        end,
        instance.DButtons
    )
    table.insert(CurrentPlace.Army, instance)
end

function NewRegiment(division)
    local instance = {}
    instance.name = 'regiment#'
    instance.type = 'tank'
    instance.RButtons = buttons.new()
    instance.delete = buttons.newToolButton(
        greyminus_icon,
        function ()
            removeTable(division, instance)
        end,
        instance.RButtons
    )
    instance.New_Company = buttons.newToolButton(
        greyplus_icon,
        function ()
            NewCompany(instance)
        end,
        instance.RButtons
    )
    table.insert(division, instance)
end

function NewCompany(regiment)
    local instance = {}
    instance.name = 'company#'
    instance.CButtons = buttons.new()
    instance.delete = buttons.newToolButton(
        greyminus_icon,
        function ()
            removeTable(regiment, instance)
        end,
        instance.CButtons
    )
    table.insert(regiment, instance)
end