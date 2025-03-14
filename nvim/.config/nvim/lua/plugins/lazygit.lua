-- nvim v0.8.0
return {
	"kdheepak/lazygit.nvim",
	lazy = true,
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	-- optional for floating window border decoration
	dependencies = {
		--"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},
	-- setting the keybinding for LazyGit with 'keys' is recommended in
	-- order to load the plugin when the command is run for the first time
	keys = {
		{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
	},
	config = function()
		vim.cmd("autocmd BufEnter * :lua require('lazygit.utils').project_root_dir()")
		vim.g.lazygit_floating_window_scaling_factor = 1 -- scaling factor for floating window
	end,
}
