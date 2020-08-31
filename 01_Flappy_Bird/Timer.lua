--[[
    Timer.
    Used to create pipe pairs.
]]
Timer = class{}

--[[
    Constructor.
    Uses collection of pipe pairs (object of PipePairs class).
]]
function Timer:init(pipes)
    self:reset()
    self.pipes = pipes
end

--[[
    Timer update stage.
    Creates a pipe pair after time interval.
]]
function Timer:update(dt)
    self.value = self.value + dt

    -- The timer down.
    if self.value > self.timerInterval then
        self.pipes:createPipe()
        self.value = 0
        self.timerInterval = self:GetRandomTimeInterval()
    end
end

--[[
    Reset timer to 0.
]]
function Timer:reset()
    self.value = 0
    self.timerInterval = 0
end

--[[
    Helper function. Returns random time interval.
]]
function Timer:GetRandomTimeInterval()
    return 2.4 + math.random(0, 9) * 0.1
end
