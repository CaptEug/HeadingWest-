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
        ricochetAngle=80;
        weight=1.6;
    };
    angle=0
}
    
function DamageAssessment:armorTypeCaculate(ammunition,tank)
    
    local ricochet=false
    local penetrated=false
    local dx=ammunition.collider.x-tank.location.x
    local dy=ammunition.collider.y-tank.location.y
    local absAngle=math.atan(dy,dx)-tank.location.hull_angle
    local hitArmorType='right'
    local tankAngleData=tank.angleAssess


    if tankAngleData.NE<absAngle<-tankAngleData.NE then
        hitArmorType='right'
    elseif tankAngleData.NE<absAngle<tankAngleData.NW then
        hitArmorType='front'
    elseif tankAngleData.NW<=absAngle<-tankAngleData.NW then
        hitArmorType='left'
    else
        hitArmorType='back'
    end

    local relativeAngle=self:relativeAngleCaculate(hitArmorType,ammunition.angle,tank.location.hull_angle)
    
    if relativeAngle>ammunition.data.ricochetAngle then
        ricochet=true
        return ricochet
    end

    penetrated=self:probabilityCaculate(ammunition.data.penetation,relativeAngle,tank.armor[hitArmorType])
        
    if penetrated==true then
        self:damageCaculate(tank.armor[hitArmorType].parts)
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

function DamageAssessment:damageCaculate(partData)
    
    local hitPart=math.random()
    local part='engine'

    if hitPart<partData.ammorack then
        part='ammorack'
    elseif hitPart<partData.ammorack+partData.fuel then
        part='fuel'
    elseif hitPart<partData.ammorack+partData.fuel+partData.engine then
        part='engine'
    else
        part='none'
    end

    self:partDamaged(part)

end

function DamageAssessment:partDamaged(part,tank)

    if part=='track' or 'engine' then
        tank.status.stuck=true
    elseif part=='ammorack' then
        tank.status.headless=true
    elseif part=='fuel' then
        tank.status.fired=true
    else
        
    end
end




--[[tank.angleAssess=
{
    NE=math.pi/4;
    SE=-math.pi/4;
    NW=math.pi/4*3;
    SW=-math.pi/4*3
}








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
        };
        parts=
        {
            ammorack=0.1;
            fuel=0.2;
            engine=0.2;
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
        };
        parts=
        {
            ammorack=0.1;
            fuel=0.1;
            engine=0.1;
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
        };
        parts=
        {
            ammorack=0.1;
            fuel=0.1;
            engine=0.1;
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
        };
        parts=
        {
            ammorack=0.1;
            fuel=0.1;
            engine=0.3;
        }
    }
]--]]