return {
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		event = "BufReadPost",
		dependencies = {
			"leoluz/nvim-dap-go",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
			"jbyuki/one-small-step-for-vimkind",
		},
		config = function()
			local dap = require("dap")
			-- local ui = require("dapui")
			-- require("dapui").setup()
			require("dap-go").setup()
			dap.adapters = {
				["go"] = {
					type = "server",
					port = "${port}",
					executable = {
						command = "dlv",
						args = { "dap", "-l", "127.0.0.1:${port}" },
					},
				},
				["nlua"] = function(callback, config)
					callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
				end,
				["php"] = {
					type = 'executable',
					command = 'node',
					args = { vim.fn.stdpath("data") .. '/mason/packages/php-debug-adapter/extension/out/phpDebug.js' }
				},
			}
			dap.configurations = {
				["lua"] = {
					type = "nlua",
					request = "attach",
					name = "Attach to running Neovim instance",
					serverSourceRoot = '/srv/www/',
					localSourceRoot = '/home/www/VVV/www/',
				},
				["php"] = {
					{
						name = "run current script",
						type = "php",
						request = "launch",
						port = 9003,
						cwd = "${fileDirname}",
						program = "${file}",
						runtimeExcutable = "php"
					},
					{
						type = 'php',
						request = 'launch',
						name = 'Listen for Xdebug',
						port = 9003
					}
				},
			}

			-- dap.configurations.lua = {
			-- 	{
			-- 		type = "nlua",
			-- 		request = "attach",
			-- 		name = "Attach to running Neovim instance",
			-- 		serverSourceRoot = '/srv/www/',
			-- 		localSourceRoot = '/home/www/VVV/www/',
			-- 	},
			-- }
			-- dap.configurations.php = {
			-- 	{
			-- 		name = "run current script",
			-- 		type = "php",
			-- 		request = "launch",
			-- 		port = 9003,
			-- 		cwd = "${fileDirname}",
			-- 		program = "${file}",
			-- 		runtimeExcutable = "php"
			-- 	},
			-- 	{
			-- 		type = 'php',
			-- 		request = 'launch',
			-- 		name = 'Listen for Xdebug',
			-- 		port = 9003
			-- 	}
			-- }
			vim.keymap.set("n", "<leader>m", function()
				require("osv").launch({ port = 8086 })
			end, { noremap = true })
		end,
	},
}
