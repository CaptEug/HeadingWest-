Command = {}

function Command:load()
    CurrentPlace.Command = Window.new(64, 64, 432, 560)
    Command = {
        buffer = '',
        commands = {}
    }


end

function Command:update(dt)

end

function love.textinput(t)
    Command.buffer = Command.buffer .. t
end

function love.keypressed(key)
    if key == 'return' then
       local commands, params = console.buffer:match('(%w+)%s*(.*)')
       console.commands[commands](params)
       console.buffer = ''
    elseif key == 'backspace' then
       console.buffer = console.buffer:sub(1, -2)
    end
 end


function Command:draw()

end