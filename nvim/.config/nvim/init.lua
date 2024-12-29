require("config.lazy")

vim.cmd([[
set number relativenumber
syntax enable
set background=light
filetype plugin indent on
"set clipboard+=unnamedplus
set noswapfile
set tabstop=4
set shiftwidth=4
set termguicolors

set path+=**

set wildmenu
set hidden
set backspace=2
set noswapfile

" tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_keepdir = 0
let g:netrw_winsize = 20

" setting for moving lines
nnoremap <a-j> :m .+1<cr>==
nnoremap <a-k> :m .-2<cr>==
inoremap <a-j> <esc>:m .+1<cr>==gi
inoremap <a-k> <esc>:m .-2<cr>==gi
vnoremap <a-j> :m '>+1<cr>gv=gv
vnoremap <a-k> :m '<-2<cr>gv=gv

set cursorline
set autoindent
set spell
set is
set ruler
set ignorecase
set smartcase
set gp=git\ grep\ -n
set laststatus=2
packadd! matchit
command! CopyFilePath :let @+ = expand("%:p") "\<cr>"
command! CopyDirPath :let @+ = expand("%:p:h") "\<cr>"
command! CopyFileName :let @+ = expand("%:t") "\<cr>"
nnoremap cpf i#include<iostream><Esc>ousing namespace std;<Esc>o<CR>int main(){<Esc>o<Esc>oreturn 0;<Esc>o}<Esc>kki
inoremap <c-q> <Esc>:Lex<cr>
nnoremap <c-q> :Lex<cr>
set scrolloff=5
]])
