local function get_jdtls()
	-- Get the Mason Registry to gain access to downloaded binaries
	-- local jdtls_path = "/home/tayto/.local/share/nvim/mason/bin/jdtls"
	local jdtls_path = vim.fn.expand "$MASON/bin/jdtls"
	-- Obtain the path to the jar which runs the language server
	local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
	-- Declare white operating system we are using, windows use win, macos use mac
	local SYSTEM = "linux"
	-- Obtain the path to configuration files for your specific operating system
	local config = jdtls_path .. "/config_" .. SYSTEM
	-- Obtain the path to the Lomboc jar
	local lombok = jdtls_path .. "/lombok.jar"
	return launcher, config, lombok
end

local function get_bundles()
	-- local java_debug_path = "/home/tayto/.local/share/nvim/mason/packages/java-debug-adapter"
	local java_debug_path = "$MASON/packages/java-debug-adapter"
	local bundles = {
		vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", 1)
	}

	local java_test_path = "$MASON/packages/java-test"
	-- Add all of the Jars for running tests in debug mode to the bundles list
	vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar", 1), "\n"))

	return bundles
end

local function get_workspace()
	-- Get the home directory of your operating system
	local home = os.getenv "HOME"
	-- Declare a directory where you would like to store project information
	local workspace_path = home .. "/code/workspace/"
	-- Determine the project name
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	-- Create the workspace directory by concatenating the designated workspace path and the project name
	local workspace_dir = workspace_path .. project_name
	return workspace_dir
end

local function java_keymaps()
	-- Allow yourself to run JdtCompile as a Vim command
	vim.cmd(
		"command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)")
	-- Allow yourself/register to run JdtUpdateConfig as a Vim command
	vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
	-- Allow yourself/register to run JdtBytecode as a Vim command
	vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
	-- Allow yourself/register to run JdtShell as a Vim command
	vim.cmd("command! -buffer JdtJshell lua require('jdtls').jshell()")

	vim.keymap.set('n', '<leader>jo', "<Cmd> lua require('jdtls').organize_imports()<CR>",
		{ desc = "[J]ava [O]rganize Imports" })
	vim.keymap.set('n', '<leader>jv', "<Cmd> lua require('jdtls').extract_variable()<CR>",
		{ desc = "[J]ava Extract [V]ariable" })
	vim.keymap.set('v', '<leader>jv', "<Esc><Cmd> lua require('jdtls').extract_variable(true)<CR>",
		{ desc = "[J]ava Extract [V]ariable" })
	vim.keymap.set('n', '<leader>jC', "<Cmd> lua require('jdtls').extract_constant()<CR>",
		{ desc = "[J]ava Extract [C]onstant" })
	vim.keymap.set('v', '<leader>jC', "<Esc><Cmd> lua require('jdtls').extract_constant(true)<CR>",
		{ desc = "[J]ava Extract [C]onstant" })
	vim.keymap.set('n', '<leader>jt', "<Cmd> lua require('jdtls').test_nearest_method()<CR>",
		{ desc = "[J]ava [T]est Method" })
	vim.keymap.set('v', '<leader>jt', "<Esc><Cmd> lua require('jdtls').test_nearest_method(true)<CR>",
		{ desc = "[J]ava [T]est Method" })
	vim.keymap.set('n', '<leader>jT', "<Cmd> lua require('jdtls').test_class()<CR>", { desc = "[J]ava [T]est Class" })
	vim.keymap.set('n', '<leader>ju', "<Cmd> JdtUpdateConfig<CR>", { desc = "[J]ava [U]pdate Config" })
end

