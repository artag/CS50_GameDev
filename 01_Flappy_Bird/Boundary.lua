--[[
    Boundary.
]]
Boundary = class{}

--[[
    Constructor.
]]
function Boundary:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
end

--[[
    Boundary update. Only for axis X.
]]
function Boundary:updateX(x)
    self.x = x
end

--[[
    Boundary update. Only for axis Y.
]]
function Boundary:updateY(y)
    self.y = y
end

--[[
    Boundary update. Axis X and Y.
]]
function Boundary:update(x, y)
    self.x = x
    self.y = y
end

--[[
    Returns true if boundary collides with another boundary, otherwise - false.
]]
function Boundary:collides(boundary)
    local x2 = self.x + self.width
    local y2 = self.y + self.height

    local bx2 = boundary.x + boundary.width
    local by2 = boundary.y + boundary.height

    if self.x < bx2 and
        x2 > boundary.x and
        self.y < by2 and
        y2 > boundary.y then
        return true
    end

    return false
end

--[[
    Used for debug. Render boundary to the screen.
]]
function Boundary:render()
    love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
end
