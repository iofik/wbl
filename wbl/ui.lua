local M = {}

local display = require 'display'
local widget = require 'widget'

local current

function M.switch(name, ...)
    if current then
        current:removeSelf()
    end

    current = display.newGroup()
    require('wbl.screen.'..name).draw(current, ...)
end

function M.newButton(params)
    params = table.merge({
        shape       = 'rect',
        fillColor   = {
            default     = { 0.1, 0.1, 0.1, 1 },
            over        = { 1, 0.1, 0.7, 0.4 },
        },
    }, params)

    return widget.newButton(params)
end

return M
