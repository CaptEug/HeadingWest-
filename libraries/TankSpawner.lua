TankSpawner={}
HullColliders={}
TurretColliders={}
Number=1
Portnumber=1
UvzSlotInfo={
    {x=12,y=48,available=true},
    {x=12,y=48+256*1,available=true},
    {x=12,y=48+256*2,available=true},
    {x=12,y=48+256*3,available=true},
    {x=12,y=48+256*4,available=true},
    {x=12,y=48+256*5,available=true},
    {x=12,y=48+256*6,available=true},
    {x=12,y=48+256*7,available=true},
    {x=12+544,y=48,available=true},
    {x=12+544,y=48+256*1,available=true},
    {x=12+544,y=48+256*2,available=true},
    {x=12+544,y=48+256*3,available=true},
    {x=12+544,y=48+256*4,available=true},
    {x=12+544,y=48+256*5,available=true},
    {x=12+544,y=48+256*6,available=true},
    {x=12+544,y=48+256*7,available=true},
}
SlotSequence={}

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

function TankSpawner:load()
    world:addCollisionClass('tankhull')
    world:addCollisionClass('tankturret',{ignores={'tankhull'}})
end

function TankSpawner:slotOperate()
    for i,SlotNumber in ipairs(UvzSlotInfo) do
        if SlotNumber.available==true then
            Portnumber=i
            --port_isavailable=true
            table.insert(SlotSequence,Portnumber)
            SlotNumber.available=false
            break
        else
            Port_isavailable=false
        end
    end
end

function TankSpawner:findspwanlocation(place)
    
    local port_isavailable=true
    local building_slot=place.building_slot
    local n=SlotSequence[1]
    if SlotSequence[1] ~=nil then
        local x,y=UvzSlotInfo[n].x,UvzSlotInfo[n].y
        return x,y,port_isavailable,n
    end
end

function TankSpawner:testspawn(place)
    local x,y,port_isavailable,n=TankSpawner:findspwanlocation(place)
    if port_isavailable==true then
        local w,h=place.tankstock[Number].width,place.tankstock[Number].length
        local hullcollider=world:newRectangleCollider(x+100*Dx , y,w,h)

        hullcollider:setCollisionClass('tankhull')
        table.insert(HullColliders,hullcollider)
        Number=Number+1
        UvzSlotInfo[n].available=true
        table.remove(SlotSequence,1)
    end
end

function TankSpawner:testdraw(place)
    for i,tank in ipairs(place.tankstock) do
        if HullColliders[i]~=nil then
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