class = require 'class'
push = require 'push'
tick = require 'tick'

require 'AI'
require 'Ball'
require 'Messages'
require 'Paddle'
require 'Scores'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

FRAMERATE_LIMIT = 60

VIRTUAL_WIDTH = WINDOW_WIDTH / 2.5
VIRTUAL_HEIGHT = WINDOW_HEIGHT / 2.5
VIRTUAL_WIDTH_CENTER = VIRTUAL_WIDTH / 2
VIRTUAL_HEIGHT_CENTER = VIRTUAL_HEIGHT / 2

-- Fonts sizes.
SMALL_FONT_SIZE = 8
LARGE_FONT_SIZE = 16
SCORE_FONT_SIZE = 32

PADDLE_WIDTH = 5
PADDLE_HEIGHT = 20
-- Maximum paddle speed.
PADDLE_SPEED = 200
-- Initial paddle offsets. Used for initialization.
PADDLE1_X_OFFSET = 10
PADDLE1_Y_OFFSET = 30
PADDLE2_X_OFFSET = VIRTUAL_WIDTH - 15
PADDLE2_Y_OFFSET = VIRTUAL_HEIGHT - 50

BALL_WIDTH = 4
BALL_HEIGHT = 4
-- Initial ball speed. Used for initialization and reset ball state.
INITIAL_BALL_SPEED = 200
BALL_ACCELERATION_FACTOR = 1.05

SCORES_TO_WIN = 10

--[[
    Game load stage.
]]
function love.load()
    tick.framerate = FRAMERATE_LIMIT

    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Pong')

    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    messages = Messages()
    scores = Scores()

    player1 = Paddle(PADDLE1_X_OFFSET, PADDLE1_Y_OFFSET, PADDLE_WIDTH, PADDLE_HEIGHT)
    player2 = Paddle(PADDLE2_X_OFFSET, PADDLE2_Y_OFFSET, PADDLE_WIDTH, PADDLE_HEIGHT)

    local ballX = VIRTUAL_WIDTH_CENTER - BALL_WIDTH / 2
    local ballY = VIRTUAL_HEIGHT_CENTER - BALL_HEIGHT / 2
    ball = Ball(ballX, ballY, BALL_WIDTH, BALL_HEIGHT)

    ai1Paddle = Paddle(PADDLE1_X_OFFSET, PADDLE1_Y_OFFSET, PADDLE_WIDTH, PADDLE_HEIGHT)
    ai2Paddle = Paddle(PADDLE2_X_OFFSET, PADDLE2_Y_OFFSET, PADDLE_WIDTH, PADDLE_HEIGHT)
    ai1 = AI(ball, ai1Paddle)
    ai2 = AI(ball, ai2Paddle)

    gameState = 'start'
end

--[[
    Handler for window resize.
]]
function love.resize(w, h)
    push:resize(w, h)
end

--[[
    Game update stage.
]]
function love.update(dt)
    scores:update(ball)

    -- Checks the status of the winning. Changes game state if needed.
    if scores:isAnyPlayerWin(ball) then
        gameState = 'serve'
    end
    if scores:isGameDone() then
        gameState = 'done'
    end

    -- Handles player 1 keys (left paddle). Works with disabled ai1.
    if not ai1.enabled then
        if love.keyboard.isDown('w') then
            player1.dy = -PADDLE_SPEED
        elseif love.keyboard.isDown('s') then
            player1.dy = PADDLE_SPEED
        else
            player1.dy = 0
        end
    end

    -- Handles player 2 keys (right paddle). Works with disabled ai2.
    if not ai2.enabled then
        if love.keyboard.isDown('up') then
            player2.dy = -PADDLE_SPEED
        elseif love.keyboard.isDown('down') then
            player2.dy = PADDLE_SPEED
        else
            player2.dy = 0
        end
    end

    -- Updates ball position.
    if gameState == 'serve' then
        local direction = scores.servingPlayer == 1 and 'right' or 'left'
        ball:resetAndSetDirection(direction)
    elseif gameState == 'done' then
        ball:reset()
    elseif gameState == 'play' then
        if ai1.enabled and not ai2.enabled then
            ball:update(dt, ai1.paddle, player2)
        elseif not ai1.enabled and ai2.enabled then
            ball:update(dt, player1, ai2.paddle)
        elseif ai1.enabled and ai2.enabled then
            ball:update(dt, ai1.paddle, ai2.paddle)
        else
            ball:update(dt, player1, player2)
        end
    end

    -- Updates paddles positions.
    if ai1.enabled then
        ai1:update(dt)
    else
        player1:update(dt)
    end

    if ai2.enabled then
        ai2:update(dt)
    else
        player2:update(dt)
    end
end

--[[
    Keypress handler.
]]
function love.keypressed(key)
    if key == 'escape' then
        if gameState == 'start' then
            love.event.quit()
        else
            gameState = 'start'
            scores:reset()
            ball:reset()
        end
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'serve'
        elseif gameState == 'serve' then
            gameState = 'play'
        elseif gameState == 'done' then
            gameState = 'serve'

            scores:reset()
        end
    elseif key == '1' then
        if not gameState == 'start' then
            return
        end

        ai1.enabled = not ai1.enabled
    elseif key == '2' then
        if not gameState == 'start' then
            return
        end

        ai2.enabled = not ai2.enabled
    end
end

--[[
    Game draw (render) stage.
]]
function love.draw()
    push:apply('start')

    -- Cleans the screen with some sort of grey color.
    love.graphics.clear(0.1569, 0.1765, 0.2039, 1)

    -- Displays information.
    if gameState == 'start' then
        messages:showStartMessage()
        messages:showPlayer1Message(ai1)
        messages:showPlayer2Message(ai2)
    elseif gameState == 'serve' then
        scores:render()
        messages:showServeMessage(tostring(scores.servingPlayer))
    elseif gameState == 'done' then
        scores:render()
        messages:showWinnerMessage(tostring(scores.winningPlayer))
    elseif gameState == 'play' then
        scores:render()
    end

    -- Render paddles.
    if ai1.enabled then
        ai1:render()
    else
        player1:render()
    end
    if ai2.enabled then
        ai2:render()
    else
        player2:render()
    end

    -- Render ball
    ball:render()

    --showDebugInfo()

    push:apply('end')
end

--[[
    Show debug information:
    FPS and current ball velocity.
]]
function showDebugInfo()
    messages:showFPS()
    messages:showBallVelocity(ball)
end
