CommandPanel = {}

local tanklistmap = {
    ['M1'] = Tanks.M1,
    ['m1'] = Tanks.M1,
}

function CommandPanel:load()
    local image = Command_icon
    local width = image:getWidth()
    local height = image:getHeight()
    CurrentPlace.CommandPanelWindow = Window.new(0, 500, width, height)
    self.bufferlist = {}
    self.buffer = ''
    self.a = {isv = 0, to = 1}
    self.menmery = ''
    self.index = 0
    self.histroy = {}
    self.vistion = 1
    self.now = {}
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
            local word = self.now[#self.now] or ''
            if self.a.isv <= 0.5 then
                love.graphics.print(': '..word..'_', 10, 135)
            elseif self.a.isv > 0.5 then
                love.graphics.print(': '..word, 10, 135)
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
        if CurrentPlace.CommandPanelWindow.open == true and key ~= "`" then
            CommandPanel:keypressed(key)
        end
    end
end




function CommandPanel:textinput(t)
    self.buffer = self.buffer .. t
    if t ~= '`' then
        if self.now[#self.now] ~= nil then
            local bufferlength = Rtextfont:getWidth(self.now[#self.now])
            local tlength = Rtextfont:getWidth(t)
            if bufferlength + tlength >= 600 then
                table.insert(self.now, t)
            else
                self.now[#self.now] =  self.now[#self.now] .. t
            end
        else
            table.insert(self.now, t)
        end
    end
end

function CommandPanel:keypressed(key)
    if key == "return" then
        if self.buffer ~= nil then
            local b = {}

            for str in string.gmatch(self.buffer, "[^,]+") do
                table.insert(b, str)
            end
            if b[1] ~= nil then
                string.lower(b[1])
                if b[1] == 'buildtank' then
                    local tkname = tanklistmap[b[2]]
                    if tkname ~= nil then
                        local x = tonumber(b[3]) or 0
                        local y = tonumber(b[4]) or 0
                        local full = true
                        Buildtank(CurrentPlace, tkname, 'friendly', x, y, full)
                        table.insert(self.histroy, {buffer = self.buffer})
                        self.menmery = self.buffer
                        self.buffer = ''
                        table.insert(self.bufferlist, {buffer = 'Buidtank aready! :>'})
                    else
                        table.insert(self.histroy, {buffer = self.buffer})
                        self.menmery = self.buffer
                        self.buffer = ''
                        table.insert(self.bufferlist, {buffer = 'No such tank, please check if the name is entered correctly... :<'})
                    end
                else
                    table.insert(self.histroy, {buffer = self.buffer})
                    self.menmery = self.buffer
                    self.buffer = ''
                    table.insert(self.bufferlist, {buffer = 'That command does not exist!'})
                end
            end
        end
    elseif key == "backspace" or key == "`" then
        if self.buffer ~= '' then
            if self.buffer == 'That command does not exist!' then
            self.buffer = ''
            end
            self.buffer = self.buffer:sub(1, -2)
            if self.now[#self.now] ~= '' then
                self.now[#self.now] = self.now[#self.now]:sub(1, -2)
            else
                table.remove(self.now, #self.now)
            end
        end
    elseif key == "up" then
        if #self.histroy ~= 0 and self.index <= #self.histroy - 1 then
            self.index = self.index + 1
            self.buffer = self.histroy[#self.histroy - (self.index-1)].buffer
        end
    elseif key == "down" then
        if #self.histroy ~= 0 then
            if self.index >= 2 then
                self.index = self.index - 1
                self.buffer = self.histroy[#self.histroy - (self.index-1)].buffer
            elseif self.index == 1 then
                self.index = 0
                self.buffer = self.menmery
            end
        end
    end
end