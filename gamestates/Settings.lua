Settings = {}
Settings = Gamestate.new()

function Settings:init()
    Sbuttons=buttons.new()
    Apply=buttons.newButton(
        "Apply",
        function ()
            Gamestate.pop()
        end,
        Sbuttons
    )
    Back=buttons.newButton(
        "Back",
        function ()
            Gamestate.switch(ingame)
        end,
        Sbuttons
    )

end

function Settings:update()
    local ww, wh = love.graphics.getDimensions()
    Apply.bx=ww/2
    Apply.by=wh/2
    Back.bx=100
    Back.by=100
end

function Settings:draw()
    Sbuttons:use()
end