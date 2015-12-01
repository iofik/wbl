local ui = require 'wbl.ui'

application = {
	content = {
		width           = ui.ScreenWidth,
		height          = ui.ScreenHeight, 
		scale           = 'zoomStretch',
		fps             = 30,
		--imageSuffix     = { ["@2x"] = 2 },
	},
	--[[
	-- Push notifications
	notification = {
		iphone = {
			types = { 'badge', 'sound', 'alert', 'newsstand' },
		},
	},
	--]]    
}
