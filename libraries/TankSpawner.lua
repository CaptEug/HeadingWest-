TankSpawner={}
SlotSequence={}
Portnumber=1
Port_isavailable=true
TankPanelopen = false

Uvz_SlotInfo={
    {x=112,y=48,available=true},
    {x=112,y=48+256*1,available=true},
    {x=112,y=48+256*2,available=true},
    {x=112,y=48+256*3,available=true},
    {x=112,y=48+256*4,available=true},
    {x=112,y=48+256*5,available=true},
    {x=112,y=48+256*6,available=true},
    {x=112,y=48+256*7,available=true},
    {x=112+544,y=48,available=true},
    {x=112+544,y=48+256*1,available=true},
    {x=112+544,y=48+256*2,available=true},
    {x=112+544,y=48+256*3,available=true},
    {x=112+544,y=48+256*4,available=true},
    {x=112+544,y=48+256*5,available=true},
    {x=112+544,y=48+256*6,available=true},
    {x=112+544,y=48+256*7,available=true},
}

function TankSpawner:load_collider(place)

    Exsistank={} 
    
    --[[for i, tank in ipairs(place) do
        local tank_collider=world:newBSGRectangleCollider(tank.x,tank.y,tank.width,tank.length)
        tank_collider:setAngle(tank.angle)
        tank_collider:setCollisionClass('tank_hull')
        table.insert(HullColliders,tank_collider)
    end]]
    
end

function TankSpawner:slotOperate()
    for i,SlotNumber in ipairs(Uvz_SlotInfo) do
        if SlotNumber.available==true then
            Portnumber=i
            --port_isavailable=true
            table.insert(SlotSequence,Portnumber)
            SlotNumber.available=false
            break
        --[[else if CurrentPlace.ProductionNumber> CurrentPlace.building_slot then
            local minimum_time_number=0
                for i, tank in ipairs(CurrentPlace.ProductionQueue) do
                    if minimum_time_number>tank.buildtime then
                        minimum_time_number=tank.buildtime
                    end
                    if i>17 then
                        break
                    end
                end
            end]]
        end
    end
end

function TankSpawner:findspwanlocation(place)
    local port_isavailable=true
    local building_slot=place.building_slot
    local n=SlotSequence[1]
    if SlotSequence[1] ~=nil then
        local x,y=Uvz_SlotInfo[n].x,Uvz_SlotInfo[n].y
        return x,y,port_isavailable,n
    end
end

function TankSpawner:new_tank(place,new_tankdata)
    local x,y,port_isavailable,n=TankSpawner:findspwanlocation(place)
    if port_isavailable==true then
        local w,h=new_tankdata.width,new_tankdata.length
        local tank_collider=world:newRectangleCollider(x,y,w,h)
        tank_collider:setCollisionClass('tankhull')

        local tank={}
        tank.collider=tank_collider
        tank.data=new_tankdata
        tank.functions={}

        tank.functions.move=function (i)
            if love.keyboard.isDown('g') then
                Exsistank[i].collider:setLinearVelocity(10, 10)
                Exsistank[i].collider:setAngularVelocity(10)
            end

            if love.keyboard.isDown('h') then
                Exsistank[i].collider:setLinearVelocity(0, 0)
                Exsistank[i].collider:setAngularVelocity(0)
            end

        end

        table.insert(Exsistank,tank)

        Uvz_SlotInfo[n].available=true
        table.remove(SlotSequence,1)
    end
end

function TankSpawner:update(dt)
    for i, tank in ipairs(Exsistank) do
        tank.functions.move(i)
    end
end

function TankSpawner:draw_tank()
    for i, tank in ipairs(Exsistank) do
        if tank.collider==nil then
            return nil
        end

        local x,y=tank.collider:getPosition()
        local a=tank.collider:getAngle()
        local offset_x=tank.data.hull_image:getWidth()/2
        local offset_y=tank.data.hull_image:getHeight()/2+tank.data.turret_offset

        love.graphics.draw(tank.data.hull_image,x,y,a,1,1,offset_x,offset_y)
        love.graphics.draw(tank.data.armor.hull_image,x,y,a,1,1,offset_x,offset_y)
        love.graphics.draw(tank.data.turret_image,x,y,a,1,1,offset_x,offset_y)
        love.graphics.draw(tank.data.aim.turret_image,x,y,a,1,1,offset_x,offset_y)
        love.graphics.draw(tank.data.armor.turret_image,x,y,a,1,1,offset_x,offset_y)
    end
end

TankFunctions={}

function TankFunctions:move()
    
end