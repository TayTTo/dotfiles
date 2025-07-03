return {
	"mfussenegger/nvim-dap-python";
	lazy = true,
	event = "BufEnter *.py",
	config = function()
		require("dap-python").setup("python3")
	end
}
