set nocompatible
 
syntax on
colorscheme molokai
set background=dark
set gfn=Monaco:h12
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set smartindent
set cindent
set autoindent
set hlsearch
set incsearch
set showmatch
set cursorline
 
set number
filetype on
filetype plugin on
filetype plugin indent on

nnoremap <F8> :!/opt/local/bin/ctags -R --python-kinds=-i *.py<CR>

nnoremap <F4> :TlistToggle<CR>
let Tlist_Use_Left_Window = 1

set ofu=syntaxcomplete#Complete

let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
let g:SuperTabDefaultCompletionType = "context"

