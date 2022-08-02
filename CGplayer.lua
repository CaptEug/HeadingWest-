CG = {}
CG.__index = CG

function CG.new(filename)
    local instance = setmetatable({}, CG)
    instance.video = love.graphics.newVideo(filename)
    return instance
end

function CG:playCG()
    self.video:play()
    if love.graphics.getWidth() / love.graphics.getHeight() < 720 / 480 then
        love.graphics.draw(
            self.video,
            0,
            love.graphics.getHeight() / 2 - (480 * love.graphics.getWidth())/ (2 * 720),
            0,
            love.graphics.getWidth() / 720
        )   
    else
        love.graphics.draw(
            self.video,
            love.graphics.getWidth() / 2 - (720 * love.graphics.getHeight())/ (2 * 480),
            0,
            0,
            love.graphics.getHeight() / 480
        )
    end
end