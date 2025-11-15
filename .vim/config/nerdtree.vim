" NERDTree SETTINGS

" Enable Devicons/Filetype Icons
let g:WebDevIconsNerdTreeBeforeGlyph = 1
let g:NERDTreeDirArrows = 0   " Optional: Use filetype icons instead of arrows for directories
let g:NERDTreeDirArrowExpandable = ' '
let g:NERDTreeDirArrowCollapsible = ' '

"DISPLAY
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinSize = 35
let g:NERDTreeMinimalUI = 1

" Remove the path header display
let g:NERDTreeShowHelp = 0
let g:NERDTreeShowCWD = 0
let g:NERDTreeShowBookmarks = 0

" --- NERDTree Git Plugin Symbols ---
let g:nerdtree_git_indicator_map = {
    \ 'Modified'  :'✹',
    \ 'Staged'    :'✚',
    \ 'Untracked' :'✭',
    \ 'Renamed'   :'➜',
    \ 'Deleted'   :'✖',
    \ 'Dirty'     :'✗',
    \ 'Clean'     :'✔',
    \ 'Ignored'   :'☒',
    \ 'Unknown'   :'?',
    \ }

" Completely hide the NERDTree header path
augroup nerdtreehidecwd
	autocmd!
	autocmd FileType nerdtree setlocal conceallevel=3 | syntax match NERDTreeHideCWD #^[</].*$# conceal
augroup end
