--[[
    Ball.
]]
Ball = class{}

--[[
    Constructor.
]]
function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self:updateCenter()

    self.sounds = {
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static')
    }

    self.dv = INITIAL_BALL_SPEED
    self.dx = INITIAL_BALL_SPEED / 2
    self.dy = INITIAL_BALL_SPEED / 2

    self:setRandomAngleRandomDirection()
end

--[[
    Bounce from the left paddle.
]]
function Ball:bounceFromLeftPaddle(paddle1)
    if not ball:collides(paddle1) then
        return
    end

    self.x = paddle1.x + paddle1.width
    self:updateCenter()

    self.dv = self.dv * BALL_ACCELERATION_FACTOR
    self:setRandomAngleHorizontalDirection('right')
    self.sounds.paddle_hit:play()
end

--[[
    Bounce from the right paddle.
]]
function Ball:bounceFromRightPaddle(paddle2)
    if not ball:collides(paddle2) then
        return
    end

    self.x = paddle2.x - self.width
    self:updateCenter()

    self.dv = self.dv * BALL_ACCELERATION_FACTOR
    self:setRandomAngleHorizontalDirection('left')
    self.sounds.paddle_hit:play()
end

--[[
    Returns true if ball collides with any paddle, otherwise - false.
]]
function Ball:collides(paddle)
    if self.x > paddle.x + paddle.width or paddle.x > self.x + self.width then
        return false
    end

    if self.y > paddle.y + paddle.height or paddle.y > self.y + self.height then
        return false
    end

    return true
end

--[[
    Place the ball at the center of the screen.
    Reset ball's velocity to initial value.
    Set a random angle for the direction of the ball.
    Set a random horizontal and vertical direction of the ball.
]]
function Ball:reset()
    self.x = VIRTUAL_WIDTH_CENTER - self.width / 2
    self.y = VIRTUAL_HEIGHT_CENTER - self.height / 2
    self:updateCenter()

    self.dv = INITIAL_BALL_SPEED

    self:setRandomAngleRandomDirection()
end

--[[
    Place the ball at the center of the screen.
    Reset ball's velocity to initial value.
    Set a random angle for the direction of the ball.
    Set horizontal direction ('left' or 'right') of the ball,
    otherwise - set a random horizontal and vertical direction of the ball.
]]
function Ball:resetAndSetDirection(direction)
    self.x = VIRTUAL_WIDTH_CENTER - self.width / 2
    self.y = VIRTUAL_HEIGHT_CENTER - self.height / 2
    self:updateCenter()

    self.dv = INITIAL_BALL_SPEED

    if direction == 'left' then
        self:setRandomAngleHorizontalDirection('left')
    elseif direction == 'right' then
        self:setRandomAngleHorizontalDirection('right')
    else
        self:setRandomAngleRandomDirection()
    end
end

--[[
    Update ball.
]]
function Ball:update(dt, paddle1, paddle2)
    self:bounceFromLeftPaddle(paddle1)
    self:bounceFromRightPaddle(paddle2)

    self:bounceFromBottom()
    self:bounceFromTop()

    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
    self:updateCenter()
end

--[[
    Render ball.
]]
function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

--[[
    Set a random angle for the direction of the ball.
    Set a random horizontal and vertical direction of the ball.
]]
function Ball:setRandomAngleRandomDirection()
    local x_sign = math.random() == 0 and 1 or -1
    local y_sign = math.random() == 0 and 1 or -1

    self:setRandomAngle()

    self.dx = self.dx * x_sign
    self.dy = self.dy * y_sign
end

--[[
    Set a random angle for the direction of the ball.
    Set horizontal direction ('left' or 'right') of the ball.
]]
function Ball:setRandomAngleHorizontalDirection(direction)
    if direction == 'left' then
        self:setRandomAngle()
        self.dx = math.abs(self.dx) * -1
    elseif direction == 'right' then
        self:setRandomAngle()
        self.dx = math.abs(self.dx)
    end
end

--[[
    Set a random angle for the direction of the ball.
    Not change horizontal or vertical direction.
]]
function Ball:setRandomAngle()
    local x_part = math.random(2, 8) * 0.1
    local y_part = 1 - x_part

    self.dx = self.dv * x_part
    self.dy = self.dv * y_part
end

--[[
    Bounce from the top wall.
]]
function Ball:bounceFromTop()
    if self.y > 0 then
        return
    end

    self.y = 0
    self:updateCenter()

    self.dy = -self.dy
    self.sounds.wall_hit:play()
end

--[[
    Bounce from the bottom wall.
]]
function Ball:bounceFromBottom()
    if self.y < VIRTUAL_HEIGHT - self.height then
        return
    end

    self.y = VIRTUAL_HEIGHT - self.height
    self:updateCenter()

    self.dy = -self.dy
    self.sounds.wall_hit:play()
end

--[[
    Helper function. Calculate ball center.
]]
function Ball:updateCenter()
    self.centerX = self.x + self.width / 2
    self.centerY = self.y + self.height / 2
end
