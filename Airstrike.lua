Airstrike = {}

function Bombing(dt)
    local mx, my = cam:mousePosition()
   
    local count = 1
    
    while count < 4 do
        local explosion = world:newCircleCollider(mx, my, count*100)
        count = count + 1
    end
    

    
end