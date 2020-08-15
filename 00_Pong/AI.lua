--[[
    AI.
]]
AI = class{}

--[[
    Constructor.
]]
function AI:init(ball, paddle)
    self.enabled = false

    self.ball = ball
    self.paddle = paddle
end

--[[
    Update.
]]
function AI:update(dt)
    -- Disable ball tracking for the left paddle if ball located on the right side.
    if self.paddle.onTheLeft and
       (self.ball.dx > 0 or self.ball.centerX > VIRTUAL_WIDTH_CENTER) then
        if not self:isPaddleNearHeightCenter() then
            self:movePaddleToHeightCenter(dt)
            self.paddle:update(dt)
        end
        return
    end

    -- Disable ball tracking for the right paddle if ball located on the left side.
    if self.paddle.onTheRight and
       (self.ball.dx < 0 or self.ball.centerX < VIRTUAL_WIDTH_CENTER) then
        if not self:isPaddleNearHeightCenter() then
            self:movePaddleToHeightCenter(dt)
            self.paddle:update(dt)
        end
        return
    end

    -- Ball tracking. Move paddle to the ball.
    if self.paddle.y < self.ball.centerY and self.ball.centerY < self.paddle.y + self.paddle.height then
        self.paddle.dy = 0
    elseif self.ball.centerY < self.paddle.centerY then
        self.paddle.dy = -PADDLE_SPEED
    elseif self.ball.centerY > self.paddle.centerY then
        self.paddle.dy = PADDLE_SPEED
    else
        self.paddle.dy = 0
    end

    self.paddle:update(dt)
end

--[[
    Render.
]]
function AI:render()
    self.paddle:render()
end

--[[
    Helper function.
    Returns true if the paddle is located near the center of the screen height.
]]
function AI:isPaddleNearHeightCenter()
    return self.paddle.y < VIRTUAL_HEIGHT_CENTER and VIRTUAL_HEIGHT_CENTER < self.paddle.y + self.paddle.height
end

--[[
    Helper function.
    Moves paddle to the center of the screen height.
]]
function AI:movePaddleToHeightCenter(dt)
    if VIRTUAL_HEIGHT_CENTER < self.paddle.centerY then
        self.paddle.dy = -PADDLE_SPEED
    elseif VIRTUAL_HEIGHT_CENTER > self.paddle.centerY then
        self.paddle.dy = PADDLE_SPEED
    end
end
