--[[
    Timer.
    Used to create pipe pairs.
]]
Timer = class{}

local PIPE_CREATION_INTERVAL_SECONDS = 3

--[[
    Constructor.
    Uses collection of pipe pairs (object of PipePairs class).
]]
function Timer:init(pipes)
    self:reset()

    self.timerInterval = PIPE_CREATION_INTERVAL_SECONDS
    self.pipes = pipes
end

--[[
    Timer update stage.
    Creates a pipe pair after time interval.
]]
function Timer:update(dt)
    self.value = self.value + dt

    if self.value > self.timerInterval then
        self.pipes:createPipe()
        self.value = 0
    end
end

--[[
    Reset timer to 0.
]]
function Timer:reset()
    self.value = 0
end
