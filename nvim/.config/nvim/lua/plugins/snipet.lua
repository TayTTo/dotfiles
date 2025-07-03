return {
	'L3MON4D3/LuaSnip',
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	dependencies = {
		{
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
				require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
			end,
		},
	},
	build = "make install_jsregexp",
	config = function()
		require("luasnip").config.set_config({
			region_check_events = "InsertEnter",
			delete_check_events = "InsertLeave",
		})
	end
}
