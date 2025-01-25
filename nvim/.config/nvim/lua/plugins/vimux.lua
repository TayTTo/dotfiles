return {
	"preservim/vimux",
	vim.keymap.set('n', '<Leader>vo', ':VimuxOpenRunner<CR>'),
	vim.keymap.set('n', '<Leader>vp', ':VimuxPromptCommand<CR>'),
	vim.keymap.set('n', '<Leader>vl', ':VimuxRunLastCommand<CR>'),
	vim.keymap.set('n', '<Leader>vq', ':VimuxCloseRunner<CR>'),
 	vim.keymap.set('n', '<Leader>vi', ':VimuxInterruptRunner<CR>'),
}
