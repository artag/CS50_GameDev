--[[
    Countdown state.
]]
CountdownState = class{__includes = BaseState}

local COUNTDOWN_TIME = 0.75

--[[
    Constructor.
]]
function CountdownState:init()
    self.count = 3
    self.timer = 0
    self.countHeight = math.floor(VIRTUAL_HEIGHT / 3)
end

--[[
    Update stage.
]]
function CountdownState:update(dt)
    self.timer = self.timer + dt

    if self.timer > COUNTDOWN_TIME then
        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1

        if self.count == 0 then
            gStateMachine:change('play')
        end
    end
end

--[[
    Render stage.
]]
function CountdownState:render()
    love.graphics.setFont(fonts['huge'])
    love.graphics.printf(self.count, 0, self.countHeight, VIRTUAL_WIDTH, 'center')
end
