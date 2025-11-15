" STARTIFY SETTINGS

function! CustomMenuHeader()
  	let art = [
            \ ' ',
			\ ' ___      ___ ___  _____ ______      ',
			\ '|\  \    /  /|\  \|\   _ \  _   \    ',
			\ '\ \  \  /  / | \  \ \  \\\__\ \  \   ',
			\ ' \ \  \/  / / \ \  \ \  \\|__| \  \  ',
			\ '  \ \    / /   \ \  \ \  \    \ \  \ ',
			\ '   \ \__/ /     \ \__\ \__\    \ \__\',
			\ '    \|__|/       \|__|\|__|     \|__|',
			\ '',
			\ '',
			\ '',
			\ '            WELCOME TO VIM            ',
			\]
	return art
endfunction

let g:startify_custom_header = 'startify#pad(CustomMenuHeader())'

let g:startify_lists = []

" Set aggressive padding to visually center the menu on a wide screen (Adjust this number!)
" Start at 60 and adjust if the art looks too far left or right.
let g:startify_padding_left = 65
let g:startify_center = 1
