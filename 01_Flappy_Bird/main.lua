-- Used third-party libs.
class = require 'class'
push = require 'push'
tick = require 'tick'

-- Used classes.
require 'Boundary'
require 'Background'
require 'Ground'
require 'Bird'
require 'Pipe'
require 'PipePair'
require 'PipePairs'
require 'Timer'
require 'Scores'

-- State machine with states.
require 'StateMachine'
require 'states/BaseState'
require 'states/CountdownState'
require 'states/PauseState'
require 'states/PlayState'
require 'states/ResetState'
require 'states/ScoreState'
require 'states/TitleScreenState'

-- Constants.
local WINDOW_WIDTH = 1280
local WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288
VIRTUAL_WIDTH_CENTER = VIRTUAL_WIDTH / 2
VIRTUAL_HEIGHT_CENTER = VIRTUAL_HEIGHT / 2

local FRAMERATE_LIMIT = 60

-- Create used classes.
local bird = Bird()
local background = Background()
local ground = Ground(bird)
local scores = Scores()
local pipePairs = PipePairs(bird, scores)
local spawnTimer = Timer(pipePairs)

--[[
    Load stage.
]]
function love.load()
    tick.framerate = FRAMERATE_LIMIT

    math.randomseed(os.time())

    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- Initialize screen.
    love.window.setTitle('Flappy Bird')
    push:setupScreen(
        VIRTUAL_WIDTH,
        VIRTUAL_HEIGHT,
        WINDOW_WIDTH,
        WINDOW_HEIGHT,
        {
            vsync = true,
            fullscreen = false,
            resizable = true
        })

    -- Initialize state machine.
    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['countdown'] = function() return CountdownState() end,
        ['pause'] = function() return PauseState() end,
        ['play'] = function() return PlayState(bird, pipePairs, spawnTimer, scores) end,
        ['reset'] = function() return ResetState(bird, pipePairs, spawnTimer, scores) end,
        ['score'] = function() return ScoreState(scores) end
    }
    gStateMachine:change('title')

    -- Initialize fonts.
    fonts = {
        ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
        ['medium'] = love.graphics.newFont('fonts/flappy.ttf', 14),
        ['flappy'] = love.graphics.newFont('fonts/flappy.ttf', 28),
        ['huge'] = love.graphics.newFont('fonts/flappy.ttf', 56),
    }

    -- Initialize sounds
    sounds = {
        ['jump'] = love.audio.newSource('sounds/jump.wav', 'static'),
        ['explosion'] = love.audio.newSource('sounds/explosion.wav', 'static'),
        ['hurt'] = love.audio.newSource('sounds/hurt.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['music'] = love.audio.newSource('sounds/marios_way.mp3', 'static')
    }

    sounds['music']:setLooping(true)
    sounds['music']:play()

    -- Initialize keyboard and mouse input tables.
    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
end

--[[
    Resize the window.
]]
function love.resize(w, h)
    push:resize(w, h)
end

--[[
    LOVE 2D callback function for keyboard.
]]
function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end

--[[
    LOVE 2D callback function for mouse.
]]
function love.mousepressed(x, y, button)
    love.mouse.buttonsPressed[button] = true
end

--[[
    Helper function. Handles keyboard pressed keys inside game objects.
]]
function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

--[[
    Helper function. Handles mouse pressed keys inside game objects.
]]
function love.mouse.wasPressed(button)
    return love.mouse.buttonsPressed[button]
end

--[[
    Update stage.
]]
function love.update(dt)
    background:update(dt)
    gStateMachine:update(dt)
    ground:update(dt)

    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
end

--[[
    Render stage.
]]
function love.draw()
    push:start()

    background:render()
    gStateMachine:render()
    ground:render()

    --showFPS()

    push:finish()
end

--[[
    Helper/debug function. Shows FPS.
]]
function showFPS()
    love.graphics.setFont(fonts['small'])
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end
