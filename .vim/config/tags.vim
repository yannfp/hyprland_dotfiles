" GUTENTAGS SETTINGS

" Creates the tags folder outised the working directory avoiding to have to
" create a .gitignore
let g:gutentags_cache_dir = expand('~/.cache/tags')

let g:tagbar_status_line = 0

let g:gutentags_modules = ['ctags', 'cscope']
