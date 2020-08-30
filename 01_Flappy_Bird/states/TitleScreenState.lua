--[[
    Title screen.
]]
TitleScreenState = class{__includes = BaseState}

--[[
    Constructor.
]]
function TitleScreenState:init()
    self.firstRow = math.floor(4 * VIRTUAL_HEIGHT / 12)
    self.secondRow = math.floor(15 * VIRTUAL_HEIGHT / 20)
end

--[[
    Update stage.
]]
function TitleScreenState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

--[[
    Finish stage.
]]
function TitleScreenState:render()
    love.graphics.setFont(fonts['flappy'])
    love.graphics.printf('Floppy Bird', 0, self.firstRow, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(fonts['medium'])
    love.graphics.printf('Press Enter', 0, self.secondRow, VIRTUAL_WIDTH, 'center')
end
