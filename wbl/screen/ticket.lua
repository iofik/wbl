local M = {}

local Base = require 'wbl.screen.base'

local widget = require 'widget'
local display = require 'display'


local Screen = Base.Screen:new{}

function Screen:draw(group)
    local ticket = self.notice:create_ticket(require 'wbl.config'.get().rt)
    print(ticket.id, os.date(nil, ticket.eta))
end


function M.new(notice)
    return Screen:new{ notice = notice }
end

return M
