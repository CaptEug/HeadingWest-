TankSpawner={}
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

function TankSpawner:scan_slot(place)
    local slot_number
    for i, slot in ipairs(Uvz_SlotInfo) do
        if slot.available==false then
            slot_number=i
            break
        else

        end
    end
    return Uvz_SlotInfo[slot_number].x,Uvz_SlotInfo[slot_number].y,slot_number
end

function TankSpawner:slot_distribution()
    for i, slot in ipairs(Uvz_SlotInfo) do
        if slot.available==true then
            slot.available=false
            break
        end
    end
end

function TankSpawner:new_tank(place,new_tankdata)
    local x,y,slot_number=TankSpawner:scan_slot(place)

        local w,h=new_tankdata.width,new_tankdata.length
        local tank_collider=world:newRectangleCollider(x,y,w,h)
        tank_collider:setCollisionClass('tankhull')

        local tank={}
        tank.collider=tank_collider
        tank.data=new_tankdata
        tank.functions = {}
        tank.functions.move=function (i)
            if love.keyboard.isDown('g') then
                place.exsist_tank[i].collider:setLinearVelocity(10, 10)
                place.exsist_tank[i].collider:setAngularVelocity(10)
            end

            if love.keyboard.isDown('h') then
                place.exsist_tank[i].collider:setLinearVelocity(0, 0)
                place.exsist_tank[i].collider:setAngularVelocity(0)
            end

        end
        tank.Infobuttons = buttons.new()
        local tankbutton = buttons.newCampicButton(
            Gear,
            function ()
                TankPanelopen = true
                TankChoosen = tank
            end,
            tank.Infobuttons,
            x,
            y
        )

        table.insert(place.exsist_tank, tank)
        Uvz_SlotInfo[slot_number].available=true
end

function TankSpawner:update(dt)
    for i, tank in ipairs(CurrentPlace.exsist_tank) do
        tank.functions.move(i)
    end
end

function TankSpawner:draw_tank()
    for i, tank in ipairs(CurrentPlace.exsist_tank) do
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