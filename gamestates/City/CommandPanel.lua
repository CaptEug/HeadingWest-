CommandPanel = {}

function CommandPanel:load()
    CurrentPlace.CommandPanelWindow = Window.new(64, 64, 432, 560)
    CommandPanel = {
        buffer = '',
        commands = {}
    }
    CommandPanel.commands['give_money'] = function(amount)
    end

end


function CommandPanel:update(dt)

end

function love.textinput(t)
    CommandPanel.buffer = CommandPanel.buffer .. t
end

function love.keypressed(key)
    if key == 'return' then
        local commands, params = console.buffer:match('(%w+)%s*(.*)')
        CommandPanel.commands[commands](params)
        CommandPanel.buffer = ''
    elseif key == 'backspace' then
        CommandPanel.buffer = CommandPanel.buffer:sub(1, -2)
    end
 end


function CommandPanel:draw()
    CurrentPlace.CommandPanelWindow:use(
        function ()
            love.graphics.draw(CityInfoPanel_screen)
            love.graphics.setColor(0,0,0)        
        end
    )
end