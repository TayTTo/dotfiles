return {
	'saghen/blink.cmp',
	-- optional: provides snippets for the snippet source
	dependencies = {
		'rafamadriz/friendly-snippets',
	},

	--version = 'v0.11.0',
	version = '*',
	
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
		},
		cmdline = {
			enabled = false,
		},
		signature = {
			enabled = false,
			window = { border = 'single' },
		},
	},
	opts_extend = { "sources.default" },
	--	vim.keymap.set('i', '<Tab>', function()
	--		local col = vim.fn.col('.') - 1
	--		local line = vim.fn.getline('.')
	--
	--		-- If there's a non-space character before the cursor, trigger autocomplete
	--		if col > 0 and line:sub(col, col):match('%S') then
	--			require('blink.cmp').show()
	--		else
	--			-- Use Neovim's default Tab behavior for indentation
	--			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 'n', true)
	--		end
	--	end, { expr = false, noremap = true })

}
