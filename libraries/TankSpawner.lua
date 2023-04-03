TankSpawner={}

function TankSpawner:slot_distribution(place)
    local slot_full=true
    local selected_slot
    for i, slot in ipairs(place.slot_info) do
        if slot.available==true then
            slot.available=false
            selected_slot=i
            slot_full=false
            break
        end
    end
    if slot_full==true then
        selected_slot=0
    end

return selected_slot
end

function TankSpawner:new_tank(place,new_tankdata)
    local x,y=place.slot_info[new_tankdata.selected_slot].x,place.slot_info[new_tankdata.selected_slot].y
    local w,h=new_tankdata.width,new_tankdata.length
    local tank = {}
    tank.collider = world:newRectangleCollider(x,y,w,h)
    tank.collider:setCollisionClass('tankhull')
    tank.collider:setObject(tank)
    tank.collider:setMass(new_tankdata.weight)
    tank.collider:setRestitution(0.1)
    tank.collider:setLinearDamping(5)
    tank.collider:setAngularDamping(5)
    tank.data = new_tankdata
    tank.velocity={}
    tank.location={}
    tank.image_location={}
    tank.gun_location={}
    tank.functions = {}
    tank.functions.move = AutoControlfunction
    tank.status = {
        dead = {false},
        onfire = {false, Onfire_icon},
        Immobilized = {false, Immobilized_icon},
        era = {false, ERA_icon}
    }
    tank.incomp = false
    tank.compCom = false
    if tank.data.armor.type == 'ERA' then
        tank.status.era[1] = true
    end
    tank.Infobuttons = buttons.new()
    local tankbutton = buttons.newCampicButton(
        invisible_button,
        function ()
            TankPanelopen = true
            TankChoosen = tank
        end,
        tank.Infobuttons,
        x,
        y
    )

    table.insert(place.exsist_tank, tank)
    place.slot_info[new_tankdata.selected_slot].available=true
    new_tankdata.selected_slot=nil
end

function TankSpawner:update(dt)
    for i, tank in ipairs(CurrentPlace.exsist_tank) do
        TankUpdate(tank,dt)
        StatusCheck(tank,i)
        tank.functions.move(tank,dt)
    end
end

function TankSpawner:draw_tank()
    for i, tank in ipairs(CurrentPlace.exsist_tank) do
        if tank.collider==nil then
            return nil
        end

        local x,y=tank.image_location.x,tank.image_location.y
        local a=tank.location.hull_angle

        love.graphics.draw(tank.data.hull_image,x,y,a,1,1,144,144)
        love.graphics.draw(tank.data.armor.hull_image,x,y,a,1,1,144,144)
        love.graphics.draw(tank.data.turret_image,x,y,a+tank.data.turret_angle,1,1,144,144)
        love.graphics.draw(tank.data.aim.turret_image,x,y,a+tank.data.turret_angle,1,1,144,144)
        love.graphics.draw(tank.data.armor.turret_image,x,y,a+tank.data.turret_angle,1,1,144,144)
    end
end
