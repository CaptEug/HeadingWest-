mainmenu = {}

local buttons = {}

function newButton(text, fn)
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



function mainmenu:load()
    Europe = love.graphics.newImage('Europe.png')
    EUw, EUh = Europe:getDimensions()
    Rtitlefont = love.graphics.newFont('Russian.ttf', 100)
    Rbuttonfont = love.graphics.newFont('Russian.ttf', 50)
    
    Start = newButton(
        "Путь!",
        function()
            Berlin:draw()
            
        end
    )
    
    Quit = newButton(
        "Покидать",
        function()
            love.event.quit(0)   
        end
    )
    
end



function mainmenu:update(dt)
    ww, wh = love.graphics.getDimensions()

    local cx, cy = cam:position()
    if cx < ww - EUw / 2 then
        cam:lockX(ww - EUw / 2)
    end
    if cx > EUw / 2 then
        cam:lockX(EUw / 2)
    end
    if cy < wh - EUh / 2 then
        cam:lockY(wh - EUh / 2)
    end
    if cy > EUh / 2 then
        cam:lockY(EUh / 2)
    end
end



function mainmenu:draw()
    
    cam:attach()
        love.graphics.setColor(1, 1, 1, 0.7)
        love.graphics.draw(Europe, ww / 2 - EUw / 2, wh / 2 - EUh / 2)
    cam:detach()
    
    love.graphics.setFont(Rtitlefont)
    love.graphics.print("НА ЗАПАД!", ww / 2 - Rtitlefont:getWidth("НА ЗАПАД!") / 2, wh / 5)
    
    for k, button in ipairs(buttons) do
        button.last = button.now
        
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