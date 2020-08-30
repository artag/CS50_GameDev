--[[
    Play state.
]]
PlayState = class{__includes = BaseState}

--[[
    Constructor.
    Uses objects of next classes:
    - Bird
    - PipePairs
    - Timer
    - Scores
]]
function PlayState:init(bird, pipePairs, spawnTimer, scores)
    self.bird = bird
    self.pipePairs = pipePairs
    self.spawnTimer = spawnTimer
    self.scores = scores
end

--[[
    Update stage.
]]
function PlayState:update(dt)
    self.spawnTimer:update(dt)
    self.pipePairs:update(dt, self.bird.boundary)
    self.bird:update(dt)
end

--[[
    Render stage.
]]
function PlayState:render()
    self.pipePairs:render()
    self.bird:render()
    self.scores:render()
end
