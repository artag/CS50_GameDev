--[[
    State machine.
]]
StateMachine = class{}

--[[
    Constructor.
    Get input states.
]]
function StateMachine:init(states)
    self.empty = {
        render = function() end,
        update = function() end,
        enter = function() end,
        exit = function() end
    }

    self.states = states or {}
    self.current = self.empty
end

--[[
    Changes the current state to the next one.
]]
function StateMachine:change(stateName, enterParams)
    assert(self.states[stateName])
    self.current:exit()
    self.current = self.states[stateName]()
    self.current:enter(enterParams)
end

--[[
    Calls the current state update stage.
]]
function StateMachine:update(dt)
    self.current:update(dt)
end

--[[
    Calls the current state render stage.
]]
function StateMachine:render()
    self.current:render()
end
