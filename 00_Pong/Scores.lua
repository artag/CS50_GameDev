--[[
    Stores and calculate player scores.
]]
Scores = class{}

--[[
    Constructor.
]]
function Scores:init()
    self:reset()

    self.servingPlayer = 1
    self.winningPlayer = 0

    self.score_font = love.graphics.newFont('font.ttf', SCORE_FONT_SIZE)
    self.score_sound = love.audio.newSource('sounds/score.wav', 'static')
end

--[[
    Reset scores to initial values.
]]
function Scores:reset()
    self.player1Score = 0
    self.player2Score = 0
end

--[[
    Update.
]]
function Scores:update(ball)
    if ball.x < 0 then
        self.score_sound:play()

        self.servingPlayer = 1
        self.player2Score = self.player2Score + 1

        if self.player2Score == SCORES_TO_WIN then
            self.winningPlayer = 2
            self.servingPlayer = 1
        end
    elseif ball.x > VIRTUAL_WIDTH then
        self.score_sound:play()

        self.servingPlayer = 2
        self.player1Score = self.player1Score + 1

        if self.player1Score == SCORES_TO_WIN then
            self.winningPlayer = 1
            self.servingPlayer = 2
        end
    end
end

--[[
    Render.
]]
function Scores:render()
    love.graphics.setFont(self.score_font)
    love.graphics.printf(tostring(self.player1Score), 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH_CENTER * 2 / 3, 'right')
    love.graphics.printf(tostring(self.player2Score), VIRTUAL_WIDTH_CENTER * 4 / 3, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'left')
end

--[[
    Returns true if any player win in the game match, otherwise - false.
]]
function Scores:isAnyPlayerWin(ball)
    return ball.x < 0 or ball.x > VIRTUAL_WIDTH
end

--[[
    Returns true if any player win the whole game, otherwise - false.
]]
function Scores:isGameDone()
    return self.player1Score == SCORES_TO_WIN or self.player2Score == SCORES_TO_WIN
end
