require("config.lazy")

vim.cmd([[
set number relativenumber
syntax enable
filetype plugin indent on
set clipboard+=unnamedplus
set tabstop=4
set shiftwidth=4

set wildmenu
set hidden
set backspace=2
set noswapfile

" setting for moving lines
nnoremap <a-n> :m .+1<cr>==
nnoremap <a-p> :m .-2<cr>==
inoremap <a-n> <esc>:m .+1<cr>==gi
inoremap <a-p> <esc>:m .-2<cr>==gi
vnoremap <a-n> :m '>+1<cr>gv=gv
vnoremap <a-p> :m '<-2<cr>gv=gv

set cursorline
"set autoindent
set is
set ruler
set ignorecase
set smartcase
set laststatus=2
packadd! matchit
command! CopyFilePath :let @+ = expand("%:p") "\<cr>"
command! CopyDirPath :let @+ = expand("%:p:h") "\<cr>"
command! CopyFileName :let @+ = expand("%:t") "\<cr>"
nnoremap cpf i#include<iostream><Esc>ousing namespace std;<Esc>o<CR>int main(){<Esc>o<Esc>oreturn 0;<Esc>o}<Esc>kki
set scrolloff=5
nnoremap <A-o> <Cmd>lua require'jdtls'.organize_imports()<CR>
nnoremap crv <Cmd>lua require('jdtls').extract_variable()<CR>
vnoremap crv <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>
nnoremap crc <Cmd>lua require('jdtls').extract_constant()<CR>
vnoremap crc <Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>
vnoremap crm <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>


" If using nvim-dap
" This requires java-debug and vscode-java-test bundles, see install steps in this README further below.
nnoremap <leader>df <Cmd>lua require'jdtls'.test_class()<CR>
nnoremap <leader>dn <Cmd>lua require'jdtls'.test_nearest_method()<CR>
]])
vim.api.nvim_create_user_command("Ans", function()
	vim.bo.filetype = "yaml.ansible"
end, {})

vim.diagnostic.config({
    virtual_text = true,       -- Ensure virtual text is enabled
	-- update_in_insert = false,
})

vim.filetype.add({
  extension = {
    tf = "terraform"
  }
})

vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
vim.keymap.set('n', '<esc><esc>', ':noh<cr>', { noremap = true, silent = true })
