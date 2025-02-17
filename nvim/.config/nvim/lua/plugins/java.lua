return {
	"nvim-java/nvim-java",
	config = false,
	ft = {"java"},
	dependencies = {
		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					jdtls = {
						settings = {
							java = {
								configuration = {
									runtimes = {
										{
											name = "JavaSE-23",
											path = "/usr/local/sdkman/candidates/java/23-tem",
										},
									},
								},
							},
						},
					},
				},
				setup = {
					jdtls = function()
						require("java").setup({
							root_markers = {
								"settings.gradle",
								"settings.gradle.kts",
								"pom.xml",
								"build.gradle",
								"mvnw",
								"gradlew",
								"build.gradle",
								"build.gradle.kts",
							},
						})
					end,
				},
			},
		},
	},
}
--
--return {
--	'nvim-java/nvim-java',
--	config = function()
--		require('java').setup()
--		require('lspconfig').jdtls.setup({})
--	end
--}
