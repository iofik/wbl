local M = {}

local ui = require 'wbl.ui'

local widget = require 'widget'
local display = require 'display'


function M.draw(group, message)
    message = string.gsub(message or '', '^.*%.lua:%d+: *', '', 1)
    group:insert(display.newText("ERROR", 160, 240))
    group:insert(display.newText(message, 160, 260))
    group:insert(ui.newButton{
            x           = 160,
            y           = 450,
            onRelease   = function() ui.switch('main') end,
            label       = 'DISMISS',
        }
    )
end

return M
