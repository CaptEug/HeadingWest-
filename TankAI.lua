TankAI={}
function TankAI:create(name)
    local tankdata=love.filesystem.load('DefaultTank.lua')
    tankdata()
    local CreatedTanks={}
    local getank=DefaultTank['T_5455']
    local tank=tanks.new()
    table.insert(CreatedTanks,tank)
    tank:create()
end
function TankAI:spawn(x,y,type,args)
    MAUS1 = tanks.new()
    MAUS1:create()

    local AIdata={}

    AIdata.type=type
    AIdata.hp=10
    AIdata.acceleration=30
    
    
end

function TankAI:find()
    local playerx=MAUS1.x
    local playery=MAUS1.y
    if playerx^2+playery^2>20 then
        self.move(player)
    end

end

function TankAI:move(x,y,dt)
    local px=x
    local py=y
    tank2.ax=tank2.ax-px*dt
    tank2.ay=tank2.ay-py*dt
end

function TankAI:update(dt)
    local ax, ay = tanks_table:getdata(tank1)
    self.move(ax,ay,dt)
end

function TankAI:destroyDead()
    local i = #enemies
    while i > 0 do
        if enemies[i].dead then
            if enemies[i].physics then
                enemies[i].physics:destroy()
            end
            table.remove(enemies, i)
        end
        i = i - 1
    end
end