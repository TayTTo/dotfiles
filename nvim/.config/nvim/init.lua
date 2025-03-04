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
]])
vim.api.nvim_create_user_command("Ans", function()
	vim.bo.filetype = "yaml.ansible"
end, {})

vim.diagnostic.config({
    virtual_text = true,       -- Ensure virtual text is enabled
})

vim.filetype.add({
  extension = {
    tf = "terraform"
  }
})

vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })

