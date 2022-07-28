CG = {}
CG.__index = CG



CG1 = love.graphics.newVideo('OP.ogv')



function CG:playCG(dt)
    self:play()
    if love.graphics.getWidth() / love.graphics.getHeight() < 720 / 480 then
        love.graphics.draw(
            self,
            0,
            love.graphics.getHeight() / 2 - (480 * love.graphics.getWidth())/ (2 * 720),
            0,
            love.graphics.getWidth() / 720
        )   
    else
        love.graphics.draw(
            self,
            love.graphics.getWidth() / 2 - (720 * love.graphics.getHeight())/ (2 * 480),
            0,
            0,
            love.graphics.getHeight() / 480
        )
    end
end

