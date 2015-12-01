-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local Config = require 'wbl.config'
local UI = require 'wbl.ui.main'

local config = Config.parse()
UI.draw_buttons(config)
