
NGameState = {

    ThreadGnenerator = function (name)
        local t = love.thread.newThread(name)
        return t
    end
}

TestThread = love.thread.newThread("ingame")
