--[[
    Pipe.
]]
Pipe = class{}

-- One image for all instances of this type.
local PIPE_IMAGE = love.graphics.newImage('images/pipe.png')
local COLLIDE_OFFSET = 4

--[[
    Constructor.
    Sets pipe orientation ('top' or 'bottom') and pipe's position (x, y).
]]
function Pipe:init(orientation, x, y)
    self.x = x
    self.y = y
    self.orientation = orientation

    self.width = PIPE_IMAGE:getWidth()
    self.height = PIPE_IMAGE:getHeight()

    if self.orientation == 'top' then
        self.boundary = Boundary(
            self.x + COLLIDE_OFFSET,
            0,
            self.width - 2 * COLLIDE_OFFSET,
            self.y - COLLIDE_OFFSET)
    else
        self.boundary = Boundary(
            self.x + COLLIDE_OFFSET,
            self.y + COLLIDE_OFFSET,
            self.width - 2 * COLLIDE_OFFSET,
            VIRTUAL_HEIGHT)
    end
end

--[[
    Pipe update stage.
]]
function Pipe:update(x)
    self.x = x
    self.boundary:updateX(self.x + COLLIDE_OFFSET)
end

--[[
    Pipe render stage.
]]
function Pipe:render()
    if self.orientation == 'top' then
        -- Rotate on 180 degrees, scale on x = 1, scale on y = 1, offset on x by pipe width.
        love.graphics.draw(PIPE_IMAGE, self.x, self.y, math.rad(180), 1, 1, self.width)
    else
        -- Draw as is.
        love.graphics.draw(PIPE_IMAGE, self.x, self.y)
    end

    -- Debug. Shows pipe's boundary.
    --self.boundary:render()
end

--[[
    Condition when pipe can be removed.
    (Only if the pipe hides on the left side of the screen).
]]
function Pipe:canBeRemoved()
    return self.x < -self.width
end

--[[
    Returns true if pipe collides with input boundary, otherwise - false.
]]
function Pipe:collides(boundary)
    return self.boundary:collides(boundary)
end
