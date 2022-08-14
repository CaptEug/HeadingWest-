require "tanks_new"

function love.load()
    m = Tanks.new()
    local a = m:newtank("shushu.txt", 200, 200)
    local b = m:newtank("shushu.txt", 400, 200)
    m:addai(b, keybroadcontrol)

end

function love.update(dt)
    m:update(dt)
end

function love.draw()
    m:draw()
end
