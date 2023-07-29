CommandPanel = {}


CommandPanel.cheats = {
    buildtank = function() 
   
    end
}

function CommandPanel:load()
    local image = Command_icon
    local width = image:getWidth()
    local height = image:getHeight()
    CurrentPlace.CommandPanelWindow = Window.new(64, 64, 64+width, 64+height)
    self.buffer = ''
end


function CommandPanel:update(dt)

end

function CommandPanel:draw()
    CurrentPlace.CommandPanelWindow:use(
        function ()
            love.graphics.draw(Command_icon)
            love.graphics.setColor(0, 179/255, 0) 
            if  self.buffer ~= '' then
                love.graphics.print(self.buffer, 24, 24)
            else
                love.graphics.print('None', 24, 24)
            end  
            love.graphics.setColor(0, 0, 0)    
        end
    )
end


function love.textinput(t)
    if CurrentPlace ~= nil then
        if CurrentPlace.CommandPanelWindow.open == true then
            CommandPanel:textinput(t)
        end
    end
end

function love.keypressed(key, scancode, isrepeat)
    if CurrentPlace ~= nil then
        if CurrentPlace.CommandPanelWindow.open == true then
            CommandPanel:keypressed(key)
        end
    end
end

function CommandPanel:textinput(t)
    self.buffer = self.buffer .. t
end

function CommandPanel:keypressed(key)
    if key == "return" then
        local cheat, params = self.buffer:match('(%w+)%s*(.*)')
        if self.cheats[cheat] then
            self.cheats[cheat](params)
        else
            print("No such cheat command", 14, 24)
        end
        self.buffer = ''
    elseif key == "backspace" then
        self.buffer = self.buffer:sub(1, -2)
    end
end