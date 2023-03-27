ArmyEditor = {}

function ArmyEditor:load()
    CurrentPlace.openarmyeditor = false
    CurrentPlace.AEbuttons = buttons.new()
    --load buttons
    New_Division = buttons.newToolButton(
        plus_icon,
        function ()
            NewDivision('division 1')
        end,
        CurrentPlace.AEbuttons
    )
    
end

function ArmyEditor:update(dt)
    
end

function ArmyEditor:draw()
    if CurrentPlace.openarmyeditor then
        love.graphics.draw(ArmyEditor_screen, ww/2 - 200, wh/2 - 280)
        love.graphics.setColor(0,0,0)
        love.graphics.setFont(Rheadfont)
        love.graphics.print('Militry in '..CurrentPlace.name, ww/2 - 200 + 40, wh/2 - 280 + 40)
        love.graphics.setFont(Rtextfont)
    end
end

function NewDivision(name)
    local instance = {}
    instance.name = name
    instance.DButtons = buttons.new()
    instance.delete = buttons.newToolButton()
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
    instance.type = 'tank'
    instance.RButtons = buttons.new()
    instance.delete = buttons.newToolButton()
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
    instance.CButtons = buttons.new()
    instance.delete = buttons.newToolButton()
    table.insert(regiment, instance)
end
