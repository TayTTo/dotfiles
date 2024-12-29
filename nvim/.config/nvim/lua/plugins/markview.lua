return {
	{
		"OXY2DEV/markview.nvim",
		lazy = false, -- Recommended
		-- ft = "markdown" -- If you decide to lazy-load anyway

		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons"
		},
		config = function()
			require("markview").setup({
				hybrid_modes = { "n" }
			});
			vim.o.foldmethod = "expr";
			vim.o.foldexpr = "nvim_treesitter#foldexpr()";
		end
	},
}
