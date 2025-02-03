return {
	'windwp/nvim-autopairs',
	event = "InsertEnter",
	config = function ()
		require('nvim-autopairs').setup({
		enable_check_bracket_line = false,
		ignored_next_char = "[%w%.]"
	})
	end
}
