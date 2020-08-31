--[[
    Pipe pair.
]]
PipePair = class{}

local PIPE_SPEED = -60

--[[
    Constructor.
    Uses the object of Scores class.
]]
function PipePair:init(scores)
    local gapHeight = math.floor(math.random(5, 6) * VIRTUAL_HEIGHT / 20)
    local upperHeight = math.floor(9 * VIRTUAL_HEIGHT / 20)
    local lowerHeight = math.floor(17 * VIRTUAL_HEIGHT / 20)

    self.x = VIRTUAL_WIDTH
    self.y = math.random(upperHeight, lowerHeight)

    self.topPipe = Pipe('top', self.x, self.y - gapHeight)
    self.bottomPipe = Pipe('bottom', self.x, self.y)

    self.scores = scores

    self.betweenPipes = false
end

--[[
    Pipe pair update stage.
]]
function PipePair:update(dt, boundary)
    self.x = self.x + PIPE_SPEED * dt

    self.topPipe:update(self.x)
    self.bottomPipe:update(self.x)

    -- Bird (bird's boundary) enters into the pipe pair.
    if self:enteredTheGap(boundary) then
        self.betweenPipes = true
    end

    -- Bird (bird's boundary) leaves the gap of pipe pair.
    if self.betweenPipes and self:outTheGap(boundary) then
        self.scores:increase(1)
        self.betweenPipes = false
    end
end

--[[
    Pipe pair render stage.
]]
function PipePair:render()
    self.topPipe:render()
    self.bottomPipe:render()
end

--[[
    Checks if pipe pair can be removed.
]]
function PipePair:canBeRemoved()
    -- Top and bottom pipes are equal on x axis. We can use any of them.
    return self.topPipe:canBeRemoved()
end

--[[
    Returns true if the input boundary collides with any of pipe, otherwise - false.
]]
function PipePair:collides(boundary)
    return self.topPipe:collides(boundary) or self.bottomPipe:collides(boundary)
end

--[[
    Helper function.
    Returns true if the input boundary enters into the gap, otherwise - false.
]]
function PipePair:enteredTheGap(boundary)
    return boundary.x < self.x and
           self.x < boundary.x + boundary.width
end

--[[
    Helper function.
    Returns true if the input boundary leaves the gap, otherwise - false.
]]
function PipePair:outTheGap(boundary)
    return self.x + self.topPipe.width < boundary.x
end
