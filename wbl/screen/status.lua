local M = {}

local ui = require 'wbl.ui'
local status = require 'wbl.status'

local widget = require 'widget'
local display = require 'display'


function M.draw(group, ticket)
    group:insert(display.newText("Ticket: " .. ticket.id, 160, 240))
    if ticket.eta then
        group:insert(display.newText("ETA: " .. os.date('%H:%M', ticket.eta), 160, 260))
    end
    group:insert(ui.newButton{
            x           = 160,
            y           = 450,
            onRelease   = function()
                status.set(nil)
                ui.switch('main')
            end,
            label       = 'DISMISS',
        }
    )
end


return M
