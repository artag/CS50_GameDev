--[[
    Ground.
]]
Ground = class{}

local GROUND_IMAGE = love.graphics.newImage('images/ground.png')
local GROUND_SCROLL_SPEED = 60
local COLLIDE_OFFSET = 2

--[[
    Constructor.
    Uses the object of Bird class.
]]
function Ground:init(bird)
    self.groundScroll = 0

    self.height = GROUND_IMAGE:getHeight()
    self.offsetY = VIRTUAL_HEIGHT - self.height
    self.looping_point = VIRTUAL_WIDTH

    self.boundary = Boundary(
        0,
        self.offsetY + COLLIDE_OFFSET,
        VIRTUAL_WIDTH,
        self.height - COLLIDE_OFFSET)

    -- For collision detection: bird vs. ground
    self.bird = bird
end

--[[
    Ground update stage.
]]
function Ground:update(dt)
    self.groundScroll =
        (self.groundScroll + GROUND_SCROLL_SPEED * dt) % self.looping_point

    if self.bird:collides(self.boundary) then
        sounds['explosion']:play()
        sounds['hurt']:play()
        -- Hack to reset bird's position. Disables bird vs. ground collision. Bad piece of code.
        self.bird:reset()
        gStateMachine:change('score')
    end
end

--[[
    Ground render stage.
]]
function Ground:render()
    love.graphics.draw(GROUND_IMAGE, -self.groundScroll, self.offsetY)

    -- Debug. Shows ground's boundary.
    --self.boundary:render()
end
