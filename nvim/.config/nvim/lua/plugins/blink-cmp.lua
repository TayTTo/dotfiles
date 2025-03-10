return {
	'saghen/blink.cmp',
	-- optional: provides snippets for the snippet source
	dependencies = {
		'rafamadriz/friendly-snippets',
		'kristijanhusak/vim-dadbod-completion',
	},

	version = 'v0.12.4',
	--version = '*',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = 'default',
			['<C-y>'] = { 'select_and_accept', 'fallback' },
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
				auto_show = true,
				border = 'single',
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
			--cmdline = {},
			per_filetype = {
				sql = { 'snippets', 'dadbod', 'buffer' },
				mysql = { 'snippets', 'dadbod', 'buffer' },
				postgresql = { 'snippets', 'dadbod', 'buffer' },
			},
			providers = {
				dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
			},
		},
		cmdline = {
			enabled = false,
		},
		signature = {
			enabled = false,
			window = { border = 'single' },
		},
	},
	opts_extend = { "sources.default"},
}
