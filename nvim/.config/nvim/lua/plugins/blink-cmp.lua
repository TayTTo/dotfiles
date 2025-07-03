return {
	'saghen/blink.cmp',
	-- optional: provides snippets for the snippet source
	dependencies = {
		'L3MON4D3/LuaSnip',
		'kristijanhusak/vim-dadbod-completion',
	},

	-- version = 'v0.12.4',
	version = '*',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		snippets = { preset = 'luasnip' },
		keymap = {
			preset = 'default',
			['<C-y>'] = { 'select_and_accept', 'fallback' },
			['<C-p>'] = { 'select_prev', 'fallback' },
			['<C-n>'] = { 'select_next', 'fallback' },
			-- ['<C-j>'] = { 'snippet_forward', 'fallback' },
			-- ['<C-k>'] = { 'snippet_backward', 'fallback' },
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
			enabled = true,
			window = { border = 'single' },
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
