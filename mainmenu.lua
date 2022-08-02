MainMenu = {}
MainMenu = Gamestate.new()
require 'chapters/Berlin'

local buttons = {}

function buttons.newButton(text, fn)
    local instance = {
            text = text,
            fn = fn,
            w = Rbuttonfont:getWidth(text),
            h = Rbuttonfont:getHeight(text),
            now = false,
            last = false
    }
    table.insert(buttons, instance)
    return instance
end

function buttons:use()
    for k, button in ipairs(buttons) do
        local ButtonColor = {1, 1, 1, 0.5}
        local bx = ww / 2 - button.w / 2
        local by = wh / 2 + 80 * k
        local mx, my = love.mouse.getPosition()
        local Hot = mx>=bx and mx<=bx+button.w and my>=by and my<=by+button.h
        
        love.graphics.setFont(Rbuttonfont)
        
        if Hot then
            ButtonColor ={1, 0.2, 0.2, 1}
        end
        
        if love.mouse.isDown(1) and Hot then
            button.fn()
        end
        
        love.graphics.setColor(unpack(ButtonColor))
        love.graphics.print(button.text, bx, by)
    end
    love.graphics.setColor(1, 1, 1)
end



function MainMenu:init()
    StartState = false
    
    Rtitlefont = love.graphics.newFont('Russian.ttf', 100)
    Rbuttonfont = love.graphics.newFont('Russian.ttf', 50)
    
    Europe = love.graphics.newImage('Europe.png')
    EUw, EUh = Europe:getDimensions()
    
    Start = buttons.newButton(
        "Путь!",
        function()
            Gamestate.switch(testmap)
        end
    )
    
    Quit = buttons.newButton(
        "Покидать",
        function()
            love.event.quit(0)   
        end
    )
end



function MainMenu:update(dt)
    
end



function MainMenu:draw()
    cam:attach()
        love.graphics.setShader(BandWshader)
        love.graphics.draw(Europe, ww / 2 - EUw / 2, wh / 2 - EUh / 2)
        love.graphics.setShader(nil)
    cam:detach()
    
    love.graphics.setFont(Rtitlefont)
    love.graphics.print("НА ЗАПАД!", ww / 2 - Rtitlefont:getWidth("НА ЗАПАД!") / 2, wh / 5)
    
    buttons:use()
end