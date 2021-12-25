call plug#begin('~/.vim/plugged')
Plug 'dag/vim-fish'
Plug 'cespare/vim-toml'
Plug 'dracula/vim', {'as': 'dracula'}
call plug#end()

syntax on
filetype plugin indent on
set clipboard=unnamedplus
set encoding=utf-8
set fileformats=unix,dos,mac

set mouse=a
set mousemodel=popup

set wildmenu
set wildmode=longest:full,full

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

set incsearch
set hlsearch

set noswapfile
set nobackup

set number
set showcmd
set showmode

inoremap <S-Tab> <C-d>
nnoremap <leader><space> :nohlsearch<CR>
autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab
