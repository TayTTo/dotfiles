return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "biome" },
				typescript = { "biome" },
				javascriptreact = { "biome" },
				typescriptreact = { "biome" },
				css = { "biome" },
				json = { "biome" },
				yaml = { "yamlfmt" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
