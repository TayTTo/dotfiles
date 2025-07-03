return {
	"NeogitOrg/neogit",
	lazy = true,
	-- event = {"BufReadPost"},
	cmd = {"Neogit"},
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration

		-- Only one of these is needed.
		"folke/snacks.nvim", -- optional
	},
}
