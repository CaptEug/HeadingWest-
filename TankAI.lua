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

end

function TankAI:move(dt)
    local px,py=tanks_table:getdata(tank1)
    local ax,ay=tanks_table:getdata(tank2)
    local v=0.5
    if ax~=px then 
        ax=ax-(ax-px)*v*dt
    end
    if ay~=py then
        ay=ay-(ay-py)*v*dt
    end
    tank2.ax=ax
    tank2.ay=ay
end

function TankAI:update(dt)
    local ax, ay = tanks_table:getdata(tank1)
    local t=dt
    self.move(ax,ay,t)
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