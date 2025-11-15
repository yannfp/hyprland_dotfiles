" --- 1. VIM-PLUG SETUP ---
call plug#begin('~/.vim/plugged')

" Plugin for the startup screen/home page
Plug 'mhinz/vim-startify'

" Plugin for auto-closing brackets, parentheses, etc.
Plug 'jiangmiao/auto-pairs'

" The Tokyo Night theme
Plug 'ghifarit53/tokyonight-vim'

" Plugin for NERDTree
Plug 'preservim/nerdtree'
" Plugins for NERDTree Appearance
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Plugin for status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-fugitive'

" Plugin for gutentags
" Generate tags automatically, allows to go to functions definition back and forward
Plug 'ludovicchabant/vim-gutentags'
" Adds a bar showing all functions across project
Plug 'preservim/tagbar'

" Plugin Polyglot gives a better syntax
Plug 'sheerun/vim-polyglot'

" Plugin for fuzy finder Helps findeing files and text in it
Plug 'junegunn/fzf.vim'

call plug#end()

" --- 2. SOURCE MODULAR CONFIG FILES ---
source ~/dotfiles/.vim/config/settings.vim
source ~/dotfiles/.vim/config/themes.vim
source ~/dotfiles/.vim/config/keymaps.vim
source ~/dotfiles/.vim/config/airline.vim
source ~/dotfiles/.vim/config/nerdtree.vim
source ~/dotfiles/.vim/config/tags.vim
source ~/dotfiles/.vim/config/startify.vim
