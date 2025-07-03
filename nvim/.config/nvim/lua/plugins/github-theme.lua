return {
	'projekt0n/github-nvim-theme',
	name = 'github-theme',
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		require('github-theme').setup({
			inverse = {
				github_light = {
					match_paren = true,
				},
			},
			groups = {
				github_light = {
					-- TODO(user): Also redefine
					--   StatusLineNC and FloatBorder?
					LspSignatureActiveParameter = {
						fg = "#c06d00",
						style = "bold,underdashed",
						bg = "NONE",
					},
					DiagnosticHint = { fg = "#939597" },
					DiagnosticVirtualTextHint = { link = "DiagnosticHint" },
					diffNewFile = { fg = "#939597"},
					NeogitRemote = {fg = "#939597"},
					MiniStatuslineFilename = {bg = "#F2F4F6"},
				},
			}
		})
		vim.cmd('colorscheme github_light')
	end,
}
