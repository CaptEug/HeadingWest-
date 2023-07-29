CommandPanel = {}

function CommandPanel:load()
    CurrentPlace.CommandPanelWindow = Window.new(64, 64, 432, 560)
    -- CommandPanelin = {
    --     buffer = '',
    --     commands = {}
    -- }
end


function CommandPanel:update(dt)

end

function CommandPanel:draw()
    CurrentPlace.CommandPanelWindow:use(
        function ()
            love.graphics.draw(tank_info_panel)
            love.graphics.setColor(0,0,0)        
        end
    )
end


-- function love.textinput(t)
--     CommandPanelin.buffer = CommandPanelin.buffer .. t
-- end

-- function love.keypressed(key)
--     if key == 'return' then
--         local commands, params = CommandPanelin.buffer:match('(%w+)%s*(.*)')
--         CommandPanelin.commands[commands](params)
--         CommandPanelin.buffer = ''
--     elseif key == 'backspace' then
--         CommandPanelin.buffer = CommandPanelin.buffer:sub(1, -2)
--     end
--  end
