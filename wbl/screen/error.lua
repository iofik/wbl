local M = {}

local ui = require 'wbl.ui'

local widget = require 'widget'
local display = require 'display'


function M.draw(group, message)
    group:insert(display.newText("ERROR!", 160, 240))
    group:insert(display.newText(message or '', 160, 260))
    group:insert(ui.newButton{
            x           = 160,
            y           = 450,
            onRelease   = function() ui.switch('main') end,
            label       = 'DISMISS',
        }
    )
end

return M
