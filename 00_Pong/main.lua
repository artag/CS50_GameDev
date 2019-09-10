-- https://github.com/Ulydev/push
push = require 'push'

WINDOW_WIDTH = 1120
WINDOW_HEIGHT = 630

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243
VIRTUAL_WIDTH_CENTER = VIRTUAL_WIDTH / 2
VIRTUAL_HEIGHT_CENTER = VIRTUAL_HEIGHT / 2

PADDLE_WIDTH = 5
PADDLE_HEIGHT = 20

BALL_DIAMETER = 4
BALL_RADIUS = BALL_DIAMETER / 2

SMALL_FONT_SIZE = 8

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    small_font = love.graphics.newFont('font.ttf', SMALL_FONT_SIZE)
    love.graphics.setFont(small_font)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.draw()
    push:apply('start')

    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    text_offset_x = 0
    text_offset_y = 20
    love.graphics.printf('Hello Pong!', text_offset_x, text_offset_y, VIRTUAL_WIDTH, 'center')

    paddle1_offset_x = 10
    paddle1_offset_y = 30
    love.graphics.rectangle('fill', paddle1_offset_x, paddle1_offset_y, PADDLE_WIDTH, PADDLE_HEIGHT)

    paddle2_offset_x = VIRTUAL_WIDTH - PADDLE_WIDTH - 10
    paddle2_offset_y = VIRTUAL_HEIGHT - 50
    love.graphics.rectangle('fill', paddle2_offset_x, paddle2_offset_y, PADDLE_WIDTH, PADDLE_HEIGHT)

    ball_x = VIRTUAL_WIDTH_CENTER - BALL_RADIUS
    ball_y = VIRTUAL_HEIGHT_CENTER - BALL_RADIUS
    love.graphics.rectangle('fill', ball_x, ball_y, BALL_DIAMETER, BALL_DIAMETER)

    push:apply('end')
end
