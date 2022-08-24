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

function TankAI:setTank()
        local hull = self:get "hull"
        local turret = self:get "turret"
        local turret1 = self:get "turret_rdata"
        local move = self:get "move"
        local r = self:get "rotation_data"
        local m = self:get "move_data"
        local t = self:get "tankammo"
        local cos = math.cos(move.angle)
        local sin = math.sin(move.angle)
        local cos1 = math.cos(turret1.angle)
        local sin1 = math.sin(turret1.angle)
        local vx =  move.speed * sin
        local vy =  move.speed * cos * - 1
        local mx,my = love.mouse.getPosition()
        return hull,turret,turret1,move,r,m,t,cos,sin,cos1,sin1,vx,mx,my
end
local hull,turret,turret1,move,r,m,t,cos,sin,cos1,sin1,vx,mx,my=TankAI:setTank(self)