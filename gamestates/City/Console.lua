Console = {}

function Console:load()
    Consolescreen = love.graphics.newCanvas(384, 64)
    Console.window = {x = ww/2 - 192, y = wh - 64, w = 384, h = 64}
    OpenConsole = false

    Console.Buttons = Buttons.new()
    
    Offence = Buttons.newWindowToolButton(
        Offence_icon,
        function ()
            for i, tank in ipairs(CurrentPlace.exsist_tank) do
            end
        end,
        Console.window,
        Console.Buttons,
        128,
        32
    )

    Fortify = Buttons.newWindowToolButton(
        Fortify_icon,
        function ()
            for i, tank in ipairs(CurrentPlace.exsist_tank) do

            end
        end,
        Console.window,
        Console.Buttons,
        192,
        32
    )

    Resupply = Buttons.newWindowToolButton(
        Resupply_icon,
        function ()
            for i, tank in ipairs(CurrentPlace.exsist_tank) do
                if tank.picked and tank.type == 'friendly' then
                    
                end
            end
        end,
        Console.window,
        Console.Buttons,
        256,
        32
    )

    --square Selection
    Selection = {}
    Selection.active = false
end

function Console:update(dt)
    Console.window.x = ww/2 - 192
    Console.window.y = wh - 64
    OpenConsole = false
    for i, tank in ipairs(CurrentPlace.exsist_tank) do
        if tank.picked then
            OpenConsole = true
        end 
    end
end

function Console:draw()
    --draw selection
    if Selection.active and Cursormode == 'normal' then
        love.graphics.setColor(0,179/255,0)
        love.graphics.rectangle("line", Selection.startX, Selection.startY,
        love.mouse.getX() - Selection.startX, love.mouse.getY() - Selection.startY)
        love.graphics.setColor(1,1,1)
    end


    if OpenConsole then
        love.graphics.setCanvas(Consolescreen)
        love.graphics.draw(Console_screen)
        Console.Buttons:use()
        love.graphics.setCanvas()
        love.graphics.draw(Consolescreen, Console.window.x, Console.window.y)
    end
end

function SelectionMousePressed(x, y, button)
    if button == 1 and Cursormode == 'normal' then
        Selection.active = true
        Selection.startX = x
        Selection.startY = y
    end
end

function SelectionMouseReleased(x, y, button)
    if button == 1 and Selection.active then
        Selection.active = false
        Selection.endX = x
        Selection.endY = y
        if Selection.startX ~= Selection.endX and Selection.startY ~= Selection.endY then
            for i, tank in ipairs(CurrentPlace.exsist_tank) do
                local x,y = cam:cameraCoords(tank.location.x, tank.location.y)
                if ((x > Selection.startX and x < Selection.endX) or (x < Selection.startX and x > Selection.endX)) and 
                ((y > Selection.startY and y < Selection.endY) or (y < Selection.startY and y > Selection.endY)) then
                    if tank.type == 'friendly' then
                        tank.picked = true
                    end
                else
                    tank.picked = false
                end
            end
        end
        for i, tank in ipairs(CurrentPlace.exsist_tank) do
            if tank.picked == true then
                tank.functions.move = MouseControlfunction
            else
                tank.functions.move = AutoControlfunction
            end
        end  
    end
end