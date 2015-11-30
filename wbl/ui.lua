local M = {
    ScreenWidth     = 320,
    ScreenHeight    = 480,
}

local widget = require 'widget'

local Margin = 4
local ButtonWidth = math.floor((M.ScreenWidth - Margin) / 3) - Margin
local ButtonHeight = math.floor((M.ScreenHeight - Margin) / 6) - Margin

local function calc_button_pos(i)
    local x = (i-1) % 3
    local y = (i-x-1) / 3

    x = M.ScreenWidth  - 0.5*Margin - (x + 0.5) * (ButtonWidth  + Margin)
    y = M.ScreenHeight - 0.5*Margin - (y + 0.5) * (ButtonHeight + Margin)

    return x, y
end

function M.draw_buttons(config)
    for i, notice in ipairs(config.notices) do
        local x, y = calc_button_pos(i)
        local function onRelease()
            local ticket = notice:create_ticket(config.rt)
            print(ticket.id, os.date(nil, ticket.eta))
        end

        widget.newButton{
            x           = x,
            y           = y,
            onRelease   = onRelease,
            label       = notice.name,
            shape       = 'rect',
            width       = ButtonWidth,
            height      = ButtonHeight,
            fillColor   = { default={ 0.1, 0.1, 0.1, 1 }, over={ 1, 0.1, 0.7, 0.4 } },
        }
    end
end

return M
