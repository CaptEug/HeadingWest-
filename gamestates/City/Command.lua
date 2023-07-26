Command = {}

function Command:load()
    CurrentPlace.Command = Window.new(64, 64, 432, 560)
    Command = {
        buffer = '',
        commands = {}
    }
    Command.commands['give_money'] = function(amount)
        -- 增加金钱量代码
    end

end

function Command:update(dt)

end

function love.textinput(t)
    Command.buffer = Command.buffer .. t
end

function love.keypressed(key)
    if key == 'return' then
        local commands, params = console.buffer:match('(%w+)%s*(.*)')
        Command.commands[commands](params)
        Command.buffer = ''
    elseif key == 'backspace' then
        Command.buffer = Command.buffer:sub(1, -2)
    end
 end


function Command:draw()

end