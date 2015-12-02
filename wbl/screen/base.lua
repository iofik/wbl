local M = {}

local display = require 'display'

M.Screen = Class:new{}

function M.Screen:switch()
    if M.Screen._current then
        M.Screen._current:removeSelf()
    end

    M.Screen._current = display.newGroup()
    self:draw(M.Screen._current)
end

return M
