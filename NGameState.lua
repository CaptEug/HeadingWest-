local thread 
local threadCode = [[
    local min,max = ...

]]

thread = love.thread.newThread(threadCode)