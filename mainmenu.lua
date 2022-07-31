mainmenu = {}

 Button = {}
 Button.__index = Button

function Button.new(text, fn)
    return {
            text = text,
            fn = fn,
            w = Rbuttonfont:getWidth(text),
            h = Rbuttonfont:getHeight(text)
    }
end


local ButtonColor = {1, 1, 1, 0.5}
local Hot 


function mainmenu:load()
    Europe = love.graphics.newImage('Europe.png')
    Rtitlefont = love.graphics.newFont('Russian.ttf', 100)
    Rbuttonfont = love.graphics.newFont('Russian.ttf', 50)
    
    Start = Button.new(
        "Путь!",
        function()
                
        end
    )
        
    Quit = Button.new(
        "Покидать",
        function()
            love.event.quit(0)   
        end
    )
    
end



function mainmenu:update(dt)
    ww, wh = love.graphics.getDimensions()
    
end



function mainmenu:draw()
    
    cam:attach()
        --love.graphics.draw(Europe, 0, 0)
    cam:detach()
    love.graphics.setFont(Rtitlefont)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("НА ЗАПАД!", ww / 2 - Rtitlefont:getWidth("НА ЗАПАД!") / 2, wh / 5)
    
    love.graphics.setColor(unpack(ButtonColor))
    love.graphics.setFont(Rbuttonfont)
    love.graphics.print(Start.text, ww / 2 - Start.w / 2, wh / 2)
    love.graphics.print(Quit.text, ww / 2 - Quit.w / 2, wh * 3 / 5)
end
