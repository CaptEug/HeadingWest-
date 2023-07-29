ResearchPanel = {}

function ResearchPanel:load()
    CurrentPlace.ResaerchWindow = Window.new(64, 64, 640, 480)

    Close = Buttons.newWindowToolButton(
        Close_icon,
        function ()
            CurrentPlace.ResaerchWindow.open = false
        end,
        CurrentPlace.ResaerchWindow,
        CurrentPlace.ResaerchWindow.buttons,
        625,
        18
    )


end

function ResearchPanel:update()
    
end

function ResearchPanel:draw()
    CurrentPlace.ResaerchWindow:use(
        function ()
            love.graphics.draw(TechTreePanel_screen)
        end
    )
end