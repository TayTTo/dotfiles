local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'Everforest Light Medium (Gogh)'
config.colors = {
	selection_bg = '#d79921', -- Orange background for the selection
	selection_fg = '#ffffff'
}
config.font = wezterm.font('JetBrainsMono Nerd Font Mono')
config.font_size = 11
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
config.max_fps = 120
return config
