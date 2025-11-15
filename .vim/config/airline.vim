" AIRLINE BAR SETTINGS

let g:airline_powerline_fonts = 1
let g:airline_theme = 'tokyonight'

" Remove the file encoding
let g:airline_section_y = ''
let g:airline_section_z = '%l:%c'

" Tell Airline to ignore buffers that are plugins, help, etc.
let g:airline_exclude_filetypes = ['nerdtree', 'qf', 'help', 'man']

" For Git Branch Information
"let g:airline#extensions#fugitive#statusline = 0
"
"let g:airline_section_a = airline#section#create(['mode', 'branch'])
"
"let g:airline#extensions#branch#template = '%s'
"let g:airline#extensions#branch#template_default = '%s'
"
"
"let g:airline#extensions#branch#enabled = 1
"let g:airline#extensions#fugitive#enabled = 1
