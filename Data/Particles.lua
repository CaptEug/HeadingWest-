Particles = {}

function Particles:load()
    --firing effect
    
    muzzlesmoke = love.graphics.newParticleSystem(USSR_flag, 20)
    muzzlesmoke:setParticleLifetime(2, 5) -- Particles live at least 2s and at most 5s.
	muzzlesmoke:setEmissionRate(5)
	muzzlesmoke:setSizeVariation(1)
	muzzlesmoke:setLinearAcceleration(100,100) -- Random movement in all directions.
	muzzlesmoke:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.
    table.insert(Particles, muzzlesmoke)
end