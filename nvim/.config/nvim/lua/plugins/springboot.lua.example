return {
    "elmcgill/springboot-nvim",
	lazy = true,
	event = "BufEnter *.java",
    dependencies = {
        "neovim/nvim-lspconfig",
        "mfussenegger/nvim-jdtls"
    },
    config = function()
        -- gain acces to the springboot nvim plugin and its functions
        local springboot_nvim = require("springboot-nvim")

        vim.keymap.set('n', '<leader>jr', springboot_nvim.boot_run, {desc = "Java Run Spring Boot"})
        vim.keymap.set('n', '<leader>jc', springboot_nvim.generate_class, {desc = "Java Create Class"})
        vim.keymap.set('n', '<leader>ji', springboot_nvim.generate_interface, {desc = "Java Create Interface"})
        vim.keymap.set('n', '<leader>je', springboot_nvim.generate_enum, {desc = "Java Create Enum"})

        -- run the setup function with default configuration
        springboot_nvim.setup({})
    end
}
