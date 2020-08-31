--[[
    Score state.
    Shows finish scores on game over.
]]
ScoreState = class{__includes = BaseState}

local BRONZE_MEDAL_IMAGE = love.graphics.newImage('images/bronze_medal.png')
local SILVER_MEDAL_IMAGE = love.graphics.newImage('images/silver_medal.png')
local GOLD_MEDAL_IMAGE = love.graphics.newImage('images/gold_medal.png')

local SCORES_TO_BRONZE = 10
local SCORES_TO_SILVER = 25
local SCORES_TO_GOLD = 50

--[[
    Constructor.
    Uses object of Score class.
]]
function ScoreState:init(scores)
    self.scores = scores

    self.firstRow = math.floor(2 * VIRTUAL_HEIGHT / 10)
    self.secondRow = math.floor(4 * VIRTUAL_HEIGHT / 10)
    self.thirdRow = math.floor(5 * VIRTUAL_HEIGHT / 10)
    self.forthRow = math.floor(6 * VIRTUAL_HEIGHT / 10)
    self.fifthRow = math.floor(8 * VIRTUAL_HEIGHT / 10)
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

    self:renderMedal()

    love.graphics.printf('Press Enter to Play Again!', 0, self.fifthRow, VIRTUAL_WIDTH, 'center')
end

--[[
    Renders medal with additional message on the screen.
]]
function ScoreState:renderMedal()
    if self.scores.scores >= SCORES_TO_GOLD then
        love.graphics.setFont(fonts['medium'])
        love.graphics.printf('You win the gold medal!', 0, self.thirdRow, VIRTUAL_WIDTH, 'center')

        local medalWidth = GOLD_MEDAL_IMAGE:getWidth()
        local medalHeight = GOLD_MEDAL_IMAGE:getHeight()
        love.graphics.draw(
            GOLD_MEDAL_IMAGE,
            VIRTUAL_WIDTH_CENTER - medalWidth / 4,
            self.forthRow,
            0,      -- rotate
            0.5,    -- scale x
            0.5)    -- scale y
    elseif self.scores.scores >= SCORES_TO_SILVER then
        love.graphics.setFont(fonts['medium'])
        love.graphics.printf('You win the silver medal!', 0, self.thirdRow, VIRTUAL_WIDTH, 'center')

        local medalWidth = SILVER_MEDAL_IMAGE:getWidth()
        local medalHeight = SILVER_MEDAL_IMAGE:getHeight()
        love.graphics.draw(
            SILVER_MEDAL_IMAGE,
            VIRTUAL_WIDTH_CENTER - medalWidth / 4,
            self.forthRow,
            0,      -- rotate
            0.5,    -- scale x
            0.5)    -- scale y
    elseif self.scores.scores >= SCORES_TO_BRONZE then
        love.graphics.setFont(fonts['medium'])
        love.graphics.printf('You win the bronze medal!', 0, self.thirdRow, VIRTUAL_WIDTH, 'center')

        local medalWidth = BRONZE_MEDAL_IMAGE:getWidth()
        local medalHeight = BRONZE_MEDAL_IMAGE:getHeight()
        love.graphics.draw(
            BRONZE_MEDAL_IMAGE,
            VIRTUAL_WIDTH_CENTER - medalWidth / 4,
            self.forthRow,
            0,      -- rotate
            0.5,    -- scale x
            0.5)    -- scale y
    end
end
