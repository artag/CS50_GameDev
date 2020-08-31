--[[
    Pause state.
]]
PauseState = class{__includes = BaseState}

--[[
    Constructor.
]]
function PauseState:init()
    self.firstRow = math.floor(6 * VIRTUAL_HEIGHT / 20)
    self.secondRow = math.floor(10 * VIRTUAL_HEIGHT / 20)
end

--[[
    Update stage.
]]
function PauseState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

--[[
    Render stage.
]]
function PauseState:render()
    love.graphics.setFont(fonts['flappy'])
    love.graphics.printf('Pause', 0, self.firstRow, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(fonts['medium'])
    love.graphics.printf('Press Enter to play', 0, self.secondRow, VIRTUAL_WIDTH, 'center')
end
