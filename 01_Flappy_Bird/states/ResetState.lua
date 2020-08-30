--[[
    Reset state.
]]
ResetState = class{__includes = BaseState}

--[[
    Constructor.
    Reset states to initial value for object of next classes:
    Bird, PipePairs, Timer, Scores.
]]
function ResetState:init(bird, pipePairs, spawnTimer, scores)
    bird:reset()
    pipePairs:reset()
    spawnTimer:reset()
    scores: reset()
end

--[[
    Update stage.
]]
function ResetState:update(dt)
    gStateMachine:change('countdown')
end
