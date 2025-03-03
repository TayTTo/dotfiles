return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local harpoon = require('harpoon')
		harpoon:setup()
		vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
		vim.keymap.set("n", "<c-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
		--vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
		--vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
		--vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
		--vim.keymap.set("n", "<leader>4",  function() harpoon:list():select(4) end)
		vim.keymap.set("n", "<M-q>", function() harpoon:list():select(1) end)
		vim.keymap.set("n", "<M-w>", function() harpoon:list():select(2) end)
		vim.keymap.set("n", "<M-e>", function() harpoon:list():select(3) end)
		vim.keymap.set("n", "<M-r>",  function() harpoon:list():select(4) end)
		vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
		vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
	end
}
