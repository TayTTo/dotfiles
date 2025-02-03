return {
	'saghen/blink.cmp',
	-- optional: provides snippets for the snippet source
	dependencies = {
		'rafamadriz/friendly-snippets',
	},

	version = '*',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' for mappings similar to built-in completion
		-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
		-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
		-- See the full "keymap" documentation for information on defining your own keymap.
		keymap = {
			preset = 'enter',

		},
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = 'mono'
		},

		completion = {

			-- Disable auto brackets
			keyword = { range = 'full' },
			accept = { auto_brackets = { enabled = false }, },
			menu = {
				border = 'single',
				auto_show = true,
			},
			documentation = {
				window = {
					border = 'single'
				},
				auto_show = true,
				auto_show_delay_ms = 500,
			},
			list = {
				selection = {
					preselect = false,
					auto_insert = true,
				},
			},
		},
		sources = {
			default = { 'buffer', 'lsp', 'snippets', 'path' },
			cmdline = {}
		},
		signature = {
			enabled = false,
			window = { border = 'single' },
		},
	},
	opts_extend = { "sources.default" }
}
