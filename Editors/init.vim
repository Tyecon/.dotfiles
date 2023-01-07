set scrolloff=8
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set encoding=utf8
let g:airline_powerline_fonts = 1

call plug#begin(stdpath('config') . '/plugged')
Plug 'vijaymarupudi/nvim-fzf'
Plug 'dracula/vim'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot',
Plug 'preservim/nerdcommenter'
Plug 'jparise/vim-graphql'
Plug 'itchyny/lightline.vim'
call plug#end()

if (has("termguicolors"))
set termguicolors
endif
syntax enable
colorscheme dracula
