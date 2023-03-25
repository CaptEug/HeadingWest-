ArmyEditor = {}

function ArmyEditor:load()
    CurrentPlace.openarmyeditor = false
    CurrentPlace.AEbuttons = buttons.new()

    --load buttons
end

function ArmyEditor:update(dt)
    
end

function ArmyEditor:draw()
    if CurrentPlace.openarmyeditor then
        love.graphics.draw(ArmyEditor_screen, ww/2 - 176, wh/2 - 248)
        love.graphics.setColor(0,0,0)
        love.graphics.setFont(Rheadfont)
        love.graphics.print('Militry in '..CurrentPlace.name, ww/2 - 176 + 40, wh/2 - 248 + 40)
        love.graphics.setFont(Rtextfont)
    end
end