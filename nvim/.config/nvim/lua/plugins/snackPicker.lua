return {
	"folke/snacks.nvim",
	lazy = false,
	opts = {
		indent = {},
		picker = {
			win = {
				input = {
					keys = {
						["<c-j>"] = { "preview_scroll_down", mode = { "i", "n" } },
						["<c-k>"] = { "preview_scroll_up", mode = { "i", "n" } },
					}
				}
			},
			layout = {
				preset = "ivy",
				cycle = false,
			},
			layouts = {
				ivy = {
					layout = {
						box = "vertical",
						backdrop = false,
						--row = -1,
						width = 0,
						height = 0.4,
						position = "bottom",
						border = "top",
						title = " {title} {live} {flags}",
						title_pos = "left",
						{ win = "input", height = 1, border = "bottom" },
						{
							box = "horizontal",
							{ win = "list",    border = "none" },
							{ win = "preview", title = "{preview}", width = 0.6, border = "left" },
						},
					}
				}
			}
		},
		image = {
			enabled = true,
			doc = {
				inline = false,
				float = true,
				max_width = 60,
				max_height = 30,
			}
		},
		gitbrowse = {},
		dashboard = {},
		--terminal = {
		--	win = {
		--		style = "terminal",
		--		position = "float",
		--	},
		--},
	},
	keys = {
		-- Top Pickers & Explorer
		{ "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
		{ "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "Grep" },
		{ "<leader>:",       function() Snacks.picker.command_history() end,                         desc = "Command History" },
		{ "<leader>e",       function() Snacks.explorer() end,                                       desc = "File Explorer" },
		-- find
		{ "<leader>fb",      function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
		{ "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
		{ "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "Find Files" },
		{ "<leader>fp",      function() Snacks.picker.projects() end,                                desc = "Projects" },
		-- Grep
		{ "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
		-- search
		{ "<leader>sh",      function() Snacks.picker.help() end,                                    desc = "Help Pages" },
		{ "<leader>sp",      function() Snacks.picker.lazy() end,                                    desc = "Search for Plugin Spec" },
		--
		--other
		{ "<leader>bd",      function() Snacks.bufdelete() end,                                      desc = "Delete Buffer" },
		{ "<leader>gB",      function() Snacks.gitbrowse() end,                                      desc = "Git Browse",            mode = { "n", "v" } },
		{ "<c-/>",           function() Snacks.terminal() end,                                       desc = "Toggle Terminal" }
	},
}
