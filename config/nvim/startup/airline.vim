
" airline options
let g:airline_powerline_fonts=1
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='kolor'
" let g:airline_theme='PaperColor'
let g:airline#extensions#whitespace#checks = []
"I dont care about the file encoding!
let g:airline_section_y=''
" https://github.com/vim-airline/vim-airline/wiki/Configuration-Examples-and-Snippets
let g:airline_section_z = airline#section#create(['%{ObsessionStatus(''[ session ]'', '''')}', 'windowswap', '%3p%% ', 'linenr', ':%3v '])
