augroup neomake_runners
    autocmd!
    " autocmd FileType javascript let g:neomake_javascript_enabled_makers = ['eslint']
    autocmd BufWritePost *.rt :Neomake! rt
augroup end
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_javascript_fixlint_maker = {
	    \'exe': 'eslint',
	    \'args': '-f compact --fix',
        \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
        \   '%W%f: line %l\, col %c\, Warning - %m,%-G,%-G%*\d problems%#'
	    \}
let g:neomake_rt_maker = {
	    \'exe': 'grunt',
	    \'args': [ 'rt']
	    \}

"
" this is eslint fallback version.  'benjie/neomake-local-eslint.vim' will find local eslint for us
" let g:neomake_javascript_eslint_exe='/Users/davidsu/.nvm/versions/node/v4.2.1/bin/eslint'
" let g:neomake_error_sign = '❌'
let g:neomake_error_sign = {
	\ 'text': '❌',
	\ 'texthl': 'ErrorMsg',
	\ }
let g:neomake_warning_sign = {'text': '💩', 'texthl': 'NeomakeWarningSign'}
