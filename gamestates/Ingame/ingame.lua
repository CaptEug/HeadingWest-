ingame = {}
ingame = Gamestate.new()
Ingamebuttons = {}

require 'gamestates.Ingame.ingameUI'
require 'gamestates/Ingame/Mapdrawer'
require 'Data.Tank.TankSpawner'
require 'Data.Constructure.ConstructureSpawner'
require 'gamestates.Ingame.TimeToShoot'
require 'gamestates/Ingame/TimeToBomb'
require 'gamestates/Ingame/TimeToLaunchMissile'

function ingame:init()
    DestroyAll()
    local map=Maps[MapNumber]
    loadMap(map)
    ingameUI:load()
    Buildtank(CurrentPlace, Tanks.M1, 'enemy', 1500, 500)
    Buildtank(CurrentPlace, IFVs.BMP2, 'enemy', 1500, 0)
    Buildtank(CurrentPlace, Tanks.T90, 'friendly', 500, 500)
    BuildConstructure(CurrentPlace, Constructures.Maxim_Gorky, 'enemy', 2000, 3000)
end

function ingame:update(dt)
    world:update(dt)
    particleworld:update(dt)
    TankSpawner:update(dt)
    ConstructureSpawner:update(dt)
    TankProjectiles:update(dt)
    Missiles:update(dt)
    Explosives:update(dt)
    Fragments:update(dt)
    ingameUI:update(dt)
    --cam contral
    if cam.scale > 2 then
        cam:zoomTo(2)
    end
    if cam.scale < 0.2 then
        cam:zoomTo(0.2)
    end
    --mouse input
    function love.mousepressed(x, y, button)
        SelectionMousePressed(x, y, button)
        if CurrentPlace.openTankDesigner then
            TDmousepressed(x, y, button)
        end
        if CurrentPlace.openCityInfoPenal then
            AEmousepressed(x, y, button)
        end
        if CurrentPlace.openConstructMenu then
            CMmousepressed(x, y, button)
        end
        if TankPanelopen then
            TPmousepressed(x, y, button)
        end
    end
    function love.mousereleased(x, y, button)
        SelectionMouseReleased(x, y, button)
        if CurrentPlace.openTankDesigner then
            TDmousereleased(x, y, button)
        end
        if CurrentPlace.openCityInfoPenal then
            AEmousereleased(x, y, button)
        end
        if CurrentPlace.openConstructMenu then
            CMmousereleased(x, y, button)
        end
        if TankPanelopen then
            TPmousereleased(x, y, button)
        end
        BuildDetact(button)
        
    end
    function love.mousemoved(x, y, dx, dy)
        if CurrentPlace.openTankDesigner then
            TDmousemoved(x, y, dx, dy)
        end
        if CurrentPlace.openCityInfoPenal then
            AEmousemoved(x, y, dx, dy)
        end
        if CurrentPlace.openConstructMenu then
            CMmousemoved(x, y, dx, dy)
        end
        if TankPanelopen then
            TPmousemoved(x, y, dx, dy)
        end
    end
end

function ingame:draw()
    cam:attach()
        DrawMapDown()
        TankSpawner:drawtank()
        ConstructureSpawner:drawbuilding()
        DrawMapUp()
        world:draw()
        particleworld:draw()
        TankProjectiles:draw()
    cam:detach()

    ingameUI:draw()
end

function ingame:drawWithoutUI()
    cam:attach()
        DrawMapDown()
        TankSpawner:drawtank()
        DrawMapUp()
        world:draw()
        particleworld:draw()
        TankProjectiles:draw()
    cam:detach()
end
