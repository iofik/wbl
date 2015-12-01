local M = {
    ScreenWidth     = 320,
    ScreenHeight    = 480,
}

function M.switch(screen)
    if M._current then
        M._current:removeSelf()
    end
    M._current = screen.draw()
end

return M
