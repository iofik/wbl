local M = {}

M.Screen = Class:new{}

function M.Screen:switch()
    if M.Screen._current then
        M.Screen._current:removeSelf()
    end

    M.Screen._current = self:draw()
end

return M
