set scrolloff=8
set number
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set encoding=UTF-8
set laststatus=2
set showtabline=1
set noshowmode
set mouse=a
let g:lightline = {
            \ 'colorscheme': 'darcula', 
            \ }

"Vim-Plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

"Plugins
call plug#begin('~/.vim/plugged')
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
