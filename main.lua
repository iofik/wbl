-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local Config = require 'wbl.config'

local config = Config.parse()
local notice = config.notices[1]
local ticket = notice:create_ticket(config.rt)
print(ticket.id, os.date(nil, ticket.eta))
