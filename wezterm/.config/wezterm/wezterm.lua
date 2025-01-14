local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'Everforest Light Medium (Gogh)'


config.font = wezterm.font('JetBrainsMono Nerd Font Mono')
config.font_size = 12
--config.line_height = 1.1
config.force_reverse_video_cursor = true
config.enable_tab_bar = false

--config.window_decorations = "RESIZE"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
return config
