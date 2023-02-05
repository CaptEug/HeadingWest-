TankSpawner={}
HullColliders={}
TurretColliders={}
Number=1
Portnumber=1
Uvzportlocation={
    {x=12,y=48},
    {x=12,y=48+256*1},
    {x=12,y=48+256*2},
    {x=12,y=48+256*3},
    {x=12,y=48+256*4},
    {x=12,y=48+256*5},
    {x=12,y=48+256*6},
    {x=12,y=48+256*7},
    {x=12+544,y=48},
    {x=12+544,y=48+256*1},
    {x=12+544,y=48+256*2},
    {x=12+544,y=48+256*3},
    {x=12+544,y=48+256*4},
    {x=12+544,y=48+256*5},
    {x=12+544,y=48+256*6},
    {x=12+544,y=48+256*7},
}

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

function TankSpawner:update()
    
end

function TankSpawner:findspwanlocation(place)
    
    local portstatus=true
    local building_slot=place.building_slot
    local x,y=Uvzportlocation[Portnumber].x,Uvzportlocation[Portnumber].y
    
    Portnumber=Portnumber+1
return x,y,portstatus
end

function TankSpawner:load()
    world:addCollisionClass('tankhull')
    world:addCollisionClass('tankturret',{ignores={'tankhull'}})
end

function TankSpawner:testspawn(place)
    --[[for i,tank in ipairs(place.tankstock) do
        local x,y,w,h=100,200,tank.width,tank.length

        local hullcollider=world:newRectangleCollider(x+100*Dx , y,w,h)
        hullcollider:setCollisionClass('tankhull')
        table.insert(HullColliders,hullcollider)
        --[[local turretcollider=world:newCircleCollider(x+100*Dx+w/2,y+h/2,25)
        turretcollider:setCollisionClass('tankturret')
        table.insert(TurretColliders,turretcollider)]]
        --[[place.tankstock[i].width
    end]]
    local x,y,portstatus=TankSpawner:findspwanlocation(place)
    if portstatus==true then
        local w,h=place.tankstock[Number].width,place.tankstock[Number].length
        local hullcollider=world:newRectangleCollider(x+100*Dx , y,w,h)

        hullcollider:setCollisionClass('tankhull')
        table.insert(HullColliders,hullcollider)
    end
end

function TankSpawner:testdraw(place)
    if HullColliders~=nil then
        for i,tank in ipairs(place.tankstock) do
            local x,y=HullColliders[i]:getPosition()
            local a=HullColliders[i]:getAngle()
            local ox=tank.hull_image:getWidth()/2
            local oy=tank.hull_image:getHeight()/2
            
            love.graphics.draw(tank.hull_image, x, y, a, 1, 1, ox, oy)
            love.graphics.draw(tank.armor.hull_image, x, y, a, 1, 1, ox, oy)
            love.graphics.draw(tank.turret_image, x, y, a, 1, 1, ox, oy)
            love.graphics.draw(tank.armor.turret_image, x, y, a, 1, 1, ox, oy)
        end
    end
end

TankFunctions={}

function TankFunctions:move()
    
end