" Basic coc settings
set updatetime=300
set signcolumn=yes

" Tab to navigate completion list
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ "\<TAB>"
inoremap <silent><expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Enter to confirm completion
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Go to definition
nmap <silent> gd <Plug>(coc-definition)
" Find references
nmap <silent> gr <Plug>(coc-references)
" Show error/hover info
nmap <silent> K :call CocActionAsync('doHover')<CR>

" Alt+Enter to apply quick fix
nmap <M-CR> <Plug>(coc-fix-current)
imap <M-CR> <Esc><Plug>(coc-fix-current)
