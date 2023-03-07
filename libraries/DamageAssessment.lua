DamageAssessment={}
test_shell=
{
    collider={};
    name='DM53';
    type='APFSDS';
    data = 
    {
        penetation=652;
        damage=2;
        ricochetAngle=80
    };
    angle=0
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
    local relativeAngle=self:relativeAngleCaculate()

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

function DamageAssessment:relativeAngleCaculate(side,shellAngle,tankAngle)
    
    local relativeAngle=0
    local dAngle=tankAngle-shellAngle

    if side=='front' then
        relativeAngle=dAngle
    elseif side=='right' then
        relativeAngle=math.pi/2-dAngle
    elseif side=='back' then
        relativeAngle=dAngle-math.pi/2
    else
        relativeAngle=-dAngle
    end

    return relativeAngle
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

    if armor=='track'and penetrated==true then
        self:partDamaged('track')
    end

    return penetrated
end

function DamageAssessment:partDamaged(part,tank)

    if part=='track' then
        tank.status.stuck=true
    elseif part=='ammorack' then
        tank.status.headless=true
    elseif part=='fuel' then
        tank.status.fired=true
    end
end













--testDataStructure

--[[tank.status=
{
    stuck=false;
    headless=false;
    fired=false;
    dead=false;
    manualControlled=false;

}
]]

--[[tank.armor=
{
    front = 
    {   
        turret=0.4;
        upperHull=0.3;
        lowerHull=0.2；
        track=0.1;
        thickness= 
        {   
            upperHull=200;
            lowerHull=60;
            Turret=600;
            track=20
        }
    };
    right=
    {
        turret=0.2;
        hull=0.6;
        track=0.2;
        thickness=
        {
            turret=200;
            hull=60;
            track=20
        }
    };
    left=
    {
        turret=0.2;
        hull=0.6;
        track=0.2;
        thickness=
        {
            turret=200;
            hull=60;
            track=20
        }
    };
    back=
    {
        turret=0.4;
        hull=0.5;
        track=0.1;
        thickness=
        {
            turret=80;
            hull=30;
            track=20
        }
    }
]--]]