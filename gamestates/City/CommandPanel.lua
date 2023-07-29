CommandPanel = {}



function CommandPanel:load()
    local image = Command_icon
    local width = image:getWidth()
    local height = image:getHeight()
    CurrentPlace.CommandPanelWindow = Window.new(64, 64, 64+width, 64+height)
    self.buffer = ''
    self.a = {isv = 0, to = 1}
end


function CommandPanel:update(dt)
    if self.buffer == '`' then
        self.buffer = self.buffer:sub(1, -2)
    end
    if CurrentPlace.CommandPanelWindow.open == false and self.buffer ~= '' then
        self.buffer = ''
    end
    miss(self.a, dt)
end

function CommandPanel:draw()
    CurrentPlace.CommandPanelWindow:use(
        function ()
            love.graphics.draw(Command_icon)
            love.graphics.setColor(0, 0, 0) 
            if  self.buffer ~= '' then
                if self.a.isv <= 0.5 then
                    love.graphics.print(self.buffer..' I', 14, 134)
                elseif self.a.isv > 0.5 then
                    love.graphics.print(self.buffer, 14, 134)
                end
            else
                love.graphics.setColor(0, 179/255, 0)
                love.graphics.print('None', 14, 24)
            end  
            love.graphics.setColor(0, 0, 0)    
        end
    )
end

function miss(a, dt)
    local b = 2.5
    if a.isv > 0 and a.isv < 1 then
        a.isv = a.isv + b*a.to*dt
    end
    if a.isv <= 0 then
        a.isv = a.isv + dt*b
        a.to = 1
    elseif a.isv >=1 then
        a.isv = a.isv - dt*b
        a.to = -1
    end
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
        if key == "`" then
            if CurrentPlace.CommandPanelWindow.open == true then
                CurrentPlace.CommandPanelWindow.open = false
            else
                CurrentPlace.CommandPanelWindow.open = true
            end   
        end
        if CurrentPlace.CommandPanelWindow.open == true then
            CommandPanel:keypressed(key)
        end
    end
end

function CommandPanel:textinput(t)
    if self.buffer == 'No such cheat command' then
        self.buffer = ''
    end
    self.buffer = self.buffer .. t
end

function CommandPanel:keypressed(key)
    if key == "return" then
        local done1 = 0
        if self.buffer == 'buildtank' then
            Buildtank(CurrentPlace, Tanks.M1, 'enemy', 1000, 1000)
        else
            self.buffer = 'No such cheat command'
        end
    elseif key == "backspace" or key == "`" then
        if self.buffer == 'No such cheat command' then
        self.buffer = ''
        end
        self.buffer = self.buffer:sub(1, -2)
    end
end