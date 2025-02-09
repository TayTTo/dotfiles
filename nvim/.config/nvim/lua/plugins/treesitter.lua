return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		--vim.wo.foldmethod = 'expr'
		--vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		--vim.wo.foldenable = false
		--vim.wo.foldcolumn = '0'
		--vim.wo.foldtext = ""
		--vim.wo.foldlevel = 99
		--vim.opt.foldlevelstart = 1
		--vim.wo.foldnestmax = 4

		configs.setup({
			ensure_installed = { 
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"elixir",
				"heex",
				"javascript",
				"html",
				"typescript",
				"go",
				"tsx"
			},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
		})
	end
}
