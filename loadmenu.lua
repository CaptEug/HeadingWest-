Loadmenu = {}
Loadmenu = Gamestate.new()

function Loadmenu:init()
    Rtitlefont = love.graphics.newFont('Russian.ttf', 100)
    Rbuttonfont = love.graphics.newFont('Russian.ttf', 50)
    
    --Red_Europe = love.graphics.newImage('Europe/Red_Europe.png')

    EUw, EUh = Red_Europe:getDimensions()
    BandWshader = love.graphics.newShader(BandWshader_code)MainMenu = {}
    MainMenu = Gamestate.new()    
end

function Loadmenu:update(dt)
    world:update(dt)
    MAUS1:move(dt)
end

function Loadmenu:draw()
    Gbuttons:use()
    
    cam:attach()
        --gamemap:drawLayer(gamemap.layers["ground"])
        MAUS1:use()
        --gamemap:drawLayer(gamemap.layers["veg"])
        --gamemap:drawLayer(gamemap.layers["top"])
        SetColliders:draw("objects/Spike1.png")
        world:draw()
        
    cam:detach()
end