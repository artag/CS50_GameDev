--[[
    Pipe pairs.
]]
PipePairs = class{}

--[[
    Constructor.
    Uses objects of Bird and Scores classes.
]]
function PipePairs:init(bird, scores)
    self:reset()

    -- For collision detection: bird vs. pipe
    self.bird = bird
    self.scores = scores
end

--[[
    Pipe pairs update stage.
]]
function PipePairs:update(dt)
    -- self.collisionDetected = false
    -- self.betweenPipes = false

    for k, pipePair in pairs(self.pipePairs) do
        pipePair:update(dt, self.bird.boundary)

        if pipePair:collides(self.bird.boundary) then
            sounds['explosion']:play()
            sounds['hurt']:play()
            gStateMachine:change('score')
        end
    end

    -- Remove any flagged pipes
    -- We need this second loop, rather than deleting in the previous loop, because
    -- modifying the table in-place without explicit keys will result in skipping the
    -- next pipe, since all implicit keys (numerical indices) are automatically shifted
    -- down after a table removal.
    for k, pipePair in pairs(self.pipePairs) do
        if pipePair:canBeRemoved() then
            self:removePipe(k)
        end
    end
end

--[[
    Pipe pairs render stage.
]]
function PipePairs:render()
    for k, pipePair in pairs(self.pipePairs) do
        pipePair:render()
    end
end

--[[
    Helper function. Create pipe pair.
]]
function PipePairs:createPipe()
    table.insert(self.pipePairs, PipePair(self.scores))
end

--[[
    Helper function. Remove pipe pair.
]]
function PipePairs:removePipe(k)
    table.remove(self.pipePairs, k)
end

--[[
    Reset all pipes to initial condition.
    (Delete all pipes).
]]
function PipePairs:reset()
    self.pipePairs = {}
end
