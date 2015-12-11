local M = {}

local config = require 'wbl.config'
local status = require 'wbl.status'
local ui = require 'wbl.ui'

local widget = require 'widget'
local display = require 'display'


----------------------------------------
local ScreenWidth = display.contentWidth
local ScreenHeight = display.contentHeight
local Margin = 4
local ButtonWidth = math.floor((ScreenWidth - Margin) / 3) - Margin
local ButtonHeight = math.floor((ScreenHeight - Margin) / 6) - Margin

local function calc_button_pos(i)
    local x = (i-1) % 3
    local y = (i-x-1) / 3

    x = ScreenWidth  - 0.5*Margin - (x + 0.5) * (ButtonWidth  + Margin)
    y = ScreenHeight - 0.5*Margin - (y + 0.5) * (ButtonHeight + Margin)

    return x, y
end


----------------------------------------
local function create_ticket(notice)
    local ok, ticket = pcall(function()
        local ticket = notice:create_ticket(config.get().rt)
        status.set(ticket)
        return ticket
    end)

    ui.switch(ok and 'status' or 'error', ticket)
end


----------------------------------------
function M.draw(group)
    local config = config.get()
    for i, notice in ipairs(config.notices) do
        local x, y = calc_button_pos(i)
        local button = ui.newButton{
            x           = x,
            y           = y,
            onRelease   = function() create_ticket(notice) end,
            label       = notice.name,
            width       = ButtonWidth,
            height      = ButtonHeight,
        }

        group:insert(button)
    end
end


return M
