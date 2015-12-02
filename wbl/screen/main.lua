local M = {}

local Base = require 'wbl.screen.base'
local Config = require 'wbl.config'

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
local Screen = Base.Screen:new{}

function Screen:draw()
    local group = display.newGroup()

    for i, notice in ipairs(self.config.notices) do
        local x, y = calc_button_pos(i)
        local function onRelease()
            local ticket = notice:create_ticket(self.config.rt)
            print(ticket.id, os.date(nil, ticket.eta))
        end

        local button = widget.newButton{
            x           = x,
            y           = y,
            onRelease   = onRelease,
            label       = notice.name,
            shape       = 'rect',
            width       = ButtonWidth,
            height      = ButtonHeight,
            fillColor   = { default={ 0.1, 0.1, 0.1, 1 }, over={ 1, 0.1, 0.7, 0.4 } },
        }

        group:insert(button)
    end

    return group
end


----------------------------------------
function M.new()
    return Screen:new{ config = Config.get() }
end

return M
