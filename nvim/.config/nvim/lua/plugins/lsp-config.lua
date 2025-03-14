return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		opts = {},
		dependencies = {
			{ "WhoIsSethDaniel/mason-tool-installer.nvim", lazy = true},

		},
		config = function()
			local mason = require("mason")

			local mason_tool_installer = require("mason-tool-installer")

			-- enable mason and configure icons
			mason.setup({})

			mason_tool_installer.setup({
				ensure_installed = {
					"prettier", -- prettier formatter
					"stylua", -- lua formatter
					"isort", -- python formatter
					"black", -- python formatter
					"pylint", -- python linter
					"eslint_d", -- js linter
				},
			})
		end,
	},

	--Autocompletion
	--	{
	--		'hrsh7th/nvim-cmp',
	--		event = 'InsertEnter',
	--		config = function()
	--			local cmp = require('cmp')
	--			require('luasnip.loaders.from_vscode').lazy_load()
	--
	--			cmp.setup({
	--				sources = {
	--					{ name = 'nvim_lsp' },
	--					{ name = 'luasnip' },
	--					{ name = 'path'},
	--				},
	--				snippet = {
	--					expand = function(args)
	--						require('luasnip').lsp_expand(args.body)
	--					end,
	--				},
	--				window = {
	--					completion = cmp.config.window.bordered(),
	--					documentation = cmp.config.window.bordered(),
	--				},
	--				completion = {
	--					autocomplete = false
	--				},
	--				mapping = cmp.mapping.preset.insert({
	--					['<C-Space>'] = cmp.mapping.complete(),
	--					['<C-n>'] = cmp.mapping.select_next_item(),
	--					['<C-p>'] = cmp.mapping.select_prev_item(),
	--					['<C-u>'] = cmp.mapping.scroll_docs(-4),
	--					['<C-d>'] = cmp.mapping.scroll_docs(4),
	--					-- Super tab
	--					['<Tab>'] = cmp.mapping(function(fallback)
	--						local luasnip = require('luasnip')
	--						local col = vim.fn.col('.') - 1
	--
	--						if cmp.visible() then
	--							cmp.select_next_item({ behavior = 'select' })
	--						elseif luasnip.expand_or_locally_jumpable() then
	--							luasnip.expand_or_jump()
	--						elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
	--							fallback()
	--						else
	--							cmp.complete()
	--						end
	--					end, { 'i', 's' }),
	--
	--					-- Super shift tab
	--					['<S-Tab>'] = cmp.mapping(function(fallback)
	--						local luasnip = require('luasnip')
	--
	--						if cmp.visible() then
	--							cmp.select_prev_item({ behavior = 'select' })
	--						elseif luasnip.locally_jumpable(-1) then
	--							luasnip.jump(-1)
	--						else
	--							fallback()
	--						end
	--					end, { 'i', 's' }),
	--					['<CR>'] = cmp.mapping.confirm({ select = false }),
	--				}),
	--			})
	--		end
	--	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			--{ 'hrsh7th/cmp-nvim-lsp' },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "saghen/blink.cmp" },
		},
		init = function()
			-- Reserve a space in the gutter
			vim.opt.numberwidth = 2
			vim.opt.signcolumn = "yes:1"
			vim.opt.statuscolumn = "%l%s"
			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "",
					},
					numhl = {
						[vim.diagnostic.severity.WARN] = "WarningMsg",
						[vim.diagnostic.severity.ERROR] = "ErrorMsg",
						[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
						[vim.diagnostic.severity.HINT] = "DiagnosticHint",
					},
				},
			})
		end,
		config = function()
			local lsp_defaults = require("lspconfig").util.default_config
			local capabilities = require("blink-cmp").get_lsp_capabilities()
			require("lspconfig").lua_ls.setup({ capabilities = capabilities })

			-- Add cmp_nvim_lsp capabilities settings to lspconfig
			-- This should be executed before you configure any language server
			--	lsp_defaults.capabilities = vim.tbl_deep_extend(
			--		'force',
			--		lsp_defaults.capabilities,
			--		require('cmp_nvim_lsp').default_capabilities()
			--	)

			-- LspAttach is where you enable features that only work
			-- if there is a language server active in the file
			local buffer_autoformat = function(bufnr)
				local group = "lsp_autoformat"
				vim.api.nvim_create_augroup(group, { clear = false })
				vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })

				--	vim.api.nvim_create_autocmd('BufWritePre', {
				--		buffer = bufnr,
				--		group = group,
				--		desc = 'LSP format on save',
				--		callback = function()
				--			-- note: do not enable async formatting
				--			vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
				--		end,
				--	})
			end
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf }

					vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
					vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
					vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
					vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
					vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
					vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
					vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
					vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
					vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
					vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
					local id = vim.tbl_get(event, "data", "client_id")
					local client = id and vim.lsp.get_client_by_id(id)
					if client == nil then
						return
					end

					-- make sure there is at least one client with formatting capabilities
					if client.supports_method("textDocument/formatting") then
						buffer_autoformat(event.buf)
					end
				end,
			})
			--require("lspconfig").yamlls.setup({
			--	settings = {
			--		yaml = {
			--			validate = true,
			--			format = { enable = true },
			--			schemas = {
			--				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
			--			},
			--		},
			--	},
			--})

			require('lspconfig').jdtls.setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ansiblels",
					"clangd",
					"gopls",
					"jsonls",
					"marksman",
					"pylsp",
					"terraformls",
					"tflint",
					"tailwindcss",
					"cssls",
					"ts_ls",
					"eslint@4.5.0",
					"emmet_language_server",
					"html",
					"vtsls",
				},
				handlers = {
					-- this first function is the "default handler"
					-- it applies to every language server without a "custom handler"
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,
				},
			})
		end,
	},
}
