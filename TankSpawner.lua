TankSpawner={}
TurretCollider={}

function TankSpawner:loadTank()
    
end

function TankSpawner:spawn(place)
    --table.insert(Exsistank,TankFunctions:newtank())
    TankColliders()
end

function TankColliders(place)
    table.insert(TurretCollider,world:newRectangleCollider(100 + 100*Dx, 100,100,100))
    local turretcollider={}
    Dx=Dx+1
end
function GetCollidersPositon()
    for i,j in (TurretCollider) do
    local x,y=body:GetCollidersPositon(j)
    end
end
function TankSpawner:draw(place)
    --[[for i,t in ipairs(Exsistank) do
        love.graphics.draw(t.hull_image)
        love.graphics.draw(t.turret_image)
    end]]
    for i, tank in ipairs(place.tankstock) do
        love.graphics.draw(tank.hull_image, 100 + 100*i, 100)
        love.graphics.draw(tank.armor.hull_image, 100 + 100*i, 100)
        love.graphics.draw(tank.turret_image, 100 + 100*i, 100)
        love.graphics.draw(tank.armor.turret_image, 100 + 100*i, 100)
    end
end

TankFunctions={}

function TankFunctions:newtank()
    local tankfactors=Factory.ProductionQueue
    local tank={}
    --[[name = TankPresent.name,
        hull_image = TankPresent.hull_image,
        turret_image = TankPresent.turret_image,
        armor = TankGear.armor,
        aim = TankGear.aim,
        ammo = TankGear.ammo,
        mob = TankGear.mob,]]
        return tank
end

--love.graphics.draw()
--world.newRectangleCollider()
--[[Exsistank={
    {
        name='t72'
        hull_image=...
        yuttt=..
        x=
        y=
        a=
        a
        r=

    }

    {
        name=...

    }
}]]