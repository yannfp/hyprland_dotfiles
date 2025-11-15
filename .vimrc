" --- 1. VIM-PLUG ---
call plug#begin('~/.vim/plugged')

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

" --- 2. CORE VIM SETTINGS ---

" Enable syntax highlighting (colors adapting to language)
syntax on

" Enable filetype detection, plugins, and indentation
" This is crucial for auto-indent and omni-completion
filetype plugin indent on

" Enable auto-indenting
set autoindent

" Use smart indentation (better for C-like languages)
set smartindent

" Set tab width to 4 spaces
set tabstop=4
set shiftwidth=4

" Show line numbers
set number
set relativenumber

" Show the command you are typing
set showcmd

" Enable incremental search (searches as you type)
set incsearch

" Highlight search results
set hlsearch

" Set clipboard to all computer
set clipboard=unnamedplus

" Set the column 80
set colorcolumn=80

" Automatically change the current directory to the one of the file being edited
set autochdir


" --- 3. THEME ---

" Set the colorscheme to Tokyo Night
set termguicolors

colorscheme tokyonight
let g:tokyonight_style = 'night'

" --- 4. Airline Bar ---
let g:airline_powerline_fonts = 1
let g:airline_theme = 'tokyonight'

" For Git Branch Information
let g:airline#extensions#fugitive#statusline = 0

let g:airline_section_a = airline#section#create(['mode', 'branch'])

let g:airline#extensions#branch#template = '%s'
let g:airline#extensions#branch#template_default = '%s'


let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#fugitive#enabled = 1

" Remove the file encoding
let g:airline_section_y = ''
let g:airline_section_z = '%l:%c'


" --- 5. NERDTree Appearance
" Show hidden files
let g:NERDTreeShowHidden = 1

" Set the size of NERDTree
let g:NERDTreeWinSize = 35

" Show bookmarks
" let g:NERDTreeShowBookmarks = 1

let g:NERDTreeGitStatusDisplay = 0

" Gives a cleaner look by hiding the header, bookmarks, and path
let g:NERDTreeMinimalUI = 1

" Show relative path instead of absolute
let g:NERDTreeShowAbsolutePath = 0

" --- 6. Gutentags ---
" Creates the tage folder outised the working directory avoiding to have to
" create a .gitignore
let g:gutentags_cache_dir = expand('~/.cache/tags')

let g:tagbar_status_line = 0

let g:gutentags_modules = ['ctags', 'cscope']
"
" Cscope Mappings
"
" Find all references to the symbol under the cursor
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>

" Find the global definition
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>

" Find all functions that CALL this function
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>

" Find all functions CALLED BY this function
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" Find all files that #include this file

" --- 7. Shortcuts ---

" Set the leader key
let mapleader = ","

" Open the NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>

" Open tagbar
nmap <leader>t :TagbarToggle<CR>


" --- 8. Extras ---

" Automatically set filetype for Polybar config
autocmd BufRead,BufNewFile ~/.config/polybar/config setfiletype ini

" Python Config
autocmd FileType python setlocal expandtab softtabstop=4 tabstop=4 shiftwidth=4
autocmd FileType python setlocal indentkeys-=0# indentexpr=python#GetIndent()
