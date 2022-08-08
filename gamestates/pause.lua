Pause = {}
Pause = Gamestate.new()

function Pause:enter(from)
    self.from = from -- record previous state
end

function Pause:draw()
    local W, H = love.graphics.getWidth(), love.graphics.getHeight()
    -- draw previous screen
    self.from:draw()
    -- overlay with pause message
    love.graphics.setColor(0,0,0, 100)
    love.graphics.rectangle('fill', 0,0, W,H)
    love.graphics.setColor(255,255,255)
    love.graphics.printf('PAUSE', 0, H/2, W, 'center')
end

function love.keypressed(key)
    if Gamestate.current() == testmap and key == 'p' then
        return Gamestate.push(Pause)
    end
end

function Pause:keypressed(key)
    if key == 'p' then
        return Gamestate.pop() -- return to previous state
    end
end