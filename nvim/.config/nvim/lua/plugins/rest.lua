return {
	"rest-nvim/rest.nvim",
	lazy = true,
	event = {"BufReadPost"},
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "http")
		end,
		opts = {
			result_split_in_place = true,

		}
	}
}
