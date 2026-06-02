return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			-- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		-- Setup autoinstall parser
		local autoinstall_langs = {
			"c",
			"lua",
			"javascript",
			"html",
			"typescript",
			"go",
			"tsx",
		}
		require("nvim-treesitter").install(autoinstall_langs)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = autoinstall_langs,
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
