--[[
    Background.
]]
Background = class{}

local BACKGROUND_SCROLL_SPEED = 30
local BACKGROUND_LOOPING_POINT = 413

--[[
    Constructor.
]]
function Background:init()
    self.background = love.graphics.newImage('images/background.png')
    self.backgroundScroll = 0
end

--[[
    Background update stage.
    Scroll background on axis X.
]]
function Background:update(dt)
    self.backgroundScroll =
        (self.backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
        % BACKGROUND_LOOPING_POINT
end

--[[
    Background render stage.
]]
function Background:render()
    love.graphics.draw(self.background, -self.backgroundScroll, 0)
end
