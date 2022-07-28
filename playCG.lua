CG = {}




function CG.new(name)
    local instance = setmetatable({}, CG)
    instance.video = love.video.newVideo("")
end


function CG:playCG()
    if love.graphics.getWidth() / love.graphics.getHeight() < 720 / 480 then
        love.graphics.draw(
            self.video,
            0,
            love.graphics.getHeight() / 2 - (heightVideo * love.graphics.getWidth())/ (2 * widthVideo),
            0,
            love.graphics.getWidth() / widthVideo
        )   
    else
        love.graphics.draw(
            video,
            love.graphics.getWidth() / 2 - (widthVideo * love.graphics.getHeight())/ (2 * heightVideo),
            0,
            0,
            love.graphics.getHeight() / heightVideo
        )
    end
end

