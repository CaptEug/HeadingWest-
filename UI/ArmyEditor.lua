ArmyEditor = {}

function ArmyEditor:load()
    CurrentPlace.openarmyeditor = false
    CurrentPlace.AEbuttons = buttons.new()
    DivisionNum = 1
    DivisionHight = 100
    --load buttons
    New_Division = buttons.newToolButton(
        plus_icon,
        function ()
            NewDivision('division#'..tostring(DivisionNum))
            DivisionNum = DivisionNum + 1
        end,
        CurrentPlace.AEbuttons
    )
    
end

function ArmyEditor:update(dt)
    --button pos update
    New_Division.bx = ww/2 - 200
    New_Division.by = wh/2 - 280

end

function ArmyEditor:draw()
    if CurrentPlace.openarmyeditor then
        love.graphics.draw(ArmyEditor_screen, ww/2 - 200, wh/2 - 280)
        love.graphics.setColor(0,0,0)
        love.graphics.setFont(Rheadfont)
        love.graphics.print('Militry in '..CurrentPlace.name, ww/2 - 200 + 40, wh/2 - 280 + 40)
        love.graphics.setFont(Rtextfont)

        for i, division in ipairs(CurrentPlace.Army) do
            love.graphics.setColor(0.3,0.3,0.3)
            love.graphics.print('new regiment', ww/2 - 200 + 20, wh/2 - 280 + 20 + DivisionHight)
            love.graphics.setColor(0,0,0)
            love.graphics.setFont(Rheadfont)
            love.graphics.print(division.name, ww/2 - 200 + 20, wh/2 - 280 + DivisionHight)
            love.graphics.setFont(Rtextfont)

            division.delete.bx = ww/2 - 200 + 120
            division.delete.by = wh/2 - 280 + DivisionHight
            division.New_Regiment.bx = ww/2 - 200 + 120
            division.New_Regiment.by = wh/2 - 280 + 20 + DivisionHight
            division.DButtons:use()
            division.rgtHight = 0

            for n, regiment in ipairs(division) do
                love.graphics.setColor(0.3,0.3,0.3)
                love.graphics.print('new company', ww/2 - 200 + 128, wh/2 - 280 + 20 + DivisionHight + 20*n + division.rgtHight)
                love.graphics.setColor(0,0,0)
                love.graphics.print(regiment.name, ww/2 - 200 + 20, wh/2 - 280 + 20 + DivisionHight + 20*n + division.rgtHight)
                
                regiment.delete.bx = ww/2 - 200 + 20
                regiment.delete.by = wh/2 - 280 + 20 + DivisionHight + 20*n + division.rgtHight
                regiment.New_Company.bx = ww/2 - 200 + 200
                regiment.New_Company.by = wh/2 - 280 + 20 + DivisionHight + 20*n + division.rgtHight
                regiment.RButtons:use()

                for m, company in ipairs(regiment) do
                    love.graphics.setColor(0,0,0)
                    love.graphics.print(company.name, ww/2 - 200 + 128, wh/2 - 280 + 20 + DivisionHight + 20*n + division.rgtHight + 20*m)
                end

                division.rgtHight = division.rgtHight + 20 * #regiment
            end

            if i < #CurrentPlace.Army then
                DivisionHight = DivisionHight + 64 + 20 * #division + division.rgtHight
            else
                DivisionHight = 96
            end
        end
        CurrentPlace.AEbuttons:use()

    end
end

function NewDivision(name)
    local instance = {}
    instance.name = name
    instance.DButtons = buttons.new()
    instance.delete = buttons.newToolButton(
        minus_icon,
        function ()
            removeTable(CurrentPlace.Army, instance)
        end,
        instance.DButtons
    )
    instance.New_Regiment = buttons.newToolButton(
        plus_icon,
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
        minus_icon,
        function ()
            removeTable(division, instance)
        end,
        instance.RButtons
    )
    instance.New_Company = buttons.newToolButton(
        plus_icon,
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
        minus_icon,
        function ()
            removeTable(regiment, instance)
        end,
        instance.CButtons
    )
    table.insert(regiment, instance)
end
