" Disable netrw.
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

set background=dark
set clipboard=unnamedplus
set foldlevel=999
set foldmethod=syntax
set nojoinspaces
set modeline
set mouse=a
set number
set relativenumber
set tabpagemax=1000000
set title
set undofile
set undolevels=1000000

highlight Pmenu ctermbg=7

nnoremap <space><space> :w<cr>

nnoremap <f1> :tabprev<cr>
inoremap <f1> <esc>:tabprev<cr>
nnoremap <s-f1> :bprev<cr>
inoremap <s-f1> <esc>:bprev<cr>

nnoremap <f2> :tabnext<cr>
inoremap <f2> <esc>:tabnext<cr>
nnoremap <s-f2> :bnext<cr>
inoremap <s-f2> <esc>:bnext<cr>
