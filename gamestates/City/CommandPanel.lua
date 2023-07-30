CommandPanel = {}



function CommandPanel:load()
    local image = Command_icon
    local width = image:getWidth()
    local height = image:getHeight()
    CurrentPlace.CommandPanelWindow = Window.new(0, 500, width, height)
    self.bufferlist = {}
    self.buffer = ''
    self.a = {isv = 0, to = 1}
    self.index = 0
end



function findIndex(a, B)
    for i, value in ipairs(B) do
        if value == a then
            return i
        end
    end
    return nil
end


function CommandPanel:update(dt)
    if self.buffer == '`' then
        self.buffer = self.buffer:sub(1, -2)
    end
    if CurrentPlace.CommandPanelWindow.open == false and self.buffer ~= '' then
        self.buffer = ''
    end
    miss(self.a, dt)
    if #self.bufferlist > 10 then
        table.remove(self.bufferlist, 1)
    end 
end

function CommandPanel:draw()
    CurrentPlace.CommandPanelWindow:use(
        function ()
            love.graphics.draw(Command_icon)
            love.graphics.setColor(0, 0, 0) 
            if self.a.isv <= 0.5 then
                love.graphics.print(': '..self.buffer..'_', 10, 135)
            elseif self.a.isv > 0.5 then
                love.graphics.print(': '..self.buffer, 10, 135)
            end
            for i, buffer in ipairs(self.bufferlist) do
                love.graphics.setColor(0, 179/255, 0)
                love.graphics.print(buffer.buffer, 10, 3+(i-1)*12)
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
    self.buffer = self.buffer .. t
end

function CommandPanel:keypressed(key)
    if key == "return" then
        local done1 = 0
        if self.buffer == 'buildtank' then
            Buildtank(CurrentPlace, Tanks.M1, 'enemy', 1000, 1000)
            self.buffer = ''
            table.insert(self.bufferlist, {buffer = 'buidtank aready!'})
        else
            self.buffer = ''
            table.insert(self.bufferlist, {buffer = 'No such cheat command!'})
        end
    elseif key == "backspace" or key == "`" then
        if self.buffer == 'No such cheat command' then
        self.buffer = ''
        end
        self.buffer = self.buffer:sub(1, -2)
    elseif key == "up" then
        if #self.bufferlist ~= 0 then
            self.index = self.index + 1
            self.buffer = self.bufferlist[- self.index]
        end
    elseif key == "down" then
        if #self.bufferlist ~= 0 then
            if self.index >= 1 then
                self.index = self.index - 1
                self.buffer = self.bufferlist[- self.index]
            end
        end
    end
end