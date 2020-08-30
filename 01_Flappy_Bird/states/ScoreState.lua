--[[
    Score state.
    Shows finish scores on game over.
]]
ScoreState = class{__includes = BaseState}

--[[
    Constructor.
    Uses object of Score class.
]]
function ScoreState:init(scores)
    self.scores = scores

    self.firstRow = math.floor(2 * VIRTUAL_HEIGHT / 10)
    self.secondRow = math.floor(4 * VIRTUAL_HEIGHT / 10)
    self.thirdRow = math.floor(6 * VIRTUAL_HEIGHT / 10)
end

--[[
    Update stage.
]]
function ScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('reset')
    end
end

--[[
    Render stage.
]]
function ScoreState:render()
    love.graphics.setFont(fonts['flappy'])
    love.graphics.printf('Oof! You lost!', 0, self.firstRow, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(fonts['medium'])
    love.graphics.printf('Score: ' .. tostring(self.scores.scores), 0, self.secondRow, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Enter to Play Again!', 0, self.thirdRow, VIRTUAL_WIDTH, 'center')
end
