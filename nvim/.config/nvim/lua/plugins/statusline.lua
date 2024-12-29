return {
	{
		'echasnovski/mini.statusline',
		version = '*',
		config = function()
			local statusline = require 'mini.statusline'
			statusline.setup { use_icons = true }
		end
	},
}
