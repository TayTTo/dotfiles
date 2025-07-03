return {
	"jay-babu/mason-nvim-dap.nvim",
	lazy = true,
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		'williamboman/mason.nvim'
	},
	config = function()
		-- ensure the java debug adapter is installed

		require("mason-nvim-dap").setup({
			ensure_installed = { "java-debug-adapter", "java-test" }
		})
	end
}
