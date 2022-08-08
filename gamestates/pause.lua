-- pause gamestate
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

