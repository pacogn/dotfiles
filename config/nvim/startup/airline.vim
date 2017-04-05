
" airline options
" powerline fonts only work after manually loading startup/options.vim!! WTF!!
let g:airline_powerline_fonts=1
" let g:airline#extensions#disable_rtp_load = 0
let g:airline_theme='kolor'
" let g:airline_theme='PaperColor'
let g:airline#extensions#whitespace#checks = []
"I dont care about the file encoding!
let g:airline_section_y='%{ShrinkedFilePath()}'
let g:airline_section_z = airline#section#create(['%{ObsessionStatus(''[ session ]'', '''')}', 'windowswap', '%3p%% ', 'linenr', ':%3v '])

function! ShrinkedFilePath()
    let filePath = expand('%:p:h')
    let withoutHome = substitute(filePath, $HOME, '', '')
    if len(withoutHome) > 20
      let withoutHome=strpart(withoutHome, 0, 20) . '...'
    elseif filePath =~ 'santa/'
      return 'SANTA VIEWER'
    elseif filePath =~ 'santa-editor'
      return 'SANTA-EDITOR'
    elseif filePath =~ 'nvim/startup'
      return 'NVIM/STARTUP' 
  endif
    return withoutHome

endfunction


if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if exists('g:isfirstload')
    " this symbols work... but only on second load :(
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = ''
    let g:airline_symbols.spell = 'Ꞩ'
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
else
    let g:airline_left_sep=''
    let g:airline_right_sep=''
endif
let g:isfirstload = 1
" https://github.com/vim-airline/vim-airline/wiki/Configuration-Examples-and-Snippets