local function setup_jdtls()
	-- Get access to the jdtls plugin and all of its functionality
	local jdtls = require "jdtls"

	-- Get the paths to the jdtls jar, operating specific configuration directory, and lombok jar
	local launcher, os_config, lombok = get_jdtls()

	-- Get the path you specified to hold project information
	local workspace_dir = get_workspace()

	-- Get the bundles list with the jars to the debug adapter, and testing adapters
	local bundles = get_bundles()

	-- Determine the root directory of the project by looking for these specific markers
	local root_dir = jdtls.setup.find_root({ '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' });

	-- Tell our JDTLS language features it is capable of
	local capabilities = {
		workspace = {
			configuration = true
		},
		textDocument = {
			completion = {
				snippetSupport = false
			}
		}
	}


	-- Get the default extended client capablities of the JDTLS language server
	local extendedClientCapabilities = jdtls.extendedClientCapabilities
	-- Modify one property called resolveAdditionalTextEditsSupport and set it to true
	extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

	-- Set the command that starts the JDTLS language server jar
	local cmd = {
		'java',
		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-Xmx1g',
		'--add-modules=ALL-SYSTEM',
		'--add-opens', 'java.base/java.util=ALL-UNNAMED',
		'--add-opens', 'java.base/java.lang=ALL-UNNAMED',
		'-javaagent:' .. lombok,
		'-jar',
		launcher,
		'-configuration',
		os_config,
		'-data',
		workspace_dir
	}

	-- Configure settings in the JDTLS server
	local settings = {
		java = {
			-- Enable code formatting
			format = {
				enabled = true,
				-- Use the Google Style guide for code formattingh
				settings = {
					url = vim.fn.stdpath("config") .. "/lang_servers/intellij-java-google-style.xml",
					profile = "GoogleStyle"
				}
			},
			-- Enable downloading archives from eclipse automatically
			eclipse = {
				downloadSource = true
			},
			-- Enable downloading archives from maven automatically
			maven = {
				downloadSources = true
			},
			-- Enable method signature help
			signatureHelp = {
				enabled = true
			},
			-- Use the fernflower decompiler when using the javap command to decompile byte code back to java code
			contentProvider = {
				preferred = "fernflower"
			},
			-- Setup automatical package import oranization on file save
			saveActions = {
				organizeImports = true
			},
			-- Customize completion options
			completion = {
				-- When using an unimported static method, how should the LSP rank possible places to import the static method from
				favoriteStaticMembers = {
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*",
				},
				-- Try not to suggest imports from these packages in the code action window
				filteredTypes = {
					"com.sun.*",
					"io.micrometer.shaded.*",
					"java.awt.*",
					"jdk.*",
					"sun.*",
				},
				-- Set the order in which the language server should organize imports
				importOrder = {
					"java",
					"jakarta",
					"javax",
					"com",
					"org",
				}
			},
			sources = {
				-- How many classes from a specific package should be imported before automatic imports combine them all into a single import
				organizeImports = {
					starThreshold = 9999,
					staticThreshold = 9999
				}
			},
			-- How should different pieces of code be generated?
			codeGeneration = {
				-- When generating toString use a json format
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
				},
				-- When generating hashCode and equals methods use the java 7 objects method
				hashCodeEquals = {
					useJava7Objects = true
				},
				-- When generating code use code blocks
				useBlocks = true
			},
			-- If changes to the project will require the developer to update the projects configuration advise the developer before accepting the change
			configuration = {
				updateBuildConfiguration = "interactive"
			},
			-- enable code lens in the lsp
			referencesCodeLens = {
				enabled = true
			},
			-- enable inlay hints for parameter names,
			inlayHints = {
				parameterNames = {
					enabled = "all"
				}
			}
		}
	}

	-- Create a table called init_options to pass the bundles with debug and testing jar, along with the extended client capablies to the start or attach function of JDTLS
	local init_options = {
		bundles = bundles,
		extendedClientCapabilities = extendedClientCapabilities
	}

	-- Function that will be ran once the language server is attached
	java_keymaps()
	local on_attach = function(_, bufnr)
		-- Map the Java specific key mappings once the server is attached

		-- Setup the java debug adapter of the JDTLS server
		require('jdtls.dap').setup_dap()

		-- Find the main method(s) of the application so the debug adapter can successfully start up the application
		-- Sometimes this will randomly fail if language server takes to long to startup for the project, if a ClassDefNotFoundException occurs when running
		-- the debug tool, attempt to run the debug tool while in the main class of the application, or restart the neovim instance
		-- Unfortunately I have not found an elegant way to ensure this works 100%
		require('jdtls.dap').setup_dap_main_class_configs()
		-- Enable jdtls commands to be used in Neovim
		require 'jdtls.setup'.add_commands()
		-- Refresh the codelens
		-- Code lens enables features such as code reference counts, implemenation counts, and more.
		vim.lsp.codelens.refresh()

		-- Setup a function that automatically runs every time a java file is saved to refresh the code lens
		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = { "*.java" },
			callback = function()
				local _, _ = pcall(vim.lsp.codelens.refresh)
			end
		})
	end

	-- Create the configuration table for the start or attach function
	local dap = require('dap')
	dap.configurations.java = {
		{
			type = 'java',
			request = 'launch',
			name = "Launch file",
		},
	}
	local config = {
		cmd = cmd,
		root_dir = root_dir,
		settings = settings,
		capabilities = capabilities,
		init_options = init_options,
		on_attach = on_attach
	}

	-- Start the JDTLS server
	require('jdtls').start_or_attach(config)
end

return {
	setup_jdtls = setup_jdtls,
}
