--[[
    Display messages.
]]
Messages = class{}

--[[
    Constructor.
]]
function Messages:init()
    self.small_font = love.graphics.newFont('font.ttf', SMALL_FONT_SIZE)
    self.large_font = love.graphics.newFont('font.ttf', LARGE_FONT_SIZE)

    self.xOffset = VIRTUAL_WIDTH * 0.1
    self.firstRow = VIRTUAL_HEIGHT * 0.1
    self.secondRow = VIRTUAL_HEIGHT * 0.2
    self.thirdRow = VIRTUAL_HEIGHT * 0.3
end

--[[
    Show message on "start" game state.
]]
function Messages:showStartMessage()
    love.graphics.setFont(self.small_font)
    love.graphics.printf('Welcome to Pong!', 0, self.firstRow, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Enter to begin!', 0, self.secondRow, VIRTUAL_WIDTH, 'center')
end

--[[
    Show message on "serve" game state.
]]
function Messages:showServeMessage(playerNumber)
    love.graphics.setFont(self.small_font)
    love.graphics.printf('Player ' .. playerNumber .. "'s serve!", 0, self.firstRow, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Enter to serve!', 0, self.secondRow, VIRTUAL_WIDTH, 'center')
end

--[[
    Show message on "done" game state.
]]
function Messages:showWinnerMessage(playerNumber)
    love.graphics.setFont(self.large_font)
    love.graphics.printf('Player ' .. playerNumber .. " wins!", 0, self.firstRow, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(self.small_font)
    love.graphics.printf('Press Enter to restart', 0, self.thirdRow, VIRTUAL_WIDTH, 'center')
end

--[[
    Debug message. Show FPS.
]]
function Messages:showFPS()
    self:setGreenSmallFont()
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), self.xOffset, self.firstRow)
end

--[[
    Debug message. Show ball velocity. (x component : y component : summary velocity).
]]
function Messages:showBallVelocity(ball)
    self:setGreenSmallFont()
    love.graphics.print(
        'Ball velocity (' .. tostring(ball.dx) .. ' : ' .. tostring(ball.dy) .. ' : ' .. tostring(ball.dv) .. ')',
        self.xOffset,
        self.secondRow)
end

--[[
    Helper function. Set green small font.
]]
function Messages:setGreenSmallFont()
    love.graphics.setFont(self.small_font)
    -- green color
    love.graphics.setColor(0, 1, 0, 1)
end
