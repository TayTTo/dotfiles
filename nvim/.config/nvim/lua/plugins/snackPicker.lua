return {
	"folke/snacks.nvim",
	lazy = false,
	opts = {
		indent = {},
		picker = {
			toggles = {
				hidden = ".",
			},
			win = {
				input = {
					keys = {
						["<c-j>"] = { "preview_scroll_down", mode = { "i", "n" } },
						["<c-k>"] = { "preview_scroll_up", mode = { "i", "n" } },
						["<a-.>"] = { "toggle_hidden", mode = { "i", "n" } },
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
				float = false,
				max_width = 40,
				max_height = 20,
			}
		},
		gitbrowse = {},
		dashboard = {},
		bigfile = {},
	},
	vim.schedule(function()
		local image_doc = require 'snacks.image.doc'
		local attach = image_doc.attach
		image_doc.attach = function(buf) ---@diagnostic disable-line
			if vim.bo[buf].ft:match 'react' then
				return
			end
			attach(buf)
		end
	end),
	keys = {
		-- Top Pickers & Explorer
		{ "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "Grep" },
		{ "<leader>:",       function() Snacks.picker.command_history() end,                         desc = "Command History" },
		{ "<leader>e",       function() Snacks.explorer() end,                                       desc = "File Explorer" },
		-- find
		{ "<leader>fb",      function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
		{ "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
		{ "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "Find Files" },
		{ "<leader>fp",      function() Snacks.picker.projects() end,                                desc = "Projects" },
		{ "<leader><space>", function() Snacks.picker.recent({ filter = { cwd = true } }) end,       desc = "Recent" },
		-- Grep
		{ "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
		{ "<leader>sB",      function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
		{ "<leader>sw",      function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word", mode = { "n", "x" } },
		-- git
		{ "<leader>gb",      function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
		{ "<leader>gl",      function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
		{ "<leader>gL",      function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
		{ "<leader>gs",      function() Snacks.picker.git_status() end,                              desc = "Git Status" },
		{ "<leader>gS",      function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
		{ "<leader>gd",      function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
		{ "<leader>gf",      function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
		{ "<leader>sH",      function() Snacks.picker.highlights() end,                              { desc = "[c]heck [H]ighlights " } },
		-- search
		{ "<leader>sh",      function() Snacks.picker.help() end,                                    desc = "Help Pages" },
		{ "<leader>sp",      function() Snacks.picker.lazy() end,                                    desc = "Search for Plugin Spec" },
		--other
		{ "<leader>bd",      function() Snacks.bufdelete() end,                                      desc = "Delete Buffer" },
		{ "<leader>gB",      function() Snacks.gitbrowse() end,                                      desc = "Git Browse",               mode = { "n", "v" } },
		{ "<c-/>",           function() Snacks.terminal() end,                                       desc = "Toggle Terminal" },
		{ "<leader>sd",      function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
		{ "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
	},
}
