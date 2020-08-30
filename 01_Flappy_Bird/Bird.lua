--[[
    Bird.
]]
Bird = class{}

local BIRD_IMAGE = love.graphics.newImage('images/bird.png')

local GRAVITY = 25
local COLLIDE_OFFSET = 1

--[[
    Constructor.
]]
function Bird:init()
    self.width = BIRD_IMAGE:getWidth()
    self.height = BIRD_IMAGE:getHeight()

    self:reset()
end

--[[
    Bird update stage.
]]
function Bird:update(dt)
    self.dy = self.dy + GRAVITY * dt

    if love.keyboard.wasPressed('space') or love.mouse.wasPressed(1) then
        self.dy = -5
        sounds['jump']:play()
    end

    self.y = self.y + self.dy
    self.boundary:updateY(self.y + COLLIDE_OFFSET)
end

--[[
    Bird render stage.
]]
function Bird:render()
    love.graphics.draw(BIRD_IMAGE, self.x, self.y, math.rad(self.dy))

    -- Debug. Shows bird's boundary.
    -- self.boundary:render()
end

--[[
    Reset bird's position.
]]
function Bird:reset()
    self.x = VIRTUAL_WIDTH_CENTER - self.width / 2
    self.y = VIRTUAL_HEIGHT_CENTER - self.height / 2

    self.dy = 0

    self.boundary = Boundary(
        self.x + COLLIDE_OFFSET,
        self.y + COLLIDE_OFFSET,
        self.width - 2 * COLLIDE_OFFSET,
        self.height - 2 * COLLIDE_OFFSET)
end

--[[
    Returns true if bird collides with some boundary, otherwise - false.
]]
function Bird:collides(boundary)
    return self.boundary:collides(boundary)
end
