--[[
    Paddle.
]]
Paddle = class{}

--[[
    Constructor.
]]
function Paddle:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = 0

    -- Calculate paddle horizontal position
    self.onTheLeft = self.x < VIRTUAL_WIDTH_CENTER
    self.onTheRight = self.x > VIRTUAL_WIDTH_CENTER

    self:updateCenter()
end

--[[
    Update.
]]
function Paddle:update(dt)
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)
    end

    self:updateCenter()
end

--[[
    Render.
]]
function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

--[[
    Helper function. Calculate paddle center.
]]
function Paddle:updateCenter()
    self.centerX = self.x + self.width / 2
    self.centerY = self.y + self.height / 2
end
