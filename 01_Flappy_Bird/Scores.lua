--[[
    Scores.
]]
Scores = class{}

--[[
    Constructor.
]]
function Scores:init()
    self:reset()
end

--[[
    Render stage.
]]
function Scores:render()
    love.graphics.setFont(fonts['flappy'])
    love.graphics.print('Score: ' .. tostring(self.scores), 10, 10)
end

--[[
    Increase the score by input value.
]]
function Scores:increase(score)
    sounds['score']:play()
    self.scores = self.scores + score
end

--[[
    Reset score to 0.
]]
function Scores:reset()
    self.scores = 0
end
