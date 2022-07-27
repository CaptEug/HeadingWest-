Berlin = {}
require 'Tank'



function Berlin:load()
    sti = require 'libraries/sti'
    gamemap = sti('chapters/maps/checkpointC.lua')
    camera = require 'libraries/camera'
    cam = camera()
    wf = require 'libraries/windfield'
    Tank:load()
end



function Berlin:update(dt)
    Tank:update(dt)
end



function Berlin:draw()
    cam:attach()
        gamemap:drawLayer(gamemap.layers["ground"])
        Tank:draw()
        gamemap:drawLayer(gamemap.layers["veg"])
        gamemap:drawLayer(gamemap.layers["top"])
    cam:detach()
end