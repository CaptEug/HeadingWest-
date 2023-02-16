TankSpawner={}
HullColliders={}
TurretColliders={}
SlotSequence={}
Number=1
Portnumber=1
Port_isavailable=true
TankPanelopen = false

UvzSlotInfo={
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
    for i, tank in ipairs(place) do
        local tank_collider=world:newBSGRectangleCollider(tank.x,tank.y,tank.width,tank.length)
        tank_collider:setAngle(tank.angle)
        tank_collider:setCollisionClass('tank_hull')
        table.insert(HullColliders,tank_collider)
    end
end

--[[function TankSpawner:load()
    --add tankinfopanel button
    for i,tank in ipairs(CurrentPlace.tankstock) do
        tank.Infobutton = buttons.new()
        local button = buttons.newCamButton(
            invisible_button,
            function ()
                TankPanelopen = true
                TankInfoPanel(tank)
            end,
            tank.Infobutton
        )
    end
end

function TankSpawner:update()
    --tankbutton pos update
    for i, tank in ipairs(CurrentPlace.tankstock) do
        for i, button in ipairs(tank.Infobutton) do
            button.x, button.y = tank.hullcollider:getPosition()
        end
    end
end]]

function TankSpawner:slotOperate()
    for i,SlotNumber in ipairs(UvzSlotInfo) do
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
        local x,y=UvzSlotInfo[n].x,UvzSlotInfo[n].y
        return x,y,port_isavailable,n
    end
end

function TankSpawner:new_tank(place,new_tankdata)
    local x,y,port_isavailable,n=TankSpawner:findspwanlocation(place)
    if port_isavailable==true then
        local w,h=new_tankdata.width,new_tankdata.length
        local tank_collider=world:newRectangleCollider(x,y,w,h)

        tank_collider:setCollisionClass('tankhull')
        table.insert(HullColliders,tank_collider)
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
        
        if tank.turret_offset~=0 then
            y=y-tank.turret_offset
        end

        love.graphics.draw(tank.hull_image, x, y, a, 1, 1, ox, oy)
        love.graphics.draw(tank.armor.hull_image, x, y, a, 1, 1, ox, oy)
        love.graphics.draw(tank.turret_image, x, y, a, 1, 1, ox, oy)
        love.graphics.draw(tank.aim.turret_image, x, y, a, 1, 1, ox, oy)
        love.graphics.draw(tank.armor.turret_image, x, y, a, 1, 1, ox, oy)
        end
    end
end

TankFunctions={}

function TankFunctions:move()
    
end

function TankInfoPanel(tank)
    
end