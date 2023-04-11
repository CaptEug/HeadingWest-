Particles = {}

function Particles:load()
    --firing effect
    Particles.muzzlesmoke = love.graphics.newParticleSystem(USSR_flag, 20)
    Particles.muzzlesmoke:setParticleLifetime(2, 5) -- Particles live at least 2s and at most 5s.
	Particles.muzzlesmoke:setEmissionRate(5)
	Particles.muzzlesmoke:setSizeVariation(1)
	Particles.muzzlesmoke:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.

    Particles.enginesmoke = love.graphics.newParticleSystem(USSR_flag, 20)
    Particles.enginesmoke:setParticleLifetime(2, 5) -- Particles live at least 2s and at most 5s.
	Particles.enginesmoke:setEmissionRate(5)
	Particles.enginesmoke:setSizeVariation(1)
    Particles.enginesmoke:setLinearAcceleration(-20, -20, 20, 20) -- Random movement in all directions.
	Particles.enginesmoke:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.
end

function TankParticlesDraw()
    for i, tank in ipairs(CurrentPlace.exsist_tank) do
        for i, particle in ipairs(tank.particles) do
            love.graphics.draw(particle)
        end
    end
end