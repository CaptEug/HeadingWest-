DamageAssessment={}
test_shell=
{
    collider={};
    name='DM53';
    type='APFSDS';
    data = 
    {
        penetation=652;
        damage=2
    };
}


function DamageAssessment:damageCaculate(ammunition,tank)
    
    local shellAngle=test_shell.collider:getAngle()
    local shellPenetration=test_shell.data.penetation
    local tankAngle=tank.location.angle
    local hitArmorType=self:armorSideCaculate(ammunition,tank)
    local damage=test_shell.data.damage
    
        
    return damage
end
    
    
function DamageAssessment:armorSideCaculate(ammunition,tank)
    
    local ricochet=false
    local penetrated=false
    local dx=test_shell.collider.x-tank.location.x
    local dy=test_shell.collider.y-tank.location.y
    local absAngle=math.atan2(dy,dx)
    local hitArmorType='right'
    local relativeAngle=ammunition.angle-tank.location.angle

    if -math.pi/4<absAngle<math.pi/4 then
        hitArmorType='right'
    elseif math.pi/4<=absAngle<math.pi/4*3 then
        hitArmorType='front'
    elseif math.pi/4*3<=absAngle<-math.pi/4*3 then
        hitArmorType='left'
    else
        hitArmorType='back'
    end
    
    if relativeAngle>test_shell.data.ricochetAngle then
        ricochet=true
        return ricochet
    end

    penetrated=self:probabilityCaculate(test_shell.data.penetation,relativeAngle,tank.armor[hitArmorType])
        
    if penetrated==true then
        tank.hp=tank.hp-self:damageCaculate(ammunition,tank)
    end

end

function DamageAssessment:probabilityCaculate(penetration,angle,armorData)
    local penetrated=false
    local hitPart=math.random()
    local armor='turret'

    if hitPart<armorData.track then
        armor='track'
    elseif hitPart<armorData.track+armorData.lowerHull then
        armor='lowerHull'
    elseif hitPart<armorData.track+armorData.lowerHull+armorData.upperHull then
        armor='upperHull'
    else
        armor='turret'
    end

    local thickness=armorData.thickness[armor]/math.sin(angle)

    if penetration>thickness then
        penetrated=true
    end

    return penetrated
end

--[[tank.armor.front = 
{   
    turret=0.4;
    upperHull=0.3;
    lowerHull=0.2；
    track=0.1;
    thickness = 
    {   
        upperHull=200;
        lowerHull=60;
        Turret=600
    }
}--]]