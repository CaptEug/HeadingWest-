function unfogArea(x, y, radius)
    love.graphics.setCanvas(shadowTexture)
    love.graphics.setBlendMode("replace")
    love.graphics.circle("fill", x, y, radius)
    love.graphics.setBlendMode("alpha") 
    love.graphics.setCanvas() 
end




mapShader = love.graphics.newShader [[
    extern Image mask;
    vec4 effect(vec4 color, Image tex, vec2 tc, vec2 pc) {
        vec4 texcolor = Texel(tex, tc);
        vec4 maskcolor = Texel(mask, tc);

        return texcolor * maskcolor;
    }
]]

love.graphics.setShader(mapShader)
mapShader:send("mask", shadowTexture)
love.graphics.draw(map)
love.graphics.setShader()


function love.draw()
    love.graphics.setShader(mapShader)
    mapShader:send("mask", shadowTexture)
    love.graphics.draw(map)
    love.graphics.setShader() 
end